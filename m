From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 4/5] l10n: git-glossary
Date: Mon,  8 Dec 2014 16:38:58 +0100
Message-ID: <e7fbb52bac55c2e5adae78078386d7081bb39fb9.1418052470.git.git@drmicha.warpmail.net>
References: <cover.1418052470.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 16:39:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0PD-0000ST-V9
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 16:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbaLHPjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 10:39:11 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45537 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755665AbaLHPjH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 10:39:07 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id BACED20AA1
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 10:39:06 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 08 Dec 2014 10:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=uur1bCKCHpUglO
	qKf1ORiFcRVwU=; b=AmhWwAyhm7cidR4JOaSsOziKzC6Ja4SEsxXtOYSHbcLiUX
	jonAY45HMzTkWKOp/BROFnRX4KiRNCDLjfBqYkJ4lh8qmQektQAKLIVFH+Y8jwmD
	Z9CjFMhP1wqTWriX/NJiPTP1y1neN/d8J/y8oY0ZkhTipMjnY5ln8Dj7IZwho=
X-Sasl-enc: V5TqsHlm1Yhwf0TlBQJHrE98jOc1EYhfaIo8b9z3DWGf 1418053145
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id ED993C00281;
	Mon,  8 Dec 2014 10:39:05 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
In-Reply-To: <cover.1418052470.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261048>

git.pot update for the new glossary command.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 po/git.pot | 1362 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 829 insertions(+), 533 deletions(-)

diff --git a/po/git.pot b/po/git.pot
index ee91402..d725a5d 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2014-11-20 09:42+0800\n"
+"POT-Creation-Date: 2014-12-08 16:02+0100\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -70,8 +70,8 @@ msgstr ""
 #: archive.c:422 builtin/archive.c:88 builtin/blame.c:2517
 #: builtin/blame.c:2518 builtin/config.c:57 builtin/fast-export.c:986
 #: builtin/fast-export.c:988 builtin/grep.c:712 builtin/hash-object.c:101
-#: builtin/ls-files.c:489 builtin/ls-files.c:492 builtin/notes.c:411
-#: builtin/notes.c:568 builtin/read-tree.c:109 parse-options.h:151
+#: builtin/ls-files.c:489 builtin/ls-files.c:492 builtin/notes.c:394
+#: builtin/notes.c:557 builtin/read-tree.c:109 parse-options.h:151
 msgid "file"
 msgstr ""
 
@@ -103,7 +103,7 @@ msgstr ""
 msgid "list supported archive formats"
 msgstr ""
 
-#: archive.c:441 builtin/archive.c:90 builtin/clone.c:85
+#: archive.c:441 builtin/archive.c:90 builtin/clone.c:86
 msgid "repo"
 msgstr ""
 
@@ -111,7 +111,7 @@ msgstr ""
 msgid "retrieve the archive from remote repository <repo>"
 msgstr ""
 
-#: archive.c:443 builtin/archive.c:92 builtin/notes.c:490
+#: archive.c:443 builtin/archive.c:92 builtin/notes.c:478
 msgid "command"
 msgstr ""
 
@@ -236,7 +236,7 @@ msgstr ""
 msgid "unrecognized header: %s%s (%d)"
 msgstr ""
 
-#: bundle.c:87 builtin/commit.c:788
+#: bundle.c:87 builtin/commit.c:834
 #, c-format
 msgid "could not open '%s'"
 msgstr ""
@@ -245,9 +245,9 @@ msgstr ""
 msgid "Repository lacks these prerequisite commits:"
 msgstr ""
 
-#: bundle.c:163 sequencer.c:641 sequencer.c:1096 builtin/blame.c:2706
-#: builtin/branch.c:652 builtin/commit.c:1085 builtin/log.c:330
-#: builtin/log.c:823 builtin/log.c:1432 builtin/log.c:1669 builtin/merge.c:357
+#: bundle.c:163 sequencer.c:645 sequencer.c:1100 builtin/blame.c:2706
+#: builtin/branch.c:652 builtin/commit.c:1107 builtin/log.c:330
+#: builtin/log.c:823 builtin/log.c:1432 builtin/log.c:1669 builtin/merge.c:358
 #: builtin/shortlog.c:158
 msgid "revision walk setup failed"
 msgstr ""
@@ -604,11 +604,11 @@ msgstr[1] ""
 msgid "%s: %s - %s"
 msgstr ""
 
-#: lockfile.c:275
+#: lockfile.c:283
 msgid "BUG: reopen a lockfile that is still open"
 msgstr ""
 
-#: lockfile.c:277
+#: lockfile.c:285
 msgid "BUG: reopen a lockfile that has been committed"
 msgstr ""
 
@@ -616,8 +616,8 @@ msgstr ""
 msgid "failed to read the cache"
 msgstr ""
 
-#: merge.c:94 builtin/checkout.c:356 builtin/checkout.c:562
-#: builtin/clone.c:659
+#: merge.c:94 builtin/checkout.c:374 builtin/checkout.c:580
+#: builtin/clone.c:662
 msgid "unable to write new index file"
 msgstr ""
 
@@ -664,7 +664,7 @@ msgstr ""
 msgid "blob expected for %s '%s'"
 msgstr ""
 
-#: merge-recursive.c:792 builtin/clone.c:318
+#: merge-recursive.c:792 builtin/clone.c:321
 #, c-format
 msgid "failed to open '%s'"
 msgstr ""
@@ -861,7 +861,7 @@ msgstr ""
 msgid "Could not parse object '%s'"
 msgstr ""
 
-#: merge-recursive.c:2019 builtin/merge.c:666
+#: merge-recursive.c:2019 builtin/merge.c:667
 msgid "Unable to write index."
 msgstr ""
 
@@ -1017,32 +1017,32 @@ msgstr ""
 msgid "Internal error"
 msgstr ""
 
-#: remote.c:1968
+#: remote.c:1980
 #, c-format
 msgid "Your branch is based on '%s', but the upstream is gone.\n"
 msgstr ""
 
-#: remote.c:1972
+#: remote.c:1984
 msgid "  (use \"git branch --unset-upstream\" to fixup)\n"
 msgstr ""
 
-#: remote.c:1975
+#: remote.c:1987
 #, c-format
 msgid "Your branch is up-to-date with '%s'.\n"
 msgstr ""
 
-#: remote.c:1979
+#: remote.c:1991
 #, c-format
 msgid "Your branch is ahead of '%s' by %d commit.\n"
 msgid_plural "Your branch is ahead of '%s' by %d commits.\n"
 msgstr[0] ""
 msgstr[1] ""
 
-#: remote.c:1985
+#: remote.c:1997
 msgid "  (use \"git push\" to publish your local commits)\n"
 msgstr ""
 
-#: remote.c:1988
+#: remote.c:2000
 #, c-format
 msgid "Your branch is behind '%s' by %d commit, and can be fast-forwarded.\n"
 msgid_plural ""
@@ -1050,11 +1050,11 @@ msgid_plural ""
 msgstr[0] ""
 msgstr[1] ""
 
-#: remote.c:1996
+#: remote.c:2008
 msgid "  (use \"git pull\" to update your local branch)\n"
 msgstr ""
 
-#: remote.c:1999
+#: remote.c:2011
 #, c-format
 msgid ""
 "Your branch and '%s' have diverged,\n"
@@ -1065,7 +1065,7 @@ msgid_plural ""
 msgstr[0] ""
 msgstr[1] ""
 
-#: remote.c:2009
+#: remote.c:2021
 msgid "  (use \"git pull\" to merge the remote branch into yours)\n"
 msgstr ""
 
@@ -1086,14 +1086,14 @@ msgstr ""
 msgid "the receiving end does not support --signed push"
 msgstr ""
 
-#: sequencer.c:172 builtin/merge.c:781 builtin/merge.c:892
-#: builtin/merge.c:1002 builtin/merge.c:1012
+#: sequencer.c:172 builtin/merge.c:782 builtin/merge.c:893 builtin/merge.c:994
+#: builtin/merge.c:1004
 #, c-format
 msgid "Could not open '%s' for writing"
 msgstr ""
 
-#: sequencer.c:174 builtin/merge.c:343 builtin/merge.c:784
-#: builtin/merge.c:1004 builtin/merge.c:1017
+#: sequencer.c:174 builtin/merge.c:344 builtin/merge.c:785 builtin/merge.c:996
+#: builtin/merge.c:1009
 #, c-format
 msgid "Could not write to '%s'"
 msgstr ""
@@ -1111,7 +1111,7 @@ msgid ""
 "and commit the result with 'git commit'"
 msgstr ""
 
-#: sequencer.c:211 sequencer.c:852 sequencer.c:935
+#: sequencer.c:211 sequencer.c:856 sequencer.c:939
 #, c-format
 msgid "Could not write to %s"
 msgstr ""
@@ -1134,197 +1134,197 @@ msgid "Commit your changes or stash them to proceed."
 msgstr ""
 
 #. TRANSLATORS: %s will be "revert" or "cherry-pick"
-#: sequencer.c:304
+#: sequencer.c:321
 #, c-format
 msgid "%s: Unable to write new index file"
 msgstr ""
 
-#: sequencer.c:335
+#: sequencer.c:339
 msgid "Could not resolve HEAD commit\n"
 msgstr ""
 
-#: sequencer.c:355
+#: sequencer.c:359
 msgid "Unable to update cache tree\n"
 msgstr ""
 
-#: sequencer.c:402
+#: sequencer.c:406
 #, c-format
 msgid "Could not parse commit %s\n"
 msgstr ""
 
-#: sequencer.c:407
+#: sequencer.c:411
 #, c-format
 msgid "Could not parse parent commit %s\n"
 msgstr ""
 
-#: sequencer.c:473
+#: sequencer.c:477
 msgid "Your index file is unmerged."
 msgstr ""
 
-#: sequencer.c:492
+#: sequencer.c:496
 #, c-format
 msgid "Commit %s is a merge but no -m option was given."
 msgstr ""
 
-#: sequencer.c:500
+#: sequencer.c:504
 #, c-format
 msgid "Commit %s does not have parent %d"
 msgstr ""
 
-#: sequencer.c:504
+#: sequencer.c:508
 #, c-format
 msgid "Mainline was specified but commit %s is not a merge."
 msgstr ""
 
 #. TRANSLATORS: The first %s will be "revert" or
 #. "cherry-pick", the second %s a SHA1
-#: sequencer.c:517
+#: sequencer.c:521
 #, c-format
 msgid "%s: cannot parse parent commit %s"
 msgstr ""
 
-#: sequencer.c:521
+#: sequencer.c:525
 #, c-format
 msgid "Cannot get commit message for %s"
 msgstr ""
 
-#: sequencer.c:607
+#: sequencer.c:611
 #, c-format
 msgid "could not revert %s... %s"
 msgstr ""
 
-#: sequencer.c:608
+#: sequencer.c:612
 #, c-format
 msgid "could not apply %s... %s"
 msgstr ""
 
-#: sequencer.c:644
+#: sequencer.c:648
 msgid "empty commit set passed"
 msgstr ""
 
-#: sequencer.c:652
+#: sequencer.c:656
 #, c-format
 msgid "git %s: failed to read the index"
 msgstr ""
 
-#: sequencer.c:656
+#: sequencer.c:660
 #, c-format
 msgid "git %s: failed to refresh the index"
 msgstr ""
 
-#: sequencer.c:716
+#: sequencer.c:720
 #, c-format
 msgid "Cannot %s during a %s"
 msgstr ""
 
-#: sequencer.c:738
+#: sequencer.c:742
 #, c-format
 msgid "Could not parse line %d."
 msgstr ""
 
-#: sequencer.c:743
+#: sequencer.c:747
 msgid "No commits parsed."
 msgstr ""
 
-#: sequencer.c:756
+#: sequencer.c:760
 #, c-format
 msgid "Could not open %s"
 msgstr ""
 
-#: sequencer.c:760
+#: sequencer.c:764
 #, c-format
 msgid "Could not read %s."
 msgstr ""
 
-#: sequencer.c:767
+#: sequencer.c:771
 #, c-format
 msgid "Unusable instruction sheet: %s"
 msgstr ""
 
-#: sequencer.c:797
+#: sequencer.c:801
 #, c-format
 msgid "Invalid key: %s"
 msgstr ""
 
-#: sequencer.c:800
+#: sequencer.c:804
 #, c-format
 msgid "Invalid value for %s: %s"
 msgstr ""
 
