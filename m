From: "Alexey Mahotkin" <squadette@gmail.com>
Subject: [PATCH] alphabetize LIB_OBJS
Date: Fri, 21 Sep 2007 01:09:35 +0400
Message-ID: <bb5b640b0709201409j11e3f4d4l11238ea00457bbfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 23:10:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTHv-0007M6-Dw
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbXITVJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbXITVJl
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:09:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:24085 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbXITVJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:09:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so581871nfb
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=wyMT3EkwJL7kY/nDwJzPm00CJCVEh3evyfjhpO8UA0Y=;
        b=DMo+C4fNPVK6IXieuZouPcl+tXJ2tU/fgNGat56XTs6ht2qxwdO5IDqdqePk7+jDus2c4wakeCZF/5WGF97l/6Wd4Crb2jMlxVOE9fVMbCVojWY8WMznkXdivaviUw7mHxh+JyEPRohTICXu4pFbhB4E7camZTSdUCJI43lak54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ML9KXsnpRA4LaLTXpnRs7Crt1IgFkV2QYPBrvBiYuZtEpEn16whQIHqsk7M356E6s1hM7e5DshOqq8rKFEMEKNdorHhHF0h6JIV4TwULpWcw8JZKx8X328/NeykkB3lZKEZCIZ5+650zBAd8XUDIlxXLVfRZJSeZkOP6/lzsLDE=
Received: by 10.86.63.19 with SMTP id l19mr1513851fga.1190322576092;
        Thu, 20 Sep 2007 14:09:36 -0700 (PDT)
Received: by 10.86.66.18 with HTTP; Thu, 20 Sep 2007 14:09:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58804>

I often have to build new Gits on slow machines.  Alphabetized list of
objects allows to estimate time to build completion.

Please apply.

Thank you,

diff --git a/Makefile b/Makefile
index 0055eef..4d3eef0 100644
--- a/Makefile
+++ b/Makefile
@@ -299,21 +299,27 @@ DIFF_OBJS = \
 	diffcore-delta.o log-tree.o

 LIB_OBJS = \
-	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
-	date.o diff-delta.o entry.o exec_cmd.o ident.o \
-	interpolate.o \
-	lockfile.o \
-	patch-ids.o \
-	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
-	sideband.o reachable.o reflog-walk.o \
-	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
-	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
-	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
-	revision.o pager.o tree-walk.o xdiff-interface.o \
-	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
-	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
-	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o
+	alloc.o archive-zip.o archive-tar.o attr.o \
+	base85.o blob.o \
+	cache-tree.o color.o commit.o config.o connect.o convert.o
csum-file.o ctype.o copy.o \
+	date.o decorate.o diff-delta.o dir.o \
+	entry.o environment.o exec_cmd.o \
+	grep.o \
+	help.o \
+	ident.o interpolate.o \
+	list-objects.o lockfile.o \
+	mailmap.o match-trees.o merge-file.o \
+	object.o object-refs.o \
+	pack-check.o pack-write.o pager.o patch-delta.o patch-ids.o path.o
path-list.o pkt-line.o progress.o \
+	quote.o \
+	reachable.o read-cache.o reflog-walk.o refs.o remote.o revision.o
run-command.o \
+	server-info.o setup.o sha1_file.o sha1_name.o shallow.o sideband.o
strbuf.o symlinks.o \
+	tag.o trace.o tree.o tree-walk.o \
+	usage.o \
+	write_or_die.o wt-status.o \
+	xdiff-interface.o \
+	unpack-trees.o utf8.o \
+	$(DIFF_OBJS)

 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -328,6 +334,7 @@ BUILTIN_OBJS = \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
 	builtin-commit-tree.o \
+	builtin-config.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
 	builtin-diff.o \
@@ -351,12 +358,12 @@ BUILTIN_OBJS = \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
+	builtin-pack-refs.o \
 	builtin-prune.o \
 	builtin-prune-packed.o \
 	builtin-push.o \
 	builtin-read-tree.o \
 	builtin-reflog.o \
-	builtin-config.o \
 	builtin-rerere.o \
 	builtin-reset.o \
 	builtin-rev-list.o \
@@ -366,6 +373,7 @@ BUILTIN_OBJS = \
 	builtin-runstatus.o \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
+	builtin-show-ref.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
 	builtin-tag.o \
@@ -376,9 +384,7 @@ BUILTIN_OBJS = \
 	builtin-upload-archive.o \
 	builtin-verify-pack.o \
 	builtin-verify-tag.o \
-	builtin-write-tree.o \
-	builtin-show-ref.o \
-	builtin-pack-refs.o
+	builtin-write-tree.o

 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =


-- 
Alexey Mahotkin
http://www.versioncontrolblog.com/
