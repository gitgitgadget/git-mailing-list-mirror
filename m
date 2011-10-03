From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/9] po/is.po: add Icelandic translation
Date: Mon,  3 Oct 2011 18:58:09 +0000
Message-ID: <1317668297-2702-2-git-send-email-avarab@gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?q?Marcin=20Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 20:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAniy-0005F0-V8
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 20:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565Ab1JCS6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 14:58:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60232 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab1JCS6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 14:58:43 -0400
Received: by ywb5 with SMTP id 5so3723477ywb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=E88SN/OK+Wac2n4V8XRkPPV9F+B8HCH8U1j4pHoCw6s=;
        b=rOC6l8PUwzGH8XLOZW14otmtk6XFfzNvqhHToL7S18ajEkKzcjjYlf09ia+T4D9Rma
         XzHzxsNYAkdFHhZPmtR4xRNrOaiJo+NeW/rFhlFmBKNBoWnZNtxq+K5VFZokKL2TLRi6
         sJfHb/SOwJRHwXkxAn1gqaT1yPWguvEIZe+Ak=
Received: by 10.223.39.25 with SMTP id d25mr307433fae.131.1317668321028;
        Mon, 03 Oct 2011 11:58:41 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id f25sm22312819faf.7.2011.10.03.11.58.38
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 11:58:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.3
In-Reply-To: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182688>

Translate some non-TEST into Icelandic. This is far from a complete
translation, I've only translated init-db.c.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po | 3412 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 3412 insertions(+), 0 deletions(-)
 create mode 100644 po/is.po

diff --git a/po/is.po b/po/is.po
new file mode 100644
index 0000000..db8cb65
--- /dev/null
+++ b/po/is.po
@@ -0,0 +1,3412 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2011-07-06 19:20+0000\n"
+"PO-Revision-Date: 2011-07-06 19:07 +0000\n"
+"Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Language: \n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: diff.c:104
+#, c-format
+msgid "  Failed to parse dirstat cut-off percentage '%.*s'\n"
+msgstr ""
+
+#: diff.c:109
+#, fuzzy, c-format
+msgid "  Unknown dirstat parameter '%.*s'\n"
+msgstr "gat ekki stat-a=C3=B0 sni=C3=B0i=C3=B0 '%s'"
+
+#: diff.c:205
+#, c-format
+msgid ""
+"Found errors in 'diff.dirstat' config variable:\n"
+"%s"
+msgstr ""
+
+#: diff.c:3295
+#, c-format
+msgid ""
+"Failed to parse --dirstat/-X option parameter:\n"
+"%s"
+msgstr ""
+
+#: wt-status.c:134
+msgid "Unmerged paths:"
+msgstr ""
+
+#: wt-status.c:140 wt-status.c:157
+#, c-format
+msgid "  (use \"git reset %s <file>...\" to unstage)"
+msgstr ""
+
+#: wt-status.c:142 wt-status.c:159
+msgid "  (use \"git rm --cached <file>...\" to unstage)"
+msgstr ""
+
+#: wt-status.c:143
+msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
+msgstr ""
+
+#: wt-status.c:151
+msgid "Changes to be committed:"
+msgstr ""
+
+#: wt-status.c:169
+msgid "Changes not staged for commit:"
+msgstr ""
+
+#: wt-status.c:173
+msgid "  (use \"git add <file>...\" to update what will be committed)"
+msgstr ""
+
+#: wt-status.c:175
+msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
+msgstr ""
+
+#: wt-status.c:176
+msgid ""
+"  (use \"git checkout -- <file>...\" to discard changes in working di=
rectory)"
+msgstr ""
+
+#: wt-status.c:178
+msgid "  (commit or discard the untracked or modified content in submo=
dules)"
+msgstr ""
+
+#: wt-status.c:187
+#, c-format
+msgid "%s files:"
+msgstr ""
+
+#: wt-status.c:190
+#, c-format
+msgid "  (use \"git %s <file>...\" to include in what will be committe=
d)"
+msgstr ""
+
+#: wt-status.c:207
+msgid "bug"
+msgstr ""
+
+#: wt-status.c:212
+msgid "both deleted:"
+msgstr ""
+
+#: wt-status.c:213
+msgid "added by us:"
+msgstr ""
+
+#: wt-status.c:214
+msgid "deleted by them:"
+msgstr ""
+
+#: wt-status.c:215
+msgid "added by them:"
+msgstr ""
+
+#: wt-status.c:216
+msgid "deleted by us:"
+msgstr ""
+
+#: wt-status.c:217
+msgid "both added:"
+msgstr ""
+
+#: wt-status.c:218
+msgid "both modified:"
+msgstr ""
+
+#: wt-status.c:248
+msgid "new commits, "
+msgstr ""
+
+#: wt-status.c:250
+msgid "modified content, "
+msgstr ""
+
+#: wt-status.c:252
+msgid "untracked content, "
+msgstr ""
+
+#: wt-status.c:266
+#, c-format
+msgid "new file:   %s"
+msgstr ""
+
+#: wt-status.c:269
+#, c-format
+msgid "copied:     %s -> %s"
+msgstr ""
+
+#: wt-status.c:272
+#, c-format
+msgid "deleted:    %s"
+msgstr ""
+
+#: wt-status.c:275
+#, c-format
+msgid "modified:   %s"
+msgstr ""
+
+#: wt-status.c:278
+#, c-format
+msgid "renamed:    %s -> %s"
+msgstr ""
+
+#: wt-status.c:281
+#, c-format
+msgid "typechange: %s"
+msgstr ""
+
+#: wt-status.c:284
+#, c-format
+msgid "unknown:    %s"
+msgstr ""
+
+#: wt-status.c:287
+#, c-format
+msgid "unmerged:   %s"
+msgstr ""
+
+#: wt-status.c:290
+#, c-format
+msgid "bug: unhandled diff status %c"
+msgstr ""
+
+#: wt-status.c:713
+msgid "On branch "
+msgstr ""
+
+#: wt-status.c:720
+msgid "Not currently on any branch."
+msgstr ""
+
+#: wt-status.c:731
+#, fuzzy
+msgid "Initial commit"
+msgstr "Bj=C3=B3 til t=C3=B3ma"
+
+#: wt-status.c:745
+msgid "Untracked"
+msgstr ""
+
+#: wt-status.c:747
+msgid "Ignored"
+msgstr ""
+
+#: wt-status.c:749
+#, c-format
+msgid "Untracked files not listed%s"
+msgstr ""
+
+#: wt-status.c:751
+msgid " (use -u option to show untracked files)"
+msgstr ""
+
+#: wt-status.c:757
+msgid "No changes"
+msgstr ""
+
+#: wt-status.c:761
+#, c-format
+msgid "no changes added to commit%s\n"
+msgstr ""
+
+#: wt-status.c:763
+msgid " (use \"git add\" and/or \"git commit -a\")"
+msgstr ""
+
+#: wt-status.c:765
+#, c-format
+msgid "nothing added to commit but untracked files present%s\n"
+msgstr ""
+
+#: wt-status.c:767
+msgid " (use \"git add\" to track)"
+msgstr ""
+
+#: wt-status.c:769 wt-status.c:772 wt-status.c:775
+#, c-format
+msgid "nothing to commit%s\n"
+msgstr ""
+
+#: wt-status.c:770
+msgid " (create/copy files and use \"git add\" to track)"
+msgstr ""
+
+#: wt-status.c:773
+msgid " (use -u to show untracked files)"
+msgstr ""
+
+#: wt-status.c:776
+msgid " (working directory clean)"
+msgstr ""
+
+#: wt-status.c:884
+msgid "HEAD (no branch)"
+msgstr ""
+
+#: wt-status.c:890
+msgid "Initial commit on "
+msgstr ""
+
+#: wt-status.c:905
+msgid "behind "
+msgstr ""
+
+#: wt-status.c:908 wt-status.c:911
+msgid "ahead "
+msgstr ""
+
+#: wt-status.c:913
+msgid ", behind "
+msgstr ""
+
+#: builtin/add.c:61
+#, c-format
+msgid "unexpected diff status %c"
+msgstr ""
+
+#: builtin/add.c:66 builtin/commit.c:291
+msgid "updating files failed"
+msgstr ""
+
+#: builtin/add.c:76
+#, c-format
+msgid "remove '%s'\n"
+msgstr ""
+
+#: builtin/add.c:175
+#, c-format
+msgid "Path '%s' is in submodule '%.*s'"
+msgstr ""
+
+#: builtin/add.c:191
+msgid "Unstaged changes after refreshing the index:"
+msgstr ""
+
+#: builtin/add.c:194 builtin/add.c:454 builtin/rm.c:186
+#, c-format
+msgid "pathspec '%s' did not match any files"
+msgstr ""
+
+#: builtin/add.c:208
+#, c-format
+msgid "'%s' is beyond a symbolic link"
+msgstr ""
+
+#: builtin/add.c:275
+msgid "Could not read the index"
+msgstr ""
+
+#: builtin/add.c:284
+#, c-format
+msgid "Could not open '%s' for writing."
+msgstr ""
+
+#: builtin/add.c:288
+#, fuzzy
+msgid "Could not write patch"
+msgstr "Gat ekki gert %s skrifanlega af h=C3=B3p"
+
+#: builtin/add.c:293
+#, fuzzy, c-format
+msgid "Could not stat '%s'"
+msgstr "gat ekki stat-a=C3=B0 '%s'"
+
+#: builtin/add.c:295
+msgid "Empty patch. Aborted."
+msgstr ""
+
+#: builtin/add.c:301
+#, c-format
+msgid "Could not apply '%s'"
+msgstr ""
+
+#: builtin/add.c:310
+msgid "The following paths are ignored by one of your .gitignore files=
:\n"
+msgstr ""
+
+#: builtin/add.c:350
+#, c-format
+msgid "Use -f if you really want to add them.\n"
+msgstr ""
+
+#: builtin/add.c:351
+msgid "no files added"
+msgstr ""
+
+#: builtin/add.c:357
+msgid "adding files failed"
+msgstr ""
+
+#: builtin/add.c:389
+msgid "-A and -u are mutually incompatible"
+msgstr ""
+
+#: builtin/add.c:391
+msgid "Option --ignore-missing can only be used together with --dry-ru=
n"
+msgstr ""
+
+#: builtin/add.c:411
+#, c-format
+msgid "Nothing specified, nothing added.\n"
+msgstr ""
+
+#: builtin/add.c:412
+#, c-format
+msgid "Maybe you wanted to say 'git add .'?\n"
+msgstr ""
+
+#: builtin/add.c:418 builtin/clean.c:95 builtin/commit.c:350 builtin/m=
v.c:77
+#: builtin/rm.c:162
+msgid "index file corrupt"
+msgstr ""
+
+#: builtin/add.c:470 builtin/mv.c:223 builtin/rm.c:260
+msgid "Unable to write new index file"
+msgstr ""
+
+#: builtin/archive.c:17
+#, c-format
+msgid "could not create archive file '%s'"
+msgstr ""
+
+#: builtin/archive.c:20
+msgid "could not redirect output"
+msgstr ""
+
+#: builtin/archive.c:36
+msgid "git archive: Remote with no URL"
+msgstr ""
+
+#: builtin/archive.c:46
+msgid "git archive: expected ACK/NAK, got EOF"
+msgstr ""
+
+#: builtin/archive.c:51
+#, c-format
+msgid "git archive: NACK %s"
+msgstr ""
+
+#: builtin/archive.c:52
+msgid "git archive: protocol error"
+msgstr ""
+
+#: builtin/archive.c:57
+msgid "git archive: expected a flush"
+msgstr ""
+
+#: builtin/branch.c:136
+#, c-format
+msgid ""
+"deleting branch '%s' that has been merged to\n"
+"         '%s', but not yet merged to HEAD."
+msgstr ""
+
+#: builtin/branch.c:140
+#, c-format
+msgid ""
+"not deleting branch '%s' that is not yet merged to\n"
+"         '%s', even though it is merged to HEAD."
+msgstr ""
+
+#. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
+#: builtin/branch.c:161
+msgid "remote "
+msgstr ""
+
+#: builtin/branch.c:169
+#, fuzzy
+msgid "cannot use -a with -d"
+msgstr "finn ekki n=C3=BAverandi m=C3=B6ppu"
+
+#: builtin/branch.c:175
+msgid "Couldn't look up commit object for HEAD"
+msgstr ""
+
+#: builtin/branch.c:180
+#, c-format
+msgid "Cannot delete the branch '%s' which you are currently on."
+msgstr ""
+
+#: builtin/branch.c:190
+#, c-format
+msgid "%sbranch '%s' not found."
+msgstr ""
+
+#: builtin/branch.c:198
+#, c-format
+msgid "Couldn't look up commit object for '%s'"
+msgstr ""
+
+#: builtin/branch.c:204
+#, c-format
+msgid ""
+"The branch '%s' is not fully merged.\n"
+"If you are sure you want to delete it, run 'git branch -D %s'."
+msgstr ""
+
+#: builtin/branch.c:212
+#, c-format
+msgid "Error deleting %sbranch '%s'"
+msgstr ""
+
+#: builtin/branch.c:217
+#, c-format
+msgid "Deleted %sbranch %s (was %s).\n"
+msgstr ""
+
+#: builtin/branch.c:222
+msgid "Update of config-file failed"
+msgstr ""
+
+#: builtin/branch.c:304
+#, c-format
+msgid "branch '%s' does not point at a commit"
+msgstr ""
+
+#: builtin/branch.c:376
+#, c-format
+msgid "behind %d] "
+msgstr ""
+
+#: builtin/branch.c:378
+#, c-format
+msgid "ahead %d] "
+msgstr ""
+
+#: builtin/branch.c:380
+#, c-format
+msgid "ahead %d, behind %d] "
+msgstr ""
+
+#: builtin/branch.c:483
+msgid "(no branch)"
+msgstr ""
+
+#: builtin/branch.c:543
+msgid "some refs could not be read"
+msgstr ""
+
+#: builtin/branch.c:556
+msgid "cannot rename the current branch while not on any."
+msgstr ""
+
+#: builtin/branch.c:566 builtin/branch.c:570
+#, c-format
+msgid "Invalid branch name: '%s'"
+msgstr ""
+
+#: builtin/branch.c:573
+#, c-format
+msgid "A branch named '%s' already exists."
+msgstr ""
+
+#: builtin/branch.c:579
+msgid "Branch rename failed"
+msgstr ""
+
+#: builtin/branch.c:583
+#, c-format
+msgid "Renamed a misnamed branch '%s' away"
+msgstr ""
+
+#: builtin/branch.c:587
+#, c-format
+msgid "Branch renamed to %s, but HEAD is not updated!"
+msgstr ""
+
+#: builtin/branch.c:594
+msgid "Branch is renamed, but update of config-file failed"
+msgstr ""
+
+#: builtin/branch.c:609
+#, c-format
+msgid "malformed object name %s"
+msgstr ""
+
+#: builtin/branch.c:683
+msgid "Failed to resolve HEAD as a valid ref."
+msgstr ""
+
+#: builtin/branch.c:689
+msgid "HEAD not found below refs/heads!"
+msgstr ""
+
+#: builtin/branch.c:709
+msgid "-a and -r options to 'git branch' do not make sense with a bran=
ch name"
+msgstr ""
+
+#: builtin/bundle.c:47
+#, c-format
+msgid "%s is okay\n"
+msgstr ""
+
+#: builtin/bundle.c:56
+msgid "Need a repository to create a bundle."
+msgstr ""
+
+#: builtin/bundle.c:60
+msgid "Need a repository to unbundle."
+msgstr ""
+
+#: builtin/checkout.c:111 builtin/checkout.c:139
+#, c-format
+msgid "path '%s' does not have our version"
+msgstr ""
+
+#: builtin/checkout.c:113 builtin/checkout.c:141
+#, c-format
+msgid "path '%s' does not have their version"
+msgstr ""
+
+#: builtin/checkout.c:124
+#, c-format
+msgid "path '%s' does not have all three versions"
+msgstr ""
+
+#: builtin/checkout.c:159
+#, c-format
+msgid "path '%s' does not have all 3 versions"
+msgstr ""
+
+#: builtin/checkout.c:176
+#, c-format
+msgid "path '%s': cannot merge"
+msgstr ""
+
+#: builtin/checkout.c:193
+#, c-format
+msgid "Unable to add merge result for '%s'"
+msgstr ""
+
+#: builtin/checkout.c:198 builtin/reset.c:170
+#, c-format
+msgid "make_cache_entry failed for path '%s'"
+msgstr ""
+
+#: builtin/checkout.c:220 builtin/checkout.c:374
+msgid "corrupt index file"
+msgstr ""
+
+#: builtin/checkout.c:248 builtin/checkout.c:255
+#, c-format
+msgid "path '%s' is unmerged"
+msgstr ""
+
+#: builtin/checkout.c:284 builtin/checkout.c:478 builtin/clone.c:668
+#: builtin/merge.c:789
+msgid "unable to write new index file"
+msgstr ""
+
+#: builtin/checkout.c:301 builtin/diff.c:301 builtin/merge.c:396
+msgid "diff_setup_done failed"
+msgstr ""
+
+#: builtin/checkout.c:396
+msgid "you need to resolve your current index first"
+msgstr ""
+
+#: builtin/checkout.c:527
+#, fuzzy, c-format
+msgid "Can not do reflog for '%s'\n"
+msgstr "gat ekki opna=C3=B0 m=C3=B6ppuna '%s'"
+
+#: builtin/checkout.c:557
+msgid "HEAD is now at"
+msgstr ""
+
+#: builtin/checkout.c:563
+#, c-format
+msgid "Already on '%s'\n"
+msgstr ""
+
+#: builtin/checkout.c:567
+#, c-format
+msgid "Switched to and reset branch '%s'\n"
+msgstr ""
+
+#: builtin/checkout.c:569
+#, c-format
+msgid "Switched to a new branch '%s'\n"
+msgstr ""
+
+#: builtin/checkout.c:571
+#, c-format
+msgid "Switched to branch '%s'\n"
+msgstr ""
+
+#: builtin/checkout.c:651
+#, c-format
+msgid " ... and %d more.\n"
+msgstr ""
+
+#. The singular version
+#: builtin/checkout.c:657
+#, c-format
+msgid ""
+"Warning: you are leaving %d commit behind, not connected to\n"
+"any of your branches:\n"
+"\n"
+"%s\n"
+msgid_plural ""
+"Warning: you are leaving %d commits behind, not connected to\n"
+"any of your branches:\n"
+"\n"
+"%s\n"
+msgstr[0] ""
+msgstr[1] ""
+
+#: builtin/checkout.c:675
+#, c-format
+msgid ""
+"If you want to keep them by creating a new branch, this may be a good=
 time\n"
