From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Additional white space fixes
Date: Fri, 8 Jun 2007 18:54:35 +0200
Message-ID: <e5bfff550706080954h88b6196u7d8a640206c8b07d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 18:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwhjo-0006wC-00
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 18:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969353AbXFHQyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 12:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969254AbXFHQyi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 12:54:38 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:49857 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S969219AbXFHQyg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 12:54:36 -0400
Received: by nz-out-0506.google.com with SMTP id n1so793982nzf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 09:54:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bMTUQ5V10+zGquBgGJOQKqymfhyCBjfuFjwcuot6/qZdU+59wPPpkBR6CylBgjgV9PqCYO8hm0aSTnfFANY+GlqHsMFJgXeVpLLcPdY8P8jhm8sgy0N4OAHV+8gkj5mtMMSeo4aoRCT60TxSc+7hi3KJHdhVFbTLxf0eDGJ5bRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oqVqS8f5qNzjmWi3I+NZ1Nujqx/lXYO19SSru9A6v3bIwCcEtr2plVZMhiCzrJL40Z7yCkTvQwjF4r14AyeAE7KgURUTLTO1/p5OFo2oL1iEBgIZ3ddaYc9eLHlvy4i9sqI4RkSP+hblpcLalmrq8+coTLbcsxZLCYHsdphgzHo=
Received: by 10.114.175.16 with SMTP id x16mr2817828wae.1181321675367;
        Fri, 08 Jun 2007 09:54:35 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Fri, 8 Jun 2007 09:54:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49485>

Some white space breakage survived after "git-apply --whitespace=strip".

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 builtin-pack-objects.c |    2 +-
 builtin-tar-tree.c     |    2 +-
 diff.h                 |    2 +-
 git-clean.sh           |    2 +-
 git-svn.perl           |    2 +-
 git.c                  |    2 +-
 gitweb/gitweb.perl     |    6 +++---
 read-cache.c           |    4 ++--
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3d396ca..5601ac3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -28,7 +28,7 @@ struct object_entry {

 	unsigned int hash;	/* name hint hash */
 	unsigned int depth;	/* delta depth */
-	struct packed_git *in_pack; 	/* already in pack */
+	struct packed_git *in_pack;	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
 	struct object_entry *delta_child; /* deltified objects who bases me */
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index b04719e..8861a29 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -21,7 +21,7 @@ int cmd_tar_tree(int argc, const char **
 	 * $0 tree-ish ==>
 	 *	git-archive --format=tar tree-ish
 	 * $0 tree-ish basedir ==>
-	 * 	git-archive --format-tar --prefix=basedir tree-ish
+	 *	git-archive --format-tar --prefix=basedir tree-ish
 	 */
 	int i;
 	const char **nargv = xcalloc(sizeof(*nargv), argc + 2);
diff --git a/diff.h b/diff.h
index a7ee6d8..0e8b84f 100644
--- a/diff.h
+++ b/diff.h
@@ -155,7 +155,7 @@ extern void diff_unmerge(struct diff
 			 unsigned mode,
 			 const unsigned char *sha1);

-#define DIFF_SETUP_REVERSE      	1
+#define DIFF_SETUP_REVERSE		1
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4

diff --git a/git-clean.sh b/git-clean.sh
index 299309d..538d2f6 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -7,7 +7,7 @@ USAGE="[-d] [-f] [-n] [-q] [-x | -X] [--]
 LONG_USAGE='Clean untracked files from the working directory
 	-d	remove directories as well
 	-f	override clean.requireForce and clean anyway
-	-n 	don'\''t remove anything, just show what would be done
+	-n	don'\''t remove anything, just show what would be done
 	-q	be quiet, only report errors
 	-x	remove ignored files as well
 	-X	remove only ignored files
diff --git a/git-svn.perl b/git-svn.perl
index e350061..29b762b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4012,7 +4012,7 @@ diff-index line ($m hash)
 $l_map = {
 	# repository root url
 	'https://svn.musicpd.org' => {
-		# repository path 		# GIT_SVN_ID
+		# repository path		# GIT_SVN_ID
 		'mpd/trunk'		=>	'trunk',
 		'mpd/tags/0.11.5'	=>	'tags/0.11.5',
 	},
diff --git a/git.c b/git.c
index 29b55a1..99be8c5 100644
--- a/git.c
+++ b/git.c
@@ -214,7 +214,7 @@ const char git_version_string[]
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NOT_BARE 	(1<<2)
+#define NOT_BARE	(1<<2)

 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e92596c..82af59d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -105,9 +105,9 @@ our $fallback_encoding = 'latin1';
 # $GITWEB_CONFIG as necessary.
 our %feature = (
 	# feature => {
-	# 	'sub' => feature-sub (subroutine),
-	# 	'override' => allow-override (boolean),
-	# 	'default' => [ default options...] (array reference)}
+	#	'sub' => feature-sub (subroutine),
+	#	'override' => allow-override (boolean),
+	#	'default' => [ default options...] (array reference)}
 	#
 	# if feature is overridable (it means that allow-override has true value),
 	# then feature-sub will be called with default options as parameters;
diff --git a/read-cache.c b/read-cache.c
index 4362b11..6009293 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -208,9 +208,9 @@ int ie_match_stat(struct index_state *istate,

 	/*
 	 * Within 1 second of this sequence:
-	 * 	echo xyzzy >file && git-update-index --add file
+	 *	echo xyzzy >file && git-update-index --add file
 	 * running this command:
-	 * 	echo frotz >file
+	 *	echo frotz >file
 	 * would give a falsely clean cache entry.  The mtime and
 	 * length match the cache, and other stat fields do not change.
 	 *
-- 
1.5.2.GIT
