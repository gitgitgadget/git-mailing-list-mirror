From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git-gui: update Japanese translation
Date: Tue, 02 Feb 2010 19:20:21 +0900
Message-ID: <20100202192021.6117@nanako3.lavabit.com>
References: <20100201151647.GB8916@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------boundary"
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 11:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcFsi-0002RO-Tp
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 11:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060Ab0BBKVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 05:21:10 -0500
Received: from karen.lavabit.com ([72.249.41.33]:56006 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887Ab0BBKVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 05:21:05 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 5376918F38E;
	Tue,  2 Feb 2010 04:21:03 -0600 (CST)
Received: from 4921.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 15OE531IGZO3; Tue, 02 Feb 2010 04:21:03 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=6m0VlNy6SqTZAgdW/DcnIVmFCdDAC72CUTuFpwTWAhVYk8HDLwZbf8qLrjflp7BWyalMjFepuDDQiO9RctqD8EXXNaRPYQSatNChkOEM9O90sjpStULPmL51Z6OkBJnmANWkzSmtQ+mVRj27TXTnBunI15i5V9NvLZb9yyQrxKo=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id;
In-Reply-To: <20100201151647.GB8916@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138707>

This is a multi-part message in MIME format.
--------------boundary
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Update ja.po to match 2010-01-26 version of pot file.

Signed-off-by: しらいし ななこ <nanako3@lavabit.com>
---
 po/ja.po |  653 ++++++++++++++++++++++++++++--------------------------
 1 files changed, 339 insertions(+), 314 deletions(-)

--------------boundary
Content-Type: text/x-patch; name="0001-git-gui-update-Japanese-translation.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0001-git-gui-update-Japanese-translation.patch"

diff --git a/po/ja.po b/po/ja.po
index 63c4695..ee381a4 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -3,46 +3,45 @@
 # This file is distributed under the same license as the git-gui package.
 # しらいし ななこ <nanako3@bluebottle.com>, 2007.
 #
-#, fuzzy
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-12-08 08:31-0800\n"
-"PO-Revision-Date: 2008-12-09 06:27+0900\n"
+"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"PO-Revision-Date: 2010-02-02 19:03+0900\n"
 "Last-Translator: しらいし ななこ <nanako3@lavabit.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 
-#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.sh:847
-#: git-gui.sh:866
+#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
+#: git-gui.sh:922
 msgid "git-gui: fatal error"
 msgstr "git-gui: 致命的なエラー"
 
-#: git-gui.sh:689
+#: git-gui.sh:743
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "%s に無効なフォントが指定されています:"
 
-#: git-gui.sh:723
+#: git-gui.sh:779
 msgid "Main Font"
 msgstr "主フォント"
 
-#: git-gui.sh:724
+#: git-gui.sh:780
 msgid "Diff/Console Font"
 msgstr "diff/コンソール・フォント"
 
-#: git-gui.sh:738
+#: git-gui.sh:794
 msgid "Cannot find git in PATH."
 msgstr "PATH 中に git が見つかりません"
 
-#: git-gui.sh:765
+#: git-gui.sh:821
 msgid "Cannot parse Git version string:"
 msgstr "Git バージョン名が理解できません:"
 
-#: git-gui.sh:783
+#: git-gui.sh:839
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -61,446 +60,475 @@ msgstr ""
 "\n"
 "'%s' はバージョン 1.5.0 と思って良いですか？\n"
 
-#: git-gui.sh:1062
+#: git-gui.sh:1128
 msgid "Git directory not found:"
 msgstr "Git ディレクトリが見つかりません:"
 
-#: git-gui.sh:1069
+#: git-gui.sh:1146
 msgid "Cannot move to top of working directory:"
 msgstr "作業ディレクトリの最上位に移動できません"
 
-#: git-gui.sh:1076
-msgid "Cannot use funny .git directory:"
-msgstr "変な .git ディレクトリは使えません"
+#: git-gui.sh:1154
+msgid "Cannot use bare repository:"
+msgstr "裸のリポジトリは使えません:"
 
-#: git-gui.sh:1081
+#: git-gui.sh:1162
 msgid "No working directory"
 msgstr "作業ディレクトリがありません"
 
-#: git-gui.sh:1247 lib/checkout_op.tcl:305
+#: git-gui.sh:1334 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "ファイル状態を更新しています…"
 
-#: git-gui.sh:1303
+#: git-gui.sh:1390
 msgid "Scanning for modified files ..."
 msgstr "変更されたファイルをスキャンしています…"
 
-#: git-gui.sh:1367
+#: git-gui.sh:1454
 msgid "Calling prepare-commit-msg hook..."
 msgstr "prepare-commit-msg フックを実行中・・・"
 
-#: git-gui.sh:1384
+#: git-gui.sh:1471
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr "prepare-commit-msg フックがコミットを拒否しました"
 
-#: git-gui.sh:1542 lib/browser.tcl:246
+#: git-gui.sh:1629 lib/browser.tcl:246
 msgid "Ready."
 msgstr "準備完了"
 
-#: git-gui.sh:1819
+#: git-gui.sh:1787
+#, tcl-format
+msgid "Displaying only %s of %s files."
+msgstr "全体で%s個の内の%sファイルだけ表示しています"
+
+#: git-gui.sh:1913
 msgid "Unmodified"
 msgstr "変更無し"
 
-#: git-gui.sh:1821
+#: git-gui.sh:1915
 msgid "Modified, not staged"
 msgstr "変更あり、コミット未予定"
 
-#: git-gui.sh:1822 git-gui.sh:1830
+#: git-gui.sh:1916 git-gui.sh:1924
 msgid "Staged for commit"
 msgstr "コミット予定済"
 
-#: git-gui.sh:1823 git-gui.sh:1831
+#: git-gui.sh:1917 git-gui.sh:1925
 msgid "Portions staged for commit"
 msgstr "部分的にコミット予定済"
 
-#: git-gui.sh:1824 git-gui.sh:1832
+#: git-gui.sh:1918 git-gui.sh:1926
 msgid "Staged for commit, missing"
 msgstr "コミット予定済、ファイル無し"
 
-#: git-gui.sh:1826
+#: git-gui.sh:1920
 msgid "File type changed, not staged"
 msgstr "ファイル型変更、コミット未予定"
 
-#: git-gui.sh:1827
+#: git-gui.sh:1921
 msgid "File type changed, staged"
 msgstr "ファイル型変更、コミット予定済"
 
-#: git-gui.sh:1829
+#: git-gui.sh:1923
 msgid "Untracked, not staged"
 msgstr "管理外、コミット未予定"
 
-#: git-gui.sh:1834
+#: git-gui.sh:1928
 msgid "Missing"
 msgstr "ファイル無し"
 
-#: git-gui.sh:1835
+#: git-gui.sh:1929
 msgid "Staged for removal"
 msgstr "削除予定済"
 
-#: git-gui.sh:1836
+#: git-gui.sh:1930
 msgid "Staged for removal, still present"
 msgstr "削除予定済、ファイル未削除"
 
-#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
-#: git-gui.sh:1842 git-gui.sh:1843
+#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
+#: git-gui.sh:1936 git-gui.sh:1937
 msgid "Requires merge resolution"
 msgstr "要マージ解決"
 
-#: git-gui.sh:1878
+#: git-gui.sh:1972
 msgid "Starting gitk... please wait..."
 msgstr "gitk を起動中…お待ち下さい…"
 
-#: git-gui.sh:1887
+#: git-gui.sh:1984
 msgid "Couldn't find gitk in PATH"
 msgstr "PATH 中に gitk が見つかりません"
 
-#: git-gui.sh:2280 lib/choose_repository.tcl:36
+#: git-gui.sh:2043
+msgid "Couldn't find git gui in PATH"
+msgstr "PATH 中に git gui が見つかりません"
+
+#: git-gui.sh:2455 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "リポジトリ"
 
-#: git-gui.sh:2281
+#: git-gui.sh:2456
 msgid "Edit"
 msgstr "編集"
 
-#: git-gui.sh:2283 lib/choose_rev.tcl:561
+#: git-gui.sh:2458 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "ブランチ"
 
-#: git-gui.sh:2286 lib/choose_rev.tcl:548
+#: git-gui.sh:2461 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "コミット"
 
-#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
 msgid "Merge"
 msgstr "マージ"
 
-#: git-gui.sh:2290 lib/choose_rev.tcl:557
+#: git-gui.sh:2465 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "リモート"
 
-#: git-gui.sh:2293
+#: git-gui.sh:2468
 msgid "Tools"
 msgstr "ツール"
 
-#: git-gui.sh:2302
+#: git-gui.sh:2477
 msgid "Explore Working Copy"
 msgstr "ワーキングコピーをブラウズ"
 
-#: git-gui.sh:2307
+#: git-gui.sh:2483
 msgid "Browse Current Branch's Files"
 msgstr "現在のブランチのファイルを見る"
 
-#: git-gui.sh:2311
+#: git-gui.sh:2487
 msgid "Browse Branch Files..."
 msgstr "ブランチのファイルを見る…"
 
-#: git-gui.sh:2316
+#: git-gui.sh:2492
 msgid "Visualize Current Branch's History"
 msgstr "現在のブランチの履歴を見る"
 
-#: git-gui.sh:2320
+#: git-gui.sh:2496
 msgid "Visualize All Branch History"
 msgstr "全てのブランチの履歴を見る"
 
-#: git-gui.sh:2327
+#: git-gui.sh:2503
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "ブランチ %s のファイルを見る"
 
-#: git-gui.sh:2329
+#: git-gui.sh:2505
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "ブランチ %s の履歴を見る"
 
-#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "データベース統計"
 
-#: git-gui.sh:2337 lib/database.tcl:34
+#: git-gui.sh:2513 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "データベース圧縮"
 
-#: git-gui.sh:2340
+#: git-gui.sh:2516
 msgid "Verify Database"
 msgstr "データベース検証"
 
-#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
-#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
+#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
 msgid "Create Desktop Icon"
 msgstr "デスクトップ・アイコンを作る"
 
-#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
 msgid "Quit"
 msgstr "終了"
 
-#: git-gui.sh:2371
+#: git-gui.sh:2547
 msgid "Undo"
 msgstr "元に戻す"
 
-#: git-gui.sh:2374
+#: git-gui.sh:2550
 msgid "Redo"
 msgstr "やり直し"
 
-#: git-gui.sh:2378 git-gui.sh:2923
+#: git-gui.sh:2554 git-gui.sh:3109
 msgid "Cut"
 msgstr "切り取り"
 
-#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
+#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "コピー"
 
-#: git-gui.sh:2384 git-gui.sh:2929
+#: git-gui.sh:2560 git-gui.sh:3115
 msgid "Paste"
 msgstr "貼り付け"
 
-#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
+#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "削除"
 
-#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
+#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
 msgid "Select All"
 msgstr "全て選択"
 
-#: git-gui.sh:2400
+#: git-gui.sh:2576
 msgid "Create..."
 msgstr "作成…"
 
-#: git-gui.sh:2406
+#: git-gui.sh:2582
 msgid "Checkout..."
 msgstr "チェックアウト"
 
-#: git-gui.sh:2412
+#: git-gui.sh:2588
 msgid "Rename..."
 msgstr "名前変更…"
 
-#: git-gui.sh:2417
+#: git-gui.sh:2593
 msgid "Delete..."
 msgstr "削除…"
 
-#: git-gui.sh:2422
+#: git-gui.sh:2598
 msgid "Reset..."
 msgstr "リセット…"
 
-#: git-gui.sh:2432
+#: git-gui.sh:2608
 msgid "Done"
 msgstr "完了"
 
-#: git-gui.sh:2434
+#: git-gui.sh:2610
 msgid "Commit@@verb"
 msgstr "コミット"
 
-#: git-gui.sh:2443 git-gui.sh:2864
+#: git-gui.sh:2619 git-gui.sh:3050
 msgid "New Commit"
 msgstr "新規コミット"
 
-#: git-gui.sh:2451 git-gui.sh:2871
+#: git-gui.sh:2627 git-gui.sh:3057
 msgid "Amend Last Commit"
 msgstr "最新コミットを訂正"
 
-#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "再スキャン"
 
-#: git-gui.sh:2467
+#: git-gui.sh:2643
 msgid "Stage To Commit"
 msgstr "コミット予定する"
 
-#: git-gui.sh:2473
+#: git-gui.sh:2649
 msgid "Stage Changed Files To Commit"
 msgstr "変更されたファイルをコミット予定"
 
-#: git-gui.sh:2479
+#: git-gui.sh:2655
 msgid "Unstage From Commit"
 msgstr "コミットから降ろす"
 
-#: git-gui.sh:2484 lib/index.tcl:410
+#: git-gui.sh:2661 lib/index.tcl:412
 msgid "Revert Changes"
 msgstr "変更を元に戻す"
 
-#: git-gui.sh:2491 git-gui.sh:3069
+#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
 msgid "Show Less Context"
 msgstr "文脈を少なく"
 
-#: git-gui.sh:2495 git-gui.sh:3073
+#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
 msgid "Show More Context"
 msgstr "文脈を多く"
 
-#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
+#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
 msgid "Sign Off"
 msgstr "署名"
 
-#: git-gui.sh:2518
+#: git-gui.sh:2696
 msgid "Local Merge..."
 msgstr "ローカル・マージ…"
 
-#: git-gui.sh:2523
+#: git-gui.sh:2701
 msgid "Abort Merge..."
 msgstr "マージ中止…"
 
-#: git-gui.sh:2535 git-gui.sh:2575
+#: git-gui.sh:2713 git-gui.sh:2741
 msgid "Add..."
 msgstr "追加"
 
-#: git-gui.sh:2539
+#: git-gui.sh:2717
 msgid "Push..."
 msgstr "プッシュ…"
 
-#: git-gui.sh:2543
+#: git-gui.sh:2721
 msgid "Delete Branch..."
 msgstr "ブランチ削除..."
 
-#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
-#, tcl-format
-msgid "About %s"
-msgstr "%s について"
-
-#: git-gui.sh:2557
-msgid "Preferences..."
-msgstr "設定…"
-
-#: git-gui.sh:2565 git-gui.sh:3115
+#: git-gui.sh:2731 git-gui.sh:3292
 msgid "Options..."
 msgstr "オプション…"
 
-#: git-gui.sh:2576
+#: git-gui.sh:2742
 msgid "Remove..."
 msgstr "削除..."
 
-#: git-gui.sh:2585 lib/choose_repository.tcl:50
+#: git-gui.sh:2751 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "ヘルプ"
 
-#: git-gui.sh:2611
+#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#, tcl-format
+msgid "About %s"
+msgstr "%s について"
+
+#: git-gui.sh:2783
 msgid "Online Documentation"
 msgstr "オンライン・ドキュメント"
 
-#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
 msgid "Show SSH Key"
 msgstr "SSH キーを表示"
 
-#: git-gui.sh:2707
+#: git-gui.sh:2893
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "致命的: パス %s が stat できません。そのようなファイルやディレクトリはありま"
 "せん"
 
-#: git-gui.sh:2740
+#: git-gui.sh:2926
 msgid "Current Branch:"
 msgstr "現在のブランチ"
 
-#: git-gui.sh:2761
+#: git-gui.sh:2947
 msgid "Staged Changes (Will Commit)"
 msgstr "ステージングされた（コミット予定済の）変更"
 
-#: git-gui.sh:2781
+#: git-gui.sh:2967
 msgid "Unstaged Changes"
 msgstr "コミット予定に入っていない変更"
 
-#: git-gui.sh:2831
+#: git-gui.sh:3017
 msgid "Stage Changed"
 msgstr "変更をコミット予定に入れる"
 
-#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
 msgstr "プッシュ"
 
-#: git-gui.sh:2885
+#: git-gui.sh:3071
 msgid "Initial Commit Message:"
 msgstr "最初のコミットメッセージ:"
 
-#: git-gui.sh:2886
+#: git-gui.sh:3072
 msgid "Amended Commit Message:"
 msgstr "訂正したコミットメッセージ:"
 
-#: git-gui.sh:2887
+#: git-gui.sh:3073
 msgid "Amended Initial Commit Message:"
 msgstr "訂正した最初のコミットメッセージ:"
 
-#: git-gui.sh:2888
+#: git-gui.sh:3074
 msgid "Amended Merge Commit Message:"
 msgstr "訂正したマージコミットメッセージ:"
 
-#: git-gui.sh:2889
+#: git-gui.sh:3075
 msgid "Merge Commit Message:"
 msgstr "マージコミットメッセージ:"
 
-#: git-gui.sh:2890
+#: git-gui.sh:3076
 msgid "Commit Message:"
 msgstr "コミットメッセージ:"
 
-#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
+#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
 msgid "Copy All"
 msgstr "全てコピー"
 
-#: git-gui.sh:2963 lib/blame.tcl:104
+#: git-gui.sh:3149 lib/blame.tcl:104
 msgid "File:"
 msgstr "ファイル:"
 
-#: git-gui.sh:3078
+#: git-gui.sh:3255
 msgid "Refresh"
 msgstr "再読み込み"
 
-#: git-gui.sh:3099
+#: git-gui.sh:3276
 msgid "Decrease Font Size"
 msgstr "フォントを小さく"
 
-#: git-gui.sh:3103
+#: git-gui.sh:3280
 msgid "Increase Font Size"
 msgstr "フォントを大きく"
 
-#: git-gui.sh:3111 lib/blame.tcl:281
+#: git-gui.sh:3288 lib/blame.tcl:281
 msgid "Encoding"
 msgstr "エンコーディング"
 
-#: git-gui.sh:3122
+#: git-gui.sh:3299
 msgid "Apply/Reverse Hunk"
 msgstr "パッチを適用/取り消す"
 
-#: git-gui.sh:3127
+#: git-gui.sh:3304
 msgid "Apply/Reverse Line"
 msgstr "パッチ行を適用/取り消す"
 
-#: git-gui.sh:3137
+#: git-gui.sh:3323
 msgid "Run Merge Tool"
 msgstr "マージツールを起動"
 
-#: git-gui.sh:3142
+#: git-gui.sh:3328
 msgid "Use Remote Version"
 msgstr "リモートの方を採用"
 
-#: git-gui.sh:3146
+#: git-gui.sh:3332
 msgid "Use Local Version"
 msgstr "ローカルの方を採用"
 
-#: git-gui.sh:3150
+#: git-gui.sh:3336
 msgid "Revert To Base"
 msgstr "ベース版を採用"
 
-#: git-gui.sh:3169
+#: git-gui.sh:3354
+msgid "Visualize These Changes In The Submodule"
+msgstr "サブモジュール内のこれらの変更を見る"
+
+#: git-gui.sh:3358
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "サブモジュール内で現在のブランチの履歴を見る"
+
+#: git-gui.sh:3362
+msgid "Visualize All Branch History In The Submodule"
+msgstr "サブモジュール内で全てのブランチの履歴を見る"
+
+#: git-gui.sh:3367
+msgid "Start git gui In The Submodule"
+msgstr "サブモジュール内でgit guiを起動する"
+
+#: git-gui.sh:3389
 msgid "Unstage Hunk From Commit"
 msgstr "パッチをコミット予定から外す"
 
-#: git-gui.sh:3170
+#: git-gui.sh:3391
+msgid "Unstage Lines From Commit"
+msgstr "コミット予定から行を外す"
+
+#: git-gui.sh:3393
 msgid "Unstage Line From Commit"
 msgstr "コミット予定から行を外す"
 
-#: git-gui.sh:3172
+#: git-gui.sh:3396
 msgid "Stage Hunk For Commit"
 msgstr "パッチをコミット予定に加える"
 
-#: git-gui.sh:3173
+#: git-gui.sh:3398
+msgid "Stage Lines For Commit"
+msgstr "パッチ行をコミット予定に加える"
+
+#: git-gui.sh:3400
 msgid "Stage Line For Commit"
 msgstr "パッチ行をコミット予定に加える"
 
-#: git-gui.sh:3196
+#: git-gui.sh:3424
 msgid "Initializing..."
 msgstr "初期化しています…"
 
-#: git-gui.sh:3301
+#: git-gui.sh:3541
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -515,7 +543,7 @@ msgstr ""
 "以下の環境変数は %s が起動する Git サブプロセスによって無視されるでしょう:\n"
 "\n"
 
-#: git-gui.sh:3331
+#: git-gui.sh:3570
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -525,7 +553,7 @@ msgstr ""
 "これは Cygwin で配布されている Tcl バイナリに\n"
 "関しての既知の問題によります"
 
-#: git-gui.sh:3336
+#: git-gui.sh:3575
 #, tcl-format
 msgid ""
 "\n"
@@ -609,43 +637,43 @@ msgstr "コピー検知を実行中…"
 msgid "Loading annotation..."
 msgstr "注釈を読み込んでいます…"
 
-#: lib/blame.tcl:964
+#: lib/blame.tcl:963
 msgid "Author:"
 msgstr "作者:"
 
-#: lib/blame.tcl:968
+#: lib/blame.tcl:967
 msgid "Committer:"
 msgstr "コミット者:"
 
-#: lib/blame.tcl:973
+#: lib/blame.tcl:972
 msgid "Original File:"
 msgstr "元ファイル"
 
-#: lib/blame.tcl:1021
+#: lib/blame.tcl:1020
 msgid "Cannot find HEAD commit:"
 msgstr "HEAD コミットが見つかりません"
 
-#: lib/blame.tcl:1076
+#: lib/blame.tcl:1075
 msgid "Cannot find parent commit:"
 msgstr "親コミットが見つかりません:"
 
-#: lib/blame.tcl:1091
+#: lib/blame.tcl:1090
 msgid "Unable to display parent"
 msgstr "親を表示できません"
 
-#: lib/blame.tcl:1092 lib/diff.tcl:297
+#: lib/blame.tcl:1091 lib/diff.tcl:320
 msgid "Error loading diff:"
 msgstr "diff を読む際のエラーです:"
 
-#: lib/blame.tcl:1232
+#: lib/blame.tcl:1231
 msgid "Originally By:"
 msgstr "原作者:"
 
-#: lib/blame.tcl:1238
+#: lib/blame.tcl:1237
 msgid "In File:"
 msgstr "ファイル:"
 
-#: lib/blame.tcl:1243
+#: lib/blame.tcl:1242
 msgid "Copied Or Moved Here By:"
 msgstr "複写・移動者:"
 
@@ -659,10 +687,10 @@ msgstr "チェックアウト"
 
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
-#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
 #: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
 #: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:97
+#: lib/transport.tcl:108
 msgid "Cancel"
 msgstr "中止"
 
@@ -690,7 +718,7 @@ msgstr "ブランチを作成"
 msgid "Create New Branch"
 msgstr "ブランチを新規作成"
 
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
 msgid "Create"
 msgstr "作成"
 
@@ -722,7 +750,7 @@ msgstr "いいえ"
 msgid "Fast Forward Only"
 msgstr "早送りのみ"
 
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
 msgid "Reset"
 msgstr "リセット"
 
@@ -764,15 +792,25 @@ msgstr "ローカル・ブランチ"
 msgid "Delete Only If Merged Into"
 msgstr "マージ済みの時のみ削除"
 
-#: lib/branch_delete.tcl:54
-msgid "Always (Do not perform merge test.)"
-msgstr "無条件(マージテストしない)"
+#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "無条件（マージ検査をしない）"
 
 #: lib/branch_delete.tcl:103
 #, tcl-format
 msgid "The following branches are not completely merged into %s:"
 msgstr "以下のブランチは %s に完全にマージされていません:"
 
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"削除したブランチを回復するのは困難です。\n"
+"\n"
+"選択したブランチを削除して良いですか？"
+
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
@@ -802,7 +840,7 @@ msgstr "新しい名前:"
 msgid "Please select a branch to rename."
 msgstr "名前を変更するブランチを選んで下さい。"
 
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "'%s'というブランチは既に存在します。"
@@ -833,38 +871,38 @@ msgstr "[上位フォルダへ]"
 msgid "Browse Branch Files"
 msgstr "現在のブランチのファイルを見る"
 
-#: lib/browser.tcl:278 lib/choose_repository.tcl:394
-#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
-#: lib/choose_repository.tcl:995
+#: lib/browser.tcl:278 lib/choose_repository.tcl:398
+#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
+#: lib/choose_repository.tcl:1028
 msgid "Browse"
 msgstr "ブラウズ"
 
-#: lib/checkout_op.tcl:84
+#: lib/checkout_op.tcl:85
 #, tcl-format
 msgid "Fetching %s from %s"
 msgstr "%s から %s をフェッチしています"
 
-#: lib/checkout_op.tcl:132
+#: lib/checkout_op.tcl:133
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
 msgstr "致命的エラー: %s を解決できません"
 
-#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
 #: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "閉じる"
 
-#: lib/checkout_op.tcl:174
+#: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
 msgstr "ブランチ'%s'は存在しません。"
 
-#: lib/checkout_op.tcl:193
+#: lib/checkout_op.tcl:194
 #, tcl-format
 msgid "Failed to configure simplified git-pull for '%s'."
 msgstr "'%s' に簡易 git-pull を設定できませんでした"
 
-#: lib/checkout_op.tcl:228
+#: lib/checkout_op.tcl:229
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -877,21 +915,21 @@ msgstr ""
 "%s に早送りできません。\n"
 "マージが必要です。"
 
-#: lib/checkout_op.tcl:242
+#: lib/checkout_op.tcl:243
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
 msgstr "'%s' マージ戦略はサポートされていません。"
 
-#: lib/checkout_op.tcl:261
+#: lib/checkout_op.tcl:262
 #, tcl-format
 msgid "Failed to update '%s'."
 msgstr "'%s' の更新に失敗しました。"
 
-#: lib/checkout_op.tcl:273
+#: lib/checkout_op.tcl:274
 msgid "Staging area (index) is already locked."
 msgstr "インデックスは既にロックされています。"
 
-#: lib/checkout_op.tcl:288
+#: lib/checkout_op.tcl:289
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -907,30 +945,30 @@ msgstr ""
 "\n"
 "自動的に再スキャンを開始します。\n"
 
-#: lib/checkout_op.tcl:344
+#: lib/checkout_op.tcl:345
 #, tcl-format
 msgid "Updating working directory to '%s'..."
 msgstr "作業ディレクトリを '%s' に更新しています…"
 
-#: lib/checkout_op.tcl:345
+#: lib/checkout_op.tcl:346
 msgid "files checked out"
 msgstr "チェックアウトされたファイル"
 
-#: lib/checkout_op.tcl:375
+#: lib/checkout_op.tcl:376
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr "'%s' のチェックアウトを中止しました（ファイル毎のマージが必要です）。"
 
-#: lib/checkout_op.tcl:376
+#: lib/checkout_op.tcl:377
 msgid "File level merge required."
 msgstr "ファイル毎のマージが必要です。"
 
-#: lib/checkout_op.tcl:380
+#: lib/checkout_op.tcl:381
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "ブランチ '%s' に滞まります。"
 
-#: lib/checkout_op.tcl:451
+#: lib/checkout_op.tcl:452
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -942,30 +980,30 @@ msgstr ""
 "ブランチ上に滞まりたいときは、この「分離されたチェックアウト」から新規ブラン"
 "チを開始してください。"
 
-#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
+#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "'%s' をチェックアウトしました"
 
-#: lib/checkout_op.tcl:500
+#: lib/checkout_op.tcl:535
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "'%s' を '%s' にリセットすると、以下のコミットが失なわれます:"
 
-#: lib/checkout_op.tcl:522
+#: lib/checkout_op.tcl:557
 msgid "Recovering lost commits may not be easy."
 msgstr "失なわれたコミットを回復するのは簡単ではありません。"
 
-#: lib/checkout_op.tcl:527
+#: lib/checkout_op.tcl:562
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "'%s' をリセットしますか？"
 
-#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "可視化"
 
-#: lib/checkout_op.tcl:600
+#: lib/checkout_op.tcl:635
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -1009,7 +1047,7 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git GUI"
 
-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
 msgid "Create New Repository"
 msgstr "新しいリポジトリを作る"
 
@@ -1017,7 +1055,7 @@ msgstr "新しいリポジトリを作る"
 msgid "New..."
 msgstr "新規…"
 
-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
 msgid "Clone Existing Repository"
 msgstr "既存リポジトリを複製する"
 
@@ -1025,7 +1063,7 @@ msgstr "既存リポジトリを複製する"
 msgid "Clone..."
 msgstr "複製…"
 
-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
 msgid "Open Existing Repository"
 msgstr "既存リポジトリを開く"
 
@@ -1041,193 +1079,193 @@ msgstr "最近使ったリポジトリ"
 msgid "Open Recent Repository:"
 msgstr "最近使ったリポジトリを開く"
 
-#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
-#: lib/choose_repository.tcl:316
+#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
+#: lib/choose_repository.tcl:320
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "リポジトリ %s を作製できません:"
 
-#: lib/choose_repository.tcl:387
+#: lib/choose_repository.tcl:391
 msgid "Directory:"
 msgstr "ディレクトリ:"
 
-#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
-#: lib/choose_repository.tcl:1017
+#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
+#: lib/choose_repository.tcl:1052
 msgid "Git Repository"
 msgstr "GIT リポジトリ"
 
-#: lib/choose_repository.tcl:442
+#: lib/choose_repository.tcl:448
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "ディレクトリ '%s' は既に存在します。"
 
-#: lib/choose_repository.tcl:446
+#: lib/choose_repository.tcl:452
 #, tcl-format
 msgid "File %s already exists."
 msgstr "ファイル '%s' は既に存在します。"
 
-#: lib/choose_repository.tcl:460
+#: lib/choose_repository.tcl:466
 msgid "Clone"
 msgstr "複製"
 
-#: lib/choose_repository.tcl:473
+#: lib/choose_repository.tcl:479
 msgid "Source Location:"
 msgstr "ソースの位置"
 
-#: lib/choose_repository.tcl:484
+#: lib/choose_repository.tcl:490
 msgid "Target Directory:"
 msgstr "先ディレクトリ:"
 
-#: lib/choose_repository.tcl:496
+#: lib/choose_repository.tcl:502
 msgid "Clone Type:"
 msgstr "複製方式:"
 
-#: lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:508
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "標準(高速・中冗長度・ハードリンク)"
 
-#: lib/choose_repository.tcl:508
+#: lib/choose_repository.tcl:514
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "全複写(低速・冗長バックアップ)"
 
-#: lib/choose_repository.tcl:514
+#: lib/choose_repository.tcl:520
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "共有(最高速・非推奨・バックアップ無し)"
 
-#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
-#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
-#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
+#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
+#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
+#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Git リポジトリではありません: %s"
 
-#: lib/choose_repository.tcl:586
+#: lib/choose_repository.tcl:592
 msgid "Standard only available for local repository."
 msgstr "標準方式は同一計算機上のリポジトリにのみ使えます。"
 
-#: lib/choose_repository.tcl:590
+#: lib/choose_repository.tcl:596
 msgid "Shared only available for local repository."
 msgstr "共有方式は同一計算機上のリポジトリにのみ使えます。"
 
-#: lib/choose_repository.tcl:611
+#: lib/choose_repository.tcl:617
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "'%s' は既に存在します。"
 
-#: lib/choose_repository.tcl:622
+#: lib/choose_repository.tcl:628
 msgid "Failed to configure origin"
 msgstr "origin を設定できませんでした"
 
-#: lib/choose_repository.tcl:634
+#: lib/choose_repository.tcl:640
 msgid "Counting objects"
 msgstr "オブジェクトを数えています"
 
-#: lib/choose_repository.tcl:635
+#: lib/choose_repository.tcl:641
 msgid "buckets"
 msgstr "バケツ"
 
-#: lib/choose_repository.tcl:659
+#: lib/choose_repository.tcl:665
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "objects/info/alternates を複写できません: %s"
 
-#: lib/choose_repository.tcl:695
+#: lib/choose_repository.tcl:701
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "%s から複製する内容はありません"
 
-#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
-#: lib/choose_repository.tcl:923
+#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
+#: lib/choose_repository.tcl:929
 msgid "The 'master' branch has not been initialized."
 msgstr "'master' ブランチが初期化されていません"
 
-#: lib/choose_repository.tcl:710
+#: lib/choose_repository.tcl:716
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "ハードリンクが作れないので、コピーします"
 
-#: lib/choose_repository.tcl:722
+#: lib/choose_repository.tcl:728
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "%s から複製しています"
 
-#: lib/choose_repository.tcl:753
+#: lib/choose_repository.tcl:759
 msgid "Copying objects"
 msgstr "オブジェクトを複写しています"
 
-#: lib/choose_repository.tcl:754
+#: lib/choose_repository.tcl:760
 msgid "KiB"
 msgstr "KiB"
 
-#: lib/choose_repository.tcl:778
+#: lib/choose_repository.tcl:784
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "オブジェクトを複写できません: %s"
 
-#: lib/choose_repository.tcl:788
+#: lib/choose_repository.tcl:794
 msgid "Linking objects"
 msgstr "オブジェクトを連結しています"
 
-#: lib/choose_repository.tcl:789
+#: lib/choose_repository.tcl:795
 msgid "objects"
 msgstr "オブジェクト"
 
-#: lib/choose_repository.tcl:797
+#: lib/choose_repository.tcl:803
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "オブジェクトをハードリンクできません: %s"
 
-#: lib/choose_repository.tcl:852
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr "ブランチやオブジェクトを取得できません。コンソール出力を見て下さい"
 
-#: lib/choose_repository.tcl:863
+#: lib/choose_repository.tcl:869
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "タグを取得できません。コンソール出力を見て下さい"
 
-#: lib/choose_repository.tcl:887
+#: lib/choose_repository.tcl:893
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "HEAD を確定できません。コンソール出力を見て下さい"
 
-#: lib/choose_repository.tcl:896
+#: lib/choose_repository.tcl:902
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "%s を掃除できません"
 
-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:908
 msgid "Clone failed."
 msgstr "複写に失敗しました。"
 
-#: lib/choose_repository.tcl:909
+#: lib/choose_repository.tcl:915
 msgid "No default branch obtained."
 msgstr "デフォールト・ブランチが取得されませんでした"
 
-#: lib/choose_repository.tcl:920
+#: lib/choose_repository.tcl:926
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "%s をコミットとして解釈できません"
 
-#: lib/choose_repository.tcl:932
+#: lib/choose_repository.tcl:938
 msgid "Creating working directory"
 msgstr "作業ディレクトリを作成しています"
 
-#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
-#: lib/index.tcl:196
+#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
+#: lib/index.tcl:198
 msgid "files"
 msgstr "ファイル"
 
-#: lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:968
 msgid "Initial file checkout failed."
 msgstr "初期チェックアウトに失敗しました"
 
-#: lib/choose_repository.tcl:978
+#: lib/choose_repository.tcl:1011
 msgid "Open"
 msgstr "開く"
 
-#: lib/choose_repository.tcl:988
+#: lib/choose_repository.tcl:1021
 msgid "Repository:"
 msgstr "リポジトリ:"
 
-#: lib/choose_repository.tcl:1037
+#: lib/choose_repository.tcl:1072
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "リポジトリ %s を開けません:"
@@ -1298,19 +1336,24 @@ msgstr ""
 "現在はまだマージの途中です。先にこのマージを中止しないと、前のコミットの訂正"
 "はできません\n"
 
-#: lib/commit.tcl:49
+#: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
 msgstr "訂正するコミットのデータを読めません:"
 
-#: lib/commit.tcl:76
+#: lib/commit.tcl:75
 msgid "Unable to obtain your identity:"
 msgstr "ユーザの正体を確認できません:"
 
-#: lib/commit.tcl:81
+#: lib/commit.tcl:80
 msgid "Invalid GIT_COMMITTER_IDENT:"
 msgstr "GIT_COMMITTER_IDENT が無効です:"
 
-#: lib/commit.tcl:133
+#: lib/commit.tcl:129
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "警告: Tcl はエンコーディング '%s' をサポートしていません"
+
+#: lib/commit.tcl:149
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -1326,7 +1369,7 @@ msgstr ""
 "\n"
 "自動的に再スキャンを開始します。\n"
 
-#: lib/commit.tcl:156
+#: lib/commit.tcl:172
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1339,7 +1382,7 @@ msgstr ""
 "ファイル %s にはマージ衝突が残っています。まず解決してコミット予定に加える必"
 "要があります。\n"
 
-#: lib/commit.tcl:164
+#: lib/commit.tcl:180
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1350,7 +1393,7 @@ msgstr ""
 "\n"
 "ファイル %s は本プログラムではコミットできません。\n"
 
-#: lib/commit.tcl:172
+#: lib/commit.tcl:188
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1360,7 +1403,7 @@ msgstr ""
 "\n"
 "最低一つの変更をコミット予定に加えてからコミットして下さい。\n"
 
-#: lib/commit.tcl:187
+#: lib/commit.tcl:203
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1378,45 +1421,40 @@ msgstr ""
 "- 第２行: 空白\n"
 "- 残りの行: なぜ、この変更が良い変更か、の説明。\n"
 
-#: lib/commit.tcl:211
-#, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr "警告: Tcl はエンコーディング '%s' をサポートしていません"
-
-#: lib/commit.tcl:227
+#: lib/commit.tcl:234
 msgid "Calling pre-commit hook..."
 msgstr "コミット前フックを実行中・・・"
 
-#: lib/commit.tcl:242
+#: lib/commit.tcl:249
 msgid "Commit declined by pre-commit hook."
 msgstr "コミット前フックがコミットを拒否しました"
 
-#: lib/commit.tcl:265
+#: lib/commit.tcl:272
 msgid "Calling commit-msg hook..."
 msgstr "コミット・メッセージ・フックを実行中・・・"
 
-#: lib/commit.tcl:280
+#: lib/commit.tcl:287
 msgid "Commit declined by commit-msg hook."
 msgstr "コミット・メッセージ・フックがコミットを拒否しました"
 
-#: lib/commit.tcl:293
+#: lib/commit.tcl:300
 msgid "Committing changes..."
 msgstr "変更点をコミット中・・・"
 
-#: lib/commit.tcl:309
+#: lib/commit.tcl:316
 msgid "write-tree failed:"
 msgstr "write-tree が失敗しました:"
 
-#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
+#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
 msgid "Commit failed."
 msgstr "コミットに失敗しました。"
 
-#: lib/commit.tcl:327
+#: lib/commit.tcl:334
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "コミット %s は壊れています"
 
-#: lib/commit.tcl:332
+#: lib/commit.tcl:339
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1430,19 +1468,19 @@ msgstr ""
 "\n"
 "自動的に再スキャンを開始します。\n"
 
-#: lib/commit.tcl:339
+#: lib/commit.tcl:346
 msgid "No changes to commit."
 msgstr "コミットする変更がありません。"
 
-#: lib/commit.tcl:353
+#: lib/commit.tcl:360
 msgid "commit-tree failed:"
 msgstr "commit-tree が失敗しました:"
 
-#: lib/commit.tcl:373
+#: lib/commit.tcl:381
 msgid "update-ref failed:"
 msgstr "update-ref が失敗しました:"
 
-#: lib/commit.tcl:461
+#: lib/commit.tcl:469
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "コミット %s を作成しました: %s"
@@ -1495,20 +1533,19 @@ msgstr "データベース圧縮"
 msgid "Verifying the object database with fsck-objects"
 msgstr "fsck-objects でオブジェクト・データベースを検証しています"
 
-#: lib/database.tcl:108
+#: lib/database.tcl:107
 #, tcl-format
 msgid ""
 "This repository currently has approximately %i loose objects.\n"
 "\n"
 "To maintain optimal performance it is strongly recommended that you compress "
-"the database when more than %i loose objects exist.\n"
+"the database.\n"
 "\n"
 "Compress the database now?"
 msgstr ""
 "このリポジトリにはおおよそ %i 個の個別オブジェクトがあります\n"
 "\n"
-"最適な性能を保つために、%i 個以上の個別オブジェクトを作る毎にデータベースを圧"
-"縮することを推奨します\n"
+"最適な性能を保つために、データベースを圧縮することを推奨します\n"
 "\n"
 "データベースを圧縮しますか？"
 
@@ -1517,7 +1554,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "Git から出た無効な日付: %s"
 
-#: lib/diff.tcl:59
+#: lib/diff.tcl:64
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1539,12 +1576,12 @@ msgstr ""
 "\n"
 "同様な状態のファイルを探すために、自動的に再スキャンを開始します。"
 
-#: lib/diff.tcl:99
+#: lib/diff.tcl:104
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "%s の変更点をロード中…"
 
-#: lib/diff.tcl:120
+#: lib/diff.tcl:125
 msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
@@ -1552,7 +1589,7 @@ msgstr ""
 "LOCAL: 削除\n"
 "Remote:\n"
 
-#: lib/diff.tcl:125
+#: lib/diff.tcl:130
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
@@ -1560,32 +1597,32 @@ msgstr ""
 "REMOTE: 削除\n"
 "LOCAL:\n"
 
-#: lib/diff.tcl:132
+#: lib/diff.tcl:137
 msgid "LOCAL:\n"
 msgstr "LOCAL:\n"
 
-#: lib/diff.tcl:135
+#: lib/diff.tcl:140
 msgid "REMOTE:\n"
 msgstr "REMOTE\n"
 
-#: lib/diff.tcl:197 lib/diff.tcl:296
+#: lib/diff.tcl:202 lib/diff.tcl:319
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "%s を表示できません"
 
-#: lib/diff.tcl:198
+#: lib/diff.tcl:203
 msgid "Error loading file:"
 msgstr "ファイルを読む際のエラーです:"
 
-#: lib/diff.tcl:205
+#: lib/diff.tcl:210
 msgid "Git Repository (subproject)"
 msgstr "Git リポジトリ(サブプロジェクト)"
 
-#: lib/diff.tcl:217
+#: lib/diff.tcl:222
 msgid "* Binary file (not showing content)."
 msgstr "* バイナリファイル(内容は表示しません)"
 
-#: lib/diff.tcl:222
+#: lib/diff.tcl:227
 #, tcl-format
 msgid ""
 "* Untracked file is %d bytes.\n"
@@ -1594,7 +1631,7 @@ msgstr ""
 "* 管理外のファイルの大きさは %d バイトです。\n"
 "* 最初の %d バイトだけ表示しています。\n"
 
-#: lib/diff.tcl:228
+#: lib/diff.tcl:233
 #, tcl-format
 msgid ""
 "\n"
@@ -1606,19 +1643,19 @@ msgstr ""
 "* %s は管理外のファイルをここで切りおとしました。\n"
 "* 全体を見るには外部エディタを使ってください。\n"
 
-#: lib/diff.tcl:436
+#: lib/diff.tcl:482
 msgid "Failed to unstage selected hunk."
 msgstr "選択されたパッチをコミット予定から外せません。"
 
-#: lib/diff.tcl:443
+#: lib/diff.tcl:489
 msgid "Failed to stage selected hunk."
 msgstr "選択されたパッチをコミット予定に加えられません。"
 
-#: lib/diff.tcl:509
+#: lib/diff.tcl:568
 msgid "Failed to unstage selected line."
 msgstr "選択されたパッチ行をコミット予定から外せません。"
 
-#: lib/diff.tcl:517
+#: lib/diff.tcl:576
 msgid "Failed to stage selected line."
 msgstr "選択されたパッチ行をコミット予定に加えられません。"
 
@@ -1655,7 +1692,7 @@ msgstr "インデックスをロックできません"
 msgid "Index Error"
 msgstr "索引エラー"
 
-#: lib/index.tcl:21
+#: lib/index.tcl:17
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to "
 "resynchronize git-gui."
@@ -1663,7 +1700,7 @@ msgstr ""
 "GIT インデックスの更新が失敗しました。git-gui と同期をとるために再スキャンし"
 "ます。"
 
-#: lib/index.tcl:27
+#: lib/index.tcl:28
 msgid "Continue"
 msgstr "続行"
 
@@ -1671,43 +1708,43 @@ msgstr "続行"
 msgid "Unlock Index"
 msgstr "インデックスのロック解除"
 
-#: lib/index.tcl:287
+#: lib/index.tcl:289
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "コミットから '%s' を降ろす"
 
-#: lib/index.tcl:326
+#: lib/index.tcl:328
 msgid "Ready to commit."
 msgstr "コミット準備完了"
 
-#: lib/index.tcl:339
+#: lib/index.tcl:341
 #, tcl-format
 msgid "Adding %s"
 msgstr "コミットに %s を加えています"
 
-#: lib/index.tcl:396
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "ファイル %s にした変更を元に戻しますか？"
 
-#: lib/index.tcl:398
+#: lib/index.tcl:400
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "これら %i 個のファイルにした変更を元に戻しますか？"
 
-#: lib/index.tcl:406
+#: lib/index.tcl:408
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr "変更を元に戻すとコミット予定していない変更は全て失われます。"
 
-#: lib/index.tcl:409
+#: lib/index.tcl:411
 msgid "Do Nothing"
 msgstr "何もしない"
 
-#: lib/index.tcl:427
+#: lib/index.tcl:429
 msgid "Reverting selected files"
 msgstr "選択されたファイルにした変更を元に戻します"
 
-#: lib/index.tcl:431
+#: lib/index.tcl:433
 #, tcl-format
 msgid "Reverting %s"
 msgstr "%s にした変更を元に戻します"
@@ -1883,7 +1920,8 @@ msgstr ""
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr "ファイル %s には解決していない競合部分がまだあるようですが、いいですか?"
+msgstr ""
+"ファイル %s には解決していない競合部分がまだあるようですが、いいですか?"
 
 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -2141,7 +2179,8 @@ msgstr "%s からフェッチしています"
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr "リポジトリ '%s' を初期化できません。"
 
-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/transport.tcl:81
 #, tcl-format
 msgid "push %s"
 msgstr "%s をプッシュ"
@@ -2159,11 +2198,11 @@ msgstr "遠隔でブランチ削除"
 msgid "From Repository"
 msgstr "元のリポジトリ"
 
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
 msgid "Remote:"
 msgstr "リモート:"
 
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
 msgid "Arbitrary Location:"
 msgstr "任意の位置:"
 
@@ -2179,10 +2218,6 @@ msgstr "条件付で削除"
 msgid "Merged Into:"
 msgstr "マージ先:"
 
-#: lib/remote_branch_delete.tcl:119
-msgid "Always (Do not perform merge checks)"
-msgstr "無条件（マージ検査をしない）"
-
 #: lib/remote_branch_delete.tcl:152
 msgid "A branch is required for 'Merged Into'."
 msgstr "'マージ先' にはブランチが必要です。"
@@ -2211,26 +2246,16 @@ msgstr ""
 msgid "Please select one or more branches to delete."
 msgstr "削除するブランチを選択して下さい。"
 
-#: lib/remote_branch_delete.tcl:216
-msgid ""
-"Recovering deleted branches is difficult.\n"
-"\n"
-"Delete the selected branches?"
-msgstr ""
-"削除したブランチを回復するのは困難です。\n"
-"\n"
-"選択したブランチを削除して良いですか？"
-
 #: lib/remote_branch_delete.tcl:226
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr "%s からブランチを削除しています。"
 
-#: lib/remote_branch_delete.tcl:286
+#: lib/remote_branch_delete.tcl:292
 msgid "No repository selected."
 msgstr "リポジトリが選択されていません。"
 
-#: lib/remote_branch_delete.tcl:291
+#: lib/remote_branch_delete.tcl:297
 #, tcl-format
 msgid "Scanning %s..."
 msgstr "%s をスキャンしています…"
@@ -2251,11 +2276,11 @@ msgstr "前"
 msgid "Case-Sensitive"
 msgstr "大文字小文字を区別"
 
-#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
 msgid "Cannot write shortcut:"
 msgstr "ショートカットが書けません:"
 
-#: lib/shortcut.tcl:136
+#: lib/shortcut.tcl:137
 msgid "Cannot write icon:"
 msgstr "アイコンが書けません:"
 
@@ -2501,30 +2526,30 @@ msgstr "%s へミラーしています"
 msgid "Pushing %s %s to %s"
 msgstr "%3$s へ %1$s %2$s をプッシュしています"
 
-#: lib/transport.tcl:89
+#: lib/transport.tcl:100
 msgid "Push Branches"
 msgstr "ブランチをプッシュ"
 
-#: lib/transport.tcl:103
+#: lib/transport.tcl:114
 msgid "Source Branches"
 msgstr "元のブランチ"
 
-#: lib/transport.tcl:120
+#: lib/transport.tcl:131
 msgid "Destination Repository"
 msgstr "送り先リポジトリ"
 
-#: lib/transport.tcl:158
+#: lib/transport.tcl:169
 msgid "Transfer Options"
 msgstr "通信オプション"
 
-#: lib/transport.tcl:160
+#: lib/transport.tcl:171
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr "既存ブランチを上書き(変更を破棄する可能性があります)"
 
-#: lib/transport.tcl:164
+#: lib/transport.tcl:175
 msgid "Use thin pack (for slow network connections)"
 msgstr "Thin Pack を使う（遅いネットワーク接続）"
 
-#: lib/transport.tcl:168
+#: lib/transport.tcl:179
 msgid "Include tags"
 msgstr "タグを含める"

--------------boundary--