-#: sequencer.c:812
+#: sequencer.c:816
 #, c-format
 msgid "Malformed options sheet: %s"
 msgstr ""
 
-#: sequencer.c:833
+#: sequencer.c:837
 msgid "a cherry-pick or revert is already in progress"
 msgstr ""
 
-#: sequencer.c:834
+#: sequencer.c:838
 msgid "try \"git cherry-pick (--continue | --quit | --abort)\""
 msgstr ""
 
-#: sequencer.c:838
+#: sequencer.c:842
 #, c-format
 msgid "Could not create sequencer directory %s"
 msgstr ""
 
-#: sequencer.c:854 sequencer.c:939
+#: sequencer.c:858 sequencer.c:943
 #, c-format
 msgid "Error wrapping up %s."
 msgstr ""
 
-#: sequencer.c:873 sequencer.c:1009
+#: sequencer.c:877 sequencer.c:1013
 msgid "no cherry-pick or revert in progress"
 msgstr ""
 
-#: sequencer.c:875
+#: sequencer.c:879
 msgid "cannot resolve HEAD"
 msgstr ""
 
-#: sequencer.c:877
+#: sequencer.c:881
 msgid "cannot abort from a branch yet to be born"
 msgstr ""
 
-#: sequencer.c:899 builtin/apply.c:4128
+#: sequencer.c:903 builtin/apply.c:4128
 #, c-format
 msgid "cannot open %s: %s"
 msgstr ""
 
-#: sequencer.c:902
+#: sequencer.c:906
 #, c-format
 msgid "cannot read %s: %s"
 msgstr ""
 
-#: sequencer.c:903
+#: sequencer.c:907
 msgid "unexpected end of file"
 msgstr ""
 
-#: sequencer.c:909
+#: sequencer.c:913
 #, c-format
 msgid "stored pre-cherry-pick HEAD file '%s' is corrupt"
 msgstr ""
 
-#: sequencer.c:932
+#: sequencer.c:936
 #, c-format
 msgid "Could not format %s."
 msgstr ""
 
-#: sequencer.c:1077
+#: sequencer.c:1081
 #, c-format
 msgid "%s: can't cherry-pick a %s"
 msgstr ""
 
-#: sequencer.c:1080
+#: sequencer.c:1084
 #, c-format
 msgid "%s: bad revision"
 msgstr ""
 
-#: sequencer.c:1114
+#: sequencer.c:1118
 msgid "Can't revert as initial commit"
 msgstr ""
 
-#: sequencer.c:1115
+#: sequencer.c:1119
 msgid "Can't cherry-pick into empty head"
 msgstr ""
 
@@ -1383,7 +1383,7 @@ msgstr ""
 msgid "staging updated .gitmodules failed"
 msgstr ""
 
-#: submodule.c:1111 builtin/init-db.c:363
+#: submodule.c:1111 builtin/init-db.c:364
 #, c-format
 msgid "Could not create git link %s"
 msgstr ""
@@ -1611,193 +1611,193 @@ msgstr ""
 msgid "bug: unhandled diff status %c"
 msgstr ""
 
-#: wt-status.c:761
+#: wt-status.c:758
 msgid "Submodules changed but not updated:"
 msgstr ""
 
-#: wt-status.c:763
+#: wt-status.c:760
 msgid "Submodule changes to be committed:"
 msgstr ""
 
-#: wt-status.c:842
+#: wt-status.c:839
 msgid ""
 "Do not touch the line above.\n"
 "Everything below will be removed."
 msgstr ""
 
-#: wt-status.c:933
+#: wt-status.c:930
 msgid "You have unmerged paths."
 msgstr ""
 
-#: wt-status.c:936
+#: wt-status.c:933
 msgid "  (fix conflicts and run \"git commit\")"
 msgstr ""
 
-#: wt-status.c:939
+#: wt-status.c:936
 msgid "All conflicts fixed but you are still merging."
 msgstr ""
 
-#: wt-status.c:942
+#: wt-status.c:939
 msgid "  (use \"git commit\" to conclude merge)"
 msgstr ""
 
-#: wt-status.c:952
+#: wt-status.c:949
 msgid "You are in the middle of an am session."
 msgstr ""
 
-#: wt-status.c:955
+#: wt-status.c:952
 msgid "The current patch is empty."
 msgstr ""
 
-#: wt-status.c:959
+#: wt-status.c:956
 msgid "  (fix conflicts and then run \"git am --continue\")"
 msgstr ""
 
-#: wt-status.c:961
+#: wt-status.c:958
 msgid "  (use \"git am --skip\" to skip this patch)"
 msgstr ""
 
-#: wt-status.c:963
+#: wt-status.c:960
 msgid "  (use \"git am --abort\" to restore the original branch)"
 msgstr ""
 
-#: wt-status.c:1023 wt-status.c:1040
+#: wt-status.c:1020 wt-status.c:1037
 #, c-format
 msgid "You are currently rebasing branch '%s' on '%s'."
 msgstr ""
 
-#: wt-status.c:1028 wt-status.c:1045
+#: wt-status.c:1025 wt-status.c:1042
 msgid "You are currently rebasing."
 msgstr ""
 
-#: wt-status.c:1031
+#: wt-status.c:1028
 msgid "  (fix conflicts and then run \"git rebase --continue\")"
 msgstr ""
 
-#: wt-status.c:1033
+#: wt-status.c:1030
 msgid "  (use \"git rebase --skip\" to skip this patch)"
 msgstr ""
 
-#: wt-status.c:1035
+#: wt-status.c:1032
 msgid "  (use \"git rebase --abort\" to check out the original branch)"
 msgstr ""
 
-#: wt-status.c:1048
+#: wt-status.c:1045
 msgid "  (all conflicts fixed: run \"git rebase --continue\")"
 msgstr ""
 
-#: wt-status.c:1052
+#: wt-status.c:1049
 #, c-format
 msgid ""
 "You are currently splitting a commit while rebasing branch '%s' on '%s'."
 msgstr ""
 
-#: wt-status.c:1057
+#: wt-status.c:1054
 msgid "You are currently splitting a commit during a rebase."
 msgstr ""
 
-#: wt-status.c:1060
+#: wt-status.c:1057
 msgid "  (Once your working directory is clean, run \"git rebase --continue\")"
 msgstr ""
 
-#: wt-status.c:1064
+#: wt-status.c:1061
 #, c-format
 msgid "You are currently editing a commit while rebasing branch '%s' on '%s'."
 msgstr ""
 
-#: wt-status.c:1069
+#: wt-status.c:1066
 msgid "You are currently editing a commit during a rebase."
 msgstr ""
 
-#: wt-status.c:1072
+#: wt-status.c:1069
 msgid "  (use \"git commit --amend\" to amend the current commit)"
 msgstr ""
 
-#: wt-status.c:1074
+#: wt-status.c:1071
 msgid ""
 "  (use \"git rebase --continue\" once you are satisfied with your changes)"
 msgstr ""
 
-#: wt-status.c:1084
+#: wt-status.c:1081
 #, c-format
 msgid "You are currently cherry-picking commit %s."
 msgstr ""
 
-#: wt-status.c:1089
+#: wt-status.c:1086
 msgid "  (fix conflicts and run \"git cherry-pick --continue\")"
 msgstr ""
 
-#: wt-status.c:1092
+#: wt-status.c:1089
 msgid "  (all conflicts fixed: run \"git cherry-pick --continue\")"
 msgstr ""
 
-#: wt-status.c:1094
+#: wt-status.c:1091
 msgid "  (use \"git cherry-pick --abort\" to cancel the cherry-pick operation)"
 msgstr ""
 
-#: wt-status.c:1103
+#: wt-status.c:1100
 #, c-format
 msgid "You are currently reverting commit %s."
 msgstr ""
 
-#: wt-status.c:1108
+#: wt-status.c:1105
 msgid "  (fix conflicts and run \"git revert --continue\")"
 msgstr ""
 
-#: wt-status.c:1111
+#: wt-status.c:1108
 msgid "  (all conflicts fixed: run \"git revert --continue\")"
 msgstr ""
 
-#: wt-status.c:1113
+#: wt-status.c:1110
 msgid "  (use \"git revert --abort\" to cancel the revert operation)"
 msgstr ""
 
-#: wt-status.c:1124
+#: wt-status.c:1121
 #, c-format
 msgid "You are currently bisecting, started from branch '%s'."
 msgstr ""
 
-#: wt-status.c:1128
+#: wt-status.c:1125
 msgid "You are currently bisecting."
 msgstr ""
 
-#: wt-status.c:1131
+#: wt-status.c:1128
 msgid "  (use \"git bisect reset\" to get back to the original branch)"
 msgstr ""
 
-#: wt-status.c:1306
+#: wt-status.c:1303
 msgid "On branch "
 msgstr ""
 
-#: wt-status.c:1313
+#: wt-status.c:1310
 msgid "rebase in progress; onto "
 msgstr ""
 
-#: wt-status.c:1320
+#: wt-status.c:1317
 msgid "HEAD detached at "
 msgstr ""
 
-#: wt-status.c:1322
+#: wt-status.c:1319
 msgid "HEAD detached from "
 msgstr ""
 
-#: wt-status.c:1325
+#: wt-status.c:1322
 msgid "Not currently on any branch."
 msgstr ""
 
-#: wt-status.c:1342
+#: wt-status.c:1339
 msgid "Initial commit"
 msgstr ""
 
-#: wt-status.c:1356
+#: wt-status.c:1353
 msgid "Untracked files"
 msgstr ""
 
-#: wt-status.c:1358
+#: wt-status.c:1355
 msgid "Ignored files"
 msgstr ""
 
-#: wt-status.c:1362
+#: wt-status.c:1359
 #, c-format
 msgid ""
 "It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
@@ -1805,82 +1805,77 @@ msgid ""
 "new files yourself (see 'git help status')."
 msgstr ""
 
-#: wt-status.c:1368
+#: wt-status.c:1365
 #, c-format
 msgid "Untracked files not listed%s"
 msgstr ""
 
-#: wt-status.c:1370
+#: wt-status.c:1367
 msgid " (use -u option to show untracked files)"
 msgstr ""
 
-#: wt-status.c:1376
+#: wt-status.c:1373
 msgid "No changes"
 msgstr ""
 
-#: wt-status.c:1381
+#: wt-status.c:1378
 #, c-format
 msgid "no changes added to commit (use \"git add\" and/or \"git commit -a\")\n"
 msgstr ""
 
-#: wt-status.c:1384
+#: wt-status.c:1381
 #, c-format
 msgid "no changes added to commit\n"
 msgstr ""
 
-#: wt-status.c:1387
+#: wt-status.c:1384
 #, c-format
 msgid ""
 "nothing added to commit but untracked files present (use \"git add\" to "
 "track)\n"
 msgstr ""
 
-#: wt-status.c:1390
+#: wt-status.c:1387
 #, c-format
 msgid "nothing added to commit but untracked files present\n"
 msgstr ""
 
-#: wt-status.c:1393
+#: wt-status.c:1390
 #, c-format
 msgid "nothing to commit (create/copy files and use \"git add\" to track)\n"
 msgstr ""
 
-#: wt-status.c:1396 wt-status.c:1401
+#: wt-status.c:1393 wt-status.c:1398
 #, c-format
 msgid "nothing to commit\n"
 msgstr ""
 
-#: wt-status.c:1399
+#: wt-status.c:1396
 #, c-format
 msgid "nothing to commit (use -u to show untracked files)\n"
 msgstr ""
 
-#: wt-status.c:1403
+#: wt-status.c:1400
 #, c-format
 msgid "nothing to commit, working directory clean\n"
 msgstr ""
 
-#: wt-status.c:1512
+#: wt-status.c:1509
 msgid "HEAD (no branch)"
 msgstr ""
 
-#: wt-status.c:1518
+#: wt-status.c:1515
 msgid "Initial commit on "
 msgstr ""
 
-#: wt-status.c:1550
+#: wt-status.c:1547
 msgid "gone"
 msgstr ""
 
-#: wt-status.c:1552 wt-status.c:1560
+#: wt-status.c:1549 wt-status.c:1557
 msgid "behind "
 msgstr ""
 
-#: compat/precompose_utf8.c:55 builtin/clone.c:357
-#, c-format
-msgid "failed to unlink '%s'"
-msgstr ""
-
 #: builtin/add.c:22
 msgid "git add [options] [--] <pathspec>..."
 msgstr ""
