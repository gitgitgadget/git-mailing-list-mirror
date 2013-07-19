From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: Re: [PATCH v2 3/3] Update po/ja.po
Date: Fri, 19 Jul 2013 21:32:18 +0900
Message-ID: <CAPM==HJ4pTrb5cp0gNNef3PDdk5Sae-aw0ADzsb7zOY4VjDMVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:32:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V09rG-0006R2-98
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812Ab3GSMcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:32:21 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:45944 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759544Ab3GSMcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:32:19 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so3385203veb.34
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=UZ78t8fHZ6LhxJGeJ3c+xeUg6DVN9eB8sCL5Kc40H0U=;
        b=YFO//2JtRyEJq2hlLx+riqiBxtiBqUbAktSIhnL9OfyWQ9Axsg9jp8b0RbO6IslEPA
         oMKFiJ9rlMPh7y1NZKt4KRB26Kp3iFOPoDvdQKoAY7vBftCfgsv+y/LTp3WzE3HoETl7
         illOfWt+msLUjzgF22HkiLjt7lNEZ/HIZ9Ipa/fk6bu73ts6gG9dUrQNSAE++vRIvivL
         uOcczWFAjRbo75Lc3OBftixQad+yze29kmGMGeU8+PtGNh3qHehNExfT7MlUnW4nHD/d
         daY3UzogSTgpy6j4Pd61k3J6CwxqDmxCVKAv9S25ZGC//OLEX1Wl+s8Iy3/bpdSuUwpP
         POFQ==
X-Received: by 10.220.203.197 with SMTP id fj5mr5827601vcb.60.1374237138260;
 Fri, 19 Jul 2013 05:32:18 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Fri, 19 Jul 2013 05:32:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230798>

Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
---
 po/ja.po | 1143 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 616 insertions(+), 527 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 9aff249..4e583fa 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -7,41 +7,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"POT-Creation-Date: 2013-07-10 03:38+0900\n"
 "PO-Revision-Date: 2010-02-02 19:03+0900\n"
-"Last-Translator: しらいし ななこ <nanako3@lavabit.com>\n"
+"Last-Translator: Yamada Saburo <devil.tamachan@gmail.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"

-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr "git-gui: 致命的なエラー"
-
-#: git-gui.sh:743
+#: git-gui.sh:859
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "%s に無効なフォントが指定されています:"

-#: git-gui.sh:779
+#: git-gui.sh:911
 msgid "Main Font"
 msgstr "主フォント"

-#: git-gui.sh:780
+#: git-gui.sh:912
 msgid "Diff/Console Font"
 msgstr "diff/コンソール・フォント"

-#: git-gui.sh:794
+#: git-gui.sh:926 git-gui.sh:940 git-gui.sh:953 git-gui.sh:1043 git-gui.sh:1062
+#: git-gui.sh:3094
+msgid "git-gui: fatal error"
+msgstr "git-gui: 致命的なエラー"
+
+#: git-gui.sh:927
 msgid "Cannot find git in PATH."
 msgstr "PATH 中に git が見つかりません"

-#: git-gui.sh:821
+#: git-gui.sh:954
 msgid "Cannot parse Git version string:"
 msgstr "Git バージョン名が理解できません:"

-#: git-gui.sh:839
+#: git-gui.sh:979
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -60,475 +60,493 @@ msgstr ""
 "\n"
 "'%s' はバージョン 1.5.0 と思って良いですか？\n"

-#: git-gui.sh:1128
+#: git-gui.sh:1276
 msgid "Git directory not found:"
 msgstr "Git ディレクトリが見つかりません:"

-#: git-gui.sh:1146
+#: git-gui.sh:1306
 msgid "Cannot move to top of working directory:"
 msgstr "作業ディレクトリの最上位に移動できません"

-#: git-gui.sh:1154
+#: git-gui.sh:1314
 msgid "Cannot use bare repository:"
 msgstr "裸のリポジトリは使えません:"

-#: git-gui.sh:1162
+#: git-gui.sh:1322
 msgid "No working directory"
 msgstr "作業ディレクトリがありません"

-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1494 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "ファイル状態を更新しています…"

-#: git-gui.sh:1390
+#: git-gui.sh:1554
 msgid "Scanning for modified files ..."
 msgstr "変更されたファイルをスキャンしています…"

-#: git-gui.sh:1454
+#: git-gui.sh:1621
 msgid "Calling prepare-commit-msg hook..."
 msgstr "prepare-commit-msg フックを実行中・・・"

-#: git-gui.sh:1471
+#: git-gui.sh:1638
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr "prepare-commit-msg フックがコミットを拒否しました"

-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1796 lib/browser.tcl:252
 msgid "Ready."
 msgstr "準備完了"

-#: git-gui.sh:1787
+#: git-gui.sh:1954
 #, tcl-format
 msgid "Displaying only %s of %s files."
 msgstr "全体で%s個の内の%sファイルだけ表示しています"

-#: git-gui.sh:1913
+#: git-gui.sh:2080
 msgid "Unmodified"
 msgstr "変更無し"

-#: git-gui.sh:1915
+#: git-gui.sh:2082
 msgid "Modified, not staged"
 msgstr "変更あり、コミット未予定"

-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:2083 git-gui.sh:2095
 msgid "Staged for commit"
 msgstr "コミット予定済"

-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:2084 git-gui.sh:2096
 msgid "Portions staged for commit"
 msgstr "部分的にコミット予定済"

-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:2085 git-gui.sh:2097
 msgid "Staged for commit, missing"
 msgstr "コミット予定済、ファイル無し"

-#: git-gui.sh:1920
+#: git-gui.sh:2087
 msgid "File type changed, not staged"
-msgstr "ファイル型変更、コミット未予定"
+msgstr "ファイルタイプ変更、コミット未予定"

-#: git-gui.sh:1921
+#: git-gui.sh:2088 git-gui.sh:2089
+msgid "File type changed, old type staged for commit"
+msgstr "ファイルタイプ変更、元のファイルタイプでの変更をコミット予定済"
+
+#: git-gui.sh:2090
 msgid "File type changed, staged"
-msgstr "ファイル型変更、コミット予定済"
+msgstr "ファイルタイプ変更、コミット予定済"
+
+#: git-gui.sh:2091
+msgid "File type change staged, modification not staged"
+msgstr "ファイルタイプの変更はコミット予定済、内容の変更はコミット未予定"
+
+#: git-gui.sh:2092
+msgid "File type change staged, file missing"
+msgstr "ファイルタイプの変更はコミット予定済、ファイルが見つからない"

-#: git-gui.sh:1923
+#: git-gui.sh:2094
 msgid "Untracked, not staged"
 msgstr "管理外、コミット未予定"

-#: git-gui.sh:1928
+#: git-gui.sh:2099
 msgid "Missing"
 msgstr "ファイル無し"

-#: git-gui.sh:1929
+#: git-gui.sh:2100
 msgid "Staged for removal"
 msgstr "削除予定済"

-#: git-gui.sh:1930
+#: git-gui.sh:2101
 msgid "Staged for removal, still present"
 msgstr "削除予定済、ファイル未削除"

-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:2103 git-gui.sh:2104 git-gui.sh:2105 git-gui.sh:2106
+#: git-gui.sh:2107 git-gui.sh:2108
 msgid "Requires merge resolution"
 msgstr "要マージ解決"

-#: git-gui.sh:1972
+#: git-gui.sh:2143
 msgid "Starting gitk... please wait..."
 msgstr "gitk を起動中…お待ち下さい…"

-#: git-gui.sh:1984
+#: git-gui.sh:2155
 msgid "Couldn't find gitk in PATH"
 msgstr "PATH 中に gitk が見つかりません"

-#: git-gui.sh:2043
+#: git-gui.sh:2214
 msgid "Couldn't find git gui in PATH"
 msgstr "PATH 中に git gui が見つかりません"

-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2633 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "リポジトリ"

-#: git-gui.sh:2456
+#: git-gui.sh:2634
 msgid "Edit"
 msgstr "編集"

-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2636 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr "ブランチ"

-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2639 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr "コミット"

-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2642 lib/merge.tcl:123 lib/merge.tcl:152 lib/merge.tcl:170
 msgid "Merge"
 msgstr "マージ"

-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2643 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr "リモート"

-#: git-gui.sh:2468
+#: git-gui.sh:2646
 msgid "Tools"
 msgstr "ツール"

-#: git-gui.sh:2477
+#: git-gui.sh:2655
 msgid "Explore Working Copy"
 msgstr "ワーキングコピーをブラウズ"

-#: git-gui.sh:2483
+#: git-gui.sh:2661
 msgid "Browse Current Branch's Files"
 msgstr "現在のブランチのファイルを見る"

-#: git-gui.sh:2487
+#: git-gui.sh:2665
 msgid "Browse Branch Files..."
 msgstr "ブランチのファイルを見る…"

-#: git-gui.sh:2492
+#: git-gui.sh:2670
 msgid "Visualize Current Branch's History"
 msgstr "現在のブランチの履歴を見る"

-#: git-gui.sh:2496
+#: git-gui.sh:2674
 msgid "Visualize All Branch History"
 msgstr "全てのブランチの履歴を見る"

-#: git-gui.sh:2503
+#: git-gui.sh:2681
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "ブランチ %s のファイルを見る"

-#: git-gui.sh:2505
+#: git-gui.sh:2683
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "ブランチ %s の履歴を見る"

-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2688 lib/database.tcl:40 lib/database.tcl:66
 msgid "Database Statistics"
 msgstr "データベース統計"

-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2691 lib/database.tcl:33
 msgid "Compress Database"
 msgstr "データベース圧縮"

-#: git-gui.sh:2516
+#: git-gui.sh:2694
 msgid "Verify Database"
 msgstr "データベース検証"

-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: git-gui.sh:2701 git-gui.sh:2705 git-gui.sh:2709 lib/shortcut.tcl:8
 #: lib/shortcut.tcl:40 lib/shortcut.tcl:72
 msgid "Create Desktop Icon"
 msgstr "デスクトップ・アイコンを作る"