+"to do so with:\n"
+"\n"
+" git branch new_branch_name %s\n"
+"\n"
+msgstr ""
+
+#: builtin/checkout.c:700
+msgid "internal error: only -- alone should have been left"
+msgstr ""
+
+#: builtin/checkout.c:702
+msgid "internal error in revision walk"
+msgstr ""
+
+#: builtin/checkout.c:706
+msgid "Previous HEAD position was"
+msgstr ""
+
+#: builtin/checkout.c:731
+msgid "You are on a branch yet to be born"
+msgstr ""
+
+#. case (1)
+#: builtin/checkout.c:859
+#, c-format
+msgid "invalid reference: %s"
+msgstr ""
+
+#. case (1): want a tree
+#: builtin/checkout.c:898
+#, c-format
+msgid "reference is not a tree: %s"
+msgstr ""
+
+#: builtin/checkout.c:965
+msgid "-B cannot be used with -b"
+msgstr ""
+
+#: builtin/checkout.c:974
+msgid "--patch is incompatible with all other options"
+msgstr ""
+
+#: builtin/checkout.c:977
+msgid "--detach cannot be used with -b/-B/--orphan"
+msgstr ""
+
+#: builtin/checkout.c:979
+msgid "--detach cannot be used with -t"
+msgstr ""
+
+#: builtin/checkout.c:985
+msgid "--track needs a branch name"
+msgstr ""
+
+#: builtin/checkout.c:992
+msgid "Missing branch name; try -b"
+msgstr ""
+
+#: builtin/checkout.c:998
+msgid "--orphan and -b|-B are mutually exclusive"
+msgstr ""
+
+#: builtin/checkout.c:1000
+msgid "--orphan cannot be used with -t"
+msgstr ""
+
+#: builtin/checkout.c:1010
+msgid "git checkout: -f and -m are incompatible"
+msgstr ""
+
+#: builtin/checkout.c:1044
+msgid "invalid path specification"
+msgstr ""
+
+#: builtin/checkout.c:1052
+#, c-format
+msgid ""
+"git checkout: updating paths is incompatible with switching branches.=
\n"
+"Did you intend to checkout '%s' which can not be resolved as commit?"
+msgstr ""
+
+#: builtin/checkout.c:1054
+msgid "git checkout: updating paths is incompatible with switching bra=
nches."
+msgstr ""
+
+#: builtin/checkout.c:1059
+msgid "git checkout: --detach does not take a path argument"
+msgstr ""
+
+#: builtin/checkout.c:1062
+msgid ""
+"git checkout: --ours/--theirs, --force and --merge are incompatible w=
hen\n"
+"checking out of the index."
+msgstr ""
+
+#: builtin/checkout.c:1073
+#, c-format
+msgid "git checkout: we do not like '%s' as a branch name."
+msgstr ""
+
+#: builtin/checkout.c:1078
+#, c-format
+msgid "git checkout: branch %s already exists"
+msgstr ""
+
+#: builtin/checkout.c:1085
+msgid "Cannot switch branch to a non-commit."
+msgstr ""
+
+#: builtin/checkout.c:1088
+msgid "--ours/--theirs is incompatible with switching branches."
+msgstr ""
+
+#: builtin/clean.c:78
+msgid "-x and -X cannot be used together"
+msgstr ""
+
+#: builtin/clean.c:82
+msgid ""
+"clean.requireForce set to true and neither -n nor -f given; refusing =
to clean"
+msgstr ""
+
+#: builtin/clean.c:85
+msgid ""
+"clean.requireForce defaults to true and neither -n nor -f given; refu=
sing to "
+"clean"
+msgstr ""
+
+#: builtin/clean.c:154 builtin/clean.c:175
+#, c-format
+msgid "Would remove %s\n"
+msgstr ""
+
+#: builtin/clean.c:158 builtin/clean.c:178
+#, c-format
+msgid "Removing %s\n"
+msgstr ""
+
+#: builtin/clean.c:161 builtin/clean.c:181
+#, c-format
+msgid "failed to remove %s"
+msgstr ""
+
+#: builtin/clean.c:165
+#, c-format
+msgid "Would not remove %s\n"
+msgstr ""
+
+#: builtin/clean.c:167
+#, c-format
+msgid "Not removing %s\n"
+msgstr ""
+
+#: builtin/clone.c:214
+#, c-format
+msgid "reference repository '%s' is not a local directory."
+msgstr ""
+
+#: builtin/clone.c:241
+#, fuzzy, c-format
+msgid "failed to open '%s'"
+msgstr "gat ekki opna=C3=B0 m=C3=B6ppuna '%s'"
+
+#: builtin/clone.c:245
+#, fuzzy, c-format
+msgid "failed to create directory '%s'"
+msgstr "brj=C3=A1lu=C3=B0 git mappa %s"
+
+#: builtin/clone.c:247 builtin/diff.c:74
+#, fuzzy, c-format
+msgid "failed to stat '%s'"
+msgstr "gat ekki stat-a=C3=B0 '%s'"
+
+#: builtin/clone.c:249
+#, fuzzy, c-format
+msgid "%s exists and is not a directory"
+msgstr "brj=C3=A1lu=C3=B0 git mappa %s"
+
+#: builtin/clone.c:263
+#, c-format
+msgid "failed to stat %s\n"
+msgstr ""
+
+#: builtin/clone.c:273
+#, c-format
+msgid "failed to unlink '%s'"
+msgstr ""
+
+#: builtin/clone.c:278
+#, fuzzy, c-format
+msgid "failed to create link '%s'"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/clone.c:282
+#, fuzzy, c-format
+msgid "failed to copy file to '%s'"
+msgstr "gat ekki afrita=C3=B0 '%s' til '%s'"
+
+#: builtin/clone.c:311
+#, c-format
+msgid "done.\n"
+msgstr ""
+
+#: builtin/clone.c:394
+msgid "Too many arguments."
+msgstr ""
+
+#: builtin/clone.c:398
+msgid "You must specify a repository to clone."
+msgstr ""
+
+#: builtin/clone.c:406
+#, c-format
+msgid "--bare and --origin %s options are incompatible."
+msgstr ""
+
+#: builtin/clone.c:420
+#, c-format
+msgid "repository '%s' does not exist"
+msgstr ""
+
+#: builtin/clone.c:425
+msgid "--depth is ignored in local clones; use file:// instead."
+msgstr ""
+
+#: builtin/clone.c:435
+#, c-format
+msgid "destination path '%s' already exists and is not an empty direct=
ory."
+msgstr ""
+
+#: builtin/clone.c:445
+#, c-format
+msgid "working tree '%s' already exists."
+msgstr ""
+
+#: builtin/clone.c:458 builtin/clone.c:472
+#, c-format
+msgid "could not create leading directories of '%s'"
+msgstr ""
+
+#: builtin/clone.c:461
+#, fuzzy, c-format
+msgid "could not create work tree dir '%s'."
+msgstr "Get ekki opna=C3=B0 tr=C3=A9=C3=B0 '%s'"
+
+#: builtin/clone.c:480
+#, c-format
+msgid "Cloning into bare repository %s...\n"
+msgstr ""
+
+#: builtin/clone.c:482
+#, c-format
+msgid "Cloning into %s...\n"
+msgstr ""
+
+#: builtin/clone.c:540
+#, c-format
+msgid "Don't know how to clone %s"
+msgstr ""
+
+#: builtin/clone.c:579
+#, c-format
+msgid "Remote branch %s not found in upstream %s, using HEAD instead"
+msgstr ""
+
+#: builtin/clone.c:589
+msgid "You appear to have cloned an empty repository."
+msgstr ""
+
+#: builtin/clone.c:631
+msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
+msgstr ""
+
+#: builtin/commit.c:41
+msgid ""
+"Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n=
"
+"You can suppress this message by setting them explicitly:\n"
+"\n"
+"    git config --global user.name \"Your Name\"\n"
+"    git config --global user.email you@example.com\n"
+"\n"
+"After doing this, you may fix the identity used for this commit with:=
\n"
+"\n"
+"    git commit --amend --reset-author\n"
+msgstr ""
+
+#: builtin/commit.c:53
+msgid ""
+"You asked to amend the most recent commit, but doing so would make\n"
+"it empty. You can repeat your command with --allow-empty, or you can\=
n"
+"remove the commit entirely with \"git reset HEAD^\".\n"
+msgstr ""
+
+#: builtin/commit.c:58
+msgid ""
+"The previous cherry-pick is now empty, possibly due to conflict resol=
ution.\n"
+"If you wish to commit it anyway, use:\n"
+"\n"
+"    git commit --allow-empty\n"
+"\n"
+"Otherwise, please use 'git reset'\n"
+msgstr ""
+
+#: builtin/commit.c:318
+msgid "failed to unpack HEAD tree object"
+msgstr ""
+
+#: builtin/commit.c:359
+msgid "unable to create temporary index"
+msgstr ""
+
+#: builtin/commit.c:365
+msgid "interactive add failed"
+msgstr ""
+
+#: builtin/commit.c:397 builtin/commit.c:417 builtin/commit.c:463
+msgid "unable to write new_index file"
+msgstr ""
+
+#: builtin/commit.c:447
+#, c-format
+msgid "cannot do a partial commit during a %s."
+msgstr ""
+
+#: builtin/commit.c:456
+#, fuzzy
+msgid "cannot read the index"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/commit.c:476
+msgid "unable to write temporary index file"
+msgstr ""
+
+#: builtin/commit.c:523 builtin/commit.c:1428
+msgid "could not parse HEAD commit"
+msgstr ""
+
+#: builtin/commit.c:542 builtin/commit.c:548
+#, c-format
+msgid "invalid commit: %s"
+msgstr ""
+
+#: builtin/commit.c:566
+msgid "malformed --author parameter"
+msgstr ""
+
+#: builtin/commit.c:622
+#, c-format
+msgid "Malformed ident string: '%s'"
+msgstr ""
+
+#: builtin/commit.c:656 builtin/commit.c:689 builtin/commit.c:989
+#, c-format
+msgid "could not lookup commit %s"
+msgstr ""
+
+#: builtin/commit.c:668 builtin/shortlog.c:296
+#, c-format
+msgid "(reading log message from standard input)\n"
+msgstr ""
+
+#: builtin/commit.c:670
+msgid "could not read log from standard input"
+msgstr ""
+
+#: builtin/commit.c:674
+#, fuzzy, c-format
+msgid "could not read log file '%s'"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/commit.c:680
+msgid "commit has empty message"
+msgstr ""
+
+#: builtin/commit.c:696
+msgid "could not read MERGE_MSG"
+msgstr ""
+
+#: builtin/commit.c:700
+msgid "could not read SQUASH_MSG"
+msgstr ""
+
+#: builtin/commit.c:704
+#, fuzzy, c-format
+msgid "could not read '%s'"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/commit.c:732
+#, fuzzy, c-format
+msgid "could not open '%s'"
+msgstr "gat ekki opna=C3=B0 m=C3=B6ppuna '%s'"
+
+#: builtin/commit.c:756
+msgid "could not write commit template"
+msgstr ""
+
+#: builtin/commit.c:769
+#, c-format
+msgid ""
+"\n"
+"It looks like you may be committing a %s.\n"
+"If this is not correct, please remove the file\n"
+"\t%s\n"
+"and try again.\n"
+msgstr ""
+
+#: builtin/commit.c:782
+msgid "Please enter the commit message for your changes."
+msgstr ""
+
+#: builtin/commit.c:785
+msgid ""
+" Lines starting\n"
+"with '#' will be ignored, and an empty message aborts the commit.\n"
+msgstr ""
+
+#: builtin/commit.c:790
+msgid ""
+" Lines starting\n"
+"with '#' will be kept; you may remove them yourself if you want to.\n=
"
+"An empty message aborts the commit.\n"
+msgstr ""
+
+#: builtin/commit.c:802
+#, c-format
+msgid "%sAuthor:    %s"
+msgstr ""
+
+#: builtin/commit.c:809
+#, c-format
+msgid "%sCommitter: %s"
+msgstr ""
+
+#: builtin/commit.c:829
+#, fuzzy
+msgid "Cannot read index"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/commit.c:869
+msgid "Error building trees"
+msgstr ""
+
+#: builtin/commit.c:884 builtin/tag.c:313
+#, c-format
+msgid "Please supply the message using either -m or -F option.\n"
+msgstr ""
+
+#: builtin/commit.c:964
+#, c-format
+msgid "No existing author found with '%s'"
+msgstr ""
+
+#: builtin/commit.c:979 builtin/commit.c:1173
+#, c-format
+msgid "Invalid untracked files mode '%s'"
+msgstr ""
+
+#: builtin/commit.c:1018
+msgid "Using both --reset-author and --author does not make sense"
+msgstr ""
+
+#: builtin/commit.c:1032
+msgid "You have nothing to amend."
+msgstr ""
+
+#: builtin/commit.c:1034
+#, c-format
+msgid "You are in the middle of a %s -- cannot amend."
+msgstr ""
+
+#: builtin/commit.c:1036
+msgid "Options --squash and --fixup cannot be used together"
+msgstr ""
+
+#: builtin/commit.c:1046
+msgid "Only one of -c/-C/-F/--fixup can be used."
+msgstr ""
+
+#: builtin/commit.c:1048
+msgid "Option -m cannot be combined with -c/-C/-F/--fixup."
+msgstr ""
+
+#: builtin/commit.c:1054
+msgid "--reset-author can be used only with -C, -c or --amend."
+msgstr ""
+
+#: builtin/commit.c:1071
+msgid "Only one of --include/--only/--all/--interactive/--patch can be=
 used."