@@ -1941,7 +1936,7 @@ msgid "dry run"
 msgstr ""
 
 #: builtin/add.c:249 builtin/apply.c:4415 builtin/check-ignore.c:19
-#: builtin/commit.c:1362 builtin/count-objects.c:63 builtin/fsck.c:608
+#: builtin/commit.c:1384 builtin/count-objects.c:63 builtin/fsck.c:608
 #: builtin/log.c:1617 builtin/mv.c:109 builtin/read-tree.c:114
 msgid "be verbose"
 msgstr ""
@@ -1950,7 +1945,7 @@ msgstr ""
 msgid "interactive picking"
 msgstr ""
 
-#: builtin/add.c:252 builtin/checkout.c:1108 builtin/reset.c:286
+#: builtin/add.c:252 builtin/checkout.c:1126 builtin/reset.c:286
 msgid "select hunks interactively"
 msgstr ""
 
@@ -2271,7 +2266,7 @@ msgstr ""
 msgid "Checking patch %s..."
 msgstr ""
 
-#: builtin/apply.c:3746 builtin/checkout.c:213 builtin/reset.c:135
+#: builtin/apply.c:3746 builtin/checkout.c:231 builtin/reset.c:135
 #, c-format
 msgid "make_cache_entry failed for path '%s'"
 msgstr ""
@@ -2350,7 +2345,7 @@ msgstr ""
 msgid "unable to read index file"
 msgstr ""
 
-#: builtin/apply.c:4362 builtin/apply.c:4365 builtin/clone.c:91
+#: builtin/apply.c:4362 builtin/apply.c:4365 builtin/clone.c:92
 #: builtin/fetch.c:93
 msgid "path"
 msgstr ""
@@ -2883,9 +2878,9 @@ msgid "act on remote-tracking branches"
 msgstr ""
 
 #: builtin/branch.c:827 builtin/branch.c:833 builtin/branch.c:854
-#: builtin/branch.c:860 builtin/commit.c:1622 builtin/commit.c:1623
-#: builtin/commit.c:1624 builtin/commit.c:1625 builtin/tag.c:616
-#: builtin/tag.c:622
+#: builtin/branch.c:860 builtin/commit.c:1644 builtin/commit.c:1645
+#: builtin/commit.c:1646 builtin/commit.c:1647 builtin/tag.c:616
+#: builtin/tag.c:622 glossary.h:14
 msgid "commit"
 msgstr ""
 
@@ -2949,7 +2944,7 @@ msgstr ""
 msgid "Failed to resolve HEAD as a valid ref."
 msgstr ""
 
-#: builtin/branch.c:881 builtin/clone.c:634
+#: builtin/branch.c:881 builtin/clone.c:637
 msgid "HEAD not found below refs/heads!"
 msgstr ""
 
@@ -3126,7 +3121,7 @@ msgstr ""
 msgid "terminate input and output records by a NUL character"
 msgstr ""
 
-#: builtin/check-ignore.c:18 builtin/checkout.c:1089 builtin/gc.c:274
+#: builtin/check-ignore.c:18 builtin/checkout.c:1107 builtin/gc.c:274
 msgid "suppress progress reporting"
 msgstr ""
 
@@ -3231,105 +3226,105 @@ msgstr ""
 msgid "git checkout [options] [<branch>] -- <file>..."
 msgstr ""
 
-#: builtin/checkout.c:114 builtin/checkout.c:147
+#: builtin/checkout.c:132 builtin/checkout.c:165
 #, c-format
 msgid "path '%s' does not have our version"
 msgstr ""
 
-#: builtin/checkout.c:116 builtin/checkout.c:149
+#: builtin/checkout.c:134 builtin/checkout.c:167
 #, c-format
 msgid "path '%s' does not have their version"
 msgstr ""
 
-#: builtin/checkout.c:132
+#: builtin/checkout.c:150
 #, c-format
 msgid "path '%s' does not have all necessary versions"
 msgstr ""
 
-#: builtin/checkout.c:176
+#: builtin/checkout.c:194
 #, c-format
 msgid "path '%s' does not have necessary versions"
 msgstr ""
 
-#: builtin/checkout.c:193
+#: builtin/checkout.c:211
 #, c-format
 msgid "path '%s': cannot merge"
 msgstr ""
 
-#: builtin/checkout.c:210
+#: builtin/checkout.c:228
 #, c-format
 msgid "Unable to add merge result for '%s'"
 msgstr ""
 
-#: builtin/checkout.c:231 builtin/checkout.c:234 builtin/checkout.c:237
-#: builtin/checkout.c:240
+#: builtin/checkout.c:249 builtin/checkout.c:252 builtin/checkout.c:255
+#: builtin/checkout.c:258
 #, c-format
 msgid "'%s' cannot be used with updating paths"
 msgstr ""
 
-#: builtin/checkout.c:243 builtin/checkout.c:246
+#: builtin/checkout.c:261 builtin/checkout.c:264
 #, c-format
 msgid "'%s' cannot be used with %s"
 msgstr ""
 
-#: builtin/checkout.c:249
+#: builtin/checkout.c:267
 #, c-format
 msgid "Cannot update paths and switch to branch '%s' at the same time."
 msgstr ""
 
-#: builtin/checkout.c:260 builtin/checkout.c:449
+#: builtin/checkout.c:278 builtin/checkout.c:467
 msgid "corrupt index file"
 msgstr ""
 
-#: builtin/checkout.c:320 builtin/checkout.c:327
+#: builtin/checkout.c:338 builtin/checkout.c:345
 #, c-format
 msgid "path '%s' is unmerged"
 msgstr ""
 
-#: builtin/checkout.c:471
+#: builtin/checkout.c:489
 msgid "you need to resolve your current index first"
 msgstr ""
 
-#: builtin/checkout.c:597
+#: builtin/checkout.c:615
 #, c-format
 msgid "Can not do reflog for '%s'\n"
 msgstr ""
 
-#: builtin/checkout.c:635
+#: builtin/checkout.c:653
 msgid "HEAD is now at"
 msgstr ""
 
-#: builtin/checkout.c:642
+#: builtin/checkout.c:660
 #, c-format
 msgid "Reset branch '%s'\n"
 msgstr ""
 
-#: builtin/checkout.c:645
+#: builtin/checkout.c:663
 #, c-format
 msgid "Already on '%s'\n"
 msgstr ""
 
-#: builtin/checkout.c:649
+#: builtin/checkout.c:667
 #, c-format
 msgid "Switched to and reset branch '%s'\n"
 msgstr ""
 
-#: builtin/checkout.c:651 builtin/checkout.c:1032
+#: builtin/checkout.c:669 builtin/checkout.c:1050
 #, c-format
 msgid "Switched to a new branch '%s'\n"
 msgstr ""
 
-#: builtin/checkout.c:653
+#: builtin/checkout.c:671
 #, c-format
 msgid "Switched to branch '%s'\n"
 msgstr ""
 
-#: builtin/checkout.c:705
+#: builtin/checkout.c:723
 #, c-format
 msgid " ... and %d more.\n"
 msgstr ""
 
-#: builtin/checkout.c:711
+#: builtin/checkout.c:729
 #, c-format
 msgid ""
 "Warning: you are leaving %d commit behind, not connected to\n"
@@ -3344,7 +3339,7 @@ msgid_plural ""
 msgstr[0] ""
 msgstr[1] ""
 
-#: builtin/checkout.c:729
+#: builtin/checkout.c:747
 #, c-format
 msgid ""
 "If you want to keep them by creating a new branch, this may be a good time\n"
@@ -3354,151 +3349,151 @@ msgid ""
 "\n"
 msgstr ""
 
-#: builtin/checkout.c:759
+#: builtin/checkout.c:777
 msgid "internal error in revision walk"
 msgstr ""
 
-#: builtin/checkout.c:763
+#: builtin/checkout.c:781
 msgid "Previous HEAD position was"
 msgstr ""
 
-#: builtin/checkout.c:790 builtin/checkout.c:1027
+#: builtin/checkout.c:808 builtin/checkout.c:1045
 msgid "You are on a branch yet to be born"
 msgstr ""
 
-#: builtin/checkout.c:934
+#: builtin/checkout.c:952
 #, c-format
 msgid "only one reference expected, %d given."
 msgstr ""
 
-#: builtin/checkout.c:973
+#: builtin/checkout.c:991
 #, c-format
 msgid "invalid reference: %s"
 msgstr ""
 
-#: builtin/checkout.c:1002
+#: builtin/checkout.c:1020
 #, c-format
 msgid "reference is not a tree: %s"
 msgstr ""
 
-#: builtin/checkout.c:1041
+#: builtin/checkout.c:1059
 msgid "paths cannot be used with switching branches"
 msgstr ""
 
-#: builtin/checkout.c:1044 builtin/checkout.c:1048
+#: builtin/checkout.c:1062 builtin/checkout.c:1066
 #, c-format
 msgid "'%s' cannot be used with switching branches"
 msgstr ""
 
-#: builtin/checkout.c:1052 builtin/checkout.c:1055 builtin/checkout.c:1060
-#: builtin/checkout.c:1063
+#: builtin/checkout.c:1070 builtin/checkout.c:1073 builtin/checkout.c:1078
+#: builtin/checkout.c:1081
 #, c-format
 msgid "'%s' cannot be used with '%s'"
 msgstr ""
 
-#: builtin/checkout.c:1068
+#: builtin/checkout.c:1086
 #, c-format
 msgid "Cannot switch branch to a non-commit '%s'"
 msgstr ""
 
-#: builtin/checkout.c:1090 builtin/checkout.c:1092 builtin/clone.c:89
-#: builtin/remote.c:159 builtin/remote.c:161
+#: builtin/checkout.c:1108 builtin/checkout.c:1110 builtin/clone.c:90
+#: builtin/remote.c:159 builtin/remote.c:161 glossary.h:7
 msgid "branch"
 msgstr ""
 
-#: builtin/checkout.c:1091
+#: builtin/checkout.c:1109
 msgid "create and checkout a new branch"
 msgstr ""
 
-#: builtin/checkout.c:1093
+#: builtin/checkout.c:1111
 msgid "create/reset and checkout a branch"
 msgstr ""
 
-#: builtin/checkout.c:1094
+#: builtin/checkout.c:1112
 msgid "create reflog for new branch"
 msgstr ""
 
-#: builtin/checkout.c:1095
+#: builtin/checkout.c:1113
 msgid "detach the HEAD at named commit"
 msgstr ""
 
-#: builtin/checkout.c:1096
+#: builtin/checkout.c:1114
 msgid "set upstream info for new branch"
 msgstr ""
 
-#: builtin/checkout.c:1098
+#: builtin/checkout.c:1116
 msgid "new-branch"
 msgstr ""
 
-#: builtin/checkout.c:1098
+#: builtin/checkout.c:1116
 msgid "new unparented branch"
 msgstr ""
 
-#: builtin/checkout.c:1099
+#: builtin/checkout.c:1117
 msgid "checkout our version for unmerged files"
 msgstr ""
 
-#: builtin/checkout.c:1101
+#: builtin/checkout.c:1119
 msgid "checkout their version for unmerged files"
 msgstr ""
 
-#: builtin/checkout.c:1103
+#: builtin/checkout.c:1121
 msgid "force checkout (throw away local modifications)"
 msgstr ""
 
-#: builtin/checkout.c:1104
+#: builtin/checkout.c:1122
 msgid "perform a 3-way merge with the new branch"
 msgstr ""
 
-#: builtin/checkout.c:1105 builtin/merge.c:226
+#: builtin/checkout.c:1123 builtin/merge.c:227
 msgid "update ignored files (default)"
 msgstr ""
 
-#: builtin/checkout.c:1106 builtin/log.c:1239 parse-options.h:245
+#: builtin/checkout.c:1124 builtin/log.c:1239 parse-options.h:245
 msgid "style"
 msgstr ""
 
-#: builtin/checkout.c:1107
+#: builtin/checkout.c:1125
 msgid "conflict style (merge or diff3)"
 msgstr ""
 
-#: builtin/checkout.c:1110
+#: builtin/checkout.c:1128
 msgid "do not limit pathspecs to sparse entries only"
 msgstr ""
 
-#: builtin/checkout.c:1112
+#: builtin/checkout.c:1130
 msgid "second guess 'git checkout no-such-branch'"
 msgstr ""
 
-#: builtin/checkout.c:1135
+#: builtin/checkout.c:1153
 msgid "-b, -B and --orphan are mutually exclusive"
 msgstr ""
 