-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2717 lib/choose_repository.tcl:188 lib/choose_repository.tcl:196
 msgid "Quit"
 msgstr "終了"

-#: git-gui.sh:2547
+#: git-gui.sh:2725
 msgid "Undo"
 msgstr "元に戻す"

-#: git-gui.sh:2550
+#: git-gui.sh:2728
 msgid "Redo"
 msgstr "やり直し"

-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2732 git-gui.sh:3321
 msgid "Cut"
 msgstr "切り取り"

-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2735 git-gui.sh:3324 git-gui.sh:3398 git-gui.sh:3483
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "コピー"

-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2738 git-gui.sh:3327
 msgid "Paste"
 msgstr "貼り付け"

-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2741 git-gui.sh:3330 lib/branch_delete.tcl:28
+#: lib/remote_branch_delete.tcl:39
 msgid "Delete"
 msgstr "削除"

-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2745 git-gui.sh:3334 git-gui.sh:3487 lib/console.tcl:71
 msgid "Select All"
 msgstr "全て選択"

-#: git-gui.sh:2576
+#: git-gui.sh:2754
 msgid "Create..."
 msgstr "作成…"

-#: git-gui.sh:2582
+#: git-gui.sh:2760
 msgid "Checkout..."
 msgstr "チェックアウト"

-#: git-gui.sh:2588
+#: git-gui.sh:2766
 msgid "Rename..."
 msgstr "名前変更…"

-#: git-gui.sh:2593
+#: git-gui.sh:2771
 msgid "Delete..."
 msgstr "削除…"

-#: git-gui.sh:2598
+#: git-gui.sh:2776
 msgid "Reset..."
 msgstr "リセット…"

-#: git-gui.sh:2608
+#: git-gui.sh:2786
 msgid "Done"
 msgstr "完了"

-#: git-gui.sh:2610
+#: git-gui.sh:2788
 msgid "Commit@@verb"
 msgstr "コミット"

-#: git-gui.sh:2619 git-gui.sh:3050
+#: git-gui.sh:2797 git-gui.sh:3262
 msgid "New Commit"
 msgstr "新規コミット"

-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2805 git-gui.sh:3269
 msgid "Amend Last Commit"
 msgstr "最新コミットを訂正"

-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2815 git-gui.sh:3223 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr "再スキャン"

-#: git-gui.sh:2643
+#: git-gui.sh:2821
 msgid "Stage To Commit"
 msgstr "コミット予定する"

-#: git-gui.sh:2649
+#: git-gui.sh:2827
 msgid "Stage Changed Files To Commit"
 msgstr "変更されたファイルをコミット予定"

-#: git-gui.sh:2655
+#: git-gui.sh:2833
 msgid "Unstage From Commit"
 msgstr "コミットから降ろす"

-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2839 lib/index.tcl:442
 msgid "Revert Changes"
 msgstr "変更を元に戻す"

-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2847 git-gui.sh:3534 git-gui.sh:3565
 msgid "Show Less Context"
 msgstr "文脈を少なく"

-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2851 git-gui.sh:3538 git-gui.sh:3569
 msgid "Show More Context"
 msgstr "文脈を多く"

-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2858 git-gui.sh:3236 git-gui.sh:3345
 msgid "Sign Off"
 msgstr "署名"

-#: git-gui.sh:2696
+#: git-gui.sh:2874
 msgid "Local Merge..."
 msgstr "ローカル・マージ…"

-#: git-gui.sh:2701
+#: git-gui.sh:2879
 msgid "Abort Merge..."
 msgstr "マージ中止…"

-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2891 git-gui.sh:2919
 msgid "Add..."
 msgstr "追加"

-#: git-gui.sh:2717
+#: git-gui.sh:2895
 msgid "Push..."
 msgstr "プッシュ…"

-#: git-gui.sh:2721
+#: git-gui.sh:2899
 msgid "Delete Branch..."
 msgstr "ブランチ削除..."

-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:2909 git-gui.sh:3516
 msgid "Options..."
 msgstr "オプション…"

-#: git-gui.sh:2742
+#: git-gui.sh:2920
 msgid "Remove..."
 msgstr "削除..."

-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:2929 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "ヘルプ"

-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: git-gui.sh:2933 git-gui.sh:2937 lib/about.tcl:14
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr "%s について"

-#: git-gui.sh:2783
+#: git-gui.sh:2961
 msgid "Online Documentation"
 msgstr "オンライン・ドキュメント"

-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:2964 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
 msgid "Show SSH Key"
 msgstr "SSH キーを表示"

-#: git-gui.sh:2893
+#: git-gui.sh:2983 git-gui.sh:3115
+msgid "Usage"
+msgstr "使用状況"
+
+#: git-gui.sh:3064 lib/blame.tcl:573
+msgid "Error"
+msgstr "エラー"
+
+#: git-gui.sh:3095
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr ""
-"致命的: パス %s が stat できません。そのようなファイルやディレクトリはありま"
-"せん"
+msgstr "致命的: パス %s が stat できません。そのようなファイルやディレクトリはありません"

-#: git-gui.sh:2926
+#: git-gui.sh:3128
 msgid "Current Branch:"
 msgstr "現在のブランチ"

-#: git-gui.sh:2947
+#: git-gui.sh:3154
 msgid "Staged Changes (Will Commit)"
 msgstr "ステージングされた（コミット予定済の）変更"

-#: git-gui.sh:2967
+#: git-gui.sh:3174
 msgid "Unstaged Changes"
 msgstr "コミット予定に入っていない変更"

-#: git-gui.sh:3017
+#: git-gui.sh:3229
 msgid "Stage Changed"
 msgstr "変更をコミット予定に入れる"

-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3248 lib/transport.tcl:137 lib/transport.tcl:229
 msgid "Push"
 msgstr "プッシュ"

-#: git-gui.sh:3071
+#: git-gui.sh:3283
 msgid "Initial Commit Message:"
 msgstr "最初のコミットメッセージ:"

-#: git-gui.sh:3072
+#: git-gui.sh:3284
 msgid "Amended Commit Message:"
 msgstr "訂正したコミットメッセージ:"

-#: git-gui.sh:3073
+#: git-gui.sh:3285
 msgid "Amended Initial Commit Message:"
 msgstr "訂正した最初のコミットメッセージ:"

-#: git-gui.sh:3074
+#: git-gui.sh:3286
 msgid "Amended Merge Commit Message:"
 msgstr "訂正したマージコミットメッセージ:"

-#: git-gui.sh:3075
+#: git-gui.sh:3287
 msgid "Merge Commit Message:"
 msgstr "マージコミットメッセージ:"

-#: git-gui.sh:3076
+#: git-gui.sh:3288
 msgid "Commit Message:"
 msgstr "コミットメッセージ:"

-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3337 git-gui.sh:3491 lib/console.tcl:73
 msgid "Copy All"
 msgstr "全てコピー"

-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3361 lib/blame.tcl:105
 msgid "File:"
 msgstr "ファイル:"

-#: git-gui.sh:3255
+#: git-gui.sh:3479
 msgid "Refresh"
 msgstr "再読み込み"

-#: git-gui.sh:3276
+#: git-gui.sh:3500
 msgid "Decrease Font Size"
 msgstr "フォントを小さく"

-#: git-gui.sh:3280
+#: git-gui.sh:3504
 msgid "Increase Font Size"
 msgstr "フォントを大きく"

-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3512 lib/blame.tcl:294
 msgid "Encoding"
 msgstr "エンコーディング"

-#: git-gui.sh:3299
+#: git-gui.sh:3523
 msgid "Apply/Reverse Hunk"
 msgstr "パッチを適用/取り消す"

-#: git-gui.sh:3304
+#: git-gui.sh:3528
 msgid "Apply/Reverse Line"
 msgstr "パッチ行を適用/取り消す"

-#: git-gui.sh:3323
+#: git-gui.sh:3547
 msgid "Run Merge Tool"
 msgstr "マージツールを起動"

-#: git-gui.sh:3328
+#: git-gui.sh:3552
 msgid "Use Remote Version"
 msgstr "リモートの方を採用"

-#: git-gui.sh:3332
+#: git-gui.sh:3556
 msgid "Use Local Version"
 msgstr "ローカルの方を採用"

-#: git-gui.sh:3336
+#: git-gui.sh:3560
 msgid "Revert To Base"
 msgstr "ベース版を採用"

-#: git-gui.sh:3354
+#: git-gui.sh:3578
 msgid "Visualize These Changes In The Submodule"
 msgstr "サブモジュール内のこれらの変更を見る"

-#: git-gui.sh:3358
+#: git-gui.sh:3582
 msgid "Visualize Current Branch History In The Submodule"
 msgstr "サブモジュール内で現在のブランチの履歴を見る"

-#: git-gui.sh:3362
+#: git-gui.sh:3586
 msgid "Visualize All Branch History In The Submodule"
 msgstr "サブモジュール内で全てのブランチの履歴を見る"

-#: git-gui.sh:3367
+#: git-gui.sh:3591
 msgid "Start git gui In The Submodule"
 msgstr "サブモジュール内でgit guiを起動する"

-#: git-gui.sh:3389
+#: git-gui.sh:3626
 msgid "Unstage Hunk From Commit"
 msgstr "パッチをコミット予定から外す"

-#: git-gui.sh:3391
+#: git-gui.sh:3628
 msgid "Unstage Lines From Commit"
 msgstr "コミット予定から行を外す"

-#: git-gui.sh:3393
+#: git-gui.sh:3630
 msgid "Unstage Line From Commit"
 msgstr "コミット予定から行を外す"

-#: git-gui.sh:3396
+#: git-gui.sh:3633
 msgid "Stage Hunk For Commit"
 msgstr "パッチをコミット予定に加える"

-#: git-gui.sh:3398
+#: git-gui.sh:3635
 msgid "Stage Lines For Commit"
 msgstr "パッチ行をコミット予定に加える"

-#: git-gui.sh:3400
+#: git-gui.sh:3637
 msgid "Stage Line For Commit"
 msgstr "パッチ行をコミット予定に加える"

