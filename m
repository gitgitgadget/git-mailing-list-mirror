From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH 4/4] [trivial] Fix spelling typo in contrib
Date: Wed, 13 Nov 2013 00:17:45 +0900
Message-ID: <1384269465-23352-4-git-send-email-standby24x7@gmail.com>
References: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
Cc: Masanari Iida <standby24x7@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 16:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgFjV-0002MN-0r
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 16:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab3KLPSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 10:18:18 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55986 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3KLPSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 10:18:16 -0500
Received: by mail-pa0-f49.google.com with SMTP id lf10so1955140pab.36
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ipOsEuMmUIs6BkzsIW7YAJDY1DpOkBKLoWUqZ7KmiD8=;
        b=PxMKrEWmI1B1ExbX/LG0IWA30SYYFHkfSqUSRHnvb2TzWgfW6KdWb+sX2xyr8JUcmM
         O33lWgs4Wkw49Z84iGBDcGdinnwYDZOM1YXYzPYFpBy/kMJBQZbmHvOEm1cbqizqAPWE
         oor407QYAGdguW4j/53fuUTytk4a4bpShlAdl/7M5gqAoNx1ayq//elubK6n6IRu+kV2
         Sr1ovVRBC/QPEYT7EaE8nUX4q4PQqHjb2Ov1GMmQLvlG6ba+HOsYqi9dIjwsAz8PY11o
         si9GmyDar9CobBSieQrNjo1XBvPZ6CWSTxJIV8ZVM7Z+uztwm/Ht2t5z8jZunsZR+SL/
         MZtA==
X-Received: by 10.68.215.4 with SMTP id oe4mr2239368pbc.198.1384269495137;
        Tue, 12 Nov 2013 07:18:15 -0800 (PST)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by mx.google.com with ESMTPSA id iu7sm38133081pbc.45.2013.11.12.07.18.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 07:18:13 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
	id 1884564948; Wed, 13 Nov 2013 00:18:10 +0900 (JST)
X-Mailer: git-send-email 1.8.5.rc1.17.g0ecd94d
In-Reply-To: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237713>

Correct spelling typo in contrib

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 contrib/gitview/gitview                     | 2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl | 2 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh       | 2 +-
 contrib/mw-to-git/t/test.config             | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 4c99dfb..4e23c65 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -1205,7 +1205,7 @@ class GitView(object):
 
 		#The first parent always continue on the same line
 		try:
-			# check we alreay have the value
+			# check we already have the value
 			tmp_node_pos = self.nodepos[commit.parent_sha1[0]]
 		except KeyError:
 			self.colours[commit.parent_sha1[0]] = colour
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 476e0a2..3f8d993 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1315,7 +1315,7 @@ sub get_mw_namespace_id {
 	# Store "notANameSpace" as special value for inexisting namespaces
 	my $store_id = ($id || 'notANameSpace');
 
-	# Store explicitely requested namespaces on disk
+	# Store explicitly requested namespaces on disk
 	if (!exists $cached_mw_namespace_id{$name}) {
 		run_git(qq(config --add remote.${remotename}.namespaceCache "${name}:${store_id}"));
 		$cached_mw_namespace_id{$name} = 1;
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index ca6860f..3372b2a 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -91,7 +91,7 @@ test_diff_directories () {
 # Check that <dir> contains exactly <N> files
 test_contains_N_files () {
 	if test `ls -- "$1" | wc -l` -ne "$2"; then
-		echo "directory $1 sould contain $2 files"
+		echo "directory $1 should contain $2 files"
 		echo "it contains these files:"
 		ls "$1"
 		false
diff --git a/contrib/mw-to-git/t/test.config b/contrib/mw-to-git/t/test.config
index 4cfebe9..5ba0684 100644
--- a/contrib/mw-to-git/t/test.config
+++ b/contrib/mw-to-git/t/test.config
@@ -12,7 +12,7 @@ SERVER_ADDR=localhost
 TMP=/tmp
 DB_FILE=wikidb.sqlite
 
-# If LIGHTTPD is not set to true, the script will use the defaut
+# If LIGHTTPD is not set to true, the script will use the default
 # web server running in WIKI_DIR_INST.
 WIKI_DIR_INST=/var/www
 
-- 
1.8.5.rc1.17.g0ecd94d