-#: builtin/checkout.c:1152
+#: builtin/checkout.c:1170
 msgid "--track needs a branch name"
 msgstr ""
 
-#: builtin/checkout.c:1157
+#: builtin/checkout.c:1175
 msgid "Missing branch name; try -b"
 msgstr ""
 
-#: builtin/checkout.c:1194
+#: builtin/checkout.c:1212
 msgid "invalid path specification"
 msgstr ""
 
-#: builtin/checkout.c:1201
+#: builtin/checkout.c:1219
 #, c-format
 msgid ""
 "Cannot update paths and switch to branch '%s' at the same time.\n"
 "Did you intend to checkout '%s' which can not be resolved as commit?"
 msgstr ""
 
-#: builtin/checkout.c:1206
+#: builtin/checkout.c:1224
 #, c-format
 msgid "git checkout: --detach does not take a path argument '%s'"
 msgstr ""
 
-#: builtin/checkout.c:1210
+#: builtin/checkout.c:1228
 msgid ""
 "git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
 "checking out of the index."
@@ -3664,254 +3659,275 @@ msgstr ""
 msgid "git clone [options] [--] <repo> [<dir>]"
 msgstr ""
 
-#: builtin/clone.c:65 builtin/fetch.c:112 builtin/merge.c:223
+#: builtin/clone.c:66 builtin/fetch.c:112 builtin/merge.c:224
 #: builtin/push.c:514
 msgid "force progress reporting"
 msgstr ""
 
-#: builtin/clone.c:67
+#: builtin/clone.c:68
 msgid "don't create a checkout"
 msgstr ""
 
-#: builtin/clone.c:68 builtin/clone.c:70 builtin/init-db.c:488
+#: builtin/clone.c:69 builtin/clone.c:71 builtin/init-db.c:489
 msgid "create a bare repository"
 msgstr ""
 
-#: builtin/clone.c:72
+#: builtin/clone.c:73
 msgid "create a mirror repository (implies bare)"
 msgstr ""
 
-#: builtin/clone.c:74
+#: builtin/clone.c:75
 msgid "to clone from a local repository"
 msgstr ""
 
-#: builtin/clone.c:76
+#: builtin/clone.c:77
 msgid "don't use local hardlinks, always copy"
 msgstr ""
 
-#: builtin/clone.c:78
+#: builtin/clone.c:79
 msgid "setup as shared repository"
 msgstr ""
 
-#: builtin/clone.c:80 builtin/clone.c:82
+#: builtin/clone.c:81 builtin/clone.c:83
 msgid "initialize submodules in the clone"
 msgstr ""
 
-#: builtin/clone.c:83 builtin/init-db.c:485
+#: builtin/clone.c:84 builtin/init-db.c:486
 msgid "template-directory"
 msgstr ""
 
-#: builtin/clone.c:84 builtin/init-db.c:486
+#: builtin/clone.c:85 builtin/init-db.c:487
 msgid "directory from which templates will be used"
 msgstr ""
 
-#: builtin/clone.c:86
+#: builtin/clone.c:87
 msgid "reference repository"
 msgstr ""
 
-#: builtin/clone.c:87 builtin/column.c:26 builtin/merge-file.c:44
+#: builtin/clone.c:88 builtin/column.c:26 builtin/merge-file.c:44
 msgid "name"
 msgstr ""
 
-#: builtin/clone.c:88
+#: builtin/clone.c:89
 msgid "use <name> instead of 'origin' to track upstream"
 msgstr ""
 
-#: builtin/clone.c:90
+#: builtin/clone.c:91
 msgid "checkout <branch> instead of the remote's HEAD"
 msgstr ""
 
-#: builtin/clone.c:92
+#: builtin/clone.c:93
 msgid "path to git-upload-pack on the remote"
 msgstr ""
 
-#: builtin/clone.c:93 builtin/fetch.c:113 builtin/grep.c:659
+#: builtin/clone.c:94 builtin/fetch.c:113 builtin/grep.c:659
 msgid "depth"
 msgstr ""
 
-#: builtin/clone.c:94
+#: builtin/clone.c:95
 msgid "create a shallow clone of that depth"
 msgstr ""
 
-#: builtin/clone.c:96
+#: builtin/clone.c:97
 msgid "clone only one branch, HEAD or --branch"
 msgstr ""
 
-#: builtin/clone.c:97 builtin/init-db.c:494
+#: builtin/clone.c:99
+msgid "use --reference only while cloning"
+msgstr ""
+
+#: builtin/clone.c:100 builtin/init-db.c:495
 msgid "gitdir"
 msgstr ""
 
-#: builtin/clone.c:98 builtin/init-db.c:495
+#: builtin/clone.c:101 builtin/init-db.c:496
 msgid "separate git dir from working tree"
 msgstr ""
 
-#: builtin/clone.c:99
+#: builtin/clone.c:102
 msgid "key=value"
 msgstr ""
 
-#: builtin/clone.c:100
+#: builtin/clone.c:103
 msgid "set config inside the new repository"
 msgstr ""
 
-#: builtin/clone.c:253
+#: builtin/clone.c:256
 #, c-format
 msgid "reference repository '%s' is not a local repository."
 msgstr ""
 
-#: builtin/clone.c:257
+#: builtin/clone.c:260
 #, c-format
 msgid "reference repository '%s' is shallow"
 msgstr ""
 
-#: builtin/clone.c:260
+#: builtin/clone.c:263
 #, c-format
 msgid "reference repository '%s' is grafted"
 msgstr ""
 
-#: builtin/clone.c:322
+#: builtin/clone.c:325
 #, c-format
 msgid "failed to create directory '%s'"
 msgstr ""
 
-#: builtin/clone.c:324 builtin/diff.c:84
+#: builtin/clone.c:327 builtin/diff.c:84
 #, c-format
 msgid "failed to stat '%s'"
 msgstr ""
 
-#: builtin/clone.c:326
+#: builtin/clone.c:329
 #, c-format
 msgid "%s exists and is not a directory"
 msgstr ""
 
-#: builtin/clone.c:340
+#: builtin/clone.c:343
 #, c-format
 msgid "failed to stat %s\n"
 msgstr ""
 
-#: builtin/clone.c:362
+#: builtin/clone.c:360
+#, c-format
+msgid "failed to unlink '%s'"
+msgstr ""
+
+#: builtin/clone.c:365
 #, c-format
 msgid "failed to create link '%s'"
 msgstr ""
 
-#: builtin/clone.c:366
+#: builtin/clone.c:369
 #, c-format
 msgid "failed to copy file to '%s'"
 msgstr ""
 
-#: builtin/clone.c:389 builtin/clone.c:563
+#: builtin/clone.c:392 builtin/clone.c:566
 #, c-format
 msgid "done.\n"
 msgstr ""
 
-#: builtin/clone.c:401
+#: builtin/clone.c:404
 msgid ""
 "Clone succeeded, but checkout failed.\n"
 "You can inspect what was checked out with 'git status'\n"
 "and retry the checkout with 'git checkout -f HEAD'\n"
 msgstr ""
 
-#: builtin/clone.c:478
+#: builtin/clone.c:481
 #, c-format
 msgid "Could not find remote branch %s to clone."
 msgstr ""
 
-#: builtin/clone.c:558
+#: builtin/clone.c:561
 #, c-format
 msgid "Checking connectivity... "
 msgstr ""
 
-#: builtin/clone.c:561
+#: builtin/clone.c:564
 msgid "remote did not send all necessary objects"
 msgstr ""
 
-#: builtin/clone.c:625
+#: builtin/clone.c:628
 msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
 msgstr ""
 
-#: builtin/clone.c:656
+#: builtin/clone.c:659
 msgid "unable to checkout working tree"
 msgstr ""
 
-#: builtin/clone.c:765
+#: builtin/clone.c:746
+msgid "cannot repack to clean up"
+msgstr ""
+
+#: builtin/clone.c:748
+msgid "cannot unlink temporary alternates file"
+msgstr ""
+
+#: builtin/clone.c:778
 msgid "Too many arguments."
 msgstr ""
 
-#: builtin/clone.c:769
+#: builtin/clone.c:782
 msgid "You must specify a repository to clone."
 msgstr ""
 
-#: builtin/clone.c:780
+#: builtin/clone.c:793
 #, c-format
 msgid "--bare and --origin %s options are incompatible."
 msgstr ""
 
-#: builtin/clone.c:783
+#: builtin/clone.c:796
 msgid "--bare and --separate-git-dir are incompatible."
 msgstr ""
 
-#: builtin/clone.c:796
+#: builtin/clone.c:809
 #, c-format
 msgid "repository '%s' does not exist"
 msgstr ""
 
-#: builtin/clone.c:802 builtin/fetch.c:1155
+#: builtin/clone.c:815 builtin/fetch.c:1155
 #, c-format
 msgid "depth %s is not a positive number"
 msgstr ""
 
-#: builtin/clone.c:812
+#: builtin/clone.c:825
 #, c-format
 msgid "destination path '%s' already exists and is not an empty directory."
 msgstr ""
 
-#: builtin/clone.c:822
+#: builtin/clone.c:835
 #, c-format
 msgid "working tree '%s' already exists."
 msgstr ""
 
-#: builtin/clone.c:835 builtin/clone.c:847
+#: builtin/clone.c:848 builtin/clone.c:860
 #, c-format
 msgid "could not create leading directories of '%s'"
 msgstr ""
 
-#: builtin/clone.c:838
+#: builtin/clone.c:851
 #, c-format
 msgid "could not create work tree dir '%s'."
 msgstr ""
 
-#: builtin/clone.c:857
+#: builtin/clone.c:870
 #, c-format
 msgid "Cloning into bare repository '%s'...\n"
 msgstr ""
 
-#: builtin/clone.c:859
+#: builtin/clone.c:872
 #, c-format
 msgid "Cloning into '%s'...\n"
 msgstr ""
 
-#: builtin/clone.c:895
+#: builtin/clone.c:897
+msgid "--dissociate given, but there is no --reference"
+msgstr ""
+
+#: builtin/clone.c:912
 msgid "--depth is ignored in local clones; use file:// instead."
 msgstr ""
 
-#: builtin/clone.c:898
+#: builtin/clone.c:915
 msgid "source repository is shallow, ignoring --local"
 msgstr ""
 
-#: builtin/clone.c:903
+#: builtin/clone.c:920
 msgid "--local is ignored"
 msgstr ""
 
-#: builtin/clone.c:907
+#: builtin/clone.c:924
 #, c-format
 msgid "Don't know how to clone %s"
 msgstr ""
 
-#: builtin/clone.c:958 builtin/clone.c:966
+#: builtin/clone.c:975 builtin/clone.c:983
 #, c-format
 msgid "Remote branch %s not found in upstream %s"
 msgstr ""
 
-#: builtin/clone.c:969
+#: builtin/clone.c:986
 msgid "You appear to have cloned an empty repository."
 msgstr ""
 
@@ -4088,43 +4104,43 @@ msgid ""
 "in the current commit message"
 msgstr ""
 
-#: builtin/commit.c:712 builtin/commit.c:745 builtin/commit.c:1120
+#: builtin/commit.c:758 builtin/commit.c:791 builtin/commit.c:1142
 #, c-format
 msgid "could not lookup commit %s"
 msgstr ""
 
-#: builtin/commit.c:724 builtin/shortlog.c:273
+#: builtin/commit.c:770 builtin/shortlog.c:273
 #, c-format
 msgid "(reading log message from standard input)\n"
 msgstr ""
 
-#: builtin/commit.c:726
+#: builtin/commit.c:772
 msgid "could not read log from standard input"
 msgstr ""
 
-#: builtin/commit.c:730
+#: builtin/commit.c:776
 #, c-format
 msgid "could not read log file '%s'"
 msgstr ""
 
-#: builtin/commit.c:752
+#: builtin/commit.c:798
 msgid "could not read MERGE_MSG"
 msgstr ""
 
-#: builtin/commit.c:756
+#: builtin/commit.c:802
 msgid "could not read SQUASH_MSG"
 msgstr ""
 
-#: builtin/commit.c:760
+#: builtin/commit.c:806
 #, c-format
 msgid "could not read '%s'"
 msgstr ""
 
-#: builtin/commit.c:831
+#: builtin/commit.c:853
 msgid "could not write commit template"
 msgstr ""
 
-#: builtin/commit.c:849
+#: builtin/commit.c:871
 #, c-format
 msgid ""
 "\n"
@@ -4134,7 +4150,7 @@ msgid ""
 "and try again.\n"
 msgstr ""
 
