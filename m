From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 6/6] Remove additional whitespace breakage
Date: Sun, 20 May 2007 12:30:37 +0200
Message-ID: <4650234D.1010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 12:31:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpigj-0006Nt-1X
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764742AbXETKap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764780AbXETKap
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:30:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:42525 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764519AbXETKam (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:30:42 -0400
Received: by ug-out-1314.google.com with SMTP id 44so893593uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 03:30:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=sW/9mLynd1H7uBn8hlujyXX7iKseCVIYCWRchSfEESVpEDvbt1FTSzxua26rWL9MPvLMQa/3Z8VWP1UHnPt61WBj4pDzQo3plgImsomsG0Pim1zbPurZHjwpbeqYCv3vdYZganokv8XpO+OQxam6tVdYV0wdLN0UKZCVaEa+X3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=mtmsEkNpUnLR3lnKLYkRULBVKc549cYA1+6iNJoDgt3Jln/NEDzQVDyEhFxBVe68saYILjoEyK3s3s0ST0LySXH/FR6vFcTLfyyayREML26ZB7OC2OpkfHhLv+uwG09/XjW1dmzpi3Cku6l0jZfmG2+/+OfC8HiY8bAIM98bFa8=
Received: by 10.66.224.3 with SMTP id w3mr2550800ugg.1179657041032;
        Sun, 20 May 2007 03:30:41 -0700 (PDT)
Received: from ?10.0.0.13? ( [151.70.107.76])
        by mx.google.com with ESMTP id s1sm3779519uge.2007.05.20.03.30.39;
        Sun, 20 May 2007 03:30:40 -0700 (PDT)
User-Agent: Thunderbird 2.0b2 (X11/20070313)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47820>

This time using nice clean.sh script from H. Peter Anvin

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
index 3ba1f09..dda7d2e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -28,7 +28,7 @@ struct object_entry {
  	unsigned long size;	/* uncompressed size */
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
@@ -21,7 +21,7 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
  	 * $0 tree-ish ==>
  	 *	git-archive --format=tar tree-ish
  	 * $0 tree-ish basedir ==>
-	 * 	git-archive --format-tar --prefix=basedir tree-ish
+	 *	git-archive --format-tar --prefix=basedir tree-ish
  	 */
  	int i;
  	const char **nargv = xcalloc(sizeof(*nargv), argc + 2);
diff --git a/diff.h b/diff.h
index 63738c1..f7e6377 100644
--- a/diff.h
+++ b/diff.h
@@ -157,7 +157,7 @@ extern void diff_unmerge(struct diff_options *,

  extern int diff_scoreopt_parse(const char *opt);

-#define DIFF_SETUP_REVERSE      	1
+#define DIFF_SETUP_REVERSE		1
  #define DIFF_SETUP_USE_CACHE		2
  #define DIFF_SETUP_USE_SIZE_CACHE	4

diff --git a/git-clean.sh b/git-clean.sh
index 299309d..538d2f6 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -7,7 +7,7 @@ USAGE="[-d] [-f] [-n] [-q] [-x | -X] [--] <paths>..."
  LONG_USAGE='Clean untracked files from the working directory
  	-d	remove directories as well
  	-f	override clean.requireForce and clean anyway
-	-n 	don'\''t remove anything, just show what would be done
+	-n	don'\''t remove anything, just show what would be done
  	-q	be quiet, only report errors
  	-x	remove ignored files as well
  	-X	remove only ignored files
diff --git a/git-svn.perl b/git-svn.perl
index eda9969..8ac39b2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4008,7 +4008,7 @@ diff-index line ($m hash)
  $l_map = {
  	# repository root url
  	'https://svn.musicpd.org' => {
-		# repository path 		# GIT_SVN_ID
+		# repository path		# GIT_SVN_ID
  		'mpd/trunk'		=>	'trunk',
  		'mpd/tags/0.11.5'	=>	'tags/0.11.5',
  	},
diff --git a/git.c b/git.c
index f200907..664a638 100644
--- a/git.c
+++ b/git.c
@@ -214,7 +214,7 @@ const char git_version_string[] = GIT_VERSION;
   * require working tree to be present -- anything uses this needs
   * RUN_SETUP for reading from the configuration file.
   */
-#define NOT_BARE 	(1<<2)
+#define NOT_BARE	(1<<2)

  static void handle_internal_command(int argc, const char **argv, char **envp)
  {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5c7011a..8226b48 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -98,9 +98,9 @@ our $mimetypes_file = undef;
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
index 0f0c827..922046f 100644
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
1.5.2.rc3.90.gf33e-dirty
