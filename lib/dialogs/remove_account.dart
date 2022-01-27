import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:solana_wallet/state/base_account.dart';
import 'package:solana_wallet/state/states.dart';

Future<void> removeAccountDialog(BuildContext context, Account account) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer(
          builder: (context, ref, _) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("'${account.name}' will be permanently removed. "),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Remove'),
                  onPressed: () {
                    removeAccount(ref, context, account);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
}

/*
 * Remove an account by passing it's instance
 */
void removeAccount(WidgetRef ref, BuildContext context, Account account) {
  final accountsProv = ref.read(accountsProvider.notifier);

  accountsProv.removeAccount(account);

  if (accountsProv.state.length == 0) {
    Navigator.pushReplacementNamed(context, "/account_selection");
  }
}