-#: builtin/commit.c:854
+#: builtin/commit.c:876
 #, c-format
 msgid ""
 "\n"
@@ -4144,14 +4160,14 @@ msgid ""
 "and try again.\n"
 msgstr ""
 
-#: builtin/commit.c:867
+#: builtin/commit.c:889
 #, c-format
 msgid ""
 "Please enter the commit message for your changes. Lines starting\n"
 "with '%c' will be ignored, and an empty message aborts the commit.\n"
 msgstr ""
 
-#: builtin/commit.c:874
+#: builtin/commit.c:896
 #, c-format
 msgid ""
 "Please enter the commit message for your changes. Lines starting\n"
@@ -4159,348 +4175,348 @@ msgid ""
 "An empty message aborts the commit.\n"
 msgstr ""
 
-#: builtin/commit.c:888
+#: builtin/commit.c:910
 #, c-format
 msgid "%sAuthor:    %.*s <%.*s>"
 msgstr ""
 
-#: builtin/commit.c:896
+#: builtin/commit.c:918
 #, c-format
 msgid "%sDate:      %s"
 msgstr ""
 
-#: builtin/commit.c:903
+#: builtin/commit.c:925
 #, c-format
 msgid "%sCommitter: %.*s <%.*s>"
 msgstr ""
 
-#: builtin/commit.c:921
+#: builtin/commit.c:943
 msgid "Cannot read index"
 msgstr ""
 
-#: builtin/commit.c:978
+#: builtin/commit.c:1000
 msgid "Error building trees"
 msgstr ""
 
-#: builtin/commit.c:993 builtin/tag.c:495
+#: builtin/commit.c:1015 builtin/tag.c:495
 #, c-format
 msgid "Please supply the message using either -m or -F option.\n"
 msgstr ""
 
-#: builtin/commit.c:1095
+#: builtin/commit.c:1117
 #, c-format
 msgid "No existing author found with '%s'"
 msgstr ""
 
-#: builtin/commit.c:1110 builtin/commit.c:1350
+#: builtin/commit.c:1132 builtin/commit.c:1372
 #, c-format
 msgid "Invalid untracked files mode '%s'"
 msgstr ""
 
-#: builtin/commit.c:1147
+#: builtin/commit.c:1169
 msgid "--long and -z are incompatible"
 msgstr ""
 
-#: builtin/commit.c:1177
+#: builtin/commit.c:1199
 msgid "Using both --reset-author and --author does not make sense"
 msgstr ""
 
-#: builtin/commit.c:1186
+#: builtin/commit.c:1208
 msgid "You have nothing to amend."
 msgstr ""
 
-#: builtin/commit.c:1189
+#: builtin/commit.c:1211
 msgid "You are in the middle of a merge -- cannot amend."
 msgstr ""
 
-#: builtin/commit.c:1191
+#: builtin/commit.c:1213
 msgid "You are in the middle of a cherry-pick -- cannot amend."
 msgstr ""
 
-#: builtin/commit.c:1194
+#: builtin/commit.c:1216
 msgid "Options --squash and --fixup cannot be used together"
 msgstr ""
 
-#: builtin/commit.c:1204
+#: builtin/commit.c:1226
 msgid "Only one of -c/-C/-F/--fixup can be used."
 msgstr ""
 
-#: builtin/commit.c:1206
+#: builtin/commit.c:1228
 msgid "Option -m cannot be combined with -c/-C/-F/--fixup."
 msgstr ""
 
-#: builtin/commit.c:1214
+#: builtin/commit.c:1236
 msgid "--reset-author can be used only with -C, -c or --amend."
 msgstr ""
 
-#: builtin/commit.c:1231
+#: builtin/commit.c:1253
 msgid "Only one of --include/--only/--all/--interactive/--patch can be used."
 msgstr ""
 
-#: builtin/commit.c:1233
+#: builtin/commit.c:1255
 msgid "No paths with --include/--only does not make sense."
 msgstr ""
 
-#: builtin/commit.c:1235
+#: builtin/commit.c:1257
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
 
-#: builtin/commit.c:1237
+#: builtin/commit.c:1259
 msgid "Explicit paths specified without -i or -o; assuming --only paths..."
 msgstr ""
 
-#: builtin/commit.c:1249 builtin/tag.c:728
+#: builtin/commit.c:1271 builtin/tag.c:728
 #, c-format
 msgid "Invalid cleanup mode %s"
 msgstr ""
 
-#: builtin/commit.c:1254
+#: builtin/commit.c:1276
 msgid "Paths with -a does not make sense."
 msgstr ""
 
-#: builtin/commit.c:1364 builtin/commit.c:1644
+#: builtin/commit.c:1386 builtin/commit.c:1666
 msgid "show status concisely"
 msgstr ""
 
-#: builtin/commit.c:1366 builtin/commit.c:1646
+#: builtin/commit.c:1388 builtin/commit.c:1668
 msgid "show branch information"
 msgstr ""
 
-#: builtin/commit.c:1368 builtin/commit.c:1648 builtin/push.c:500
+#: builtin/commit.c:1390 builtin/commit.c:1670 builtin/push.c:500
 msgid "machine-readable output"
 msgstr ""
 
-#: builtin/commit.c:1371 builtin/commit.c:1650
+#: builtin/commit.c:1393 builtin/commit.c:1672
 msgid "show status in long format (default)"
 msgstr ""
 
-#: builtin/commit.c:1374 builtin/commit.c:1653
+#: builtin/commit.c:1396 builtin/commit.c:1675
 msgid "terminate entries with NUL"
 msgstr ""
 
-#: builtin/commit.c:1376 builtin/commit.c:1656 builtin/fast-export.c:980
+#: builtin/commit.c:1398 builtin/commit.c:1678 builtin/fast-export.c:980
 #: builtin/fast-export.c:983 builtin/tag.c:603
 msgid "mode"
 msgstr ""
 
-#: builtin/commit.c:1377 builtin/commit.c:1656
+#: builtin/commit.c:1399 builtin/commit.c:1678
 msgid "show untracked files, optional modes: all, normal, no. (Default: all)"
 msgstr ""
 
-#: builtin/commit.c:1380
+#: builtin/commit.c:1402
 msgid "show ignored files"
 msgstr ""
 
-#: builtin/commit.c:1381 parse-options.h:153
+#: builtin/commit.c:1403 parse-options.h:153
 msgid "when"
 msgstr ""
 
-#: builtin/commit.c:1382
+#: builtin/commit.c:1404
 msgid ""
 "ignore changes to submodules, optional when: all, dirty, untracked. "
 "(Default: all)"
 msgstr ""
 
-#: builtin/commit.c:1384
+#: builtin/commit.c:1406
 msgid "list untracked files in columns"
 msgstr ""
 
-#: builtin/commit.c:1471
+#: builtin/commit.c:1493
 msgid "couldn't look up newly created commit"
 msgstr ""
 
-#: builtin/commit.c:1473
+#: builtin/commit.c:1495
 msgid "could not parse newly created commit"
 msgstr ""
 
-#: builtin/commit.c:1518
+#: builtin/commit.c:1540 glossary.h:20
 msgid "detached HEAD"
 msgstr ""
 
-#: builtin/commit.c:1521
+#: builtin/commit.c:1543
 msgid " (root-commit)"
 msgstr ""
 
-#: builtin/commit.c:1614
+#: builtin/commit.c:1636
 msgid "suppress summary after successful commit"
 msgstr ""
 
-#: builtin/commit.c:1615
+#: builtin/commit.c:1637
 msgid "show diff in commit message template"
 msgstr ""
 
-#: builtin/commit.c:1617
+#: builtin/commit.c:1639
 msgid "Commit message options"
 msgstr ""
 
-#: builtin/commit.c:1618 builtin/tag.c:601
+#: builtin/commit.c:1640 builtin/tag.c:601
 msgid "read message from file"
 msgstr ""
 
-#: builtin/commit.c:1619
+#: builtin/commit.c:1641
 msgid "author"
 msgstr ""
 
-#: builtin/commit.c:1619
+#: builtin/commit.c:1641
 msgid "override author for commit"
 msgstr ""
 
-#: builtin/commit.c:1620 builtin/gc.c:275
+#: builtin/commit.c:1642 builtin/gc.c:275
 msgid "date"
 msgstr ""
 
-#: builtin/commit.c:1620
+#: builtin/commit.c:1642
 msgid "override date for commit"
 msgstr ""
 
-#: builtin/commit.c:1621 builtin/merge.c:217 builtin/notes.c:408
-#: builtin/notes.c:565 builtin/tag.c:599
+#: builtin/commit.c:1643 builtin/merge.c:218 builtin/notes.c:391
+#: builtin/notes.c:554 builtin/tag.c:599
 msgid "message"
 msgstr ""
 
-#: builtin/commit.c:1621
+#: builtin/commit.c:1643
 msgid "commit message"
 msgstr ""
 
-#: builtin/commit.c:1622
+#: builtin/commit.c:1644
 msgid "reuse and edit message from specified commit"
 msgstr ""
 
-#: builtin/commit.c:1623
+#: builtin/commit.c:1645
 msgid "reuse message from specified commit"
 msgstr ""
 
-#: builtin/commit.c:1624
+#: builtin/commit.c:1646
 msgid "use autosquash formatted message to fixup specified commit"
 msgstr ""
 
-#: builtin/commit.c:1625
+#: builtin/commit.c:1647
 msgid "use autosquash formatted message to squash specified commit"
 msgstr ""
 
-#: builtin/commit.c:1626
+#: builtin/commit.c:1648
 msgid "the commit is authored by me now (used with -C/-c/--amend)"
 msgstr ""
 
-#: builtin/commit.c:1627 builtin/log.c:1191 builtin/revert.c:86
+#: builtin/commit.c:1649 builtin/log.c:1191 builtin/revert.c:86
 msgid "add Signed-off-by:"
 msgstr ""
 
-#: builtin/commit.c:1628
+#: builtin/commit.c:1650
 msgid "use specified template file"
 msgstr ""
 
-#: builtin/commit.c:1629
+#: builtin/commit.c:1651
 msgid "force edit of commit"
 msgstr ""
 
-#: builtin/commit.c:1630
+#: builtin/commit.c:1652
 msgid "default"
 msgstr ""
 
-#: builtin/commit.c:1630 builtin/tag.c:604
+#: builtin/commit.c:1652 builtin/tag.c:604
 msgid "how to strip spaces and #comments from message"
 msgstr ""
 
-#: builtin/commit.c:1631
+#: builtin/commit.c:1653
 msgid "include status in commit message template"
 msgstr ""
 
-#: builtin/commit.c:1632 builtin/merge.c:224 builtin/revert.c:92
+#: builtin/commit.c:1654 builtin/merge.c:225 builtin/revert.c:92
 #: builtin/tag.c:605
 msgid "key-id"
 msgstr ""
 
-#: builtin/commit.c:1633 builtin/merge.c:225 builtin/revert.c:93
+#: builtin/commit.c:1655 builtin/merge.c:226 builtin/revert.c:93
 msgid "GPG sign commit"
 msgstr ""
 
-#: builtin/commit.c:1636
+#: builtin/commit.c:1658
 msgid "Commit contents options"
 msgstr ""
 
-#: builtin/commit.c:1637
+#: builtin/commit.c:1659
 msgid "commit all changed files"
 msgstr ""
 
-#: builtin/commit.c:1638
+#: builtin/commit.c:1660
 msgid "add specified files to index for commit"
 msgstr ""
 
-#: builtin/commit.c:1639
+#: builtin/commit.c:1661
 msgid "interactively add files"
 msgstr ""
 
-#: builtin/commit.c:1640
+#: builtin/commit.c:1662
 msgid "interactively add changes"
 msgstr ""
 
-#: builtin/commit.c:1641
+#: builtin/commit.c:1663
 msgid "commit only specified files"
 msgstr ""
 
-#: builtin/commit.c:1642
+#: builtin/commit.c:1664
 msgid "bypass pre-commit hook"
 msgstr ""
 
-#: builtin/commit.c:1643
+#: builtin/commit.c:1665
 msgid "show what would be committed"
 msgstr ""
 
-#: builtin/commit.c:1654
+#: builtin/commit.c:1676
 msgid "amend previous commit"
 msgstr ""
 
-#: builtin/commit.c:1655
+#: builtin/commit.c:1677
 msgid "bypass post-rewrite hook"
 msgstr ""
 