-#: git-gui.sh:3424
+#: git-gui.sh:3662
 msgid "Initializing..."
 msgstr "初期化しています…"

-#: git-gui.sh:3541
+#: git-gui.sh:3805
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -543,7 +561,7 @@ msgstr ""
 "以下の環境変数は %s が起動する Git サブプロセスによって無視されるでしょう:\n"
 "\n"

-#: git-gui.sh:3570
+#: git-gui.sh:3834
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -553,7 +571,7 @@ msgstr ""
 "これは Cygwin で配布されている Tcl バイナリに\n"
 "関しての既知の問題によります"

-#: git-gui.sh:3575
+#: git-gui.sh:3839
 #, tcl-format
 msgid ""
 "\n"
@@ -572,165 +590,168 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "Git のグラフィカルUI git-gui"

-#: lib/blame.tcl:72
+#: lib/blame.tcl:73
 msgid "File Viewer"
 msgstr "ファイルピューワ"

-#: lib/blame.tcl:78
+#: lib/blame.tcl:79
 msgid "Commit:"
 msgstr "コミット:"

-#: lib/blame.tcl:271
+#: lib/blame.tcl:280
 msgid "Copy Commit"
 msgstr "コミットをコピー"

-#: lib/blame.tcl:275
+#: lib/blame.tcl:284
 msgid "Find Text..."
 msgstr "テキストを検索"

-#: lib/blame.tcl:284
+#: lib/blame.tcl:288
+msgid "Goto Line..."
+msgstr "指定行へ移動"
+
+#: lib/blame.tcl:297
 msgid "Do Full Copy Detection"
 msgstr "コピー検知"

-#: lib/blame.tcl:288
+#: lib/blame.tcl:301
 msgid "Show History Context"
 msgstr "文脈を見せる"

-#: lib/blame.tcl:291
+#: lib/blame.tcl:304
 msgid "Blame Parent Commit"
 msgstr "親コミットを註釈"

-#: lib/blame.tcl:450
+#: lib/blame.tcl:466
 #, tcl-format
 msgid "Reading %s..."
 msgstr "%s を読んでいます…"

-#: lib/blame.tcl:557
+#: lib/blame.tcl:594
 msgid "Loading copy/move tracking annotations..."
 msgstr "コピー・移動追跡データを読んでいます…"

-#: lib/blame.tcl:577
+#: lib/blame.tcl:614
 msgid "lines annotated"
 msgstr "行を注釈しました"

-#: lib/blame.tcl:769
+#: lib/blame.tcl:806
 msgid "Loading original location annotations..."
 msgstr "元位置行の注釈データを読んでいます…"

-#: lib/blame.tcl:772
+#: lib/blame.tcl:809
 msgid "Annotation complete."
 msgstr "注釈完了しました"

-#: lib/blame.tcl:802
+#: lib/blame.tcl:839
 msgid "Busy"
 msgstr "実行中"

-#: lib/blame.tcl:803
+#: lib/blame.tcl:840
 msgid "Annotation process is already running."
 msgstr "すでに blame プロセスを実行中です。"

-#: lib/blame.tcl:842
+#: lib/blame.tcl:879
 msgid "Running thorough copy detection..."
 msgstr "コピー検知を実行中…"

-#: lib/blame.tcl:910
+#: lib/blame.tcl:947
 msgid "Loading annotation..."
 msgstr "注釈を読み込んでいます…"

-#: lib/blame.tcl:963
+#: lib/blame.tcl:1000
 msgid "Author:"
 msgstr "作者:"

-#: lib/blame.tcl:967
+#: lib/blame.tcl:1004
 msgid "Committer:"
 msgstr "コミット者:"

-#: lib/blame.tcl:972
+#: lib/blame.tcl:1009
 msgid "Original File:"
 msgstr "元ファイル"

-#: lib/blame.tcl:1020
+#: lib/blame.tcl:1057
 msgid "Cannot find HEAD commit:"
 msgstr "HEAD コミットが見つかりません"

-#: lib/blame.tcl:1075
+#: lib/blame.tcl:1112
 msgid "Cannot find parent commit:"
 msgstr "親コミットが見つかりません:"

-#: lib/blame.tcl:1090
+#: lib/blame.tcl:1127
 msgid "Unable to display parent"
 msgstr "親を表示できません"

-#: lib/blame.tcl:1091 lib/diff.tcl:320
+#: lib/blame.tcl:1128 lib/diff.tcl:338
 msgid "Error loading diff:"
 msgstr "diff を読む際のエラーです:"

-#: lib/blame.tcl:1231
+#: lib/blame.tcl:1269
 msgid "Originally By:"
 msgstr "原作者:"

-#: lib/blame.tcl:1237
+#: lib/blame.tcl:1275
 msgid "In File:"
 msgstr "ファイル:"

-#: lib/blame.tcl:1242
+#: lib/blame.tcl:1280
 msgid "Copied Or Moved Here By:"
 msgstr "複写・移動者:"

-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+#: lib/branch_checkout.tcl:16 lib/branch_checkout.tcl:21
 msgid "Checkout Branch"
 msgstr "ブランチをチェックアウト"

-#: lib/branch_checkout.tcl:23
+#: lib/branch_checkout.tcl:26
 msgid "Checkout"
 msgstr "チェックアウト"

-#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
-#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
-#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:108
+#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37 lib/branch_delete.tcl:34
+#: lib/branch_rename.tcl:32 lib/browser.tcl:292 lib/checkout_op.tcl:579
+#: lib/choose_font.tcl:45 lib/merge.tcl:174 lib/option.tcl:127
+#: lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/transport.tcl:141
 msgid "Cancel"
 msgstr "中止"

-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
+#: lib/branch_checkout.tcl:35 lib/browser.tcl:297 lib/tools_dlg.tcl:321
 msgid "Revision"
 msgstr "リビジョン"

-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:69 lib/option.tcl:307
 msgid "Options"
 msgstr "オプション"

-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
 msgstr "トラッキング・ブランチをフェッチ"

-#: lib/branch_checkout.tcl:44
+#: lib/branch_checkout.tcl:47
 msgid "Detach From Local Branch"
 msgstr "ローカル・ブランチから削除"

-#: lib/branch_create.tcl:22
+#: lib/branch_create.tcl:23
 msgid "Create Branch"
 msgstr "ブランチを作成"

-#: lib/branch_create.tcl:27
+#: lib/branch_create.tcl:28
 msgid "Create New Branch"
 msgstr "ブランチを新規作成"

-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
+#: lib/branch_create.tcl:33 lib/choose_repository.tcl:383
 msgid "Create"
 msgstr "作成"

-#: lib/branch_create.tcl:40
+#: lib/branch_create.tcl:42
 msgid "Branch Name"
 msgstr "ブランチ名"

-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
+#: lib/branch_create.tcl:44 lib/remote_add.tcl:41 lib/tools_dlg.tcl:51
 msgid "Name:"
 msgstr "名前:"

-#: lib/branch_create.tcl:58
+#: lib/branch_create.tcl:57
 msgid "Match Tracking Branch Name"
 msgstr "トラッキング・ブランチ名を合わせる"

@@ -758,41 +779,41 @@ msgstr "リセット"
 msgid "Checkout After Creation"
 msgstr "作成してすぐチェックアウト"

-#: lib/branch_create.tcl:131
+#: lib/branch_create.tcl:132
 msgid "Please select a tracking branch."
 msgstr "トラッキング・ブランチを選択して下さい。"

-#: lib/branch_create.tcl:140
+#: lib/branch_create.tcl:141
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
 msgstr "トラッキング・ブランチ %s は遠隔リポジトリのブランチではありません。"

-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+#: lib/branch_create.tcl:154 lib/branch_rename.tcl:92
 msgid "Please supply a branch name."
 msgstr "ブランチ名を指定して下さい。"

-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#: lib/branch_create.tcl:165 lib/branch_rename.tcl:112
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
 msgstr "'%s' はブランチ名に使えません。"

-#: lib/branch_delete.tcl:15
+#: lib/branch_delete.tcl:16
 msgid "Delete Branch"
 msgstr "ブランチ削除"

-#: lib/branch_delete.tcl:20
+#: lib/branch_delete.tcl:21
 msgid "Delete Local Branch"
 msgstr "ローカル・ブランチを削除"

-#: lib/branch_delete.tcl:37
+#: lib/branch_delete.tcl:39
 msgid "Local Branches"
 msgstr "ローカル・ブランチ"

-#: lib/branch_delete.tcl:52
+#: lib/branch_delete.tcl:51
 msgid "Delete Only If Merged Into"
 msgstr "マージ済みの時のみ削除"

-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+#: lib/branch_delete.tcl:53 lib/remote_branch_delete.tcl:120
 msgid "Always (Do not perform merge checks)"
 msgstr "無条件（マージ検査をしない）"

@@ -801,7 +822,7 @@ msgstr "無条件（マージ検査をしない）"
 msgid "The following branches are not completely merged into %s:"
 msgstr "以下のブランチは %s に完全にマージされていません:"

-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:218
 msgid ""
 "Recovering deleted branches is difficult.\n"
 "\n"
@@ -820,32 +841,32 @@ msgstr ""
 "以下のブランチを削除できません:\n"
 "%s"

-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+#: lib/branch_rename.tcl:15 lib/branch_rename.tcl:23
 msgid "Rename Branch"
 msgstr "ブランチの名前変更"

-#: lib/branch_rename.tcl:26
+#: lib/branch_rename.tcl:28
 msgid "Rename"
 msgstr "名前変更"

-#: lib/branch_rename.tcl:36
+#: lib/branch_rename.tcl:38
 msgid "Branch:"
 msgstr "ブランチ:"

-#: lib/branch_rename.tcl:39
+#: lib/branch_rename.tcl:46
 msgid "New Name:"
 msgstr "新しい名前:"

-#: lib/branch_rename.tcl:75
+#: lib/branch_rename.tcl:81
 msgid "Please select a branch to rename."
 msgstr "名前を変更するブランチを選んで下さい。"