+msgstr ""
+
+#: builtin/commit.c:1073
+msgid "No paths with --include/--only does not make sense."
+msgstr ""
+
+#: builtin/commit.c:1075
+msgid "Clever... amending the last one with dirty index."
+msgstr ""
+
+#: builtin/commit.c:1077
+msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
+msgstr ""
+
+#: builtin/commit.c:1087
+#, c-format
+msgid "Invalid cleanup mode %s"
+msgstr ""
+
+#: builtin/commit.c:1092
+msgid "Paths with -a does not make sense."
+msgstr ""
+
+#: builtin/commit.c:1274
+msgid "couldn't look up newly created commit"
+msgstr ""
+
+#: builtin/commit.c:1276
+msgid "could not parse newly created commit"
+msgstr ""
+
+#: builtin/commit.c:1316
+msgid "detached HEAD"
+msgstr ""
+
+#: builtin/commit.c:1318
+msgid " (root-commit)"
+msgstr ""
+
+#: builtin/commit.c:1441 builtin/merge.c:490
+#, c-format
+msgid "could not open '%s' for reading"
+msgstr ""
+
+#: builtin/commit.c:1446
+#, c-format
+msgid "Corrupt MERGE_HEAD file (%s)"
+msgstr ""
+
+#: builtin/commit.c:1453
+msgid "could not read MERGE_MODE"
+msgstr ""
+
+#: builtin/commit.c:1472
+#, c-format
+msgid "could not read commit message: %s"
+msgstr ""
+
+#: builtin/commit.c:1486
+#, c-format
+msgid "Aborting commit due to empty commit message.\n"
+msgstr ""
+
+#: builtin/commit.c:1493
+msgid "failed to write commit object"
+msgstr ""
+
+#: builtin/commit.c:1511
+msgid "cannot lock HEAD ref"
+msgstr ""
+
+#: builtin/commit.c:1515
+msgid "cannot update HEAD ref"
+msgstr ""
+
+#: builtin/commit.c:1525
+msgid ""
+"Repository has been updated, but unable to write\n"
+"new_index file. Check that disk is not full or quota is\n"
+"not exceeded, and then \"git reset HEAD\" to recover."
+msgstr ""
+
+#: builtin/describe.c:234
+#, c-format
+msgid "annotated tag %s not available"
+msgstr ""
+
+#: builtin/describe.c:238
+#, c-format
+msgid "annotated tag %s has no embedded name"
+msgstr ""
+
+#: builtin/describe.c:240
+#, c-format
+msgid "tag '%s' is really '%s' here"
+msgstr ""
+
+#: builtin/describe.c:267
+#, c-format
+msgid "Not a valid object name %s"
+msgstr ""
+
+#: builtin/describe.c:270
+#, c-format
+msgid "%s is not a valid '%s' object"
+msgstr ""
+
+#: builtin/describe.c:287
+#, fuzzy, c-format
+msgid "no tag exactly matches '%s'"
+msgstr "gat ekki stat-a=C3=B0 sni=C3=B0i=C3=B0 '%s'"
+
+#: builtin/describe.c:289
+#, c-format
+msgid "searching to describe %s\n"
+msgstr ""
+
+#: builtin/describe.c:329
+#, c-format
+msgid "finished search at %s\n"
+msgstr ""
+
+#: builtin/describe.c:353
+#, c-format
+msgid ""
+"No annotated tags can describe '%s'.\n"
+"However, there were unannotated tags: try --tags."
+msgstr ""
+
+#: builtin/describe.c:357
+#, c-format
+msgid ""
+"No tags can describe '%s'.\n"
+"Try --always, or create some tags."
+msgstr ""
+
+#: builtin/describe.c:378
+#, c-format
+msgid "traversed %lu commits\n"
+msgstr ""
+
+#: builtin/describe.c:381
+#, c-format
+msgid ""
+"more than %i tags found; listed %i most recent\n"
+"gave up search at %s\n"
+msgstr ""
+
+#: builtin/describe.c:436
+msgid "--long is incompatible with --abbrev=3D0"
+msgstr ""
+
+#: builtin/describe.c:462
+msgid "No names found, cannot describe anything."
+msgstr ""
+
+#: builtin/describe.c:469
+msgid "--dirty is incompatible with committishes"
+msgstr ""
+
+#: builtin/diff.c:76
+#, c-format
+msgid "'%s': not a regular file or symlink"
+msgstr ""
+
+#: builtin/diff.c:220
+#, c-format
+msgid "invalid option: %s"
+msgstr ""
+
+#: builtin/diff.c:296
+msgid "Not a git repository"
+msgstr ""
+
+#: builtin/diff.c:346
+#, c-format
+msgid "invalid object '%s' given."
+msgstr ""
+
+#: builtin/diff.c:351
+#, c-format
+msgid "more than %d trees given: '%s'"
+msgstr ""
+
+#: builtin/diff.c:361
+#, c-format
+msgid "more than two blobs given: '%s'"
+msgstr ""
+
+#: builtin/diff.c:369
+#, c-format
+msgid "unhandled object '%s' given."
+msgstr ""
+
+#: builtin/fetch.c:199
+msgid "Couldn't find remote ref HEAD"
+msgstr ""
+
+#: builtin/fetch.c:252
+#, fuzzy, c-format
+msgid "object %s not found"
+msgstr "sni=C3=B0in funndust ekki %s"
+
+#: builtin/fetch.c:257
+msgid "[up to date]"
+msgstr ""
+
+#.
+#. * If this is the head, and it's not okay to update
+#. * the head, and the old value of the head isn't empty...
+#.
+#: builtin/fetch.c:270
+#, c-format
+msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
+msgstr ""
+
+#: builtin/fetch.c:271 builtin/fetch.c:342
+msgid "[rejected]"
+msgstr ""
+
+#: builtin/fetch.c:281
+msgid "[tag update]"
+msgstr ""
+
+#: builtin/fetch.c:282 builtin/fetch.c:307 builtin/fetch.c:323
+msgid "  (unable to update local ref)"
+msgstr ""
+
+#: builtin/fetch.c:294
+msgid "[new tag]"
+msgstr ""
+
+#: builtin/fetch.c:298
+msgid "[new branch]"
+msgstr ""
+
+#: builtin/fetch.c:338
+msgid "unable to update local ref"
+msgstr ""
+
+#: builtin/fetch.c:338
+msgid "forced update"
+msgstr ""
+
+#: builtin/fetch.c:343
+msgid "(non-fast-forward)"
+msgstr ""
+
+#: builtin/fetch.c:361 builtin/fetch.c:684
+#, fuzzy, c-format
+msgid "cannot open %s: %s\n"
+msgstr "gat ekki opna=C3=B0 m=C3=B6ppuna '%s'"
+
+#: builtin/fetch.c:439
+#, c-format
+msgid "From %.*s\n"
+msgstr ""
+
+#: builtin/fetch.c:450
+#, c-format
+msgid ""
+"some local refs could not be updated; try running\n"
+" 'git remote prune %s' to remove any old, conflicting branches"
+msgstr ""
+
+#: builtin/fetch.c:500
+msgid "could not run rev-list"
+msgstr ""
+
+#: builtin/fetch.c:514
+#, c-format
+msgid "failed write to rev-list: %s"
+msgstr ""
+
+#: builtin/fetch.c:521
+#, c-format
+msgid "failed to close rev-list's stdin: %s"
+msgstr ""
+
+#: builtin/fetch.c:548
+#, c-format
+msgid "   (%s will become dangling)\n"
+msgstr ""
+
+#: builtin/fetch.c:549
+#, c-format
+msgid "   (%s has become dangling)\n"
+msgstr ""
+
+#: builtin/fetch.c:556
+msgid "[deleted]"
+msgstr ""
+
+#: builtin/fetch.c:557
+msgid "(none)"
+msgstr ""
+
+#: builtin/fetch.c:674
+#, c-format
+msgid "Refusing to fetch into current branch %s of non-bare repository=
"
+msgstr ""
+
+#: builtin/fetch.c:708
+#, c-format
+msgid "Don't know how to fetch from %s"
+msgstr ""
+
+#: builtin/fetch.c:762
+#, c-format
+msgid "Option \"%s\" value \"%s\" is not valid for %s"
+msgstr ""
+
+#: builtin/fetch.c:765
+#, c-format
+msgid "Option \"%s\" is ignored for %s\n"
+msgstr ""
+
+#: builtin/fetch.c:864
+#, c-format
+msgid "Fetching %s\n"
+msgstr ""
+
+#: builtin/fetch.c:866
+#, c-format
+msgid "Could not fetch %s"
+msgstr ""
+
+#: builtin/fetch.c:883
+msgid ""
+"No remote repository specified.  Please, specify either a URL or a\n"
+"remote name from which new revisions should be fetched."
+msgstr ""
+
+#: builtin/fetch.c:903
+msgid "You need to specify a tag name."
+msgstr ""
+
+#: builtin/fetch.c:946
+msgid "fetch --all does not take a repository argument"
+msgstr ""
+
+#: builtin/fetch.c:948
+msgid "fetch --all does not make sense with refspecs"
+msgstr ""
+
+#: builtin/fetch.c:959
+#, c-format
+msgid "No such remote or remote group: %s"
+msgstr ""
+
+#: builtin/fetch.c:967
+msgid "Fetching a group and specifying refspecs does not make sense"
+msgstr ""
+
+#: builtin/gc.c:63
+#, c-format
+msgid "Invalid %s: '%s'"
+msgstr ""
+
+#: builtin/gc.c:78
+msgid "Too many options specified"
+msgstr ""
+
+#: builtin/gc.c:103
+#, fuzzy, c-format
+msgid "insanely long object directory %.*s"
+msgstr "brj=C3=A1lu=C3=B0 git mappa %s"
+
+#: builtin/gc.c:223
+#, c-format
+msgid "Auto packing the repository for optimum performance.\n"
+msgstr ""
+
+#: builtin/gc.c:226
+#, c-format
+msgid ""
+"Auto packing the repository for optimum performance. You may also\n"
+"run \"git gc\" manually. See \"git help gc\" for more information.\n"
+msgstr ""
+
+#: builtin/gc.c:254
+msgid ""
+"There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
+msgstr ""
+
+#: builtin/grep.c:256
+#, c-format
+msgid "grep: failed to create thread: %s"
+msgstr ""
+
+#: builtin/grep.c:374
+#, c-format
+msgid "'%s': unable to read %s"
+msgstr ""
+
+#: builtin/grep.c:425
+#, c-format
+msgid "'%s': %s"
+msgstr ""
+
+#: builtin/grep.c:436
+#, c-format
+msgid "'%s': short read %s"
+msgstr ""
+
+#: builtin/grep.c:498
+#, c-format
+msgid "Failed to chdir: %s"
+msgstr ""
+
+#: builtin/grep.c:573 builtin/grep.c:604
+#, c-format
+msgid "unable to read tree (%s)"
+msgstr ""
+
+#: builtin/grep.c:618
+#, c-format
+msgid "unable to grep from object of type %s"
+msgstr ""
+
+#: builtin/grep.c:674
+#, c-format
+msgid "switch `%c' expects a numerical value"
+msgstr ""
+
+#: builtin/grep.c:691
+#, fuzzy, c-format
+msgid "cannot open '%s'"
+msgstr "gat ekki opna=C3=B0 m=C3=B6ppuna '%s'"
+
+#: builtin/grep.c:974
+msgid "no pattern given."
+msgstr ""
+
+#: builtin/grep.c:1001
+#, c-format
+msgid "bad object %s"
+msgstr ""
+
+#: builtin/grep.c:1025
+msgid "--open-files-in-pager only works on the worktree"
+msgstr ""
+
+#: builtin/grep.c:1050
+msgid "--cached cannot be used with --no-index."
+msgstr ""
+
+#: builtin/grep.c:1052
+msgid "--no-index cannot be used with revs."
+msgstr ""
+
+#: builtin/grep.c:1061
+msgid "both --cached and trees are given."
+msgstr ""
+
+#: builtin/init-db.c:35
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "Gat ekki gert %s skrifanlega af h=C3=B3p"
+
+#: builtin/init-db.c:62
+#, c-format
+msgid "insanely long template name %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega langt sni=C3=B0snafn %s"
+
+#: builtin/init-db.c:67
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "gat ekki stat-a=C3=B0 '%s'"
+
+#: builtin/init-db.c:73
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "gat ekki stat-a=C3=B0 sni=C3=B0i=C3=B0 '%s'"
+
+#: builtin/init-db.c:80
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "gat ekki opna=C3=B0 m=C3=B6ppuna '%s'"
+
+#: builtin/init-db.c:97
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/init-db.c:99
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega langur tengill %s"
+
+#: builtin/init-db.c:102
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "gat ekki b=C3=BAi=C3=B0 til tengilinn '%s' '%s'"
+
+#: builtin/init-db.c:106
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "gat ekki afrita=C3=B0 '%s' til '%s'"
+
+#: builtin/init-db.c:110
+#, c-format
+msgid "ignoring template %s"
+msgstr "hunsa sni=C3=B0i=C3=B0 %s"
+
+#: builtin/init-db.c:133
+#, c-format
+msgid "insanely long template path %s"
+msgstr "brj=C3=A1l=C3=A6=C3=B0islega l=C3=B6ng sl=C3=B3=C3=B0 =C3=A1 s=
ni=C3=B0 %s"
+
+#: builtin/init-db.c:141
+#, c-format
+msgid "templates not found %s"
+msgstr "sni=C3=B0in funndust ekki %s"
+
+#: builtin/init-db.c:154
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "afrita ekki sni=C3=B0in vegna rangar =C3=BAtg=C3=A1fu %d fr=C3=
=A1 '%s'"
+
+#: builtin/init-db.c:192
+#, c-format
+msgid "insane git directory %s"
+msgstr "brj=C3=A1lu=C3=B0 git mappa %s"
+
+#: builtin/init-db.c:322 builtin/init-db.c:325
+#, c-format
+msgid "%s already exists"
+msgstr ""
+
+#: builtin/init-db.c:354
+#, c-format
+msgid "unable to handle file type %d"
+msgstr ""
+
+#: builtin/init-db.c:357
+#, c-format
+msgid "unable to move %s to %s"
+msgstr ""
+
+#: builtin/init-db.c:362
+#, c-format
+msgid "Could not create git link %s"
+msgstr ""
+
+#.
+#. * TRANSLATORS: The first '%s' is either "Reinitialized
+#. * existing" or "Initialized empty", the second " shared" or
+#. * "", and the last '%s%s' is the verbatim directory name.
+#.
+#: builtin/init-db.c:419
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s Git lind =C3=AD %s%s\n"
+
+#: builtin/init-db.c:420
+msgid "Reinitialized existing"
+msgstr "Endurger=C3=B0i"
+
+#: builtin/init-db.c:420
+msgid "Initialized empty"
+msgstr "Bj=C3=B3 til t=C3=B3ma"
+
+#: builtin/init-db.c:421
+msgid " shared"
+msgstr " sameiginlega"
+
+#: builtin/init-db.c:440
+msgid "cannot tell cwd"
+msgstr "finn ekki n=C3=BAverandi m=C3=B6ppu"
+
+#: builtin/init-db.c:521 builtin/init-db.c:528
+#, c-format
+msgid "cannot mkdir %s"
+msgstr "get ekki b=C3=BAi=C3=B0 til m=C3=B6ppuna %s"
+
+#: builtin/init-db.c:532
+#, c-format
+msgid "cannot chdir to %s"
+msgstr "get ekki fari=C3=B0 inn =C3=AD m=C3=B6ppuna %s"
+
+#: builtin/init-db.c:554
+#, c-format
+msgid ""
+"%s (or --work-tree=3D<directory>) not allowed without specifying %s (=
or --git-"
+"dir=3D<directory>)"
+msgstr ""
+"%s (e=C3=B0a --work-tree=3D<mappa>) ekki leyfilegt =C3=A1samt %s (e=C3=
=B0a --git-dir=3D<mappa>)"
+
+#: builtin/init-db.c:578
+msgid "Cannot access current working directory"
+msgstr "Get ekki opna=C3=B0 n=C3=BAverandi m=C3=B6ppu"
+
+#: builtin/init-db.c:585
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr "Get ekki opna=C3=B0 tr=C3=A9=C3=B0 '%s'"
+
+#: builtin/log.c:186
+#, c-format
+msgid "Final output: %d %s\n"
+msgstr ""
+
+#: builtin/log.c:287 builtin/log.c:721 builtin/log.c:1274 builtin/log.=
c:1492
+#: builtin/merge.c:338 builtin/revert.c:539 builtin/shortlog.c:181
+msgid "revision walk setup failed"
+msgstr ""
+
+#: builtin/log.c:397 builtin/log.c:486
+#, c-format
+msgid "Could not read object %s"
+msgstr ""
+
+#: builtin/log.c:510
+#, c-format
+msgid "Unknown type: %d"
+msgstr ""
+
+#: builtin/log.c:605
+msgid "format.headers without value"
+msgstr ""
+
+#: builtin/log.c:677
+msgid "name of output directory is too long"
+msgstr ""
+
+#: builtin/log.c:688
+#, fuzzy, c-format
+msgid "Cannot open patch file %s"
+msgstr "gat ekki opna=C3=B0 m=C3=B6ppuna '%s'"
+
+#: builtin/log.c:702
+msgid "Need exactly one range."
+msgstr ""
+
+#: builtin/log.c:710
+msgid "Not a range."
+msgstr ""
+
+#: builtin/log.c:747
+msgid "Could not extract email from committer identity."
+msgstr ""
+
+#: builtin/log.c:779
+msgid "Cover letter needs email format"
+msgstr ""
+
+#: builtin/log.c:872
+#, fuzzy, c-format
+msgid "insane in-reply-to: %s"
+msgstr "brj=C3=A1lu=C3=B0 git mappa %s"
+
+#: builtin/log.c:945
+msgid "Two output directories?"
+msgstr ""
+
+#: builtin/log.c:1136
+#, c-format
+msgid "bogus committer info %s"
+msgstr ""
+
+#: builtin/log.c:1181
+msgid "-n and -k are mutually exclusive."
+msgstr ""
+
+#: builtin/log.c:1183
+msgid "--subject-prefix and -k are mutually exclusive."
+msgstr ""
+
+#: builtin/log.c:1188 builtin/shortlog.c:284
+#, c-format
+msgid "unrecognized argument: %s"
+msgstr ""
+
+#: builtin/log.c:1191
+msgid "--name-only does not make sense"
+msgstr ""
+
+#: builtin/log.c:1193
+msgid "--name-status does not make sense"
+msgstr ""
+
+#: builtin/log.c:1195
+msgid "--check does not make sense"
+msgstr ""
+
+#: builtin/log.c:1218
+msgid "standard output, or directory, which one?"
+msgstr ""
+
+#: builtin/log.c:1220
+#, c-format
+msgid "Could not create directory '%s'"
+msgstr ""
+
+#: builtin/log.c:1355
+msgid "Failed to create output files"
+msgstr ""
+
+#: builtin/log.c:1458
+#, c-format
+msgid ""
+"Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
+msgstr ""
+
+#: builtin/log.c:1474 builtin/log.c:1476 builtin/log.c:1488
+#, c-format
+msgid "Unknown commit %s"
+msgstr ""
+
+#: builtin/merge.c:88
+msgid "switch `m' requires a value"
+msgstr ""
+
+#: builtin/merge.c:125
+#, c-format
+msgid "Could not find merge strategy '%s'.\n"
+msgstr ""
+
+#: builtin/merge.c:126
+#, c-format
+msgid "Available strategies are:"
+msgstr ""
+
+#: builtin/merge.c:131
+#, c-format
+msgid "Available custom strategies are:"
+msgstr ""
+
+#: builtin/merge.c:233
+msgid "could not run stash."
+msgstr ""
+
+#: builtin/merge.c:238
+msgid "stash failed"
+msgstr ""
+
+#: builtin/merge.c:243
+#, c-format
+msgid "not a valid object: %s"
+msgstr ""
+
+#: builtin/merge.c:261 builtin/merge.c:278
+msgid "read-tree failed"
+msgstr ""
+
+#: builtin/merge.c:307
+msgid " (nothing to squash)"
+msgstr ""
+
+#: builtin/merge.c:320
+#, c-format
+msgid "Squash commit -- not updating HEAD\n"
+msgstr ""
+
+#: builtin/merge.c:323 builtin/merge.c:844 builtin/merge.c:1430
+#: builtin/merge.c:1442 builtin/revert.c:213
+#, c-format
+msgid "Could not write to '%s'"
+msgstr ""
+
+#: builtin/merge.c:352
+msgid "Writing SQUASH_MSG"
+msgstr ""
+
+#: builtin/merge.c:354
+msgid "Finishing SQUASH_MSG"
+msgstr ""
+
+#: builtin/merge.c:374
+#, c-format
+msgid "No merge message -- not updating HEAD\n"
+msgstr ""
+
+#: builtin/merge.c:425
+#, c-format
+msgid "'%s' does not point to a commit"
+msgstr ""
+
+#: builtin/merge.c:517
+#, c-format
+msgid "Bad branch.%s.mergeoptions string: %s"
+msgstr ""
+
+#: builtin/merge.c:550
+#, c-format
+msgid "%s: negative length %s"
+msgstr ""
+
+#: builtin/merge.c:609
+msgid "git write-tree failed to write a tree"
+msgstr ""
+
+#: builtin/merge.c:659
+msgid "failed to read the cache"
+msgstr ""
+
+#: builtin/merge.c:676
+msgid "Unable to write index."
+msgstr ""
+
+#: builtin/merge.c:689
+msgid "Not handling anything other than two heads merge."
+msgstr ""
+
+#: builtin/merge.c:703
+#, c-format
+msgid "Unknown option for merge-recursive: -X%s"
+msgstr ""
+
+#: builtin/merge.c:717
+#, c-format
+msgid "unable to write %s"
+msgstr ""
+
+#: builtin/merge.c:841 builtin/merge.c:920 builtin/merge.c:1427
+#: builtin/merge.c:1436 builtin/revert.c:210
+#, fuzzy, c-format
+msgid "Could not open '%s' for writing"
+msgstr "Gat ekki gert %s skrifanlega af h=C3=B3p"
+
+#: builtin/merge.c:852
+#, c-format
+msgid "Could not read from '%s'"
+msgstr ""
+
+#: builtin/merge.c:869
+#, c-format
+msgid "Wonderful.\n"
+msgstr ""
+
+#: builtin/merge.c:936
+#, c-format
+msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
+msgstr ""
+
+#: builtin/merge.c:951
+#, c-format
+msgid "'%s' is not a commit"
+msgstr ""
+
+#: builtin/merge.c:992
+msgid "No current branch."
+msgstr ""
+
+#: builtin/merge.c:994
+msgid "No remote for the current branch."
+msgstr ""
+
+#: builtin/merge.c:996
+msgid "No default upstream defined for the current branch."
+msgstr ""
+
+#: builtin/merge.c:1001
+#, c-format
+msgid "No remote tracking branch for %s from %s"
+msgstr ""
+
+#: builtin/merge.c:1053
+msgid "There is no merge to abort (MERGE_HEAD missing)."
+msgstr ""
+
+#: builtin/merge.c:1068 git-pull.sh:31
+msgid ""
+"You have not concluded your merge (MERGE_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+
+#: builtin/merge.c:1071 git-pull.sh:34
+msgid "You have not concluded your merge (MERGE_HEAD exists)."
+msgstr ""
+
+#: builtin/merge.c:1075
+msgid ""
+"You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
+"Please, commit your changes before you can merge."
+msgstr ""
+
+#: builtin/merge.c:1078
+msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
+msgstr ""
+
+#: builtin/merge.c:1087
+msgid "You cannot combine --squash with --no-ff."
+msgstr ""
+
+#: builtin/merge.c:1092
+msgid "You cannot combine --no-ff with --ff-only."
+msgstr ""
+
+#: builtin/merge.c:1126
+msgid "Can merge only exactly one commit into empty head"
+msgstr ""
+
+#: builtin/merge.c:1129
+msgid "Squash commit into empty head not supported yet"
+msgstr ""
+
+#: builtin/merge.c:1131
+msgid "Non-fast-forward commit does not make sense into an empty head"
+msgstr ""
+
+#: builtin/merge.c:1135 builtin/merge.c:1181
+#, c-format
+msgid "%s - not something we can merge"
+msgstr ""
+
+#: builtin/merge.c:1239
+#, c-format
+msgid "Updating %s..%s\n"
+msgstr ""
+
+#: builtin/merge.c:1273
+#, c-format
+msgid "Trying really trivial in-index merge...\n"
+msgstr ""
+
+#: builtin/merge.c:1277
+#, c-format
+msgid "Nope.\n"
+msgstr ""
+
+#: builtin/merge.c:1310
+msgid "Not possible to fast-forward, aborting."
+msgstr ""
+
+#: builtin/merge.c:1336 builtin/merge.c:1409
+#, c-format
+msgid "Rewinding the tree to pristine...\n"
+msgstr ""
+
+#: builtin/merge.c:1340
+#, c-format
+msgid "Trying merge strategy %s...\n"
+msgstr ""
+
+#: builtin/merge.c:1401
+#, c-format
+msgid "No merge strategy handled the merge.\n"
+msgstr ""
+
+#: builtin/merge.c:1403
+#, c-format
+msgid "Merge with strategy %s failed.\n"
+msgstr ""
+
+#: builtin/merge.c:1411
+#, c-format
+msgid "Using the %s to prepare resolving by hand.\n"
+msgstr ""
+
+#: builtin/merge.c:1447
+#, c-format
+msgid "Automatic merge went well; stopped before committing as request=
ed\n"
+msgstr ""
+
+#: builtin/mv.c:103
+#, fuzzy, c-format
+msgid "Checking rename of '%s' to '%s'\n"
+msgstr "gat ekki afrita=C3=B0 '%s' til '%s'"
+
+#: builtin/mv.c:107
+msgid "bad source"
+msgstr ""
+
+#: builtin/mv.c:110
+msgid "can not move directory into itself"
+msgstr ""
+
+#: builtin/mv.c:113
+msgid "cannot move directory over file"
+msgstr ""
+
+#: builtin/mv.c:123
+#, c-format
+msgid "Huh? %.*s is in index?"
+msgstr ""
+
+#: builtin/mv.c:135
+msgid "source directory is empty"
+msgstr ""
+
+#: builtin/mv.c:166
+msgid "not under version control"
+msgstr ""
+
+#: builtin/mv.c:168
+msgid "destination exists"
+msgstr ""
+
+#: builtin/mv.c:175
+#, c-format
+msgid "%s; will overwrite!"
+msgstr ""
+
+#: builtin/mv.c:178
+msgid "Cannot overwrite"
+msgstr ""
+
+#: builtin/mv.c:181
+msgid "multiple sources for the same target"
+msgstr ""
+
+#: builtin/mv.c:196
+#, c-format
+msgid "%s, source=3D%s, destination=3D%s"
+msgstr ""
+
+#: builtin/mv.c:206
+#, c-format
+msgid "Renaming %s to %s\n"
+msgstr ""
+
+#: builtin/mv.c:209
+#, c-format
+msgid "renaming '%s' failed"
+msgstr ""
+
+#: builtin/notes.c:139
+#, c-format
+msgid "unable to start 'show' for object '%s'"
+msgstr ""
+
+#: builtin/notes.c:145
+msgid "can't fdopen 'show' output fd"
+msgstr ""
+
+#: builtin/notes.c:155
+#, c-format
+msgid "failed to close pipe to 'show' for object '%s'"
+msgstr ""
+
+#: builtin/notes.c:158
+#, c-format
+msgid "failed to finish 'show' for object '%s'"
+msgstr ""
+
+#: builtin/notes.c:175 builtin/tag.c:303
+#, fuzzy, c-format
+msgid "could not create file '%s'"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/notes.c:189
+msgid "Please supply the note contents using either -m or -F option"
+msgstr ""
+
+#: builtin/notes.c:210 builtin/notes.c:968
+#, c-format
+msgid "Removing note for object %s\n"
+msgstr ""
+
+#: builtin/notes.c:215
+msgid "unable to write note object"
+msgstr ""
+
+#: builtin/notes.c:217
+#, c-format
+msgid "The note contents has been left in %s"
+msgstr ""
+
+#: builtin/notes.c:251 builtin/tag.c:448
+#, fuzzy, c-format
+msgid "cannot read '%s'"
+msgstr "gat ekki lesi=C3=B0 tengilinn '%s'"
+
+#: builtin/notes.c:253 builtin/tag.c:451
+#, fuzzy, c-format
+msgid "could not open or read '%s'"
+msgstr "gat ekki opna=C3=B0 m=C3=B6ppuna '%s'"
+
+#: builtin/notes.c:272 builtin/notes.c:445 builtin/notes.c:447
+#: builtin/notes.c:507 builtin/notes.c:561 builtin/notes.c:644
+#: builtin/notes.c:649 builtin/notes.c:724 builtin/notes.c:766
+#: builtin/notes.c:963 builtin/reset.c:303 builtin/tag.c:464
+#, c-format
+msgid "Failed to resolve '%s' as a valid ref."
+msgstr ""
+
+#: builtin/notes.c:275
+#, c-format
+msgid "Failed to read object '%s'."
+msgstr ""
+
+#: builtin/notes.c:299
+msgid "Cannot commit uninitialized/unreferenced notes tree"
+msgstr ""
+
+#: builtin/notes.c:340
+#, c-format
+msgid "Bad notes.rewriteMode value: '%s'"
+msgstr ""
+
+#: builtin/notes.c:350
+#, c-format
+msgid "Refusing to rewrite notes in %s (outside of refs/notes/)"
+msgstr ""
+
+#. TRANSLATORS: The first %s is the name of the
+#. environment variable, the second %s is its value
+#: builtin/notes.c:377
+#, c-format
+msgid "Bad %s value: '%s'"
+msgstr ""
+
+#: builtin/notes.c:441
+#, c-format
+msgid "Malformed input line: '%s'."
+msgstr ""
+
+#: builtin/notes.c:456
+#, fuzzy, c-format
+msgid "Failed to copy notes from '%s' to '%s'"
+msgstr "gat ekki afrita=C3=B0 '%s' til '%s'"
+
+#: builtin/notes.c:500 builtin/notes.c:554 builtin/notes.c:627
+#: builtin/notes.c:639 builtin/notes.c:712 builtin/notes.c:759
+#: builtin/notes.c:1028
+msgid "too many parameters"
+msgstr ""
+
+#: builtin/notes.c:513 builtin/notes.c:772
+#, c-format
+msgid "No note found for object %s."
+msgstr ""
+
+#: builtin/notes.c:580
+#, c-format
+msgid ""
+"Cannot add notes. Found existing notes for object %s. Use '-f' to ove=
rwrite "
+"existing notes"
+msgstr ""
+
+#: builtin/notes.c:585 builtin/notes.c:662
+#, c-format
+msgid "Overwriting existing notes for object %s\n"
+msgstr ""
+
+#: builtin/notes.c:635
+msgid "too few parameters"
+msgstr ""
+
+#: builtin/notes.c:656
+#, c-format
+msgid ""
+"Cannot copy notes. Found existing notes for object %s. Use '-f' to ov=
erwrite "
+"existing notes"
+msgstr ""
+
+#: builtin/notes.c:668
+#, c-format
+msgid "Missing notes on source object %s. Cannot copy."
+msgstr ""
+
+#: builtin/notes.c:717
+#, c-format
+msgid ""
+"The -m/-F/-c/-C options have been deprecated for the 'edit' subcomman=
d.\n"
+"Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
+msgstr ""
+
+#: builtin/notes.c:966
+#, c-format
+msgid "Object %s has no note\n"
+msgstr ""
+
+#: builtin/notes.c:1098
+#, c-format
+msgid "Unknown subcommand: %s"
+msgstr ""
+
+#: builtin/push.c:43
+msgid "tag shorthand without <tag>"
+msgstr ""
+
+#: builtin/push.c:62
+msgid "--delete only accepts plain target ref names"
+msgstr ""
+
+#: builtin/push.c:72
+#, c-format
+msgid ""
+"You are not currently on a branch.\n"
+"To push the history leading to the current (detached HEAD)\n"
+"state now, use\n"
+"\n"
+"    git push %s HEAD:<name-of-remote-branch>\n"
+msgstr ""
+
+#: builtin/push.c:79
+#, c-format
+msgid ""
+"The current branch %s has no upstream branch.\n"
+"To push the current branch and set the remote as upstream, use\n"
+"\n"
+"    git push --set-upstream %s %s\n"
+msgstr ""
+
+#: builtin/push.c:87
+#, c-format
+msgid "The current branch %s has multiple upstream branches, refusing =
to push."
+msgstr ""
+
+#: builtin/push.c:110
+msgid ""
+"You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
+msgstr ""
+
+#: builtin/push.c:130
+#, c-format
+msgid "Pushing to %s\n"
+msgstr ""
+
+#: builtin/push.c:134
+#, c-format
+msgid "failed to push some refs to '%s'"
+msgstr ""
+
+#: builtin/push.c:142
+#, c-format
+msgid ""
+"To prevent you from losing history, non-fast-forward updates were rej=
ected\n"
+"Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the\n"
+"'Note about fast-forwards' section of 'git push --help' for details.\=
n"
+msgstr ""
+
+#: builtin/push.c:159
+#, c-format
+msgid "bad repository '%s'"
+msgstr ""
+
+#: builtin/push.c:160
+msgid ""
+"No configured push destination.\n"
+"Either specify the URL from the command-line or configure a remote "
+"repository using\n"
+"\n"
+"    git remote add <name> <url>\n"
+"\n"
+"and then push using the remote name\n"
+"\n"
+"    git push <name>\n"
+msgstr ""
+
+#: builtin/push.c:175
+msgid "--all and --tags are incompatible"
+msgstr ""
+
+#: builtin/push.c:176
+msgid "--all can't be combined with refspecs"
+msgstr ""
+
+#: builtin/push.c:181
+msgid "--mirror and --tags are incompatible"
+msgstr ""
+
+#: builtin/push.c:182
+msgid "--mirror can't be combined with refspecs"
+msgstr ""
+
+#: builtin/push.c:187
+msgid "--all and --mirror are incompatible"
+msgstr ""
+
+#: builtin/push.c:253
+msgid "--delete is incompatible with --all, --mirror and --tags"
+msgstr ""
+
+#: builtin/push.c:255
+msgid "--delete doesn't make sense without any refs"
+msgstr ""
+
+#: builtin/reset.c:33
+msgid "mixed"
+msgstr ""
+
+#: builtin/reset.c:33
+msgid "soft"
+msgstr ""
+
+#: builtin/reset.c:33
+msgid "hard"
+msgstr ""
+
+#: builtin/reset.c:33
+msgid "merge"
+msgstr ""
+
+#: builtin/reset.c:33
+msgid "keep"
+msgstr ""
+
+#: builtin/reset.c:95
+msgid "You do not have a valid HEAD."
+msgstr ""
+
+#: builtin/reset.c:97
+msgid "Failed to find tree of HEAD."
+msgstr ""
+
+#: builtin/reset.c:103
+#, c-format
+msgid "Failed to find tree of %s."
+msgstr ""
+
+#: builtin/reset.c:108
+msgid "Could not write new index file."
+msgstr ""
+
+#: builtin/reset.c:118
+#, c-format
+msgid "HEAD is now at %s"
+msgstr ""
+
+#: builtin/reset.c:142
+msgid "Could not read index"
+msgstr ""
+
+#: builtin/reset.c:145
+msgid "Unstaged changes after reset:"
+msgstr ""
+
+#: builtin/reset.c:225
+#, c-format
+msgid "Reflog action message too long: %.*s..."
+msgstr ""
+
+#: builtin/reset.c:231
+#, c-format
+msgid "Cannot do a %s reset in the middle of a merge."
+msgstr ""
+
+#: builtin/reset.c:307
+#, c-format
+msgid "Could not parse object '%s'."
+msgstr ""
+
+#: builtin/reset.c:312
+msgid "--patch is incompatible with --{hard,mixed,soft}"
+msgstr ""
+
+#: builtin/reset.c:321
+msgid "--mixed with paths is deprecated; use 'git reset -- <paths>' in=
stead."
+msgstr ""
+
+#: builtin/reset.c:323
+#, c-format
+msgid "Cannot do %s reset with paths."
+msgstr ""
+
+#: builtin/reset.c:335
+#, c-format
+msgid "%s reset is not allowed in a bare repository"
+msgstr ""
+
+#: builtin/reset.c:351
+#, c-format
+msgid "Could not reset index file to revision '%s'."
+msgstr ""
+
+#: builtin/revert.c:99
+msgid "program error"
+msgstr ""
+
+#: builtin/revert.c:171
+#, c-format
+msgid "Could not read commit message of %s"
+msgstr ""
+
+#: builtin/revert.c:253
+#, c-format
+msgid "Could not write to %s."
+msgstr ""
+
+#: builtin/revert.c:256
+#, c-format
+msgid "Error wrapping up %s"
+msgstr ""
+
+#: builtin/revert.c:276
+msgid ""
+"Your local changes would be overwritten by revert.\n"
+"Please, commit your changes or stash them to proceed."
+msgstr ""
+
+#: builtin/revert.c:279
+msgid ""
+"Your local changes would be overwritten by cherry-pick.\n"
+"Please, commit your changes or stash them to proceed."
+msgstr ""
+
+#: builtin/revert.c:283
+msgid "Your local changes would be overwritten by revert.\n"
+msgstr ""
+
+#: builtin/revert.c:285
+msgid "Your local changes would be overwritten by cherry-pick.\n"
+msgstr ""
+
+#. TRANSLATORS: %s will be "revert" or "cherry-pick"
+#: builtin/revert.c:335
+#, c-format
+msgid "%s: Unable to write new index file"
+msgstr ""
+
+#: builtin/revert.c:401
+msgid "Your index file is unmerged."
+msgstr ""
+
+#: builtin/revert.c:404
+msgid "You do not have a valid HEAD"
+msgstr ""
+
+#: builtin/revert.c:419
+#, c-format
+msgid "Commit %s is a merge but no -m option was given."
+msgstr ""
+
+#: builtin/revert.c:427
+#, c-format
+msgid "Commit %s does not have parent %d"
+msgstr ""
+
+#: builtin/revert.c:431
+#, c-format
+msgid "Mainline was specified but commit %s is not a merge."
+msgstr ""
+
+#. TRANSLATORS: The first %s will be "revert" or
+#. "cherry-pick", the second %s a SHA1
+#: builtin/revert.c:442
+#, c-format
+msgid "%s: cannot parse parent commit %s"
+msgstr ""
+
+#: builtin/revert.c:446
+#, c-format
+msgid "Cannot get commit message for %s"
+msgstr ""
+
+#: builtin/revert.c:508
+#, c-format
+msgid "could not revert %s... %s"
+msgstr ""
+
+#: builtin/revert.c:509
+#, c-format
+msgid "could not apply %s... %s"
+msgstr ""
+
+#: builtin/revert.c:542
+msgid "empty commit set passed"
+msgstr ""
+
+#: builtin/revert.c:550
+#, c-format
+msgid "git %s: failed to read the index"
+msgstr ""
+
+#: builtin/revert.c:555
+#, c-format
+msgid "git %s: failed to refresh the index"
+msgstr ""
+
+#: builtin/revert.c:571
+msgid "cherry-pick --ff cannot be used with --signoff"
+msgstr ""
+
+#: builtin/revert.c:573
+msgid "cherry-pick --ff cannot be used with --no-commit"
+msgstr ""
+
+#: builtin/revert.c:575
+msgid "cherry-pick --ff cannot be used with -x"
+msgstr ""
+
+#: builtin/revert.c:577
+msgid "cherry-pick --ff cannot be used with --edit"
+msgstr ""
+
+#: builtin/rm.c:109
+#, c-format
+msgid ""
+"'%s' has staged content different from both the file and the HEAD\n"
+"(use -f to force removal)"
+msgstr ""
+
+#: builtin/rm.c:115
+#, c-format
+msgid ""
+"'%s' has changes staged in the index\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+
+#: builtin/rm.c:119
+#, c-format
+msgid ""
+"'%s' has local modifications\n"
+"(use --cached to keep the file, or -f to force removal)"
+msgstr ""
+
+#: builtin/rm.c:194
+#, c-format
+msgid "not removing '%s' recursively without -r"
+msgstr ""
+
+#: builtin/rm.c:230
+#, c-format
+msgid "git rm: unable to remove %s"
+msgstr ""
+
+#: builtin/shortlog.c:157
+#, c-format
+msgid "Missing author: %s"
+msgstr ""
+
+#: builtin/tag.c:121
+#, c-format
+msgid "tag name too long: %.*s..."
+msgstr ""
+
+#: builtin/tag.c:126
+#, fuzzy, c-format
+msgid "tag '%s' not found."
+msgstr "sni=C3=B0in funndust ekki %s"
+
+#: builtin/tag.c:141
+#, c-format
+msgid "Deleted tag '%s' (was %s)\n"
+msgstr ""
+
+#: builtin/tag.c:153
+#, c-format
+msgid "could not verify the tag '%s'"
+msgstr ""
+
+#: builtin/tag.c:168
+msgid "committer info too long."
+msgstr ""
+
+#: builtin/tag.c:188
+msgid "could not run gpg."
+msgstr ""
+
+#: builtin/tag.c:194
+msgid "gpg did not accept the tag data"
+msgstr ""
+
+#: builtin/tag.c:201
+msgid "gpg failed to sign the tag"
+msgstr ""
+
+#: builtin/tag.c:216
+msgid ""
+"\n"
+"#\n"
+"# Write a tag message\n"
+"#\n"
+msgstr ""
+
+#: builtin/tag.c:224
+#, c-format
+msgid "signing key value too long (%.10s...)"
+msgstr ""
+
+#: builtin/tag.c:264
+msgid "unable to sign the tag"
+msgstr ""
+
+#: builtin/tag.c:266
+msgid "unable to write tag file"
+msgstr ""
+
+#: builtin/tag.c:281
+msgid "bad object type."
+msgstr ""
+
+#: builtin/tag.c:294
+msgid "tag header too big."
+msgstr ""
+
+#: builtin/tag.c:321
+msgid "no tag message?"
+msgstr ""
+
+#: builtin/tag.c:327
+#, c-format
+msgid "The tag message has been left in %s\n"
+msgstr ""
+
+#: builtin/tag.c:431
+msgid "-n option is only allowed with -l."
+msgstr ""
+
+#: builtin/tag.c:433
+msgid "--contains option is only allowed with -l."
+msgstr ""
+
+#: builtin/tag.c:441
+msgid "only one -F or -m option is allowed."
+msgstr ""
+
+#: builtin/tag.c:461
+msgid "too many params"
+msgstr ""
+
+#: builtin/tag.c:467
+#, c-format
+msgid "'%s' is not a valid tag name."
+msgstr ""
+
+#: builtin/tag.c:472
+#, c-format
+msgid "tag '%s' already exists"
+msgstr ""
+
+#: builtin/tag.c:480
+#, c-format
+msgid "%s: cannot lock the ref"
+msgstr ""
+
+#: builtin/tag.c:482
+#, c-format
+msgid "%s: cannot update the ref"
+msgstr ""
+
+#: builtin/tag.c:484
+#, c-format
+msgid "Updated tag '%s' (was %s)\n"
+msgstr ""
+
+#: git-am.sh:47
+msgid "You need to set your committer info first"
+msgstr ""
+
+#: git-am.sh:93
+msgid ""
+"You seem to have moved HEAD since the last 'am' failure.\n"
+"Not rewinding to ORIG_HEAD"
+msgstr ""
+
+#: git-am.sh:105
+#, sh-format
+msgid ""
+"When you have resolved this problem run \"$cmdline --resolved\".\n"
+"If you would prefer to skip this patch, instead run \"$cmdline --skip=
\".\n"
+"To restore the original branch and stop patching run \"$cmdline --abo=
rt\"."
+msgstr ""
+
+#: git-am.sh:121
+msgid "Cannot fall back to three-way merge."
+msgstr ""
+
+#: git-am.sh:136
+msgid "Repository lacks necessary blobs to fall back on 3-way merge."
+msgstr ""
+
+#: git-am.sh:145
+msgid ""
+"Did you hand edit your patch?\n"
+"It does not apply to blobs recorded in its index."
+msgstr ""
+
+#: git-am.sh:154
+msgid "Falling back to patching base and 3-way merge..."
+msgstr ""
+
+#: git-am.sh:261
+msgid "Only one StGIT patch series can be applied at once"
+msgstr ""
+
+#: git-am.sh:313
+#, sh-format
+msgid "Patch format $patch_format is not supported."
+msgstr ""
+
+#: git-am.sh:315
+msgid "Patch format detection failed."
+msgstr ""
+
+#: git-am.sh:365
+msgid "-d option is no longer supported.  Do not use."
+msgstr ""
+
+#: git-am.sh:428
+#, sh-format
+msgid "previous rebase directory $dotest still exists but mbox given."
+msgstr ""
+
+#: git-am.sh:433
+msgid "Please make up your mind. --skip or --abort?"
+msgstr ""
+
+#: git-am.sh:460
+msgid "Resolve operation not in progress, we are not resuming."
+msgstr ""
+
+#: git-am.sh:525
+#, sh-format
+msgid "Dirty index: cannot apply patches (dirty: $files)"
+msgstr ""
+
+#: git-am.sh:614
+#, sh-format
+msgid ""
+"Patch is empty.  Was it split wrong?\n"
+"If you would prefer to skip this patch, instead run \"$cmdline --skip=
\".\n"
+"To restore the original branch and stop patching run \"$cmdline --abo=
rt\"."
+msgstr ""
+
+#: git-am.sh:651
+msgid "Patch does not have a valid e-mail address."
+msgstr ""
+
+#: git-am.sh:698
+msgid "cannot be interactive without stdin connected to a terminal."
+msgstr ""
+
+#: git-am.sh:702
+msgid "Commit Body is:"
+msgstr ""
+
+#. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+#. in your translation. The program will only accept English
+#. input at this point.
+#: git-am.sh:709
+msgid "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+msgstr ""
+
+#: git-am.sh:745
+#, sh-format
+msgid "Applying: $FIRSTLINE"
+msgstr ""
+
+#: git-am.sh:766
+msgid ""
+"No changes - did you forget to use 'git add'?\n"
+"If there is nothing left to stage, chances are that something else\n"
+"already introduced the same changes; you might want to skip this patc=
h."
+msgstr ""
+
+#: git-am.sh:774
+msgid ""
+"You still have unmerged paths in your index\n"
+"did you forget to use 'git add'?"
+msgstr ""
+
+#: git-am.sh:790
+msgid "No changes -- Patch already applied."
+msgstr ""
+
+#: git-am.sh:800
+#, sh-format
+msgid "Patch failed at $msgnum $FIRSTLINE"
+msgstr ""
+
+#: git-am.sh:816
+msgid "applying to an empty history"
+msgstr ""
+
+#: git-bisect.sh:40
+msgid "You need to start by \"git bisect start\""
+msgstr ""
+
+#. TRANSLATORS: Make sure to include [Y] and [n] in your
+#. translation. The program will only accept English input
+#. at this point.
+#: git-bisect.sh:48
+msgid "Do you want me to do it for you [Y/n]? "
+msgstr ""
+
+#: git-bisect.sh:67
+msgid "Bad HEAD - I need a HEAD"
+msgstr ""
+
+#: git-bisect.sh:86
+msgid "won't bisect on seeked tree"
+msgstr ""
+
+#: git-bisect.sh:90
+msgid "Bad HEAD - strange symbolic ref"
+msgstr ""
+
+#: git-bisect.sh:120
+#, sh-format
+msgid "'$arg' does not appear to be a valid revision"
+msgstr ""
+
+#: git-bisect.sh:165
+#, sh-format
+msgid "Bad bisect_write argument: $state"
+msgstr ""
+
+#: git-bisect.sh:193
+#, sh-format
+msgid "Bad rev input: $arg"
+msgstr ""
+
+#: git-bisect.sh:207
+msgid "Please call 'bisect_state' with at least one argument."
+msgstr ""
+
+#: git-bisect.sh:210
+msgid "Bad rev input: HEAD"
+msgstr ""
+
+#: git-bisect.sh:219
+#, sh-format
+msgid "Bad rev input: $rev"
+msgstr ""
+
+#: git-bisect.sh:225
+msgid "'git bisect bad' can take only one argument."
+msgstr ""
+
+#. have bad but not good.  we could bisect although
+#. this is less optimum.
+#: git-bisect.sh:249
+msgid "Warning: bisecting only with a bad commit."
+msgstr ""
+
+#. TRANSLATORS: Make sure to include [Y] and [n] in your
+#. translation. The program will only accept English input
+#. at this point.
+#: git-bisect.sh:257
+msgid "Are you sure [Y/n]? "
+msgstr ""
+
+#: git-bisect.sh:268
+msgid ""
+"You need to give me at least one good and one bad revisions.\n"
+"(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
+msgstr ""
+
+#: git-bisect.sh:274
+msgid ""
+"You need to start by \"git bisect start\".\n"
+"You then need to give me at least one good and one bad revisions.\n"
+"(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
+msgstr ""
+
+#: git-bisect.sh:330 git-bisect.sh:457
+msgid "We are not bisecting."
+msgstr ""
+
+#: git-bisect.sh:337
+#, sh-format
+msgid "'$invalid' is not a valid commit"
+msgstr ""
+
+#: git-bisect.sh:346
+#, sh-format
+msgid ""
+"Could not check out original HEAD '$branch'.\n"
+"Try 'git bisect reset <commit>'."
+msgstr ""
+
+#: git-bisect.sh:371
+msgid "No logfile given"
+msgstr ""
+
+#: git-bisect.sh:372
+#, sh-format
+msgid "cannot read $file for replaying"
+msgstr ""
+
+#: git-bisect.sh:388
+msgid "?? what are you talking about?"
+msgstr ""
+
+#: git-bisect.sh:400
+#, sh-format
+msgid "running $command"
+msgstr ""
+
+#: git-bisect.sh:407
+#, sh-format
+msgid ""
+"bisect run failed:\n"
+"exit code $res from '$command' is < 0 or >=3D 128"
+msgstr ""
+
+#: git-bisect.sh:433
+msgid "bisect run cannot continue any more"
+msgstr ""
+
+#: git-bisect.sh:441
+#, sh-format
+msgid ""
+"bisect run failed:\n"
+"'bisect_state $state' exited with error code $res"
+msgstr ""
+
+#: git-bisect.sh:449
+msgid "bisect run success"
+msgstr ""
+
+#: git-pull.sh:21
+msgid ""
+"Pull is not possible because you have unmerged files.\n"
+"Please, fix them up in the work tree, and then use 'git add/rm <file>=
'\n"
+"as appropriate to mark resolution, or use 'git commit -a'."
+msgstr ""
+
+#: git-pull.sh:25
+msgid "Pull is not possible because you have unmerged files."
+msgstr ""
+
+#: git-pull.sh:189
+msgid "updating an unborn branch with changes added to the index"
+msgstr ""
+
+#. The fetch involved updating the current branch.
+#. The working tree and the index file is still based on the
+#. $orig_head commit, but we are merging into $curr_head.
+#. First update the working tree to match $curr_head.
+#: git-pull.sh:221
+#, sh-format
+msgid ""
+"Warning: fetch updated the current branch head.\n"
+"Warning: fast-forwarding your working tree from\n"
+"Warning: commit $orig_head."
+msgstr ""
+
+#: git-pull.sh:248
+msgid "Cannot merge multiple branches into empty head"
+msgstr ""
+
+#: git-pull.sh:252
+msgid "Cannot rebase onto multiple branches"
+msgstr ""
+
+#: git-stash.sh:43
+msgid "git stash clear with parameters is unimplemented"
+msgstr ""
+
+#: git-stash.sh:65
+msgid "You do not have the initial commit yet"
+msgstr ""
+
+#: git-stash.sh:80
+#, fuzzy
+msgid "Cannot save the current index state"
+msgstr "Get ekki opna=C3=B0 n=C3=BAverandi m=C3=B6ppu"
+
+#: git-stash.sh:94 git-stash.sh:107
+#, fuzzy
+msgid "Cannot save the current worktree state"
+msgstr "Get ekki opna=C3=B0 n=C3=BAverandi m=C3=B6ppu"
+
+#: git-stash.sh:111
+msgid "No changes selected"
+msgstr ""
+
+#: git-stash.sh:114
+msgid "Cannot remove temporary index (can't happen)"
+msgstr ""
+
+#: git-stash.sh:127
+#, fuzzy
+msgid "Cannot record working tree state"
+msgstr "Get ekki opna=C3=B0 tr=C3=A9=C3=B0 '%s'"
+
+#: git-stash.sh:182
+msgid "No local changes to save"
+msgstr ""
+
+#: git-stash.sh:186
+msgid "Cannot initialize stash"
+msgstr ""
+
+#: git-stash.sh:194
+msgid "Cannot save the current status"
+msgstr ""
+
+#: git-stash.sh:207
+#, fuzzy
+msgid "Cannot remove worktree changes"
+msgstr "Get ekki opna=C3=B0 tr=C3=A9=C3=B0 '%s'"
+
+#: git-stash.sh:302
+msgid "No stash found."
+msgstr ""
+
+#: git-stash.sh:309
+#, sh-format
+msgid "Too many revisions specified: $REV"
+msgstr ""
+
+#: git-stash.sh:315
+#, sh-format
+msgid "$reference is not valid reference"
+msgstr ""
+
+#: git-stash.sh:340
+#, sh-format
+msgid "'$args' is not a stash-like commit"
+msgstr ""
+
+#: git-stash.sh:351
+#, sh-format
+msgid "'$args' is not a stash reference"
+msgstr ""
+
+#: git-stash.sh:359
+msgid "unable to refresh index"
+msgstr ""
+
+#: git-stash.sh:363
+msgid "Cannot apply a stash in the middle of a merge"
+msgstr ""
+
+#: git-stash.sh:371
+msgid "Conflicts in index. Try without --index."
+msgstr ""
+
+#: git-stash.sh:373
+msgid "Could not save index tree"
+msgstr ""
+
+#: git-stash.sh:399
+msgid "Cannot unstage modified files"
+msgstr ""
+
+#: git-stash.sh:414
+msgid "Index was not unstashed."
+msgstr ""
+
+#: git-stash.sh:433
+#, sh-format
+msgid "Dropped ${REV} ($s)"
+msgstr ""
+
+#: git-stash.sh:434
+#, sh-format
+msgid "${REV}: Could not drop stash entry"
+msgstr ""
+
+#: git-stash.sh:441
+msgid "No branch name specified"
+msgstr ""
+
+#: git-stash.sh:512
+msgid "(To restore them type \"git stash apply\")"
+msgstr ""
+
+#: git-submodule.sh:38
+#, sh-format
+msgid "remote ($remote) does not have a url defined in .git/config"
+msgstr ""
+
+#: git-submodule.sh:56
+#, sh-format
+msgid "cannot strip one component off url '$remoteurl'"
+msgstr ""
+
+#: git-submodule.sh:108
+#, sh-format
+msgid "No submodule mapping found in .gitmodules for path '$path'"
+msgstr ""
+
+#: git-submodule.sh:132
+#, sh-format
+msgid "Clone of '$url' into submodule path '$path' failed"
+msgstr ""
+
+#: git-submodule.sh:205
+#, sh-format
+msgid "repo URL: '$repo' must be absolute or begin with ./|../"
+msgstr ""
+
+#: git-submodule.sh:222
+#, sh-format
+msgid "'$path' already exists in the index"
+msgstr ""
+
+#: git-submodule.sh:227
+#, sh-format
+msgid ""
+"The following path is ignored by one of your .gitignore files:\n"
+"$path\n"
+"Use -f if you really want to add it."
+msgstr ""
+
+#: git-submodule.sh:240
+#, sh-format
+msgid "Adding existing repo at '$path' to the index"
+msgstr ""
+
+#: git-submodule.sh:242
+#, sh-format
+msgid "'$path' already exists and is not a valid git repo"
+msgstr ""
+
+#: git-submodule.sh:265
+#, sh-format
+msgid "Unable to checkout submodule '$path'"
+msgstr ""
+
+#: git-submodule.sh:269
+#, sh-format
+msgid "Failed to add submodule '$path'"
+msgstr ""
+
+#: git-submodule.sh:274
+#, sh-format
+msgid "Failed to register submodule '$path'"
+msgstr ""
+
+#: git-submodule.sh:312
+#, sh-format
+msgid "Entering '$prefix$path'"
+msgstr ""
+
+#: git-submodule.sh:324
+#, sh-format
+msgid "Stopping at '$path'; script returned non-zero status."
+msgstr ""
+
+#: git-submodule.sh:367
+#, sh-format
+msgid "No url found for submodule path '$path' in .gitmodules"
+msgstr ""
+
+#: git-submodule.sh:377
+#, sh-format
+msgid "Failed to register url for submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:382
+#, sh-format
+msgid "Failed to register update mode for submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:384
+#, sh-format
+msgid "Submodule '$name' ($url) registered for path '$path'"
+msgstr ""
+
+#: git-submodule.sh:467
+#, sh-format
+msgid ""
+"Submodule path '$path' not initialized\n"
+"Maybe you want to use 'update --init'?"
+msgstr ""
+
+#: git-submodule.sh:480
+#, sh-format
+msgid "Unable to find current revision in submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:504
+#, sh-format
+msgid "Unable to fetch in submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:517
+#, sh-format
+msgid "Unable to rebase '$sha1' in submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:518
+#, sh-format
+msgid "Submodule path '$path': rebased into '$sha1'"
+msgstr ""
+
+#: git-submodule.sh:522
+#, sh-format
+msgid "Unable to merge '$sha1' in submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:523
+#, sh-format
+msgid "Submodule path '$path': merged in '$sha1'"
+msgstr ""
+
+#: git-submodule.sh:527
+#, sh-format
+msgid "Unable to checkout '$sha1' in submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:528
+#, sh-format
+msgid "Submodule path '$path': checked out '$sha1'"
+msgstr ""
+
+#: git-submodule.sh:539 git-submodule.sh:841
+#, sh-format
+msgid "Failed to recurse into submodule path '$path'"
+msgstr ""
+
+#: git-submodule.sh:623
+msgid "--"
+msgstr ""
+
+#. unexpected type
+#: git-submodule.sh:664
+#, sh-format
+msgid "unexpected mode $mod_dst"
+msgstr ""
+
+#: git-submodule.sh:684
+#, sh-format
+msgid "  Warn: $name doesn't contain commit $sha1_src"
+msgstr ""
+
+#: git-submodule.sh:687
+#, sh-format
+msgid "  Warn: $name doesn't contain commit $sha1_dst"
+msgstr ""
+
+#: git-submodule.sh:690
+#, sh-format
+msgid "  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
+msgstr ""
+
+#: git-submodule.sh:715
+msgid "blob"
+msgstr ""
+
+#: git-submodule.sh:716
+msgid "submodule"
+msgstr ""
+
+#: git-submodule.sh:753
+msgid "# Submodules changed but not updated:"
+msgstr ""
+
+#: git-submodule.sh:755
+msgid "# Submodule changes to be committed:"
+msgstr ""
+
+#: git-submodule.sh:885
+#, sh-format
+msgid "Synchronizing submodule url for '$name'"
+msgstr ""
+
+#~ msgid "See 'git help COMMAND' for more information on a specific co=
mmand."
+#~ msgstr "Sj=C3=A1 'git help SKIPUN' til a=C3=B0 sj=C3=A1 hj=C3=A1lp =
fyrir tiltekna skipun."
+
+#~ msgid "TEST: A C test string"
+#~ msgstr "TILRAUN: C tilraunastrengur"
+
+#~ msgid "TEST: A C test string %s"
+#~ msgstr "TILRAUN: C tilraunastrengur %s"
+
+#~ msgid "TEST: A Shell test string"
+#~ msgstr "TILRAUN: Skeljartilraunastrengur"
+
+#~ msgid "TEST: A Shell test $variable"
+#~ msgstr "TILRAUN: Skeljartilraunastrengur me=C3=B0 breytunni $variab=
le"
+
+#~ msgid "TEST: A Perl test string"
+#~ msgstr "TILRAUN: Perl tilraunastrengur"
+
+#~ msgid "TEST: A Perl test variable %s"
+#~ msgstr "TILRAUN: Perl tilraunastrengur me=C3=B0 breytunni %s"
--=20
1.7.6.3