-#: builtin/commit.c:1660
+#: builtin/commit.c:1682
 msgid "ok to record an empty change"
 msgstr ""
 
-#: builtin/commit.c:1662
+#: builtin/commit.c:1684
 msgid "ok to record a change with an empty message"
 msgstr ""
 
-#: builtin/commit.c:1691
+#: builtin/commit.c:1713
 msgid "could not parse HEAD commit"
 msgstr ""
 
-#: builtin/commit.c:1730 builtin/merge.c:518
+#: builtin/commit.c:1752 builtin/merge.c:519
 #, c-format
 msgid "could not open '%s' for reading"
 msgstr ""
 
-#: builtin/commit.c:1737
+#: builtin/commit.c:1759
 #, c-format
 msgid "Corrupt MERGE_HEAD file (%s)"
 msgstr ""
 
-#: builtin/commit.c:1744
+#: builtin/commit.c:1766
 msgid "could not read MERGE_MODE"
 msgstr ""
 
-#: builtin/commit.c:1763
+#: builtin/commit.c:1785
 #, c-format
 msgid "could not read commit message: %s"
 msgstr ""
 
-#: builtin/commit.c:1774
+#: builtin/commit.c:1796
 #, c-format
 msgid "Aborting commit; you did not edit the message.\n"
 msgstr ""
 
-#: builtin/commit.c:1779
+#: builtin/commit.c:1801
 #, c-format
 msgid "Aborting commit due to empty commit message.\n"
 msgstr ""
 
-#: builtin/commit.c:1794 builtin/merge.c:850 builtin/merge.c:875
+#: builtin/commit.c:1816 builtin/merge.c:851 builtin/merge.c:876
 msgid "failed to write commit object"
 msgstr ""
 
-#: builtin/commit.c:1827
+#: builtin/commit.c:1849
 msgid ""
 "Repository has been updated, but unable to write\n"
 "new_index file. Check that disk is not full and quota is\n"
@@ -4865,7 +4881,7 @@ msgstr ""
 msgid "Skip output of blob data"
 msgstr ""
 
-#: builtin/fast-export.c:997
+#: builtin/fast-export.c:997 glossary.h:59
 msgid "refspec"
 msgstr ""
 
@@ -5142,7 +5158,7 @@ msgid "git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]"
 msgstr ""
 
 #: builtin/fmt-merge-msg.c:663 builtin/fmt-merge-msg.c:666 builtin/grep.c:698
-#: builtin/merge.c:197 builtin/repack.c:179 builtin/repack.c:183
+#: builtin/merge.c:198 builtin/repack.c:178 builtin/repack.c:182
 #: builtin/show-branch.c:654 builtin/show-ref.c:178 builtin/tag.c:590
 #: parse-options.h:132 parse-options.h:239
 msgid "n"
@@ -5324,6 +5340,19 @@ msgid ""
 "There are too many unreachable loose objects; run 'git prune' to remove them."
 msgstr ""
 
+#: builtin/glossary.c:16
+msgid "match all English git messages"
+msgstr ""
+
+#: builtin/glossary.c:21
+msgid "git glossary [-a|--all] [term]..."
+msgstr ""
+
+#: builtin/glossary.c:85 builtin/help.c:463 builtin/help.c:480
+#, c-format
+msgid "usage: %s%s"
+msgstr ""
+
 #: builtin/grep.c:23
 msgid "git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"
 msgstr ""
@@ -5563,7 +5592,7 @@ msgstr ""
 msgid "type"
 msgstr ""
 
-#: builtin/hash-object.c:94
+#: builtin/hash-object.c:94 glossary.h:43
 msgid "object type"
 msgstr ""
 
@@ -5698,11 +5727,6 @@ msgstr ""
 msgid "The common Git guides are:\n"
 msgstr ""
 
-#: builtin/help.c:463 builtin/help.c:480
-#, c-format
-msgid "usage: %s%s"
-msgstr ""
-
 #: builtin/help.c:496
 #, c-format
 msgid "`git %s' is aliased to `%s'"
@@ -6066,17 +6090,17 @@ msgstr ""
 msgid "insane git directory %s"
 msgstr ""
 
-#: builtin/init-db.c:323 builtin/init-db.c:326
+#: builtin/init-db.c:324 builtin/init-db.c:327
 #, c-format
 msgid "%s already exists"
 msgstr ""
 
-#: builtin/init-db.c:355
+#: builtin/init-db.c:356
 #, c-format
 msgid "unable to handle file type %d"
 msgstr ""
 
-#: builtin/init-db.c:358
+#: builtin/init-db.c:359
 #, c-format
 msgid "unable to move %s to %s"
 msgstr ""
@@ -6084,59 +6108,59 @@ msgstr ""
 #. TRANSLATORS: The first '%s' is either "Reinitialized
 #. existing" or "Initialized empty", the second " shared" or
 #. "", and the last '%s%s' is the verbatim directory name.
-#: builtin/init-db.c:418
+#: builtin/init-db.c:419
 #, c-format
 msgid "%s%s Git repository in %s%s\n"
 msgstr ""
 
-#: builtin/init-db.c:419
+#: builtin/init-db.c:420
 msgid "Reinitialized existing"
 msgstr ""
 
-#: builtin/init-db.c:419
+#: builtin/init-db.c:420
 msgid "Initialized empty"
 msgstr ""
 
-#: builtin/init-db.c:420
+#: builtin/init-db.c:421
 msgid " shared"
 msgstr ""
 
-#: builtin/init-db.c:467
+#: builtin/init-db.c:468
 msgid ""
 "git init [-q | --quiet] [--bare] [--template=<template-directory>] [--"
 "shared[=<permissions>]] [directory]"
 msgstr ""
 
-#: builtin/init-db.c:490
+#: builtin/init-db.c:491
 msgid "permissions"
 msgstr ""
 
-#: builtin/init-db.c:491
+#: builtin/init-db.c:492
 msgid "specify that the git repository is to be shared amongst several users"
 msgstr ""
 
-#: builtin/init-db.c:493 builtin/prune-packed.c:57 builtin/repack.c:172
+#: builtin/init-db.c:494 builtin/prune-packed.c:57 builtin/repack.c:171
 msgid "be quiet"
 msgstr ""
 
-#: builtin/init-db.c:525 builtin/init-db.c:530
+#: builtin/init-db.c:526 builtin/init-db.c:531
 #, c-format
 msgid "cannot mkdir %s"
 msgstr ""
 
-#: builtin/init-db.c:534
+#: builtin/init-db.c:535
 #, c-format
 msgid "cannot chdir to %s"
 msgstr ""
 
-#: builtin/init-db.c:555
+#: builtin/init-db.c:556
 #, c-format
 msgid ""
 "%s (or --work-tree=<directory>) not allowed without specifying %s (or --git-"
 "dir=<directory>)"
 msgstr ""
 
-#: builtin/init-db.c:583
+#: builtin/init-db.c:584
 #, c-format
 msgid "Cannot access work tree '%s'"
 msgstr ""
@@ -6568,179 +6592,179 @@ msgstr ""
 msgid "list entire tree; not just current directory (implies --full-name)"
 msgstr ""
 
-#: builtin/merge.c:44
+#: builtin/merge.c:45
 msgid "git merge [options] [<commit>...]"
 msgstr ""
 
-#: builtin/merge.c:45
+#: builtin/merge.c:46
 msgid "git merge [options] <msg> HEAD <commit>"
 msgstr ""
 
-#: builtin/merge.c:46
+#: builtin/merge.c:47
 msgid "git merge --abort"
 msgstr ""
 
-#: builtin/merge.c:99
+#: builtin/merge.c:100
 msgid "switch `m' requires a value"
 msgstr ""
 
-#: builtin/merge.c:136
+#: builtin/merge.c:137
 #, c-format
 msgid "Could not find merge strategy '%s'.\n"
 msgstr ""
 
-#: builtin/merge.c:137
+#: builtin/merge.c:138
 #, c-format
 msgid "Available strategies are:"
 msgstr ""
 
-#: builtin/merge.c:142
+#: builtin/merge.c:143
 #, c-format
 msgid "Available custom strategies are:"
 msgstr ""
 
-#: builtin/merge.c:192
+#: builtin/merge.c:193
 msgid "do not show a diffstat at the end of the merge"
 msgstr ""
 
-#: builtin/merge.c:195
+#: builtin/merge.c:196
 msgid "show a diffstat at the end of the merge"
 msgstr ""
 
-#: builtin/merge.c:196
+#: builtin/merge.c:197
 msgid "(synonym to --stat)"
 msgstr ""
 
-#: builtin/merge.c:198
+#: builtin/merge.c:199
 msgid "add (at most <n>) entries from shortlog to merge commit message"
 msgstr ""
 
-#: builtin/merge.c:201
+#: builtin/merge.c:202
 msgid "create a single commit instead of doing a merge"
 msgstr ""
 
-#: builtin/merge.c:203
+#: builtin/merge.c:204
 msgid "perform a commit if the merge succeeds (default)"
 msgstr ""
 
-#: builtin/merge.c:205
+#: builtin/merge.c:206
 msgid "edit message before committing"
 msgstr ""
 
-#: builtin/merge.c:206
+#: builtin/merge.c:207
 msgid "allow fast-forward (default)"
 msgstr ""
 
-#: builtin/merge.c:208
+#: builtin/merge.c:209
 msgid "abort if fast-forward is not possible"
 msgstr ""
 
-#: builtin/merge.c:212
+#: builtin/merge.c:213
 msgid "Verify that the named commit has a valid GPG signature"
 msgstr ""
 
-#: builtin/merge.c:213 builtin/notes.c:741 builtin/revert.c:89
+#: builtin/merge.c:214 builtin/notes.c:753 builtin/revert.c:89
 msgid "strategy"
 msgstr ""
 
-#: builtin/merge.c:214
+#: builtin/merge.c:215
 msgid "merge strategy to use"
 msgstr ""
 
-#: builtin/merge.c:215
+#: builtin/merge.c:216
 msgid "option=value"
 msgstr ""
 
-#: builtin/merge.c:216
+#: builtin/merge.c:217
 msgid "option for selected merge strategy"
 msgstr ""
 
-#: builtin/merge.c:218
+#: builtin/merge.c:219
 msgid "merge commit message (for a non-fast-forward merge)"
 msgstr ""
 
-#: builtin/merge.c:222
+#: builtin/merge.c:223
 msgid "abort the current in-progress merge"
 msgstr ""
 
-#: builtin/merge.c:250
+#: builtin/merge.c:251
 msgid "could not run stash."
 msgstr ""
 
-#: builtin/merge.c:255
+#: builtin/merge.c:256
 msgid "stash failed"
 msgstr ""
 
-#: builtin/merge.c:260
+#: builtin/merge.c:261
 #, c-format
 msgid "not a valid object: %s"
 msgstr ""
 
-#: builtin/merge.c:279 builtin/merge.c:296
+#: builtin/merge.c:280 builtin/merge.c:297
 msgid "read-tree failed"
 msgstr ""
 
-#: builtin/merge.c:326
+#: builtin/merge.c:327
 msgid " (nothing to squash)"
 msgstr ""
 
-#: builtin/merge.c:339
+#: builtin/merge.c:340
 #, c-format
 msgid "Squash commit -- not updating HEAD\n"
 msgstr ""
 
-#: builtin/merge.c:371
+#: builtin/merge.c:372
 msgid "Writing SQUASH_MSG"
 msgstr ""
 
-#: builtin/merge.c:373
+#: builtin/merge.c:374
 msgid "Finishing SQUASH_MSG"
 msgstr ""
 
-#: builtin/merge.c:396
+#: builtin/merge.c:397
 #, c-format
 msgid "No merge message -- not updating HEAD\n"
 msgstr ""
 
-#: builtin/merge.c:446
+#: builtin/merge.c:447
 #, c-format
 msgid "'%s' does not point to a commit"
 msgstr ""
 
-#: builtin/merge.c:558
+#: builtin/merge.c:559
 #, c-format
 msgid "Bad branch.%s.mergeoptions string: %s"
 msgstr ""
 
-#: builtin/merge.c:653
+#: builtin/merge.c:654
 msgid "git write-tree failed to write a tree"
 msgstr ""
 
-#: builtin/merge.c:677
+#: builtin/merge.c:678
 msgid "Not handling anything other than two heads merge."
 msgstr ""
 
-#: builtin/merge.c:691
+#: builtin/merge.c:692
 #, c-format
 msgid "Unknown option for merge-recursive: -X%s"
 msgstr ""
 