-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
+#: lib/branch_rename.tcl:102 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "'%s'というブランチは既に存在します。"

-#: lib/branch_rename.tcl:117
+#: lib/branch_rename.tcl:123
 #, tcl-format
 msgid "Failed to rename '%s'."
 msgstr "'%s'の名前変更に失敗しました。"
@@ -854,26 +875,26 @@ msgstr "'%s'の名前変更に失敗しました。"
 msgid "Starting..."
 msgstr "起動中…"

-#: lib/browser.tcl:26
+#: lib/browser.tcl:27
 msgid "File Browser"
 msgstr "ファイル・ブラウザ"

-#: lib/browser.tcl:126 lib/browser.tcl:143
+#: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
 msgid "Loading %s..."
 msgstr "%s をロード中…"

-#: lib/browser.tcl:187
+#: lib/browser.tcl:193
 msgid "[Up To Parent]"
 msgstr "[上位フォルダへ]"

-#: lib/browser.tcl:267 lib/browser.tcl:273
+#: lib/browser.tcl:275 lib/browser.tcl:282
 msgid "Browse Branch Files"
 msgstr "現在のブランチのファイルを見る"

-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
+#: lib/browser.tcl:288 lib/choose_repository.tcl:398
+#: lib/choose_repository.tcl:485 lib/choose_repository.tcl:494
+#: lib/choose_repository.tcl:1021
 msgid "Browse"
 msgstr "ブラウズ"

@@ -887,8 +908,8 @@ msgstr "%s から %s をフェッチしています"
 msgid "fatal: Cannot resolve %s"
 msgstr "致命的エラー: %s を解決できません"

-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:30
+#: lib/sshkey.tcl:55
 msgid "Close"
 msgstr "閉じる"

@@ -940,8 +961,7 @@ msgid ""
 msgstr ""
 "最後にスキャンした状態はリポジトリの状態と合致しません。\n"
 "\n"
-"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。現在"
-"のブランチを変更する前に、再スキャンが必要です。\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。現在のブランチを変更する前に、再スキャンが必要です。\n"
 "\n"
 "自動的に再スキャンを開始します。\n"

@@ -977,8 +997,7 @@ msgid ""
 msgstr ""
 "ローカル・ブランチから離れます。\n"
 "\n"
-"ブランチ上に滞まりたいときは、この「分離されたチェックアウト」から新規ブラン"
-"チを開始してください。"
+"ブランチ上に滞まりたいときは、この「分離されたチェックアウト」から新規ブランチを開始してください。"

 #: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
@@ -999,7 +1018,7 @@ msgstr "失なわれたコミットを回復するのは簡単ではありませ
 msgid "Reset '%s'?"
 msgstr "'%s' をリセットしますか？"

-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:567 lib/merge.tcl:166 lib/tools_dlg.tcl:336
 msgid "Visualize"
 msgstr "可視化"

@@ -1015,27 +1034,26 @@ msgid ""
 msgstr ""
 "現在のブランチを設定できません。\n"
 "\n"
-"作業ディレクトリは部分的にしか切り替わっていません。ファイルの更新には成功し"
-"ましたが、 Git の内部データを更新できませんでした。\n"
+"作業ディレクトリは部分的にしか切り替わっていません。ファイルの更新には成功しましたが、 Git の内部データを更新できませんでした。\n"
 "起こるはずのないエラーです。あきらめて %s を終了します。"

-#: lib/choose_font.tcl:39
+#: lib/choose_font.tcl:41
 msgid "Select"
 msgstr "選択"

-#: lib/choose_font.tcl:53
+#: lib/choose_font.tcl:55
 msgid "Font Family"
 msgstr "フォント・ファミリー"

-#: lib/choose_font.tcl:74
+#: lib/choose_font.tcl:76
 msgid "Font Size"
 msgstr "フォントの大きさ"

-#: lib/choose_font.tcl:91
+#: lib/choose_font.tcl:93
 msgid "Font Example"
 msgstr "フォント・サンプル"

-#: lib/choose_font.tcl:103
+#: lib/choose_font.tcl:105
 msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
@@ -1047,7 +1065,7 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git GUI"

-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:388
 msgid "Create New Repository"
 msgstr "新しいリポジトリを作る"

@@ -1055,42 +1073,42 @@ msgstr "新しいリポジトリを作る"
 msgid "New..."
 msgstr "新規…"

-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:472
 msgid "Clone Existing Repository"
 msgstr "既存リポジトリを複製する"

-#: lib/choose_repository.tcl:106
+#: lib/choose_repository.tcl:111
 msgid "Clone..."
 msgstr "複製…"

-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
+#: lib/choose_repository.tcl:118 lib/choose_repository.tcl:1011
 msgid "Open Existing Repository"
 msgstr "既存リポジトリを開く"

-#: lib/choose_repository.tcl:119
+#: lib/choose_repository.tcl:124
 msgid "Open..."
 msgstr "開く…"

-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:137
 msgid "Recent Repositories"
 msgstr "最近使ったリポジトリ"

-#: lib/choose_repository.tcl:138
+#: lib/choose_repository.tcl:143
 msgid "Open Recent Repository:"
 msgstr "最近使ったリポジトリを開く"

-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/choose_repository.tcl:307 lib/choose_repository.tcl:314
+#: lib/choose_repository.tcl:321
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "リポジトリ %s を作製できません:"

-#: lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:393
 msgid "Directory:"
 msgstr "ディレクトリ:"

-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
+#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1045
 msgid "Git Repository"
 msgstr "GIT リポジトリ"

@@ -1104,173 +1122,173 @@ msgstr "ディレクトリ '%s' は既に存在します。"
 msgid "File %s already exists."
 msgstr "ファイル '%s' は既に存在します。"

-#: lib/choose_repository.tcl:466
+#: lib/choose_repository.tcl:467
 msgid "Clone"
 msgstr "複製"

-#: lib/choose_repository.tcl:479
+#: lib/choose_repository.tcl:480
 msgid "Source Location:"
 msgstr "ソースの位置"

-#: lib/choose_repository.tcl:490
+#: lib/choose_repository.tcl:489
 msgid "Target Directory:"
-msgstr "先ディレクトリ:"
+msgstr "保存ディレクトリ:"

-#: lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:499
 msgid "Clone Type:"
 msgstr "複製方式:"

-#: lib/choose_repository.tcl:508
+#: lib/choose_repository.tcl:504
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "標準(高速・中冗長度・ハードリンク)"

-#: lib/choose_repository.tcl:514
+#: lib/choose_repository.tcl:509
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "全複写(低速・冗長バックアップ)"

-#: lib/choose_repository.tcl:520
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "共有(最高速・非推奨・バックアップ無し)"

-#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
-#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1051 lib/choose_repository.tcl:1059
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Git リポジトリではありません: %s"

-#: lib/choose_repository.tcl:592
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "標準方式は同一計算機上のリポジトリにのみ使えます。"

-#: lib/choose_repository.tcl:596
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "共有方式は同一計算機上のリポジトリにのみ使えます。"

-#: lib/choose_repository.tcl:617
+#: lib/choose_repository.tcl:611
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "'%s' は既に存在します。"

-#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
 msgstr "origin を設定できませんでした"

-#: lib/choose_repository.tcl:640
+#: lib/choose_repository.tcl:634
 msgid "Counting objects"
 msgstr "オブジェクトを数えています"

-#: lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:635
 msgid "buckets"
 msgstr "バケツ"

-#: lib/choose_repository.tcl:665
+#: lib/choose_repository.tcl:659
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "objects/info/alternates を複写できません: %s"

-#: lib/choose_repository.tcl:701
+#: lib/choose_repository.tcl:695
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "%s から複製する内容はありません"

-#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
-#: lib/choose_repository.tcl:929
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
 msgid "The 'master' branch has not been initialized."
 msgstr "'master' ブランチが初期化されていません"

-#: lib/choose_repository.tcl:716
+#: lib/choose_repository.tcl:710
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "ハードリンクが作れないので、コピーします"

-#: lib/choose_repository.tcl:728
+#: lib/choose_repository.tcl:722
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "%s から複製しています"

-#: lib/choose_repository.tcl:759
+#: lib/choose_repository.tcl:753
 msgid "Copying objects"
 msgstr "オブジェクトを複写しています"

-#: lib/choose_repository.tcl:760
+#: lib/choose_repository.tcl:754
 msgid "KiB"
 msgstr "KiB"

-#: lib/choose_repository.tcl:784
+#: lib/choose_repository.tcl:778
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "オブジェクトを複写できません: %s"

-#: lib/choose_repository.tcl:794
+#: lib/choose_repository.tcl:788
 msgid "Linking objects"
 msgstr "オブジェクトを連結しています"

-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:789
 msgid "objects"
 msgstr "オブジェクト"

-#: lib/choose_repository.tcl:803
+#: lib/choose_repository.tcl:797
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "オブジェクトをハードリンクできません: %s"

-#: lib/choose_repository.tcl:858
+#: lib/choose_repository.tcl:852
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr "ブランチやオブジェクトを取得できません。コンソール出力を見て下さい"

-#: lib/choose_repository.tcl:869
+#: lib/choose_repository.tcl:863
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "タグを取得できません。コンソール出力を見て下さい"

-#: lib/choose_repository.tcl:893
+#: lib/choose_repository.tcl:887
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "HEAD を確定できません。コンソール出力を見て下さい"

-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:896
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "%s を掃除できません"

-#: lib/choose_repository.tcl:908
+#: lib/choose_repository.tcl:902
 msgid "Clone failed."
 msgstr "複写に失敗しました。"

-#: lib/choose_repository.tcl:915
+#: lib/choose_repository.tcl:909
 msgid "No default branch obtained."
 msgstr "デフォールト・ブランチが取得されませんでした"

-#: lib/choose_repository.tcl:926
+#: lib/choose_repository.tcl:920
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "%s をコミットとして解釈できません"

-#: lib/choose_repository.tcl:938
+#: lib/choose_repository.tcl:932
 msgid "Creating working directory"
 msgstr "作業ディレクトリを作成しています"

