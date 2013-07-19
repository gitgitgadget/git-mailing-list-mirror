From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: Re: [PATCH v2 2/3] Update po/git-gui.pot
Date: Fri, 19 Jul 2013 21:31:37 +0900
Message-ID: <CAPM==H+gTnnnzX7HeFEuTq_KHL9mxSRTSoUVRAC=5t_G=Nih0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:31:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V09qb-00062D-Ch
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302Ab3GSMbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:31:40 -0400
Received: from mail-vb0-f45.google.com ([209.85.212.45]:33713 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab3GSMbi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:31:38 -0400
Received: by mail-vb0-f45.google.com with SMTP id p14so3111454vbm.4
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7fWlrZ5dF6kxNrH1tXJG6EjDibmJ/RT8GbLjB17ndz8=;
        b=xgXWhUvcEYHiX+LXDzNmIgjDhiTIDlvzpoCgEmxDiNEDHKQs7dighIy1QCACx3DziD
         CcL4ypK3TBA9k0xS7iD109sgtoO6WuLRGDqINMNd0+IIVZ5xFNtlKRDUJQCNNNHMdfGt
         EI6EB1fXl6dd00zw/74DzaEJVSoMHbrGnHX00xH14USSUV477jN8ZtWpS7MIqPi/PN/K
         +WFK11GhFbRojGrrM3g0Wi7VojkptEY/uzp5JM9ltcrOdrrpBnSchJeRIZRTyMrlWYIi
         1SJQbdG5p9CqQKJ39gzj0Av65PxRZiN1VrmNrEQlbmW4uciC5jtcQvu05JrVUEOFJc/a
         Nfrg==
X-Received: by 10.58.29.111 with SMTP id j15mr5682928veh.76.1374237097803;
 Fri, 19 Jul 2013 05:31:37 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Fri, 19 Jul 2013 05:31:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230797>

Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
---
 po/git-gui.pot | 1056 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 578 insertions(+), 478 deletions(-)

diff --git a/po/git-gui.pot b/po/git-gui.pot
index 0c94f9c..97ed37a 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"POT-Creation-Date: 2013-07-10 03:27+0900\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -16,33 +16,33 @@ msgstr ""
 "Content-Type: text/plain; charset=CHARSET\n"
 "Content-Transfer-Encoding: 8bit\n"

-#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
-#: git-gui.sh:922
-msgid "git-gui: fatal error"
-msgstr ""
-
-#: git-gui.sh:743
+#: git-gui.sh:859
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr ""

-#: git-gui.sh:779
+#: git-gui.sh:911
 msgid "Main Font"
 msgstr ""

-#: git-gui.sh:780
+#: git-gui.sh:912
 msgid "Diff/Console Font"
 msgstr ""

-#: git-gui.sh:794
+#: git-gui.sh:926 git-gui.sh:940 git-gui.sh:953 git-gui.sh:1043
+#: git-gui.sh:1062 git-gui.sh:3094
+msgid "git-gui: fatal error"
+msgstr ""
+
+#: git-gui.sh:927
 msgid "Cannot find git in PATH."
 msgstr ""

-#: git-gui.sh:821
+#: git-gui.sh:954
 msgid "Cannot parse Git version string:"
 msgstr ""

-#: git-gui.sh:839
+#: git-gui.sh:979
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -54,473 +54,493 @@ msgid ""
 "Assume '%s' is version 1.5.0?\n"
 msgstr ""

-#: git-gui.sh:1128
+#: git-gui.sh:1276
 msgid "Git directory not found:"
 msgstr ""

-#: git-gui.sh:1146
+#: git-gui.sh:1306
 msgid "Cannot move to top of working directory:"
 msgstr ""

-#: git-gui.sh:1154
+#: git-gui.sh:1314
 msgid "Cannot use bare repository:"
 msgstr ""

-#: git-gui.sh:1162
+#: git-gui.sh:1322
 msgid "No working directory"
 msgstr ""

-#: git-gui.sh:1334 lib/checkout_op.tcl:306
+#: git-gui.sh:1494 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr ""

-#: git-gui.sh:1390
+#: git-gui.sh:1554
 msgid "Scanning for modified files ..."
 msgstr ""

-#: git-gui.sh:1454
+#: git-gui.sh:1621
 msgid "Calling prepare-commit-msg hook..."
 msgstr ""

-#: git-gui.sh:1471
+#: git-gui.sh:1638
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr ""

-#: git-gui.sh:1629 lib/browser.tcl:246
+#: git-gui.sh:1796 lib/browser.tcl:252
 msgid "Ready."
 msgstr ""

-#: git-gui.sh:1787
+#: git-gui.sh:1954
 #, tcl-format
 msgid "Displaying only %s of %s files."
 msgstr ""

-#: git-gui.sh:1913
+#: git-gui.sh:2080
 msgid "Unmodified"
 msgstr ""

-#: git-gui.sh:1915
+#: git-gui.sh:2082
 msgid "Modified, not staged"
 msgstr ""

-#: git-gui.sh:1916 git-gui.sh:1924
+#: git-gui.sh:2083 git-gui.sh:2095
 msgid "Staged for commit"
 msgstr ""

-#: git-gui.sh:1917 git-gui.sh:1925
+#: git-gui.sh:2084 git-gui.sh:2096
 msgid "Portions staged for commit"
 msgstr ""

-#: git-gui.sh:1918 git-gui.sh:1926
+#: git-gui.sh:2085 git-gui.sh:2097
 msgid "Staged for commit, missing"
 msgstr ""

-#: git-gui.sh:1920
+#: git-gui.sh:2087
 msgid "File type changed, not staged"
 msgstr ""

-#: git-gui.sh:1921
+#: git-gui.sh:2088 git-gui.sh:2089
+msgid "File type changed, old type staged for commit"
+msgstr ""
+
+#: git-gui.sh:2090
 msgid "File type changed, staged"
 msgstr ""

-#: git-gui.sh:1923
+#: git-gui.sh:2091
+msgid "File type change staged, modification not staged"
+msgstr ""
+
+#: git-gui.sh:2092
+msgid "File type change staged, file missing"
+msgstr ""
+
+#: git-gui.sh:2094
 msgid "Untracked, not staged"
 msgstr ""

-#: git-gui.sh:1928
+#: git-gui.sh:2099
 msgid "Missing"
 msgstr ""

-#: git-gui.sh:1929
+#: git-gui.sh:2100
 msgid "Staged for removal"
 msgstr ""

-#: git-gui.sh:1930
+#: git-gui.sh:2101
 msgid "Staged for removal, still present"
 msgstr ""

-#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
-#: git-gui.sh:1936 git-gui.sh:1937
+#: git-gui.sh:2103 git-gui.sh:2104 git-gui.sh:2105 git-gui.sh:2106
+#: git-gui.sh:2107 git-gui.sh:2108
 msgid "Requires merge resolution"
 msgstr ""

-#: git-gui.sh:1972
+#: git-gui.sh:2143
 msgid "Starting gitk... please wait..."
 msgstr ""

-#: git-gui.sh:1984
+#: git-gui.sh:2155
 msgid "Couldn't find gitk in PATH"
 msgstr ""

-#: git-gui.sh:2043
+#: git-gui.sh:2214
 msgid "Couldn't find git gui in PATH"
 msgstr ""

-#: git-gui.sh:2455 lib/choose_repository.tcl:36
+#: git-gui.sh:2633 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr ""

-#: git-gui.sh:2456
+#: git-gui.sh:2634
 msgid "Edit"
 msgstr ""

-#: git-gui.sh:2458 lib/choose_rev.tcl:561
+#: git-gui.sh:2636 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr ""

-#: git-gui.sh:2461 lib/choose_rev.tcl:548
+#: git-gui.sh:2639 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr ""

-#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:2642 lib/merge.tcl:123 lib/merge.tcl:152 lib/merge.tcl:170
 msgid "Merge"
 msgstr ""

-#: git-gui.sh:2465 lib/choose_rev.tcl:557
+#: git-gui.sh:2643 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr ""

-#: git-gui.sh:2468
+#: git-gui.sh:2646
 msgid "Tools"
 msgstr ""

-#: git-gui.sh:2477
+#: git-gui.sh:2655
 msgid "Explore Working Copy"
 msgstr ""

-#: git-gui.sh:2483
+#: git-gui.sh:2661
 msgid "Browse Current Branch's Files"
 msgstr ""

-#: git-gui.sh:2487
+#: git-gui.sh:2665
 msgid "Browse Branch Files..."
 msgstr ""

-#: git-gui.sh:2492
+#: git-gui.sh:2670
 msgid "Visualize Current Branch's History"
 msgstr ""

-#: git-gui.sh:2496
+#: git-gui.sh:2674
 msgid "Visualize All Branch History"
 msgstr ""

-#: git-gui.sh:2503
+#: git-gui.sh:2681
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr ""

-#: git-gui.sh:2505
+#: git-gui.sh:2683
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr ""

-#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2688 lib/database.tcl:40 lib/database.tcl:66
 msgid "Database Statistics"
 msgstr ""

-#: git-gui.sh:2513 lib/database.tcl:34
+#: git-gui.sh:2691 lib/database.tcl:33
 msgid "Compress Database"
 msgstr ""

-#: git-gui.sh:2516
+#: git-gui.sh:2694
 msgid "Verify Database"
 msgstr ""

-#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: git-gui.sh:2701 git-gui.sh:2705 git-gui.sh:2709 lib/shortcut.tcl:8
 #: lib/shortcut.tcl:40 lib/shortcut.tcl:72
 msgid "Create Desktop Icon"
 msgstr ""

-#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository.tcl:191
+#: git-gui.sh:2717 lib/choose_repository.tcl:188 lib/choose_repository.tcl:196
 msgid "Quit"
 msgstr ""

-#: git-gui.sh:2547
+#: git-gui.sh:2725
 msgid "Undo"
 msgstr ""

-#: git-gui.sh:2550
+#: git-gui.sh:2728
 msgid "Redo"
 msgstr ""

-#: git-gui.sh:2554 git-gui.sh:3109
+#: git-gui.sh:2732 git-gui.sh:3321
 msgid "Cut"
 msgstr ""

-#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: git-gui.sh:2735 git-gui.sh:3324 git-gui.sh:3398 git-gui.sh:3483
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr ""

-#: git-gui.sh:2560 git-gui.sh:3115
+#: git-gui.sh:2738 git-gui.sh:3327
 msgid "Paste"
 msgstr ""

-#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
-#: lib/remote_branch_delete.tcl:38
+#: git-gui.sh:2741 git-gui.sh:3330 lib/branch_delete.tcl:28
+#: lib/remote_branch_delete.tcl:39
 msgid "Delete"
 msgstr ""

-#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+#: git-gui.sh:2745 git-gui.sh:3334 git-gui.sh:3487 lib/console.tcl:71
 msgid "Select All"
 msgstr ""

-#: git-gui.sh:2576
+#: git-gui.sh:2754
 msgid "Create..."
 msgstr ""

-#: git-gui.sh:2582
+#: git-gui.sh:2760
 msgid "Checkout..."
 msgstr ""

-#: git-gui.sh:2588
+#: git-gui.sh:2766
 msgid "Rename..."
 msgstr ""

-#: git-gui.sh:2593
+#: git-gui.sh:2771
 msgid "Delete..."
 msgstr ""

-#: git-gui.sh:2598
+#: git-gui.sh:2776
 msgid "Reset..."
 msgstr ""

-#: git-gui.sh:2608
+#: git-gui.sh:2786
 msgid "Done"
 msgstr ""

-#: git-gui.sh:2610
+#: git-gui.sh:2788
 msgid "Commit@@verb"
 msgstr ""

-#: git-gui.sh:2619 git-gui.sh:3050
+#: git-gui.sh:2797 git-gui.sh:3262
 msgid "New Commit"
 msgstr ""

-#: git-gui.sh:2627 git-gui.sh:3057
+#: git-gui.sh:2805 git-gui.sh:3269
 msgid "Amend Last Commit"
 msgstr ""

-#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2815 git-gui.sh:3223 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr ""

-#: git-gui.sh:2643
+#: git-gui.sh:2821
 msgid "Stage To Commit"
 msgstr ""

-#: git-gui.sh:2649
+#: git-gui.sh:2827
 msgid "Stage Changed Files To Commit"
 msgstr ""

-#: git-gui.sh:2655
+#: git-gui.sh:2833
 msgid "Unstage From Commit"
 msgstr ""

-#: git-gui.sh:2661 lib/index.tcl:412
+#: git-gui.sh:2839 lib/index.tcl:442
 msgid "Revert Changes"
 msgstr ""

-#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+#: git-gui.sh:2847 git-gui.sh:3534 git-gui.sh:3565
 msgid "Show Less Context"
 msgstr ""

-#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+#: git-gui.sh:2851 git-gui.sh:3538 git-gui.sh:3569
 msgid "Show More Context"
 msgstr ""

-#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+#: git-gui.sh:2858 git-gui.sh:3236 git-gui.sh:3345
 msgid "Sign Off"
 msgstr ""

-#: git-gui.sh:2696
+#: git-gui.sh:2874
 msgid "Local Merge..."
 msgstr ""

-#: git-gui.sh:2701
+#: git-gui.sh:2879
 msgid "Abort Merge..."
 msgstr ""

-#: git-gui.sh:2713 git-gui.sh:2741
+#: git-gui.sh:2891 git-gui.sh:2919
 msgid "Add..."
 msgstr ""

-#: git-gui.sh:2717
+#: git-gui.sh:2895
 msgid "Push..."
 msgstr ""

-#: git-gui.sh:2721
+#: git-gui.sh:2899
 msgid "Delete Branch..."
 msgstr ""

-#: git-gui.sh:2731 git-gui.sh:3292
+#: git-gui.sh:2909 git-gui.sh:3516
 msgid "Options..."
 msgstr ""

-#: git-gui.sh:2742
+#: git-gui.sh:2920
 msgid "Remove..."
 msgstr ""

-#: git-gui.sh:2751 lib/choose_repository.tcl:50
+#: git-gui.sh:2929 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr ""

-#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: git-gui.sh:2933 git-gui.sh:2937 lib/about.tcl:14
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr ""

-#: git-gui.sh:2783
+#: git-gui.sh:2961
 msgid "Online Documentation"
 msgstr ""

-#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
+#: git-gui.sh:2964 lib/choose_repository.tcl:47 lib/choose_repository.tcl:56
 msgid "Show SSH Key"
 msgstr ""

-#: git-gui.sh:2893
+#: git-gui.sh:2983 git-gui.sh:3115
+msgid "Usage"
+msgstr ""
+
+#: git-gui.sh:3064 lib/blame.tcl:573
+msgid "Error"
+msgstr ""
+
+#: git-gui.sh:3095
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""

-#: git-gui.sh:2926
+#: git-gui.sh:3128
 msgid "Current Branch:"
 msgstr ""

-#: git-gui.sh:2947
+#: git-gui.sh:3154
 msgid "Staged Changes (Will Commit)"
 msgstr ""

-#: git-gui.sh:2967
+#: git-gui.sh:3174
 msgid "Unstaged Changes"
 msgstr ""

-#: git-gui.sh:3017
+#: git-gui.sh:3229
 msgid "Stage Changed"
 msgstr ""

-#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+#: git-gui.sh:3248 lib/transport.tcl:137 lib/transport.tcl:229
 msgid "Push"
 msgstr ""

-#: git-gui.sh:3071
+#: git-gui.sh:3283
 msgid "Initial Commit Message:"
 msgstr ""

-#: git-gui.sh:3072
+#: git-gui.sh:3284
 msgid "Amended Commit Message:"
 msgstr ""

-#: git-gui.sh:3073
+#: git-gui.sh:3285
 msgid "Amended Initial Commit Message:"
 msgstr ""

-#: git-gui.sh:3074
+#: git-gui.sh:3286
 msgid "Amended Merge Commit Message:"
 msgstr ""

-#: git-gui.sh:3075
+#: git-gui.sh:3287
 msgid "Merge Commit Message:"
 msgstr ""

-#: git-gui.sh:3076
+#: git-gui.sh:3288
 msgid "Commit Message:"
 msgstr ""

-#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+#: git-gui.sh:3337 git-gui.sh:3491 lib/console.tcl:73
 msgid "Copy All"
 msgstr ""

-#: git-gui.sh:3149 lib/blame.tcl:104
+#: git-gui.sh:3361 lib/blame.tcl:105
 msgid "File:"
 msgstr ""

-#: git-gui.sh:3255
+#: git-gui.sh:3479
 msgid "Refresh"
 msgstr ""

-#: git-gui.sh:3276
+#: git-gui.sh:3500
 msgid "Decrease Font Size"
 msgstr ""

-#: git-gui.sh:3280
+#: git-gui.sh:3504
 msgid "Increase Font Size"
 msgstr ""

-#: git-gui.sh:3288 lib/blame.tcl:281
+#: git-gui.sh:3512 lib/blame.tcl:294
 msgid "Encoding"
 msgstr ""

-#: git-gui.sh:3299
+#: git-gui.sh:3523
 msgid "Apply/Reverse Hunk"
 msgstr ""

-#: git-gui.sh:3304
+#: git-gui.sh:3528
 msgid "Apply/Reverse Line"
 msgstr ""

-#: git-gui.sh:3323
+#: git-gui.sh:3547
 msgid "Run Merge Tool"
 msgstr ""

-#: git-gui.sh:3328
+#: git-gui.sh:3552
 msgid "Use Remote Version"
 msgstr ""

-#: git-gui.sh:3332
+#: git-gui.sh:3556
 msgid "Use Local Version"
 msgstr ""

-#: git-gui.sh:3336
+#: git-gui.sh:3560
 msgid "Revert To Base"
 msgstr ""

-#: git-gui.sh:3354
+#: git-gui.sh:3578
 msgid "Visualize These Changes In The Submodule"
 msgstr ""

-#: git-gui.sh:3358
+#: git-gui.sh:3582
 msgid "Visualize Current Branch History In The Submodule"
 msgstr ""

-#: git-gui.sh:3362
+#: git-gui.sh:3586
 msgid "Visualize All Branch History In The Submodule"
 msgstr ""

-#: git-gui.sh:3367
+#: git-gui.sh:3591
 msgid "Start git gui In The Submodule"
 msgstr ""

-#: git-gui.sh:3389
+#: git-gui.sh:3626
 msgid "Unstage Hunk From Commit"
 msgstr ""

-#: git-gui.sh:3391
+#: git-gui.sh:3628
 msgid "Unstage Lines From Commit"
 msgstr ""

-#: git-gui.sh:3393
+#: git-gui.sh:3630
 msgid "Unstage Line From Commit"
 msgstr ""

-#: git-gui.sh:3396
+#: git-gui.sh:3633
 msgid "Stage Hunk For Commit"
 msgstr ""

-#: git-gui.sh:3398
+#: git-gui.sh:3635
 msgid "Stage Lines For Commit"
 msgstr ""

-#: git-gui.sh:3400
+#: git-gui.sh:3637
 msgid "Stage Line For Commit"
 msgstr ""

-#: git-gui.sh:3424
+#: git-gui.sh:3662
 msgid "Initializing..."
 msgstr ""

-#: git-gui.sh:3541
+#: git-gui.sh:3805
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -531,14 +551,14 @@ msgid ""
 "\n"
 msgstr ""

-#: git-gui.sh:3570
+#: git-gui.sh:3834
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""

-#: git-gui.sh:3575
+#: git-gui.sh:3839
 #, tcl-format
 msgid ""
 "\n"
@@ -553,165 +573,169 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr ""

-#: lib/blame.tcl:72
+#: lib/blame.tcl:73
 msgid "File Viewer"
 msgstr ""

-#: lib/blame.tcl:78
+#: lib/blame.tcl:79
 msgid "Commit:"
 msgstr ""

-#: lib/blame.tcl:271
+#: lib/blame.tcl:280
 msgid "Copy Commit"
 msgstr ""

-#: lib/blame.tcl:275
+#: lib/blame.tcl:284
 msgid "Find Text..."
 msgstr ""

-#: lib/blame.tcl:284
+#: lib/blame.tcl:288
+msgid "Goto Line..."
+msgstr ""
+
+#: lib/blame.tcl:297
 msgid "Do Full Copy Detection"
 msgstr ""

-#: lib/blame.tcl:288
+#: lib/blame.tcl:301
 msgid "Show History Context"
 msgstr ""

-#: lib/blame.tcl:291
+#: lib/blame.tcl:304
 msgid "Blame Parent Commit"
 msgstr ""

-#: lib/blame.tcl:450
+#: lib/blame.tcl:466
 #, tcl-format
 msgid "Reading %s..."
 msgstr ""

-#: lib/blame.tcl:557
+#: lib/blame.tcl:594
 msgid "Loading copy/move tracking annotations..."
 msgstr ""

-#: lib/blame.tcl:577
+#: lib/blame.tcl:614
 msgid "lines annotated"
 msgstr ""

-#: lib/blame.tcl:769
+#: lib/blame.tcl:806
 msgid "Loading original location annotations..."
 msgstr ""

-#: lib/blame.tcl:772
+#: lib/blame.tcl:809
 msgid "Annotation complete."
 msgstr ""

-#: lib/blame.tcl:802
+#: lib/blame.tcl:839
 msgid "Busy"
 msgstr ""

-#: lib/blame.tcl:803
+#: lib/blame.tcl:840
 msgid "Annotation process is already running."
 msgstr ""

-#: lib/blame.tcl:842
+#: lib/blame.tcl:879
 msgid "Running thorough copy detection..."
 msgstr ""

-#: lib/blame.tcl:910
+#: lib/blame.tcl:947
 msgid "Loading annotation..."
 msgstr ""

-#: lib/blame.tcl:963
+#: lib/blame.tcl:1000
 msgid "Author:"
 msgstr ""

-#: lib/blame.tcl:967
+#: lib/blame.tcl:1004
 msgid "Committer:"
 msgstr ""

-#: lib/blame.tcl:972
+#: lib/blame.tcl:1009
 msgid "Original File:"
 msgstr ""

-#: lib/blame.tcl:1020
+#: lib/blame.tcl:1057
 msgid "Cannot find HEAD commit:"
 msgstr ""

-#: lib/blame.tcl:1075
+#: lib/blame.tcl:1112
 msgid "Cannot find parent commit:"
 msgstr ""

-#: lib/blame.tcl:1090
+#: lib/blame.tcl:1127
 msgid "Unable to display parent"
 msgstr ""

-#: lib/blame.tcl:1091 lib/diff.tcl:320
+#: lib/blame.tcl:1128 lib/diff.tcl:338
 msgid "Error loading diff:"
 msgstr ""

-#: lib/blame.tcl:1231
+#: lib/blame.tcl:1269
 msgid "Originally By:"
 msgstr ""

-#: lib/blame.tcl:1237
+#: lib/blame.tcl:1275
 msgid "In File:"
 msgstr ""

-#: lib/blame.tcl:1242
+#: lib/blame.tcl:1280
 msgid "Copied Or Moved Here By:"
 msgstr ""

-#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+#: lib/branch_checkout.tcl:16 lib/branch_checkout.tcl:21
 msgid "Checkout Branch"
 msgstr ""

-#: lib/branch_checkout.tcl:23
+#: lib/branch_checkout.tcl:26
 msgid "Checkout"
 msgstr ""

-#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
-#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:282
-#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
-#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.tcl:42
-#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
-#: lib/transport.tcl:108
+#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37
+#: lib/branch_delete.tcl:34 lib/branch_rename.tcl:32 lib/browser.tcl:292
+#: lib/checkout_op.tcl:579 lib/choose_font.tcl:45 lib/merge.tcl:174
+#: lib/option.tcl:127 lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43
+#: lib/tools_dlg.tcl:41 lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345
+#: lib/transport.tcl:141
 msgid "Cancel"
 msgstr ""

-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:328
+#: lib/branch_checkout.tcl:35 lib/browser.tcl:297 lib/tools_dlg.tcl:321
 msgid "Revision"
 msgstr ""

-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:280
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:69 lib/option.tcl:307
 msgid "Options"
 msgstr ""

-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
 msgstr ""

-#: lib/branch_checkout.tcl:44
+#: lib/branch_checkout.tcl:47
 msgid "Detach From Local Branch"
 msgstr ""

-#: lib/branch_create.tcl:22
+#: lib/branch_create.tcl:23
 msgid "Create Branch"
 msgstr ""

-#: lib/branch_create.tcl:27
+#: lib/branch_create.tcl:28
 msgid "Create New Branch"
 msgstr ""

-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
+#: lib/branch_create.tcl:33 lib/choose_repository.tcl:383
 msgid "Create"
 msgstr ""

-#: lib/branch_create.tcl:40
+#: lib/branch_create.tcl:42
 msgid "Branch Name"
 msgstr ""

-#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
+#: lib/branch_create.tcl:44 lib/remote_add.tcl:41 lib/tools_dlg.tcl:51
 msgid "Name:"
 msgstr ""

-#: lib/branch_create.tcl:58
+#: lib/branch_create.tcl:57
 msgid "Match Tracking Branch Name"
 msgstr ""

@@ -739,41 +763,41 @@ msgstr ""
 msgid "Checkout After Creation"
 msgstr ""

-#: lib/branch_create.tcl:131
+#: lib/branch_create.tcl:132
 msgid "Please select a tracking branch."
 msgstr ""

-#: lib/branch_create.tcl:140
+#: lib/branch_create.tcl:141
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
 msgstr ""

-#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+#: lib/branch_create.tcl:154 lib/branch_rename.tcl:92
 msgid "Please supply a branch name."
 msgstr ""

-#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#: lib/branch_create.tcl:165 lib/branch_rename.tcl:112
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
 msgstr ""

-#: lib/branch_delete.tcl:15
+#: lib/branch_delete.tcl:16
 msgid "Delete Branch"
 msgstr ""

-#: lib/branch_delete.tcl:20
+#: lib/branch_delete.tcl:21
 msgid "Delete Local Branch"
 msgstr ""

-#: lib/branch_delete.tcl:37
+#: lib/branch_delete.tcl:39
 msgid "Local Branches"
 msgstr ""

-#: lib/branch_delete.tcl:52
+#: lib/branch_delete.tcl:51
 msgid "Delete Only If Merged Into"
 msgstr ""

-#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+#: lib/branch_delete.tcl:53 lib/remote_branch_delete.tcl:120
 msgid "Always (Do not perform merge checks)"
 msgstr ""

@@ -782,7 +806,7 @@ msgstr ""
 msgid "The following branches are not completely merged into %s:"
 msgstr ""

-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:218
 msgid ""
 "Recovering deleted branches is difficult.\n"
 "\n"
@@ -796,32 +820,32 @@ msgid ""
 "%s"
 msgstr ""

-#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+#: lib/branch_rename.tcl:15 lib/branch_rename.tcl:23
 msgid "Rename Branch"
 msgstr ""

-#: lib/branch_rename.tcl:26
+#: lib/branch_rename.tcl:28
 msgid "Rename"
 msgstr ""

-#: lib/branch_rename.tcl:36
+#: lib/branch_rename.tcl:38
 msgid "Branch:"
 msgstr ""

-#: lib/branch_rename.tcl:39
+#: lib/branch_rename.tcl:46
 msgid "New Name:"
 msgstr ""

-#: lib/branch_rename.tcl:75
+#: lib/branch_rename.tcl:81
 msgid "Please select a branch to rename."
 msgstr ""

-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
+#: lib/branch_rename.tcl:102 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr ""

-#: lib/branch_rename.tcl:117
+#: lib/branch_rename.tcl:123
 #, tcl-format
 msgid "Failed to rename '%s'."
 msgstr ""
@@ -830,26 +854,26 @@ msgstr ""
 msgid "Starting..."
 msgstr ""

-#: lib/browser.tcl:26
+#: lib/browser.tcl:27
 msgid "File Browser"
 msgstr ""

-#: lib/browser.tcl:126 lib/browser.tcl:143
+#: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
 msgid "Loading %s..."
 msgstr ""

-#: lib/browser.tcl:187
+#: lib/browser.tcl:193
 msgid "[Up To Parent]"
 msgstr ""

-#: lib/browser.tcl:267 lib/browser.tcl:273
+#: lib/browser.tcl:275 lib/browser.tcl:282
 msgid "Browse Branch Files"
 msgstr ""

-#: lib/browser.tcl:278 lib/choose_repository.tcl:398
-#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
-#: lib/choose_repository.tcl:1028
+#: lib/browser.tcl:288 lib/choose_repository.tcl:398
+#: lib/choose_repository.tcl:485 lib/choose_repository.tcl:494
+#: lib/choose_repository.tcl:1021
 msgid "Browse"
 msgstr ""

@@ -863,8 +887,8 @@ msgstr ""
 msgid "fatal: Cannot resolve %s"
 msgstr ""

-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
-#: lib/sshkey.tcl:53
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:30
+#: lib/sshkey.tcl:55
 msgid "Close"
 msgstr ""

@@ -961,7 +985,7 @@ msgstr ""
 msgid "Reset '%s'?"
 msgstr ""

-#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+#: lib/checkout_op.tcl:567 lib/merge.tcl:166 lib/tools_dlg.tcl:336
 msgid "Visualize"
 msgstr ""

@@ -976,23 +1000,23 @@ msgid ""
 "This should not have occurred.  %s will now close and give up."
 msgstr ""

-#: lib/choose_font.tcl:39
+#: lib/choose_font.tcl:41
 msgid "Select"
 msgstr ""

-#: lib/choose_font.tcl:53
+#: lib/choose_font.tcl:55
 msgid "Font Family"
 msgstr ""

-#: lib/choose_font.tcl:74
+#: lib/choose_font.tcl:76
 msgid "Font Size"
 msgstr ""

-#: lib/choose_font.tcl:91
+#: lib/choose_font.tcl:93
 msgid "Font Example"
 msgstr ""

-#: lib/choose_font.tcl:103
+#: lib/choose_font.tcl:105
 msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
@@ -1002,7 +1026,7 @@ msgstr ""
 msgid "Git Gui"
 msgstr ""

-#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:388
 msgid "Create New Repository"
 msgstr ""

@@ -1010,42 +1034,42 @@ msgstr ""
 msgid "New..."
 msgstr ""

-#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:472
 msgid "Clone Existing Repository"
 msgstr ""

-#: lib/choose_repository.tcl:106
+#: lib/choose_repository.tcl:111
 msgid "Clone..."
 msgstr ""

-#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
+#: lib/choose_repository.tcl:118 lib/choose_repository.tcl:1011
 msgid "Open Existing Repository"
 msgstr ""

-#: lib/choose_repository.tcl:119
+#: lib/choose_repository.tcl:124
 msgid "Open..."
 msgstr ""

-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:137
 msgid "Recent Repositories"
 msgstr ""

-#: lib/choose_repository.tcl:138
+#: lib/choose_repository.tcl:143
 msgid "Open Recent Repository:"
 msgstr ""

-#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
-#: lib/choose_repository.tcl:320
+#: lib/choose_repository.tcl:307 lib/choose_repository.tcl:314
+#: lib/choose_repository.tcl:321
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr ""

-#: lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:393
 msgid "Directory:"
 msgstr ""

-#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
-#: lib/choose_repository.tcl:1052
+#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1045
 msgid "Git Repository"
 msgstr ""

@@ -1059,173 +1083,173 @@ msgstr ""
 msgid "File %s already exists."
 msgstr ""

-#: lib/choose_repository.tcl:466
+#: lib/choose_repository.tcl:467
 msgid "Clone"
 msgstr ""

-#: lib/choose_repository.tcl:479
+#: lib/choose_repository.tcl:480
 msgid "Source Location:"
 msgstr ""

-#: lib/choose_repository.tcl:490
+#: lib/choose_repository.tcl:489
 msgid "Target Directory:"
 msgstr ""

-#: lib/choose_repository.tcl:502
+#: lib/choose_repository.tcl:499
 msgid "Clone Type:"
 msgstr ""

-#: lib/choose_repository.tcl:508
+#: lib/choose_repository.tcl:504
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr ""

-#: lib/choose_repository.tcl:514
+#: lib/choose_repository.tcl:509
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr ""

-#: lib/choose_repository.tcl:520
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr ""

-#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
-#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
-#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1051 lib/choose_repository.tcl:1059
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr ""

-#: lib/choose_repository.tcl:592
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr ""

-#: lib/choose_repository.tcl:596
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr ""

-#: lib/choose_repository.tcl:617
+#: lib/choose_repository.tcl:611
 #, tcl-format
 msgid "Location %s already exists."
 msgstr ""

-#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
 msgstr ""

-#: lib/choose_repository.tcl:640
+#: lib/choose_repository.tcl:634
 msgid "Counting objects"
 msgstr ""

-#: lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:635
 msgid "buckets"
 msgstr ""

-#: lib/choose_repository.tcl:665
+#: lib/choose_repository.tcl:659
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr ""

-#: lib/choose_repository.tcl:701
+#: lib/choose_repository.tcl:695
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr ""

-#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
-#: lib/choose_repository.tcl:929
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
 msgid "The 'master' branch has not been initialized."
 msgstr ""

-#: lib/choose_repository.tcl:716
+#: lib/choose_repository.tcl:710
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr ""

-#: lib/choose_repository.tcl:728
+#: lib/choose_repository.tcl:722
 #, tcl-format
 msgid "Cloning from %s"
 msgstr ""

-#: lib/choose_repository.tcl:759
+#: lib/choose_repository.tcl:753
 msgid "Copying objects"
 msgstr ""

-#: lib/choose_repository.tcl:760
+#: lib/choose_repository.tcl:754
 msgid "KiB"
 msgstr ""

-#: lib/choose_repository.tcl:784
+#: lib/choose_repository.tcl:778
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr ""

-#: lib/choose_repository.tcl:794
+#: lib/choose_repository.tcl:788
 msgid "Linking objects"
 msgstr ""

-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:789
 msgid "objects"
 msgstr ""

-#: lib/choose_repository.tcl:803
+#: lib/choose_repository.tcl:797
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr ""

-#: lib/choose_repository.tcl:858
+#: lib/choose_repository.tcl:852
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr ""

-#: lib/choose_repository.tcl:869
+#: lib/choose_repository.tcl:863
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""

-#: lib/choose_repository.tcl:893
+#: lib/choose_repository.tcl:887
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""

-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:896
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr ""

-#: lib/choose_repository.tcl:908
+#: lib/choose_repository.tcl:902
 msgid "Clone failed."
 msgstr ""

-#: lib/choose_repository.tcl:915
+#: lib/choose_repository.tcl:909
 msgid "No default branch obtained."
 msgstr ""

-#: lib/choose_repository.tcl:926
+#: lib/choose_repository.tcl:920
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr ""

-#: lib/choose_repository.tcl:938
+#: lib/choose_repository.tcl:932
 msgid "Creating working directory"
 msgstr ""

-#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
-#: lib/index.tcl:198
+#: lib/choose_repository.tcl:933 lib/index.tcl:70 lib/index.tcl:136
+#: lib/index.tcl:207
 msgid "files"
 msgstr ""

-#: lib/choose_repository.tcl:968
+#: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
 msgstr ""

-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:1006
 msgid "Open"
 msgstr ""

-#: lib/choose_repository.tcl:1021
+#: lib/choose_repository.tcl:1016
 msgid "Repository:"
 msgstr ""

-#: lib/choose_repository.tcl:1072
+#: lib/choose_repository.tcl:1065
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr ""

-#: lib/choose_rev.tcl:53
+#: lib/choose_rev.tcl:52
 msgid "This Detached Checkout"
 msgstr ""

@@ -1233,36 +1257,36 @@ msgstr ""
 msgid "Revision Expression:"
 msgstr ""

-#: lib/choose_rev.tcl:74
+#: lib/choose_rev.tcl:72
 msgid "Local Branch"
 msgstr ""

-#: lib/choose_rev.tcl:79
+#: lib/choose_rev.tcl:77
 msgid "Tracking Branch"
 msgstr ""

-#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
 msgid "Tag"
 msgstr ""

-#: lib/choose_rev.tcl:317
+#: lib/choose_rev.tcl:321
 #, tcl-format
 msgid "Invalid revision: %s"
 msgstr ""

-#: lib/choose_rev.tcl:338
+#: lib/choose_rev.tcl:342
 msgid "No revision selected."
 msgstr ""

-#: lib/choose_rev.tcl:346
+#: lib/choose_rev.tcl:350
 msgid "Revision expression is empty."
 msgstr ""

-#: lib/choose_rev.tcl:531
+#: lib/choose_rev.tcl:537
 msgid "Updated"
 msgstr ""

-#: lib/choose_rev.tcl:559
+#: lib/choose_rev.tcl:565
 msgid "URL"
 msgstr ""

@@ -1310,7 +1334,7 @@ msgid ""
 "The rescan will be automatically started now.\n"
 msgstr ""

-#: lib/commit.tcl:172
+#: lib/commit.tcl:173
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1319,7 +1343,7 @@ msgid ""
 "before committing.\n"
 msgstr ""

-#: lib/commit.tcl:180
+#: lib/commit.tcl:181
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1327,14 +1351,14 @@ msgid ""
 "File %s cannot be committed by this program.\n"
 msgstr ""

-#: lib/commit.tcl:188
+#: lib/commit.tcl:189
 msgid ""
 "No changes to commit.\n"
 "\n"
 "You must stage at least 1 file before you can commit.\n"
 msgstr ""

-#: lib/commit.tcl:203
+#: lib/commit.tcl:204
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1345,40 +1369,50 @@ msgid ""
 "- Remaining lines: Describe why this change is good.\n"
 msgstr ""

-#: lib/commit.tcl:234
+#: lib/commit.tcl:235
 msgid "Calling pre-commit hook..."
 msgstr ""

-#: lib/commit.tcl:249
+#: lib/commit.tcl:250
 msgid "Commit declined by pre-commit hook."
 msgstr ""

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
+
+#: lib/commit.tcl:290
 msgid "Calling commit-msg hook..."
 msgstr ""

-#: lib/commit.tcl:287
+#: lib/commit.tcl:305
 msgid "Commit declined by commit-msg hook."
 msgstr ""

-#: lib/commit.tcl:300
+#: lib/commit.tcl:318
 msgid "Committing changes..."
 msgstr ""

-#: lib/commit.tcl:316
+#: lib/commit.tcl:334
 msgid "write-tree failed:"
 msgstr ""

-#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
+#: lib/commit.tcl:335 lib/commit.tcl:379 lib/commit.tcl:400
 msgid "Commit failed."
 msgstr ""

-#: lib/commit.tcl:334
+#: lib/commit.tcl:352
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr ""

-#: lib/commit.tcl:339
+#: lib/commit.tcl:357
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1387,19 +1421,19 @@ msgid ""
 "A rescan will be automatically started now.\n"
 msgstr ""

-#: lib/commit.tcl:346
+#: lib/commit.tcl:364
 msgid "No changes to commit."
 msgstr ""

-#: lib/commit.tcl:360
+#: lib/commit.tcl:378
 msgid "commit-tree failed:"
 msgstr ""

-#: lib/commit.tcl:381
+#: lib/commit.tcl:399
 msgid "update-ref failed:"
 msgstr ""

-#: lib/commit.tcl:469
+#: lib/commit.tcl:492
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr ""
@@ -1416,31 +1450,31 @@ msgstr ""
 msgid "Error: Command Failed"
 msgstr ""

-#: lib/database.tcl:43
+#: lib/database.tcl:42
 msgid "Number of loose objects"
 msgstr ""

-#: lib/database.tcl:44
+#: lib/database.tcl:43
 msgid "Disk space used by loose objects"
 msgstr ""

-#: lib/database.tcl:45
+#: lib/database.tcl:44
 msgid "Number of packed objects"
 msgstr ""

-#: lib/database.tcl:46
+#: lib/database.tcl:45
 msgid "Number of packs"
 msgstr ""

-#: lib/database.tcl:47
+#: lib/database.tcl:46
 msgid "Disk space used by packed objects"
 msgstr ""

-#: lib/database.tcl:48
+#: lib/database.tcl:47
 msgid "Packed objects waiting for pruning"
 msgstr ""

-#: lib/database.tcl:49
+#: lib/database.tcl:48
 msgid "Garbage files"
 msgstr ""

@@ -1507,7 +1541,7 @@ msgstr ""
 msgid "REMOTE:\n"
 msgstr ""

-#: lib/diff.tcl:202 lib/diff.tcl:319
+#: lib/diff.tcl:202 lib/diff.tcl:337
 #, tcl-format
 msgid "Unable to display %s"
 msgstr ""
@@ -1539,19 +1573,19 @@ msgid ""
 "* To see the entire file, use an external editor.\n"
 msgstr ""

-#: lib/diff.tcl:482
+#: lib/diff.tcl:557
 msgid "Failed to unstage selected hunk."
 msgstr ""

-#: lib/diff.tcl:489
+#: lib/diff.tcl:564
 msgid "Failed to stage selected hunk."
 msgstr ""

-#: lib/diff.tcl:568
+#: lib/diff.tcl:643
 msgid "Failed to unstage selected line."
 msgstr ""

-#: lib/diff.tcl:576
+#: lib/diff.tcl:651
 msgid "Failed to stage selected line."
 msgstr ""

@@ -1568,7 +1602,7 @@ msgstr ""
 msgid "Other"
 msgstr ""

-#: lib/error.tcl:20 lib/error.tcl:114
+#: lib/error.tcl:20 lib/error.tcl:116
 msgid "error"
 msgstr ""

@@ -1576,7 +1610,7 @@ msgstr ""
 msgid "warning"
 msgstr ""

-#: lib/error.tcl:94
+#: lib/error.tcl:96
 msgid "You must correct the above errors before committing."
 msgstr ""

@@ -1584,65 +1618,78 @@ msgstr ""
 msgid "Unable to unlock the index."
 msgstr ""

-#: lib/index.tcl:15
+#: lib/index.tcl:17
 msgid "Index Error"
 msgstr ""

-#: lib/index.tcl:17
+#: lib/index.tcl:19
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to "
 "resynchronize git-gui."
 msgstr ""

-#: lib/index.tcl:28
+#: lib/index.tcl:30
 msgid "Continue"
 msgstr ""

-#: lib/index.tcl:31
+#: lib/index.tcl:33
 msgid "Unlock Index"
 msgstr ""

-#: lib/index.tcl:289
+#: lib/index.tcl:298
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr ""

-#: lib/index.tcl:328
+#: lib/index.tcl:337
 msgid "Ready to commit."
 msgstr ""

-#: lib/index.tcl:341
+#: lib/index.tcl:350
 #, tcl-format
 msgid "Adding %s"
 msgstr ""

-#: lib/index.tcl:398
+#: lib/index.tcl:380
+#, tcl-format
+msgid "Stage %d untracked files?"
+msgstr ""
+
+#: lib/index.tcl:428
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr ""

-#: lib/index.tcl:400
+#: lib/index.tcl:430
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr ""

-#: lib/index.tcl:408
+#: lib/index.tcl:438
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""

-#: lib/index.tcl:411
+#: lib/index.tcl:441
 msgid "Do Nothing"
 msgstr ""

-#: lib/index.tcl:429
+#: lib/index.tcl:459
 msgid "Reverting selected files"
 msgstr ""

-#: lib/index.tcl:433
+#: lib/index.tcl:463
 #, tcl-format
 msgid "Reverting %s"
 msgstr ""

+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr ""
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr ""
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1682,41 +1729,41 @@ msgid ""
 "will help you abort a failed merge, should the need arise.\n"
 msgstr ""

-#: lib/merge.tcl:107
+#: lib/merge.tcl:108
 #, tcl-format
 msgid "%s of %s"
 msgstr ""

-#: lib/merge.tcl:120
+#: lib/merge.tcl:122
 #, tcl-format
 msgid "Merging %s and %s..."
 msgstr ""

-#: lib/merge.tcl:131
+#: lib/merge.tcl:133
 msgid "Merge completed successfully."
 msgstr ""

-#: lib/merge.tcl:133
+#: lib/merge.tcl:135
 msgid "Merge failed.  Conflict resolution is required."
 msgstr ""

-#: lib/merge.tcl:158
+#: lib/merge.tcl:160
 #, tcl-format
 msgid "Merge Into %s"
 msgstr ""

-#: lib/merge.tcl:177
+#: lib/merge.tcl:179
 msgid "Revision To Merge"
 msgstr ""

-#: lib/merge.tcl:212
+#: lib/merge.tcl:214
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
 "You must finish amending this commit.\n"
 msgstr ""

-#: lib/merge.tcl:222
+#: lib/merge.tcl:224
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1725,7 +1772,7 @@ msgid ""
 "Continue with aborting the current merge?"
 msgstr ""

-#: lib/merge.tcl:228
+#: lib/merge.tcl:230
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1734,19 +1781,19 @@ msgid ""
 "Continue with resetting the current changes?"
 msgstr ""

-#: lib/merge.tcl:239
+#: lib/merge.tcl:241
 msgid "Aborting"
 msgstr ""

-#: lib/merge.tcl:239
+#: lib/merge.tcl:241
 msgid "files reset"
 msgstr ""

-#: lib/merge.tcl:267
+#: lib/merge.tcl:269
 msgid "Abort failed."
 msgstr ""

-#: lib/merge.tcl:269
+#: lib/merge.tcl:271
 msgid "Abort completed.  Ready."
 msgstr ""

@@ -1790,28 +1837,28 @@ msgstr ""
 msgid "Conflict file does not exist"
 msgstr ""

-#: lib/mergetool.tcl:264
+#: lib/mergetool.tcl:246
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
 msgstr ""

-#: lib/mergetool.tcl:268
+#: lib/mergetool.tcl:275
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
 msgstr ""

-#: lib/mergetool.tcl:303
+#: lib/mergetool.tcl:310
 msgid "Merge tool is already running, terminate it?"
 msgstr ""

-#: lib/mergetool.tcl:323
+#: lib/mergetool.tcl:330
 #, tcl-format
 msgid ""
 "Error retrieving versions:\n"
 "%s"
 msgstr ""

-#: lib/mergetool.tcl:343
+#: lib/mergetool.tcl:350
 #, tcl-format
 msgid ""
 "Could not start the merge tool:\n"
@@ -1819,11 +1866,11 @@ msgid ""
 "%s"
 msgstr ""

-#: lib/mergetool.tcl:347
+#: lib/mergetool.tcl:354
 msgid "Running merge tool..."
 msgstr ""

-#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
 msgid "Merge tool failed."
 msgstr ""

@@ -1837,145 +1884,157 @@ msgstr ""
 msgid "Invalid repo encoding '%s'"
 msgstr ""

-#: lib/option.tcl:117
+#: lib/option.tcl:119
 msgid "Restore Defaults"
 msgstr ""

-#: lib/option.tcl:121
+#: lib/option.tcl:123
 msgid "Save"
 msgstr ""

-#: lib/option.tcl:131
+#: lib/option.tcl:133
 #, tcl-format
 msgid "%s Repository"
 msgstr ""

-#: lib/option.tcl:132
+#: lib/option.tcl:134
 msgid "Global (All Repositories)"
 msgstr ""

-#: lib/option.tcl:138
+#: lib/option.tcl:140
 msgid "User Name"
 msgstr ""

-#: lib/option.tcl:139
+#: lib/option.tcl:141
 msgid "Email Address"
 msgstr ""

-#: lib/option.tcl:141
+#: lib/option.tcl:143
 msgid "Summarize Merge Commits"
 msgstr ""

-#: lib/option.tcl:142
+#: lib/option.tcl:144
 msgid "Merge Verbosity"
 msgstr ""

-#: lib/option.tcl:143
+#: lib/option.tcl:145
 msgid "Show Diffstat After Merge"
 msgstr ""

-#: lib/option.tcl:144
+#: lib/option.tcl:146
 msgid "Use Merge Tool"
 msgstr ""

-#: lib/option.tcl:146
+#: lib/option.tcl:148
 msgid "Trust File Modification Timestamps"
 msgstr ""

-#: lib/option.tcl:147
+#: lib/option.tcl:149
 msgid "Prune Tracking Branches During Fetch"
 msgstr ""

-#: lib/option.tcl:148
+#: lib/option.tcl:150
 msgid "Match Tracking Branches"
 msgstr ""

-#: lib/option.tcl:149
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr ""
+
+#: lib/option.tcl:152
 msgid "Blame Copy Only On Changed Files"
 msgstr ""

-#: lib/option.tcl:150
+#: lib/option.tcl:153
 msgid "Minimum Letters To Blame Copy On"
 msgstr ""

-#: lib/option.tcl:151
+#: lib/option.tcl:154
 msgid "Blame History Context Radius (days)"
 msgstr ""

-#: lib/option.tcl:152
+#: lib/option.tcl:155
 msgid "Number of Diff Context Lines"
 msgstr ""

-#: lib/option.tcl:153
+#: lib/option.tcl:156
+msgid "Additional Diff Parameters"
+msgstr ""
+
+#: lib/option.tcl:157
 msgid "Commit Message Text Width"
 msgstr ""

-#: lib/option.tcl:154
+#: lib/option.tcl:158
 msgid "New Branch Name Template"
 msgstr ""

-#: lib/option.tcl:155
+#: lib/option.tcl:159
 msgid "Default File Contents Encoding"
 msgstr ""

-#: lib/option.tcl:203
-msgid "Change"
+#: lib/option.tcl:160
+msgid "Warn before committing to a detached head"
 msgstr ""

-#: lib/option.tcl:230
-msgid "Spelling Dictionary:"
+#: lib/option.tcl:161
+msgid "Staging of untracked files"
 msgstr ""

-#: lib/option.tcl:254
-msgid "Change Font"
+#: lib/option.tcl:161
+msgid "yes"
 msgstr ""

-#: lib/option.tcl:258
-#, tcl-format
-msgid "Choose %s"
+#: lib/option.tcl:161
+msgid "no"
 msgstr ""

-#: lib/option.tcl:264
-msgid "pt."
+#: lib/option.tcl:161
+msgid "ask"
 msgstr ""

-#: lib/option.tcl:278
-msgid "Preferences"
+#: lib/option.tcl:207
+msgid "Change"
 msgstr ""

-#: lib/option.tcl:314
-msgid "Failed to completely save options:"
+#: lib/option.tcl:251
+msgid "Spelling Dictionary:"
 msgstr ""

-#: lib/remote.tcl:163
-msgid "Remove Remote"
+#: lib/option.tcl:281
+msgid "Change Font"
 msgstr ""

-#: lib/remote.tcl:168
-msgid "Prune from"
+#: lib/option.tcl:285
+#, tcl-format
+msgid "Choose %s"
 msgstr ""

-#: lib/remote.tcl:173
-msgid "Fetch from"
+#: lib/option.tcl:291
+msgid "pt."
 msgstr ""

-#: lib/remote.tcl:215
-msgid "Push to"
+#: lib/option.tcl:305
+msgid "Preferences"
+msgstr ""
+
+#: lib/option.tcl:342
+msgid "Failed to completely save options:"
 msgstr ""

-#: lib/remote_add.tcl:19
+#: lib/remote_add.tcl:20
 msgid "Add Remote"
 msgstr ""

-#: lib/remote_add.tcl:24
+#: lib/remote_add.tcl:25
 msgid "Add New Remote"
 msgstr ""

-#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
 msgid "Add"
 msgstr ""

-#: lib/remote_add.tcl:37
+#: lib/remote_add.tcl:39
 msgid "Remote Details"
 msgstr ""

@@ -1983,58 +2042,58 @@ msgstr ""
 msgid "Location:"
 msgstr ""

-#: lib/remote_add.tcl:62
+#: lib/remote_add.tcl:60
 msgid "Further Action"
 msgstr ""

-#: lib/remote_add.tcl:65
+#: lib/remote_add.tcl:63
 msgid "Fetch Immediately"
 msgstr ""

-#: lib/remote_add.tcl:71
+#: lib/remote_add.tcl:69
 msgid "Initialize Remote Repository and Push"
 msgstr ""

-#: lib/remote_add.tcl:77
+#: lib/remote_add.tcl:75
 msgid "Do Nothing Else Now"
 msgstr ""

-#: lib/remote_add.tcl:101
+#: lib/remote_add.tcl:100
 msgid "Please supply a remote name."
 msgstr ""

-#: lib/remote_add.tcl:114
+#: lib/remote_add.tcl:113
 #, tcl-format
 msgid "'%s' is not an acceptable remote name."
 msgstr ""

-#: lib/remote_add.tcl:125
+#: lib/remote_add.tcl:124
 #, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
 msgstr ""

-#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#: lib/remote_add.tcl:132 lib/transport.tcl:6
 #, tcl-format
 msgid "fetch %s"
 msgstr ""

-#: lib/remote_add.tcl:134
+#: lib/remote_add.tcl:133
 #, tcl-format
 msgid "Fetching the %s"
 msgstr ""

-#: lib/remote_add.tcl:157
+#: lib/remote_add.tcl:156
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
 msgstr ""

-#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
-#: lib/transport.tcl:81
+#: lib/remote_add.tcl:162 lib/transport.tcl:54 lib/transport.tcl:92
+#: lib/transport.tcl:110
 #, tcl-format
 msgid "push %s"
 msgstr ""

-#: lib/remote_add.tcl:164
+#: lib/remote_add.tcl:163
 #, tcl-format
 msgid "Setting up the %s (at %s)"
 msgstr ""
@@ -2043,35 +2102,35 @@ msgstr ""
 msgid "Delete Branch Remotely"
 msgstr ""

-#: lib/remote_branch_delete.tcl:47
+#: lib/remote_branch_delete.tcl:48
 msgid "From Repository"
 msgstr ""

-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
+#: lib/remote_branch_delete.tcl:51 lib/transport.tcl:165
 msgid "Remote:"
 msgstr ""

-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
+#: lib/remote_branch_delete.tcl:72 lib/transport.tcl:187
 msgid "Arbitrary Location:"
 msgstr ""

-#: lib/remote_branch_delete.tcl:84
+#: lib/remote_branch_delete.tcl:88
 msgid "Branches"
 msgstr ""

-#: lib/remote_branch_delete.tcl:109
+#: lib/remote_branch_delete.tcl:110
 msgid "Delete Only If"
 msgstr ""

-#: lib/remote_branch_delete.tcl:111
+#: lib/remote_branch_delete.tcl:112
 msgid "Merged Into:"
 msgstr ""

-#: lib/remote_branch_delete.tcl:152
+#: lib/remote_branch_delete.tcl:153
 msgid "A branch is required for 'Merged Into'."
 msgstr ""

-#: lib/remote_branch_delete.tcl:184
+#: lib/remote_branch_delete.tcl:185
 #, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
@@ -2079,45 +2138,65 @@ msgid ""
 " - %s"
 msgstr ""

-#: lib/remote_branch_delete.tcl:189
+#: lib/remote_branch_delete.tcl:190
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
 "necessary commits.  Try fetching from %s first."
 msgstr ""

-#: lib/remote_branch_delete.tcl:207
+#: lib/remote_branch_delete.tcl:208
 msgid "Please select one or more branches to delete."
 msgstr ""

-#: lib/remote_branch_delete.tcl:226
+#: lib/remote_branch_delete.tcl:227
 #, tcl-format
 msgid "Deleting branches from %s"
 msgstr ""

-#: lib/remote_branch_delete.tcl:292
+#: lib/remote_branch_delete.tcl:300
 msgid "No repository selected."
 msgstr ""

-#: lib/remote_branch_delete.tcl:297
+#: lib/remote_branch_delete.tcl:305
 #, tcl-format
 msgid "Scanning %s..."
 msgstr ""

-#: lib/search.tcl:21
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr ""
+
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr ""
+
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr ""
+
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr ""
+
+#: lib/search.tcl:48
 msgid "Find:"
 msgstr ""

-#: lib/search.tcl:23
+#: lib/search.tcl:50
 msgid "Next"
 msgstr ""

-#: lib/search.tcl:24
+#: lib/search.tcl:51
 msgid "Prev"
 msgstr ""

-#: lib/search.tcl:25
-msgid "Case-Sensitive"
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr ""
+
+#: lib/search.tcl:54
+msgid "Case"
 msgstr ""

 #: lib/shortcut.tcl:21 lib/shortcut.tcl:62
@@ -2178,19 +2257,19 @@ msgstr ""
 msgid "Generate Key"
 msgstr ""

-#: lib/sshkey.tcl:56
+#: lib/sshkey.tcl:58
 msgid "Copy To Clipboard"
 msgstr ""

-#: lib/sshkey.tcl:70
+#: lib/sshkey.tcl:72
 msgid "Your OpenSSH Public Key"
 msgstr ""

-#: lib/sshkey.tcl:78
+#: lib/sshkey.tcl:80
 msgid "Generating..."
 msgstr ""

-#: lib/sshkey.tcl:84
+#: lib/sshkey.tcl:86
 #, tcl-format
 msgid ""
 "Could not start ssh-keygen:\n"
@@ -2198,54 +2277,24 @@ msgid ""
 "%s"
 msgstr ""

-#: lib/sshkey.tcl:111
+#: lib/sshkey.tcl:113
 msgid "Generation failed."
 msgstr ""

-#: lib/sshkey.tcl:118
+#: lib/sshkey.tcl:120
 msgid "Generation succeeded, but no keys found."
 msgstr ""

-#: lib/sshkey.tcl:121
+#: lib/sshkey.tcl:123
 #, tcl-format
 msgid "Your key is in: %s"
 msgstr ""

-#: lib/status_bar.tcl:83
+#: lib/status_bar.tcl:87
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr ""

-#: lib/tools.tcl:75
-#, tcl-format
-msgid "Running %s requires a selected file."
-msgstr ""
-
-#: lib/tools.tcl:90
-#, tcl-format
-msgid "Are you sure you want to run %s?"
-msgstr ""
-
-#: lib/tools.tcl:110
-#, tcl-format
-msgid "Tool: %s"
-msgstr ""
-
-#: lib/tools.tcl:111
-#, tcl-format
-msgid "Running: %s"
-msgstr ""
-
-#: lib/tools.tcl:149
-#, tcl-format
-msgid "Tool completed successfully: %s"
-msgstr ""
-
-#: lib/tools.tcl:151
-#, tcl-format
-msgid "Tool failed: %s"
-msgstr ""
-
 #: lib/tools_dlg.tcl:22
 msgid "Add Tool"
 msgstr ""
@@ -2254,87 +2303,122 @@ msgstr ""
 msgid "Add New Tool Command"
 msgstr ""

-#: lib/tools_dlg.tcl:33
+#: lib/tools_dlg.tcl:34
 msgid "Add globally"
 msgstr ""

-#: lib/tools_dlg.tcl:45
+#: lib/tools_dlg.tcl:46
 msgid "Tool Details"
 msgstr ""

-#: lib/tools_dlg.tcl:48
+#: lib/tools_dlg.tcl:49
 msgid "Use '/' separators to create a submenu tree:"
 msgstr ""

-#: lib/tools_dlg.tcl:61
+#: lib/tools_dlg.tcl:60
 msgid "Command:"
 msgstr ""

-#: lib/tools_dlg.tcl:74
+#: lib/tools_dlg.tcl:71
 msgid "Show a dialog before running"
 msgstr ""

-#: lib/tools_dlg.tcl:80
+#: lib/tools_dlg.tcl:77
 msgid "Ask the user to select a revision (sets $REVISION)"
 msgstr ""

-#: lib/tools_dlg.tcl:85
+#: lib/tools_dlg.tcl:82
 msgid "Ask the user for additional arguments (sets $ARGS)"
 msgstr ""

-#: lib/tools_dlg.tcl:92
+#: lib/tools_dlg.tcl:89
 msgid "Don't show the command output window"
 msgstr ""

-#: lib/tools_dlg.tcl:97
+#: lib/tools_dlg.tcl:94
 msgid "Run only if a diff is selected ($FILENAME not empty)"
 msgstr ""

-#: lib/tools_dlg.tcl:121
+#: lib/tools_dlg.tcl:118
 msgid "Please supply a name for the tool."
 msgstr ""

-#: lib/tools_dlg.tcl:129
+#: lib/tools_dlg.tcl:126
 #, tcl-format
 msgid "Tool '%s' already exists."
 msgstr ""

-#: lib/tools_dlg.tcl:151
+#: lib/tools_dlg.tcl:148
 #, tcl-format
 msgid ""
 "Could not add tool:\n"
 "%s"
 msgstr ""

-#: lib/tools_dlg.tcl:190
+#: lib/tools_dlg.tcl:187
 msgid "Remove Tool"
 msgstr ""

-#: lib/tools_dlg.tcl:196
+#: lib/tools_dlg.tcl:193
 msgid "Remove Tool Commands"
 msgstr ""

-#: lib/tools_dlg.tcl:200
+#: lib/tools_dlg.tcl:198
 msgid "Remove"
 msgstr ""

-#: lib/tools_dlg.tcl:236
+#: lib/tools_dlg.tcl:231
 msgid "(Blue denotes repository-local tools)"
 msgstr ""

-#: lib/tools_dlg.tcl:297
+#: lib/tools_dlg.tcl:292
 #, tcl-format
 msgid "Run Command: %s"
 msgstr ""

-#: lib/tools_dlg.tcl:311
+#: lib/tools_dlg.tcl:306
 msgid "Arguments"
 msgstr ""

-#: lib/tools_dlg.tcl:348
+#: lib/tools_dlg.tcl:341
 msgid "OK"
 msgstr ""

+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr ""
+
+#: lib/tools.tcl:91
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr ""
+
+#: lib/tools.tcl:95
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr ""
+
+#: lib/tools.tcl:116
+#, tcl-format
+msgid "Tool: %s"
+msgstr ""
+
+#: lib/tools.tcl:117
+#, tcl-format
+msgid "Running: %s"
+msgstr ""
+
+#: lib/tools.tcl:155
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr ""
+
+#: lib/tools.tcl:157
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr ""
+
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
@@ -2350,45 +2434,61 @@ msgstr ""
 msgid "Pruning tracking branches deleted from %s"
 msgstr ""

+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr ""
+
 #: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr ""
+
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr ""
+
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr ""
+
+#: lib/transport.tcl:55
 #, tcl-format
 msgid "Pushing changes to %s"
 msgstr ""

-#: lib/transport.tcl:64
+#: lib/transport.tcl:93
 #, tcl-format
 msgid "Mirroring to %s"
 msgstr ""

-#: lib/transport.tcl:82
+#: lib/transport.tcl:111
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr ""

-#: lib/transport.tcl:100
+#: lib/transport.tcl:132
 msgid "Push Branches"
 msgstr ""

-#: lib/transport.tcl:114
+#: lib/transport.tcl:147
 msgid "Source Branches"
 msgstr ""

-#: lib/transport.tcl:131
+#: lib/transport.tcl:162
 msgid "Destination Repository"
 msgstr ""

-#: lib/transport.tcl:169
+#: lib/transport.tcl:205
 msgid "Transfer Options"
 msgstr ""

-#: lib/transport.tcl:171
+#: lib/transport.tcl:207
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr ""

-#: lib/transport.tcl:175
+#: lib/transport.tcl:211
 msgid "Use thin pack (for slow network connections)"
 msgstr ""

-#: lib/transport.tcl:179
+#: lib/transport.tcl:215
 msgid "Include tags"
 msgstr ""
-- 
1.8.1.msysgit.1