-#: builtin/merge.c:704
+#: builtin/merge.c:705
 #, c-format
 msgid "unable to write %s"
 msgstr ""
 
-#: builtin/merge.c:793
+#: builtin/merge.c:794
 #, c-format
 msgid "Could not read from '%s'"
 msgstr ""
 
-#: builtin/merge.c:802
+#: builtin/merge.c:803
 #, c-format
 msgid "Not committing merge; use 'git commit' to complete the merge.\n"
 msgstr ""
 
-#: builtin/merge.c:808
+#: builtin/merge.c:809
 #, c-format
 msgid ""
 "Please enter a commit message to explain why this merge is necessary,\n"
@@ -6750,156 +6774,156 @@ msgid ""
 "the commit.\n"
 msgstr ""
 
-#: builtin/merge.c:832
+#: builtin/merge.c:833
 msgid "Empty commit message."
 msgstr ""
 
-#: builtin/merge.c:844
+#: builtin/merge.c:845
 #, c-format
 msgid "Wonderful.\n"
 msgstr ""
 
-#: builtin/merge.c:907
+#: builtin/merge.c:899
 #, c-format
 msgid "Automatic merge failed; fix conflicts and then commit the result.\n"
 msgstr ""
 
-#: builtin/merge.c:923
+#: builtin/merge.c:915
 #, c-format
 msgid "'%s' is not a commit"
 msgstr ""
 
-#: builtin/merge.c:964
+#: builtin/merge.c:956
 msgid "No current branch."
 msgstr ""
 
-#: builtin/merge.c:966
+#: builtin/merge.c:958
 msgid "No remote for the current branch."
 msgstr ""
 
-#: builtin/merge.c:968
+#: builtin/merge.c:960
 msgid "No default upstream defined for the current branch."
 msgstr ""
 
-#: builtin/merge.c:973
+#: builtin/merge.c:965
 #, c-format
 msgid "No remote-tracking branch for %s from %s"
 msgstr ""
 
-#: builtin/merge.c:1129
+#: builtin/merge.c:1121
 msgid "There is no merge to abort (MERGE_HEAD missing)."
 msgstr ""
 
-#: builtin/merge.c:1145
+#: builtin/merge.c:1137
 msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 
-#: builtin/merge.c:1148 git-pull.sh:34
+#: builtin/merge.c:1140 git-pull.sh:34
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr ""
 
-#: builtin/merge.c:1152
+#: builtin/merge.c:1144
 msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 
-#: builtin/merge.c:1155
+#: builtin/merge.c:1147
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists)."
 msgstr ""
 
-#: builtin/merge.c:1164
+#: builtin/merge.c:1156
 msgid "You cannot combine --squash with --no-ff."
 msgstr ""
 
-#: builtin/merge.c:1173
+#: builtin/merge.c:1165
 msgid "No commit specified and merge.defaultToUpstream not set."
 msgstr ""
 
-#: builtin/merge.c:1205
+#: builtin/merge.c:1197
 msgid "Can merge only exactly one commit into empty head"
 msgstr ""
 
-#: builtin/merge.c:1208
+#: builtin/merge.c:1200
 msgid "Squash commit into empty head not supported yet"
 msgstr ""
 
-#: builtin/merge.c:1210
+#: builtin/merge.c:1202
 msgid "Non-fast-forward commit does not make sense into an empty head"
 msgstr ""
 
-#: builtin/merge.c:1215
+#: builtin/merge.c:1207
 #, c-format
 msgid "%s - not something we can merge"
 msgstr ""
 
-#: builtin/merge.c:1266
+#: builtin/merge.c:1258
 #, c-format
 msgid "Commit %s has an untrusted GPG signature, allegedly by %s."
 msgstr ""
 
-#: builtin/merge.c:1269
+#: builtin/merge.c:1261
 #, c-format
 msgid "Commit %s has a bad GPG signature allegedly by %s."
 msgstr ""
 
-#: builtin/merge.c:1272
+#: builtin/merge.c:1264
 #, c-format
 msgid "Commit %s does not have a GPG signature."
 msgstr ""
 
-#: builtin/merge.c:1275
+#: builtin/merge.c:1267
 #, c-format
 msgid "Commit %s has a good GPG signature by %s\n"
 msgstr ""
 
-#: builtin/merge.c:1356
+#: builtin/merge.c:1348
 #, c-format
 msgid "Updating %s..%s\n"
 msgstr ""
 
-#: builtin/merge.c:1395
+#: builtin/merge.c:1387
 #, c-format
 msgid "Trying really trivial in-index merge...\n"
 msgstr ""
 
-#: builtin/merge.c:1402
+#: builtin/merge.c:1394
 #, c-format
 msgid "Nope.\n"
 msgstr ""
 
-#: builtin/merge.c:1434
+#: builtin/merge.c:1426
 msgid "Not possible to fast-forward, aborting."
 msgstr ""
 
-#: builtin/merge.c:1457 builtin/merge.c:1536
+#: builtin/merge.c:1449 builtin/merge.c:1528
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
 msgstr ""
 
-#: builtin/merge.c:1461
+#: builtin/merge.c:1453
 #, c-format
 msgid "Trying merge strategy %s...\n"
 msgstr ""
 
-#: builtin/merge.c:1527
+#: builtin/merge.c:1519
 #, c-format
 msgid "No merge strategy handled the merge.\n"
 msgstr ""
 
-#: builtin/merge.c:1529
+#: builtin/merge.c:1521
 #, c-format
 msgid "Merge with strategy %s failed.\n"
 msgstr ""
 
-#: builtin/merge.c:1538
+#: builtin/merge.c:1530
 #, c-format
 msgid "Using the %s to prepare resolving by hand.\n"
 msgstr ""
 
-#: builtin/merge.c:1550
+#: builtin/merge.c:1542
 #, c-format
 msgid "Automatic merge went well; stopped before committing as requested\n"
 msgstr ""
@@ -7085,7 +7109,7 @@ msgstr ""
 msgid "Renaming %s to %s\n"
 msgstr ""
 
-#: builtin/mv.c:256 builtin/remote.c:726 builtin/repack.c:358
+#: builtin/mv.c:256 builtin/remote.c:726 builtin/repack.c:355
 #, c-format
 msgid "renaming '%s' failed"
 msgstr ""
@@ -7136,8 +7160,8 @@ msgstr ""
 
 #: builtin/notes.c:25
 msgid ""
-"git notes [--ref <notes_ref>] add [-f] [-m <msg> | -F <file> | (-c | -C) "
-"<object>] [<object>]"
+"git notes [--ref <notes_ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> "
+"| (-c | -C) <object>] [<object>]"
 msgstr ""
 
 #: builtin/notes.c:26
@@ -7146,12 +7170,12 @@ msgstr ""
 
 #: builtin/notes.c:27
 msgid ""
-"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) "
-"<object>] [<object>]"
+"git notes [--ref <notes_ref>] append [--allow-empty] [-m <msg> | -F <file> | "
+"(-c | -C) <object>] [<object>]"
 msgstr ""
 
 #: builtin/notes.c:28
-msgid "git notes [--ref <notes_ref>] edit [<object>]"
+msgid "git notes [--ref <notes_ref>] edit [--allow-empty] [<object>]"
 msgstr ""
 
 #: builtin/notes.c:29
@@ -7235,212 +7259,216 @@ msgstr ""
 msgid "git notes get-ref"
 msgstr ""
 
-#: builtin/notes.c:136
+#: builtin/notes.c:146
 #, c-format
 msgid "unable to start 'show' for object '%s'"
 msgstr ""
 
-#: builtin/notes.c:140
+#: builtin/notes.c:150
 msgid "could not read 'show' output"
 msgstr ""
 
-#: builtin/notes.c:148
+#: builtin/notes.c:158
 #, c-format
 msgid "failed to finish 'show' for object '%s'"
 msgstr ""
 
-#: builtin/notes.c:166 builtin/tag.c:477
+#: builtin/notes.c:173 builtin/tag.c:477
 #, c-format
 msgid "could not create file '%s'"
 msgstr ""
 
-#: builtin/notes.c:185
+#: builtin/notes.c:192
 msgid "Please supply the note contents using either -m or -F option"
 msgstr ""
 
-#: builtin/notes.c:206 builtin/notes.c:847
-#, c-format
-msgid "Removing note for object %s\n"
-msgstr ""
-
-#: builtin/notes.c:211
+#: builtin/notes.c:201
 msgid "unable to write note object"
 msgstr ""
 
-#: builtin/notes.c:213
+#: builtin/notes.c:203
 #, c-format
 msgid "The note contents have been left in %s"
 msgstr ""
 
-#: builtin/notes.c:247 builtin/tag.c:693
+#: builtin/notes.c:231 builtin/tag.c:693
 #, c-format
 msgid "cannot read '%s'"
 msgstr ""
 
-#: builtin/notes.c:249 builtin/tag.c:696
+#: builtin/notes.c:233 builtin/tag.c:696
 #, c-format
 msgid "could not open or read '%s'"
 msgstr ""
 
-#: builtin/notes.c:268 builtin/notes.c:319 builtin/notes.c:321
-#: builtin/notes.c:381 builtin/notes.c:435 builtin/notes.c:518
-#: builtin/notes.c:523 builtin/notes.c:598 builtin/notes.c:640
-#: builtin/notes.c:842 builtin/tag.c:709
+#: builtin/notes.c:252 builtin/notes.c:303 builtin/notes.c:305
+#: builtin/notes.c:365 builtin/notes.c:420 builtin/notes.c:506
+#: builtin/notes.c:511 builtin/notes.c:589 builtin/notes.c:652
+#: builtin/notes.c:854 builtin/tag.c:709
 #, c-format
 msgid "Failed to resolve '%s' as a valid ref."
 msgstr ""
 
-#: builtin/notes.c:271
+#: builtin/notes.c:255
 #, c-format
 msgid "Failed to read object '%s'."
 msgstr ""
 
-#: builtin/notes.c:275
+#: builtin/notes.c:259
 #, c-format
 msgid "Cannot read note data from non-blob object '%s'."
 msgstr ""
 
-#: builtin/notes.c:315
+#: builtin/notes.c:299
 #, c-format
 msgid "Malformed input line: '%s'."
 msgstr ""
 
-#: builtin/notes.c:330
+#: builtin/notes.c:314
 #, c-format
 msgid "Failed to copy notes from '%s' to '%s'"
 msgstr ""
 
-#: builtin/notes.c:374 builtin/notes.c:428 builtin/notes.c:501
-#: builtin/notes.c:513 builtin/notes.c:586 builtin/notes.c:633
-#: builtin/notes.c:907
+#: builtin/notes.c:358 builtin/notes.c:413 builtin/notes.c:489
+#: builtin/notes.c:501 builtin/notes.c:577 builtin/notes.c:645
+#: builtin/notes.c:919
 msgid "too many parameters"
 msgstr ""
 
-#: builtin/notes.c:387 builtin/notes.c:646
+#: builtin/notes.c:371 builtin/notes.c:658
 #, c-format
 msgid "No note found for object %s."
 msgstr ""
 
-#: builtin/notes.c:409 builtin/notes.c:566
+#: builtin/notes.c:392 builtin/notes.c:555
 msgid "note contents as a string"
 msgstr ""
 
-#: builtin/notes.c:412 builtin/notes.c:569
+#: builtin/notes.c:395 builtin/notes.c:558
 msgid "note contents in a file"
 msgstr ""
 
-#: builtin/notes.c:414 builtin/notes.c:417 builtin/notes.c:571
-#: builtin/notes.c:574 builtin/tag.c:628
+#: builtin/notes.c:397 builtin/notes.c:400 builtin/notes.c:560
+#: builtin/notes.c:563 builtin/tag.c:628 glossary.h:39
 msgid "object"
 msgstr ""
 
-#: builtin/notes.c:415 builtin/notes.c:572
+#: builtin/notes.c:398 builtin/notes.c:561
 msgid "reuse and edit specified note object"
 msgstr ""
 
-#: builtin/notes.c:418 builtin/notes.c:575
+#: builtin/notes.c:401 builtin/notes.c:564
 msgid "reuse specified note object"
 msgstr ""
 
-#: builtin/notes.c:420 builtin/notes.c:488
+#: builtin/notes.c:404 builtin/notes.c:567
+msgid "allow storing empty note"
+msgstr ""
+
+#: builtin/notes.c:405 builtin/notes.c:476
 msgid "replace existing notes"
 msgstr ""
 