-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
+#: lib/choose_repository.tcl:933 lib/index.tcl:70 lib/index.tcl:136
+#: lib/index.tcl:207
 msgid "files"
 msgstr "ファイル"

-#: lib/choose_repository.tcl:968
+#: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
 msgstr "初期チェックアウトに失敗しました"

-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:1006
 msgid "Open"
 msgstr "開く"

-#: lib/choose_repository.tcl:1021
+#: lib/choose_repository.tcl:1016
 msgid "Repository:"
 msgstr "リポジトリ:"

-#: lib/choose_repository.tcl:1072
+#: lib/choose_repository.tcl:1065
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "リポジトリ %s を開けません:"

-#: lib/choose_rev.tcl:53
+#: lib/choose_rev.tcl:52
 msgid "This Detached Checkout"
 msgstr "分離されたチェックアウト"

@@ -1278,36 +1296,36 @@ msgstr "分離されたチェックアウト"
 msgid "Revision Expression:"
 msgstr "リビジョン式:"

-#: lib/choose_rev.tcl:74
+#: lib/choose_rev.tcl:72
 msgid "Local Branch"
 msgstr "ローカル・ブランチ"

-#: lib/choose_rev.tcl:79
+#: lib/choose_rev.tcl:77
 msgid "Tracking Branch"
 msgstr "トラッキング・ブランチ"

-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
 msgid "Tag"
 msgstr "タグ"

-#: lib/choose_rev.tcl:317
+#: lib/choose_rev.tcl:321
 #, tcl-format
 msgid "Invalid revision: %s"
 msgstr "無効なリビジョン: %s"

-#: lib/choose_rev.tcl:338
+#: lib/choose_rev.tcl:342
 msgid "No revision selected."
 msgstr "リビジョンが未選択です。"

-#: lib/choose_rev.tcl:346
+#: lib/choose_rev.tcl:350
 msgid "Revision expression is empty."
 msgstr "リビジョン式が空です。"

-#: lib/choose_rev.tcl:531
+#: lib/choose_rev.tcl:537
 msgid "Updated"
 msgstr "更新しました"

-#: lib/choose_rev.tcl:559
+#: lib/choose_rev.tcl:565
 msgid "URL"
 msgstr "URL"

@@ -1320,8 +1338,7 @@ msgid ""
 msgstr ""
 "訂正するコミットがそもそもありません。\n"
 "\n"
-"これから作るのは最初のコミットです。その前にはまだ訂正するようなコミットはあ"
-"りません。\n"
+"これから作るのは最初のコミットです。その前にはまだ訂正するようなコミットはありません。\n"

 #: lib/commit.tcl:18
 msgid ""
@@ -1333,8 +1350,7 @@ msgid ""
 msgstr ""
 "マージ中にコミットの訂正はできません。\n"
 "\n"
-"現在はまだマージの途中です。先にこのマージを中止しないと、前のコミットの訂正"
-"はできません\n"
+"現在はまだマージの途中です。先にこのマージを中止しないと、前のコミットの訂正はできません\n"

 #: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
@@ -1364,12 +1380,11 @@ msgid ""
 msgstr ""
 "最後にスキャンした状態はリポジトリの状態と合致しません。\n"
 "\n"
-"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。新し"
-"くコミットする前に、再スキャンが必要です。\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。新しくコミットする前に、再スキャンが必要です。\n"
 "\n"
 "自動的に再スキャンを開始します。\n"

-#: lib/commit.tcl:172
+#: lib/commit.tcl:173
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1379,10 +1394,9 @@ msgid ""
 msgstr ""
 "マージしていないファイルはコミットできません。\n"
 "\n"
-"ファイル %s にはマージ衝突が残っています。まず解決してコミット予定に加える必"
-"要があります。\n"
+"ファイル %s にはマージ衝突が残っています。まず解決してコミット予定に加える必要があります。\n"

-#: lib/commit.tcl:180
+#: lib/commit.tcl:181
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1393,7 +1407,7 @@ msgstr ""
 "\n"
 "ファイル %s は本プログラムではコミットできません。\n"

-#: lib/commit.tcl:188
+#: lib/commit.tcl:189
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1403,7 +1417,7 @@ msgstr ""
 "\n"
 "最低一つの変更をコミット予定に加えてからコミットして下さい。\n"

-#: lib/commit.tcl:203
+#: lib/commit.tcl:204
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1421,40 +1435,55 @@ msgstr ""
 "- 第２行: 空白\n"
 "- 残りの行: なぜ、この変更が良い変更か、の説明。\n"

-#: lib/commit.tcl:234
+#: lib/commit.tcl:235
 msgid "Calling pre-commit hook..."
 msgstr "コミット前フックを実行中・・・"

-#: lib/commit.tcl:249
+#: lib/commit.tcl:250
 msgid "Commit declined by pre-commit hook."
 msgstr "コミット前フックがコミットを拒否しました"

-#: lib/commit.tcl:272
+#: lib/commit.tcl:269
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+"あなたはdetached "
+"head状態でコミットしようとしています。これは危険な操作です。もし続行すれば、他ブランチへ切り替えた際に変更を失ったり、reflogで変更を復元することが困難になります。あなたは次の操作をするべきです。1.
"
+"このコミットをキャンセルする。2. 新しいブランチを作り、コミットし直す。\n"
+"\n"
+"本当にこの危険なコミットを実行しますか？"
+
+#: lib/commit.tcl:290
 msgid "Calling commit-msg hook..."
 msgstr "コミット・メッセージ・フックを実行中・・・"

-#: lib/commit.tcl:287
+#: lib/commit.tcl:305
 msgid "Commit declined by commit-msg hook."
 msgstr "コミット・メッセージ・フックがコミットを拒否しました"

-#: lib/commit.tcl:300
+#: lib/commit.tcl:318
 msgid "Committing changes..."
 msgstr "変更点をコミット中・・・"

-#: lib/commit.tcl:316
+#: lib/commit.tcl:334
 msgid "write-tree failed:"
 msgstr "write-tree が失敗しました:"

-#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
+#: lib/commit.tcl:335 lib/commit.tcl:379 lib/commit.tcl:400
 msgid "Commit failed."
 msgstr "コミットに失敗しました。"

-#: lib/commit.tcl:334
+#: lib/commit.tcl:352
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "コミット %s は壊れています"

-#: lib/commit.tcl:339
+#: lib/commit.tcl:357
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1468,19 +1497,19 @@ msgstr ""
 "\n"
 "自動的に再スキャンを開始します。\n"

-#: lib/commit.tcl:346
+#: lib/commit.tcl:364
 msgid "No changes to commit."
 msgstr "コミットする変更がありません。"

-#: lib/commit.tcl:360
+#: lib/commit.tcl:378
 msgid "commit-tree failed:"
 msgstr "commit-tree が失敗しました:"

-#: lib/commit.tcl:381
+#: lib/commit.tcl:399
 msgid "update-ref failed:"
 msgstr "update-ref が失敗しました:"

-#: lib/commit.tcl:469
+#: lib/commit.tcl:492
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "コミット %s を作成しました: %s"
@@ -1497,31 +1526,31 @@ msgstr "成功"
 msgid "Error: Command Failed"
 msgstr "エラー: コマンドが失敗しました"

-#: lib/database.tcl:43
+#: lib/database.tcl:42
 msgid "Number of loose objects"
 msgstr "ばらばらなオブジェクトの数"

-#: lib/database.tcl:44
+#: lib/database.tcl:43
 msgid "Disk space used by loose objects"
 msgstr "ばらばらなオブジェクトの使用するディスク量"

-#: lib/database.tcl:45
+#: lib/database.tcl:44
 msgid "Number of packed objects"
 msgstr "パックされたオブジェクトの数"

-#: lib/database.tcl:46
+#: lib/database.tcl:45
 msgid "Number of packs"
 msgstr "パックの数"

-#: lib/database.tcl:47
+#: lib/database.tcl:46
 msgid "Disk space used by packed objects"
 msgstr "パックされたオブジェクトの使用するディスク量"

-#: lib/database.tcl:48
+#: lib/database.tcl:47
 msgid "Packed objects waiting for pruning"
 msgstr "パックに存在するので捨てて良いオブジェクトの数"

-#: lib/database.tcl:49
+#: lib/database.tcl:48
 msgid "Garbage files"
 msgstr "ゴミファイル"

@@ -1571,8 +1600,7 @@ msgstr ""
 "\n"
 "%s には変更がありません。\n"
 "\n"
-"このファイルの変更時刻は他のアプリケーションによって更新されていますがファイ"
-"ル内容には変更がありません。\n"
+"このファイルの変更時刻は他のアプリケーションによって更新されていますがファイル内容には変更がありません。\n"
 "\n"
 "同様な状態のファイルを探すために、自動的に再スキャンを開始します。"

@@ -1605,7 +1633,7 @@ msgstr "LOCAL:\n"
 msgid "REMOTE:\n"
 msgstr "REMOTE\n"

-#: lib/diff.tcl:202 lib/diff.tcl:319
+#: lib/diff.tcl:202 lib/diff.tcl:337
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "%s を表示できません"
@@ -1643,19 +1671,19 @@ msgstr ""
 "* %s は管理外のファイルをここで切りおとしました。\n"
 "* 全体を見るには外部エディタを使ってください。\n"

-#: lib/diff.tcl:482
+#: lib/diff.tcl:557
 msgid "Failed to unstage selected hunk."
 msgstr "選択されたパッチをコミット予定から外せません。"

-#: lib/diff.tcl:489
+#: lib/diff.tcl:564
 msgid "Failed to stage selected hunk."
 msgstr "選択されたパッチをコミット予定に加えられません。"

-#: lib/diff.tcl:568
+#: lib/diff.tcl:643
 msgid "Failed to unstage selected line."
 msgstr "選択されたパッチ行をコミット予定から外せません。"

-#: lib/diff.tcl:576
+#: lib/diff.tcl:651
 msgid "Failed to stage selected line."
 msgstr "選択されたパッチ行をコミット予定に加えられません。"

@@ -1672,7 +1700,7 @@ msgstr "システム (%s)"
 msgid "Other"
 msgstr "その他"

-#: lib/error.tcl:20 lib/error.tcl:114
+#: lib/error.tcl:20 lib/error.tcl:116
 msgid "error"
 msgstr "エラー"

@@ -1680,7 +1708,7 @@ msgstr "エラー"
 msgid "warning"
 msgstr "警告"

-#: lib/error.tcl:94
+#: lib/error.tcl:96
 msgid "You must correct the above errors before committing."
 msgstr "コミットする前に、以上のエラーを修正して下さい"

@@ -1688,67 +1716,78 @@ msgstr "コミットする前に、以上のエラーを修正して下さい"
 msgid "Unable to unlock the index."
 msgstr "インデックスをロックできません"

-#: lib/index.tcl:15
+#: lib/index.tcl:17
 msgid "Index Error"
 msgstr "索引エラー"

-#: lib/index.tcl:17
+#: lib/index.tcl:19
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to "
 "resynchronize git-gui."
-msgstr ""
-"GIT インデックスの更新が失敗しました。git-gui と同期をとるために再スキャンし"
-"ます。"
+msgstr "GIT インデックスの更新が失敗しました。git-gui と同期をとるために再スキャンします。"

-#: lib/index.tcl:28
+#: lib/index.tcl:30
 msgid "Continue"
 msgstr "続行"

-#: lib/index.tcl:31
+#: lib/index.tcl:33
 msgid "Unlock Index"
 msgstr "インデックスのロック解除"

-#: lib/index.tcl:289
+#: lib/index.tcl:298
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "コミットから '%s' を降ろす"

-#: lib/index.tcl:328
+#: lib/index.tcl:337
 msgid "Ready to commit."
 msgstr "コミット準備完了"

-#: lib/index.tcl:341
+#: lib/index.tcl:350
 #, tcl-format
 msgid "Adding %s"
 msgstr "コミットに %s を加えています"

-#: lib/index.tcl:398
+#: lib/index.tcl:380
+#, tcl-format
+msgid "Stage %d untracked files?"
+msgstr "%d 個の新規ファイルがあります。コミット予定してもいいですか？"
+
+#: lib/index.tcl:428
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "ファイル %s にした変更を元に戻しますか？"

-#: lib/index.tcl:400
+#: lib/index.tcl:430
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "これら %i 個のファイルにした変更を元に戻しますか？"

-#: lib/index.tcl:408
+#: lib/index.tcl:438
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr "変更を元に戻すとコミット予定していない変更は全て失われます。"

-#: lib/index.tcl:411
+#: lib/index.tcl:441
 msgid "Do Nothing"
 msgstr "何もしない"

-#: lib/index.tcl:429
+#: lib/index.tcl:459
 msgid "Reverting selected files"
 msgstr "選択されたファイルにした変更を元に戻します"

-#: lib/index.tcl:433
+#: lib/index.tcl:463
 #, tcl-format
 msgid "Reverting %s"
 msgstr "%s にした変更を元に戻します"

+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr "指定行へ移動:"
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr "移動"
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1770,8 +1809,7 @@ msgid ""
 msgstr ""
 "最後にスキャンした状態はリポジトリの状態と合致しません。\n"
 "\n"
-"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。マー"
-"ジを開始する前に、再スキャンが必要です。\n"
+"最後にスキャンして以後、別の Git プログラムがリポジトリを変更しています。マージを開始する前に、再スキャンが必要です。\n"
 "\n"
 "自動的に再スキャンを開始します。\n"

@@ -1789,8 +1827,7 @@ msgstr ""
 "\n"
 "ファイル %s にはマージ中の衝突が残っています。\n"
 "\n"
-"このファイルの衝突を解決し、コミット予定に加えて、コミットすることでマージを"
-"完了します。そうやって始めて、新たなマージを開始できるようになります。\n"
+"このファイルの衝突を解決し、コミット予定に加えて、コミットすることでマージを完了します。そうやって始めて、新たなマージを開始できるようになります。\n"

 #: lib/merge.tcl:55
 #, tcl-format
@@ -1806,37 +1843,36 @@ msgstr ""
 "\n"
 "ファイル %s は変更中です。\n"
 "\n"
-"現在のコミットを完了してからマージを開始して下さい。そうする方がマージに失敗"
-"したときの回復が楽です。\n"
+"現在のコミットを完了してからマージを開始して下さい。そうする方がマージに失敗したときの回復が楽です。\n"

-#: lib/merge.tcl:107
+#: lib/merge.tcl:108
 #, tcl-format
 msgid "%s of %s"
 msgstr "%s の %s ブランチ"

-#: lib/merge.tcl:120
+#: lib/merge.tcl:122
 #, tcl-format
 msgid "Merging %s and %s..."
 msgstr "%s と %s をマージ中・・・"

-#: lib/merge.tcl:131
+#: lib/merge.tcl:133
 msgid "Merge completed successfully."
 msgstr "マージが完了しました"

-#: lib/merge.tcl:133
+#: lib/merge.tcl:135
 msgid "Merge failed.  Conflict resolution is required."
 msgstr "マージが失敗しました。衝突の解決が必要です。"

-#: lib/merge.tcl:158
+#: lib/merge.tcl:160
 #, tcl-format
 msgid "Merge Into %s"
 msgstr "%s にマージ"

-#: lib/merge.tcl:177
+#: lib/merge.tcl:179
 msgid "Revision To Merge"
 msgstr "マージするリビジョン"

-#: lib/merge.tcl:212
+#: lib/merge.tcl:214
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
@@ -1846,7 +1882,7 @@ msgstr ""
 "\n"
 "まず今のコミット訂正を完了させて下さい。\n"

-#: lib/merge.tcl:222
+#: lib/merge.tcl:224
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1860,7 +1896,7 @@ msgstr ""
 "\n"
 "マージを中断してよろしいですか？"

-#: lib/merge.tcl:228
+#: lib/merge.tcl:230
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1874,19 +1910,19 @@ msgstr ""
 "\n"
 "リセットしてよろしいですか？"

-#: lib/merge.tcl:239
+#: lib/merge.tcl:241
 msgid "Aborting"
 msgstr "中断しています"

-#: lib/merge.tcl:239
+#: lib/merge.tcl:241
 msgid "files reset"
 msgstr "リセットしたファイル"

-#: lib/merge.tcl:267
+#: lib/merge.tcl:269
 msgid "Abort failed."
 msgstr "中断に失敗しました。"

-#: lib/merge.tcl:269
+#: lib/merge.tcl:271
 msgid "Abort completed.  Ready."
 msgstr "中断完了。"

@@ -1920,8 +1956,7 @@ msgstr ""
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr ""
-"ファイル %s には解決していない競合部分がまだあるようですが、いいですか?"
+msgstr "ファイル %s には解決していない競合部分がまだあるようですが、いいですか?"

 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -1936,21 +1971,21 @@ msgstr "ツールでは削除やリンク競合は扱えません"
 msgid "Conflict file does not exist"
 msgstr "競合ファイルは存在しません。"

-#: lib/mergetool.tcl:264
+#: lib/mergetool.tcl:246
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
 msgstr "GUI マージツールではありません: %s"

-#: lib/mergetool.tcl:268
+#: lib/mergetool.tcl:275
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
 msgstr "マージツール '%s' はサポートしていません"

-#: lib/mergetool.tcl:303
+#: lib/mergetool.tcl:310
 msgid "Merge tool is already running, terminate it?"
 msgstr "マージツールはすでに起動しています。終了しますか?"

-#: lib/mergetool.tcl:323
+#: lib/mergetool.tcl:330
 #, tcl-format
 msgid ""
 "Error retrieving versions:\n"
@@ -1959,7 +1994,7 @@ msgstr ""
 "版の取り出し時にエラーが出ました:\n"
 "%s"

-#: lib/mergetool.tcl:343
+#: lib/mergetool.tcl:350
 #, tcl-format
 msgid ""
 "Could not start the merge tool:\n"
@@ -1970,11 +2005,11 @@ msgstr ""
 "\n"
 "%s"

-#: lib/mergetool.tcl:347
+#: lib/mergetool.tcl:354
 msgid "Running merge tool..."
 msgstr "マージツールを実行しています..."

-#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
 msgid "Merge tool failed."
 msgstr "マージツールが失敗しました。"

@@ -1988,145 +2023,157 @@ msgstr "全体エンコーディングに 無効な %s が指定されていま
 msgid "Invalid repo encoding '%s'"
 msgstr "リポジトリエンコーディングに 無効な %s が指定されています"

-#: lib/option.tcl:117
+#: lib/option.tcl:119
 msgid "Restore Defaults"
 msgstr "既定値に戻す"

-#: lib/option.tcl:121
+#: lib/option.tcl:123
 msgid "Save"
 msgstr "保存"

-#: lib/option.tcl:131
+#: lib/option.tcl:133
 #, tcl-format
 msgid "%s Repository"
 msgstr "%s リポジトリ"

-#: lib/option.tcl:132
+#: lib/option.tcl:134
 msgid "Global (All Repositories)"
-msgstr "大域（全てのリポジトリ）"
+msgstr "標準設定（全てのリポジトリ）"

-#: lib/option.tcl:138
+#: lib/option.tcl:140
 msgid "User Name"
 msgstr "ユーザ名"

-#: lib/option.tcl:139
+#: lib/option.tcl:141
 msgid "Email Address"
 msgstr "電子メールアドレス"

-#: lib/option.tcl:141
+#: lib/option.tcl:143
 msgid "Summarize Merge Commits"
-msgstr "マージコミットの要約"
+msgstr "マージコミットの要約 (--summary)"

-#: lib/option.tcl:142
+#: lib/option.tcl:144
 msgid "Merge Verbosity"
-msgstr "マージの冗長度"
+msgstr "マージのエラー出力レベル (0-5, 標準2、最高5)(merge.verbosity)"

-#: lib/option.tcl:143
+#: lib/option.tcl:145
 msgid "Show Diffstat After Merge"