-#: builtin/notes.c:454
+#: builtin/notes.c:430
 #, c-format
 msgid ""
 "Cannot add notes. Found existing notes for object %s. Use '-f' to overwrite "
 "existing notes"
 msgstr ""
 
-#: builtin/notes.c:459 builtin/notes.c:536
+#: builtin/notes.c:445 builtin/notes.c:524
 #, c-format
 msgid "Overwriting existing notes for object %s\n"
 msgstr ""
 
-#: builtin/notes.c:489
+#: builtin/notes.c:456 builtin/notes.c:617 builtin/notes.c:859
+#, c-format
+msgid "Removing note for object %s\n"
+msgstr ""
+
+#: builtin/notes.c:477
 msgid "read objects from stdin"
 msgstr ""
 
-#: builtin/notes.c:491
+#: builtin/notes.c:479
 msgid "load rewriting config for <command> (implies --stdin)"
 msgstr ""
 
-#: builtin/notes.c:509
+#: builtin/notes.c:497
 msgid "too few parameters"
 msgstr ""
 
-#: builtin/notes.c:530
+#: builtin/notes.c:518
 #, c-format
 msgid ""
 "Cannot copy notes. Found existing notes for object %s. Use '-f' to overwrite "
 "existing notes"
 msgstr ""
 
-#: builtin/notes.c:542
+#: builtin/notes.c:530
 #, c-format
 msgid "Missing notes on source object %s. Cannot copy."
 msgstr ""
 
-#: builtin/notes.c:591
+#: builtin/notes.c:582
 #, c-format
 msgid ""
 "The -m/-F/-c/-C options have been deprecated for the 'edit' subcommand.\n"
 "Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
 msgstr ""
 
-#: builtin/notes.c:738
+#: builtin/notes.c:750
 msgid "General options"
 msgstr ""
 
-#: builtin/notes.c:740
+#: builtin/notes.c:752
 msgid "Merge options"
 msgstr ""
 
-#: builtin/notes.c:742
+#: builtin/notes.c:754
 msgid ""
 "resolve notes conflicts using the given strategy (manual/ours/theirs/union/"
 "cat_sort_uniq)"
 msgstr ""
 
-#: builtin/notes.c:744
+#: builtin/notes.c:756
 msgid "Committing unmerged notes"
 msgstr ""
 
-#: builtin/notes.c:746
+#: builtin/notes.c:758
 msgid "finalize notes merge by committing unmerged notes"
 msgstr ""
 
-#: builtin/notes.c:748
+#: builtin/notes.c:760
 msgid "Aborting notes merge resolution"
 msgstr ""
 
-#: builtin/notes.c:750
+#: builtin/notes.c:762
 msgid "abort notes merge"
 msgstr ""
 
-#: builtin/notes.c:845
+#: builtin/notes.c:857
 #, c-format
 msgid "Object %s has no note\n"
 msgstr ""
 
-#: builtin/notes.c:857
+#: builtin/notes.c:869
 msgid "attempt to remove non-existent note is not an error"
 msgstr ""
 
-#: builtin/notes.c:860
+#: builtin/notes.c:872
 msgid "read object names from the standard input"
 msgstr ""
 
-#: builtin/notes.c:941
+#: builtin/notes.c:953
 msgid "notes-ref"
 msgstr ""
 
-#: builtin/notes.c:942
+#: builtin/notes.c:954
 msgid "use notes from <notes_ref>"
 msgstr ""
 
-#: builtin/notes.c:977 builtin/remote.c:1624
+#: builtin/notes.c:989 builtin/remote.c:1624
 #, c-format
 msgid "Unknown subcommand: %s"
 msgstr ""
@@ -7841,7 +7869,7 @@ msgstr ""
 msgid "--all and --mirror are incompatible"
 msgstr ""
 
-#: builtin/push.c:493
+#: builtin/push.c:493 glossary.h:61
 msgid "repository"
 msgstr ""
 
@@ -8483,71 +8511,71 @@ msgstr ""
 msgid "git repack [options]"
 msgstr ""
 
-#: builtin/repack.c:160
+#: builtin/repack.c:159
 msgid "pack everything in a single pack"
 msgstr ""
 
-#: builtin/repack.c:162
+#: builtin/repack.c:161
 msgid "same as -a, and turn unreachable objects loose"
 msgstr ""
 
-#: builtin/repack.c:165
+#: builtin/repack.c:164
 msgid "remove redundant packs, and run git-prune-packed"
 msgstr ""
 
-#: builtin/repack.c:167
+#: builtin/repack.c:166
 msgid "pass --no-reuse-delta to git-pack-objects"
 msgstr ""
 
-#: builtin/repack.c:169
+#: builtin/repack.c:168
 msgid "pass --no-reuse-object to git-pack-objects"
 msgstr ""
 
-#: builtin/repack.c:171
+#: builtin/repack.c:170
 msgid "do not run git-update-server-info"
 msgstr ""
 
-#: builtin/repack.c:174
+#: builtin/repack.c:173
 msgid "pass --local to git-pack-objects"
 msgstr ""
 
-#: builtin/repack.c:176
+#: builtin/repack.c:175
 msgid "write bitmap index"
 msgstr ""
 
-#: builtin/repack.c:177
+#: builtin/repack.c:176
 msgid "approxidate"
 msgstr ""
 
-#: builtin/repack.c:178
+#: builtin/repack.c:177
 msgid "with -A, do not loosen objects older than this"
 msgstr ""
 
-#: builtin/repack.c:180
+#: builtin/repack.c:179
 msgid "size of the window used for delta compression"
 msgstr ""
 
-#: builtin/repack.c:181 builtin/repack.c:185
+#: builtin/repack.c:180 builtin/repack.c:184
 msgid "bytes"
 msgstr ""
 
-#: builtin/repack.c:182
+#: builtin/repack.c:181
 msgid "same as the above, but limit memory size instead of entries count"
 msgstr ""
 
-#: builtin/repack.c:184
+#: builtin/repack.c:183
 msgid "limits the maximum delta depth"
 msgstr ""
 
-#: builtin/repack.c:186
+#: builtin/repack.c:185
 msgid "maximum size of each packfile"
 msgstr ""
 
-#: builtin/repack.c:188
+#: builtin/repack.c:187
 msgid "repack objects in packs marked with .keep"
 msgstr ""
 
-#: builtin/repack.c:374
+#: builtin/repack.c:371
 #, c-format
 msgid "removing '%s' failed"
 msgstr ""
@@ -8669,7 +8697,7 @@ msgstr ""
 msgid "hard"
 msgstr ""
 
-#: builtin/reset.c:34
+#: builtin/reset.c:34 glossary.h:38
 msgid "merge"
 msgstr ""
 
@@ -9656,6 +9684,10 @@ msgstr ""
 msgid "Create, list, delete or verify a tag object signed with GPG"
 msgstr ""
 
+#: rerere.h:27
+msgid "update the index with reused conflict resolution if possible"
+msgstr ""
+
 #: parse-options.h:143
 msgid "expiry-date"
 msgstr ""
@@ -9676,8 +9708,272 @@ msgstr ""
 msgid "use <n> digits to display SHA-1s"
 msgstr ""
 
-#: rerere.h:27
-msgid "update the index with reused conflict resolution if possible"
+#: glossary.h:4
+msgid "alternate object database"
+msgstr ""
+
+#: glossary.h:5
+msgid "bare repository"
+msgstr ""
+
+#: glossary.h:6
+msgid "blob object"
+msgstr ""
+
+#: glossary.h:8
+msgid "cache"
+msgstr ""
+
+#: glossary.h:9
+msgid "chain"
+msgstr ""
+
+#: glossary.h:10
+msgid "changeset"
+msgstr ""
+
+#: glossary.h:11
+msgid "checkout"
+msgstr ""
+
+#: glossary.h:12
+msgid "cherry-picking"
+msgstr ""
+
+#: glossary.h:13
+msgid "clean"
+msgstr ""
+
+#: glossary.h:15
+msgid "commit object"
+msgstr ""
+
+#: glossary.h:16
+msgid "commit-ish (also committish)"
+msgstr ""
+
+#: glossary.h:17
+msgid "core Git"
+msgstr ""
+
+#: glossary.h:18
+msgid "DAG"
+msgstr ""
+
+#: glossary.h:19
+msgid "dangling object"
+msgstr ""
+
+#: glossary.h:21
+msgid "directory"
+msgstr ""
+
+#: glossary.h:22
+msgid "dirty"
+msgstr ""
+
+#: glossary.h:23
+msgid "evil merge"
+msgstr ""
+
+#: glossary.h:24
+msgid "fast-forward"
+msgstr ""
+
+#: glossary.h:25
+msgid "fetch"
+msgstr ""
+
+#: glossary.h:26
+msgid "file system"
+msgstr ""
+
+#: glossary.h:27
+msgid "Git archive"
+msgstr ""
+
+#: glossary.h:28
+msgid "gitfile"
+msgstr ""
+
+#: glossary.h:29
+msgid "grafts"
+msgstr ""
+
+#: glossary.h:30
+msgid "hash"
+msgstr ""
+
+#: glossary.h:31
+msgid "head"
+msgstr ""
+
+#: glossary.h:32
+msgid "HEAD"
+msgstr ""
+
+#: glossary.h:33
+msgid "head ref"
+msgstr ""
+
+#: glossary.h:34
+msgid "hook"
+msgstr ""
+
+#: glossary.h:35
+msgid "index"
+msgstr ""
+
+#: glossary.h:36
+msgid "index entry"
+msgstr ""
+
+#: glossary.h:37
+msgid "master"
+msgstr ""
+
+#: glossary.h:40
+msgid "object database"
+msgstr ""
+
+#: glossary.h:41
+msgid "object identifier"
+msgstr ""
+
+#: glossary.h:42
+msgid "object name"
+msgstr ""
+
+#: glossary.h:44
+msgid "octopus"
+msgstr ""
+
+#: glossary.h:45
+msgid "origin"
+msgstr ""
+
+#: glossary.h:46
+msgid "pack"
+msgstr ""
+
+#: glossary.h:47
+msgid "pack index"
+msgstr ""
+
+#: glossary.h:48
+msgid "pathspec"
+msgstr ""
+
+#: glossary.h:49
+msgid "parent"
+msgstr ""
+
+#: glossary.h:50
+msgid "pickaxe"
+msgstr ""
+
+#: glossary.h:51
+msgid "plumbing"
+msgstr ""
+
+#: glossary.h:52
+msgid "porcelain"
+msgstr ""
+
+#: glossary.h:53
+msgid "pull"
+msgstr ""
+
+#: glossary.h:54
+msgid "push"
+msgstr ""
+
+#: glossary.h:55
+msgid "reachable"
+msgstr ""
+
+#: glossary.h:56
+msgid "rebase"
+msgstr ""
+
+#: glossary.h:57
+msgid "ref"
+msgstr ""
+
+#: glossary.h:58
+msgid "reflog"
+msgstr ""
+
+#: glossary.h:60
+msgid "remote-tracking branch"
+msgstr ""
+
+#: glossary.h:62
+msgid "resolve"
+msgstr ""
+
+#: glossary.h:63
+msgid "revision"
+msgstr ""
+
+#: glossary.h:64
+msgid "rewind"
+msgstr ""
+
+#: glossary.h:65
+msgid "SCM"
+msgstr ""
+
+#: glossary.h:66
+msgid "SHA-1"
+msgstr ""
+
+#: glossary.h:67
+msgid "shallow repository"
+msgstr ""
+
+#: glossary.h:68
+msgid "symref"
+msgstr ""
+
+#: glossary.h:69
+msgid "tag"
+msgstr ""
+
+#: glossary.h:70
+msgid "tag object"
+msgstr ""
+
+#: glossary.h:71
+msgid "topic branch"
+msgstr ""
+
+#: glossary.h:72
+msgid "tree"
+msgstr ""
+
+#: glossary.h:73
+msgid "tree object"
+msgstr ""
+
+#: glossary.h:74
+msgid "tree-ish (also treeish)"
+msgstr ""
+
+#: glossary.h:75
+msgid "unmerged index"
+msgstr ""
+
+#: glossary.h:76
+msgid "unreachable object"
+msgstr ""
+
+#: glossary.h:77
+msgid "upstream branch"
+msgstr ""
+
+#: glossary.h:78
+msgid "working tree"
 msgstr ""
 
 #: git-am.sh:52
-- 
2.2.0.345.g7041aac