-msgstr "マージ後に diffstat を表示"
+msgstr "マージ後に変更量のグラフを表示 (git diff --stat)"

-#: lib/option.tcl:144
+#: lib/option.tcl:146
 msgid "Use Merge Tool"
 msgstr "マージツールを使用"

-#: lib/option.tcl:146
+#: lib/option.tcl:148
 msgid "Trust File Modification Timestamps"
 msgstr "ファイル変更時刻を信頼する"

-#: lib/option.tcl:147
+#: lib/option.tcl:149
 msgid "Prune Tracking Branches During Fetch"
-msgstr "フェッチ中にトラッキングブランチを刈る"
+msgstr "リモートから変更取得 (fetch) したとき、リモートで削除済みのブランチを削除する"

-#: lib/option.tcl:148
+#: lib/option.tcl:150
 msgid "Match Tracking Branches"
 msgstr "トラッキングブランチを合わせる"

-#: lib/option.tcl:149
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr "DiffとBlameでTextConvを使用する"
+
+#: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
 msgstr "変更されたファイルのみコピー検知を行なう"

-#: lib/option.tcl:150
+#: lib/option.tcl:153
 msgid "Minimum Letters To Blame Copy On"
-msgstr "コピーを検知する最少文字数"
+msgstr "他ファイルから移動/コピーを検知する最少文字数 (標準値40)"

-#: lib/option.tcl:151
+#: lib/option.tcl:154
 msgid "Blame History Context Radius (days)"
-msgstr "註釈する履歴半径（日数）"
+msgstr "Blameの表示範囲（前後日数）"

-#: lib/option.tcl:152
+#: lib/option.tcl:155
 msgid "Number of Diff Context Lines"
-msgstr "diff の文脈行数"
+msgstr "差分表示で表示する未変更行数 (変更行の前x行、後x行の未変更行を表示)"

-#: lib/option.tcl:153
+#: lib/option.tcl:156
+msgid "Additional Diff Parameters"
+msgstr "Diffの追加パラメータ"
+
+#: lib/option.tcl:157
 msgid "Commit Message Text Width"
 msgstr "コミットメッセージのテキスト幅"

-#: lib/option.tcl:154
+#: lib/option.tcl:158
 msgid "New Branch Name Template"
 msgstr "新しいブランチ名のテンプレート"

-#: lib/option.tcl:155
+#: lib/option.tcl:159
 msgid "Default File Contents Encoding"
-msgstr "ファイル内容のデフォールトエンコーディング"
+msgstr "ファイル内容のデフォルト文字コード"
+
+#: lib/option.tcl:160
+msgid "Warn before committing to a detached head"
+msgstr "detached head状態でコミットする前に警告する"

-#: lib/option.tcl:203
+#: lib/option.tcl:161
+msgid "Staging of untracked files"
+msgstr "追加されたファイルをコミット予定する"
+
+#: lib/option.tcl:161
+msgid "yes"
+msgstr "常に入れる"
+
+#: lib/option.tcl:161
+msgid "no"
+msgstr "常に入れない"
+
+#: lib/option.tcl:161
+msgid "ask"
+msgstr "毎回確認"
+
+#: lib/option.tcl:207
 msgid "Change"
 msgstr "変更"

-#: lib/option.tcl:230
+#: lib/option.tcl:251
 msgid "Spelling Dictionary:"
 msgstr "スペルチェック辞書"

-#: lib/option.tcl:254
+#: lib/option.tcl:281
 msgid "Change Font"
 msgstr "フォントを変更"

-#: lib/option.tcl:258
+#: lib/option.tcl:285
 #, tcl-format
 msgid "Choose %s"
 msgstr "%s を選択"

-#: lib/option.tcl:264
+#: lib/option.tcl:291
 msgid "pt."
 msgstr "ポイント"

-#: lib/option.tcl:278
+#: lib/option.tcl:305
 msgid "Preferences"
 msgstr "設定"

-#: lib/option.tcl:314
+#: lib/option.tcl:342
 msgid "Failed to completely save options:"
 msgstr "完全にオプションを保存できません:"

-#: lib/remote.tcl:163
-msgid "Remove Remote"
-msgstr "リモートを削除"
-
-#: lib/remote.tcl:168
-msgid "Prune from"
-msgstr "から刈込む…"
-
-#: lib/remote.tcl:173
-msgid "Fetch from"
-msgstr "取得元"
-
-#: lib/remote.tcl:215
-msgid "Push to"
-msgstr "プッシュ先"
-
-#: lib/remote_add.tcl:19
+#: lib/remote_add.tcl:20
 msgid "Add Remote"
 msgstr "リモートを追加"

-#: lib/remote_add.tcl:24
+#: lib/remote_add.tcl:25
 msgid "Add New Remote"
 msgstr "リモートを新規に追加"

-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
 msgid "Add"
 msgstr "追加"

-#: lib/remote_add.tcl:37
+#: lib/remote_add.tcl:39
 msgid "Remote Details"
 msgstr "リモートの詳細"

@@ -2134,58 +2181,58 @@ msgstr "リモートの詳細"
 msgid "Location:"
 msgstr "場所:"

-#: lib/remote_add.tcl:62
+#: lib/remote_add.tcl:60
 msgid "Further Action"
 msgstr "その他の動作"

-#: lib/remote_add.tcl:65
+#: lib/remote_add.tcl:63
 msgid "Fetch Immediately"
 msgstr "即座に取得"

-#: lib/remote_add.tcl:71
+#: lib/remote_add.tcl:69
 msgid "Initialize Remote Repository and Push"
 msgstr "リモートレポジトリを初期化してプッシュ"

-#: lib/remote_add.tcl:77
+#: lib/remote_add.tcl:75
 msgid "Do Nothing Else Now"
 msgstr "何もしない"

-#: lib/remote_add.tcl:101
+#: lib/remote_add.tcl:100
 msgid "Please supply a remote name."
 msgstr "リモート名を指定して下さい。"

-#: lib/remote_add.tcl:114
+#: lib/remote_add.tcl:113
 #, tcl-format
 msgid "'%s' is not an acceptable remote name."
 msgstr "'%s' はリモート名に使えません。"

-#: lib/remote_add.tcl:125
+#: lib/remote_add.tcl:124
 #, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
 msgstr "場所 '%2$s' のリモート '%1$s'の名前変更に失敗しました。"

-#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#: lib/remote_add.tcl:132 lib/transport.tcl:6
 #, tcl-format
 msgid "fetch %s"
 msgstr "%s を取得"

-#: lib/remote_add.tcl:134
+#: lib/remote_add.tcl:133
 #, tcl-format
 msgid "Fetching the %s"
 msgstr "%s からフェッチしています"

-#: lib/remote_add.tcl:157
+#: lib/remote_add.tcl:156
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr "リポジトリ '%s' を初期化できません。"

-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
-#: lib/transport.tcl:81
+#: lib/remote_add.tcl:162 lib/transport.tcl:54 lib/transport.tcl:92
+#: lib/transport.tcl:110
 #, tcl-format
 msgid "push %s"
 msgstr "%s をプッシュ"

-#: lib/remote_add.tcl:164
+#: lib/remote_add.tcl:163
 #, tcl-format
 msgid "Setting up the %s (at %s)"
 msgstr "%2$s にある %1$s をセットアップします"
@@ -2194,35 +2241,35 @@ msgstr "%2$s にある %1$s をセットアップします"
 msgid "Delete Branch Remotely"
 msgstr "遠隔でブランチ削除"

-#: lib/remote_branch_delete.tcl:47
+#: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
 msgstr "元のリポジトリ"

-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
+#: lib/remote_branch_delete.tcl:51 lib/transport.tcl:165
 msgid "Remote:"
 msgstr "リモート:"

-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
+#: lib/remote_branch_delete.tcl:72 lib/transport.tcl:187
 msgid "Arbitrary Location:"
 msgstr "任意の位置:"

-#: lib/remote_branch_delete.tcl:84
+#: lib/remote_branch_delete.tcl:88
 msgid "Branches"
 msgstr "ブランチ"

-#: lib/remote_branch_delete.tcl:109
+#: lib/remote_branch_delete.tcl:110
 msgid "Delete Only If"
 msgstr "条件付で削除"

-#: lib/remote_branch_delete.tcl:111
+#: lib/remote_branch_delete.tcl:112
 msgid "Merged Into:"
 msgstr "マージ先:"

-#: lib/remote_branch_delete.tcl:152
+#: lib/remote_branch_delete.tcl:153
 msgid "A branch is required for 'Merged Into'."
 msgstr "'マージ先' にはブランチが必要です。"

-#: lib/remote_branch_delete.tcl:184
+#: lib/remote_branch_delete.tcl:185
 #, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
@@ -2233,48 +2280,66 @@ msgstr ""
 "\n"
 " - %s"

-#: lib/remote_branch_delete.tcl:189
+#: lib/remote_branch_delete.tcl:190
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
 "necessary commits.  Try fetching from %s first."
-msgstr ""
-"必要なコミットが不足しているために、マージ検査が失敗しました。まず %s から"
-"フェッチして下さい。"
+msgstr "必要なコミットが不足しているために、マージ検査が失敗しました。まず %s からフェッチして下さい。"

-#: lib/remote_branch_delete.tcl:207
+#: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
 msgstr "削除するブランチを選択して下さい。"

-#: lib/remote_branch_delete.tcl:226
+#: lib/remote_branch_delete.tcl:227
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "%s からブランチを削除しています。"

-#: lib/remote_branch_delete.tcl:292
+#: lib/remote_branch_delete.tcl:300
 msgid "No repository selected."
 msgstr "リポジトリが選択されていません。"

-#: lib/remote_branch_delete.tcl:297
+#: lib/remote_branch_delete.tcl:305
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "%s をスキャンしています…"

-#: lib/search.tcl:21
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "プッシュ先"
+
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "リモートを削除"
+
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "リモートで削除済ブランチを削除 (Prune)"
+
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "変更を取得 (Fetch)"
+
+#: lib/search.tcl:48
 msgid "Find:"
 msgstr "検索:"

-#: lib/search.tcl:23
+#: lib/search.tcl:50
 msgid "Next"
 msgstr "次"

-#: lib/search.tcl:24
+#: lib/search.tcl:51
 msgid "Prev"
 msgstr "前"

-#: lib/search.tcl:25
-msgid "Case-Sensitive"
-msgstr "大文字小文字を区別"
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr "正規表現"
+
+#: lib/search.tcl:54
+msgid "Case"
+msgstr "小/大文字を区別"

 #: lib/shortcut.tcl:21 lib/shortcut.tcl:62
 msgid "Cannot write shortcut:"
@@ -2334,19 +2399,19 @@ msgstr "公開鍵がありました: %s"
 msgid "Generate Key"
 msgstr "鍵を生成"

-#: lib/sshkey.tcl:56
+#: lib/sshkey.tcl:58
 msgid "Copy To Clipboard"
 msgstr "クリップボードにコピー"

-#: lib/sshkey.tcl:70
+#: lib/sshkey.tcl:72
 msgid "Your OpenSSH Public Key"
 msgstr "あなたの OpenSSH 公開鍵"

-#: lib/sshkey.tcl:78
+#: lib/sshkey.tcl:80
 msgid "Generating..."
 msgstr "生成中..."

-#: lib/sshkey.tcl:84
+#: lib/sshkey.tcl:86
 #, tcl-format
 msgid ""
 "Could not start ssh-keygen:\n"
@@ -2357,54 +2422,24 @@ msgstr ""
 "\n"
 "%s"

-#: lib/sshkey.tcl:111
+#: lib/sshkey.tcl:113
 msgid "Generation failed."
 msgstr "生成に失敗しました。"

-#: lib/sshkey.tcl:118
+#: lib/sshkey.tcl:120
 msgid "Generation succeeded, but no keys found."
 msgstr "生成には成功しましたが、鍵が見つかりません。"

-#: lib/sshkey.tcl:121
+#: lib/sshkey.tcl:123
 #, tcl-format
 msgid "Your key is in: %s"
 msgstr "あなたの鍵は %s にあります"

-#: lib/status_bar.tcl:83
+#: lib/status_bar.tcl:87
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%1$s ... %4$*i %6$s 中の %2$*i (%7$3i%%)"

-#: lib/tools.tcl:75
-#, tcl-format
-msgid "Running %s requires a selected file."
-msgstr "ファイルを選択してから %s を起動してください。"
-
-#: lib/tools.tcl:90
-#, tcl-format
-msgid "Are you sure you want to run %s?"
-msgstr "本当に %s を起動しますか?"
-
-#: lib/tools.tcl:110
-#, tcl-format
-msgid "Tool: %s"
-msgstr "ツール: %s"
-
-#: lib/tools.tcl:111
-#, tcl-format
-msgid "Running: %s"
-msgstr "実行中: %s"
-
-#: lib/tools.tcl:149
-#, tcl-format
-msgid "Tool completed successfully: %s"
-msgstr "ツールが完了しました: %s"
-
-#: lib/tools.tcl:151
-#, tcl-format
-msgid "Tool failed: %s"
-msgstr "ツールが失敗しました: %s"
-
 #: lib/tools_dlg.tcl:22
 msgid "Add Tool"
 msgstr "ツールの追加"
@@ -2413,52 +2448,52 @@ msgstr "ツールの追加"
 msgid "Add New Tool Command"
 msgstr "新規ツールコマンドの追加"

-#: lib/tools_dlg.tcl:33
+#: lib/tools_dlg.tcl:34
 msgid "Add globally"
 msgstr "全体に追加"

-#: lib/tools_dlg.tcl:45
+#: lib/tools_dlg.tcl:46
 msgid "Tool Details"
 msgstr "ツールの詳細"

-#: lib/tools_dlg.tcl:48
+#: lib/tools_dlg.tcl:49
 msgid "Use '/' separators to create a submenu tree:"
 msgstr "'/' でサブメニューを区切ります:"

-#: lib/tools_dlg.tcl:61
+#: lib/tools_dlg.tcl:60
 msgid "Command:"
 msgstr "コマンド:"

-#: lib/tools_dlg.tcl:74
+#: lib/tools_dlg.tcl:71
 msgid "Show a dialog before running"
 msgstr "起動する前にダイアログを表示"

-#: lib/tools_dlg.tcl:80
+#: lib/tools_dlg.tcl:77
 msgid "Ask the user to select a revision (sets $REVISION)"
 msgstr "ユーザにコミットを一つ選ばせる ($REVISION にセットします)"

-#: lib/tools_dlg.tcl:85
+#: lib/tools_dlg.tcl:82
 msgid "Ask the user for additional arguments (sets $ARGS)"
 msgstr "ユーザに他の引数を追加させる ($ARGS にセットします)"

-#: lib/tools_dlg.tcl:92
+#: lib/tools_dlg.tcl:89
 msgid "Don't show the command output window"
 msgstr "コマンドからの出力ウィンドウを見せない"

-#: lib/tools_dlg.tcl:97
+#: lib/tools_dlg.tcl:94
 msgid "Run only if a diff is selected ($FILENAME not empty)"
 msgstr "パッチが選ばれているときだけ動かす($FILENAME が空でない)"

-#: lib/tools_dlg.tcl:121
+#: lib/tools_dlg.tcl:118
 msgid "Please supply a name for the tool."
 msgstr "ツール名を指定して下さい。"

-#: lib/tools_dlg.tcl:129
+#: lib/tools_dlg.tcl:126
 #, tcl-format
 msgid "Tool '%s' already exists."
 msgstr "ツール '%s' は既に存在します。"

-#: lib/tools_dlg.tcl:151
+#: lib/tools_dlg.tcl:148
 #, tcl-format
 msgid ""
 "Could not add tool:\n"
@@ -2467,35 +2502,70 @@ msgstr ""
 "ツールを追加できません:\n"
 "%s"

-#: lib/tools_dlg.tcl:190
+#: lib/tools_dlg.tcl:187
 msgid "Remove Tool"
 msgstr "ツールの削除"

-#: lib/tools_dlg.tcl:196
+#: lib/tools_dlg.tcl:193
 msgid "Remove Tool Commands"
 msgstr "ツールコマンドの削除"

-#: lib/tools_dlg.tcl:200
+#: lib/tools_dlg.tcl:198
 msgid "Remove"
 msgstr "削除"

-#: lib/tools_dlg.tcl:236
+#: lib/tools_dlg.tcl:231
 msgid "(Blue denotes repository-local tools)"
 msgstr "(青色はローカルレポジトリのツールです)"

-#: lib/tools_dlg.tcl:297
+#: lib/tools_dlg.tcl:292
 #, tcl-format
 msgid "Run Command: %s"
 msgstr "コマンドを起動: %s"

-#: lib/tools_dlg.tcl:311
+#: lib/tools_dlg.tcl:306
 msgid "Arguments"
 msgstr "引数"

-#: lib/tools_dlg.tcl:348
+#: lib/tools_dlg.tcl:341
 msgid "OK"
 msgstr "OK"

+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "ファイルを選択してから %s を起動してください。"
+
+#: lib/tools.tcl:91
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "\"%2$s\" ファイルを %1$s で実行してよろしいですか?"
+
+#: lib/tools.tcl:95
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "本当に %s を起動しますか?"
+
+#: lib/tools.tcl:116
+#, tcl-format
+msgid "Tool: %s"
+msgstr "ツール: %s"
+
+#: lib/tools.tcl:117
+#, tcl-format
+msgid "Running: %s"
+msgstr "実行中: %s"
+
+#: lib/tools.tcl:155
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "ツールが完了しました: %s"
+
+#: lib/tools.tcl:157
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "ツールが失敗しました: %s"
+
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
@@ -2504,52 +2574,71 @@ msgstr "%s から新しい変更をフェッチしています"
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
-msgstr "遠隔刈込 %s"
+msgstr "リモートレポジトリ %s の削除済ブランチを削除中"

 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
-msgstr "%s から削除されたトラッキング・ブランチを刈っています"
+msgstr "%s から削除されたブランチを削除中"
+
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr "すべてのリモートレポジトリから変更取得"

 #: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr "すべてのリモートレポジトリの新しい変更を取得(fetch)しています"
+
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr "全リモートレポジトリの削除済ブランチを削除中"
+
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr "全リモートレポジトリから削除されたブランチを削除中"
+
+#: lib/transport.tcl:55
 #, tcl-format
 msgid "Pushing changes to %s"
 msgstr "%s へ変更をプッシュしています"

-#: lib/transport.tcl:64
+#: lib/transport.tcl:93
 #, tcl-format
 msgid "Mirroring to %s"
 msgstr "%s へミラーしています"

-#: lib/transport.tcl:82
+#: lib/transport.tcl:111
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "%3$s へ %1$s %2$s をプッシュしています"

-#: lib/transport.tcl:100
+#: lib/transport.tcl:132
 msgid "Push Branches"
 msgstr "ブランチをプッシュ"

-#: lib/transport.tcl:114
+#: lib/transport.tcl:147
 msgid "Source Branches"
 msgstr "元のブランチ"

-#: lib/transport.tcl:131
+#: lib/transport.tcl:162
 msgid "Destination Repository"
 msgstr "送り先リポジトリ"

-#: lib/transport.tcl:169
+#: lib/transport.tcl:205
 msgid "Transfer Options"
 msgstr "通信オプション"

-#: lib/transport.tcl:171
+#: lib/transport.tcl:207
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr "既存ブランチを上書き(変更を破棄する可能性があります)"

-#: lib/transport.tcl:175
+#: lib/transport.tcl:211
 msgid "Use thin pack (for slow network connections)"
 msgstr "Thin Pack を使う（遅いネットワーク接続）"

-#: lib/transport.tcl:179
+#: lib/transport.tcl:215
 msgid "Include tags"
 msgstr "タグを含める"
+
+#~ msgid "Case-Sensitive"
+#~ msgstr "大文字小文字を区別"
-- 
1.8.1.msysgit.1
