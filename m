From: "=?UTF-8?q?W=C5=82odzimierz=20Gajda?=" <wlodzimierz.gajda@gmail.com>
Subject: [PATCH] Documentation/git-clean.txt: fix -f, -x
Date: Wed,  2 Oct 2013 07:32:20 +0000
Message-ID: <1380699140-3548-1-git-send-email-gajdaw@gajdaw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?W=C5=82odzimierz=20Gajda?= <gajdaw@gajdaw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 02 09:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRGvA-00086v-E1
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 09:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab3JBHc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Oct 2013 03:32:29 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33703 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3JBHc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 03:32:28 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so413762wgh.26
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Ghmp6w6GkFkVix5KXnZaQHsZBFmbCKBG8uNUaHmcGy8=;
        b=UF9jjJIvFzf9ON7ZvoEGj6PVzmeDmCqtfdoo55goirrl3qaQ2fe2HZMyDzPGcI2Pua
         Fl9+m6za+sem0Y2ceRmThslXFJbj/3LMfeQWsdf1/qef0RRk/wPWazi6oIHP6ArepnyM
         driIW4fD59VUXRsFkCFNfGUypoSVg2TzIGE06MR9pZ44AkQpx98vetObrFjdWSm6oNoO
         Kl1EcZADcPIt1ay4Bv8DsgGobYx64kHSsJpT3cls9jP1voS2UG8UJUdR97Xst0ptp87t
         6Ix/Sfm4ln1cZT1PH4lqBhUYHIv2k2REjgumRtFN82HXOrz6whgsD/k2Dk620WXVCBkK
         uamg==
X-Received: by 10.194.2.108 with SMTP id 12mr98033wjt.64.1380699146599;
        Wed, 02 Oct 2013 00:32:26 -0700 (PDT)
Received: from localhost ([212.182.35.36])
        by mx.google.com with ESMTPSA id c4sm650605wiz.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 02 Oct 2013 00:32:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235665>

Change -f into `-f`, -x into `-x`, etc.

Signed-off-by: W=C5=82odzimierz Gajda <gajdaw@gajdaw.pl>
---
 Documentation/git-clean.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 8997922..b8d3486 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Cleans the working tree by recursively removing files that are not
 under version control, starting from the current directory.
=20
-Normally, only files unknown to Git are removed, but if the '-x'
+Normally, only files unknown to Git are removed, but if the `-x`
 option is specified, ignored files are also removed. This can, for
 example, be useful to remove all build products.
=20
@@ -28,14 +28,14 @@ OPTIONS
 -d::
 	Remove untracked directories in addition to untracked files.
 	If an untracked directory is managed by a different Git
-	repository, it is not removed by default.  Use -f option twice
+	repository, it is not removed by default.  Use `-f` option twice
 	if you really want to remove such a directory.
=20
 -f::
 --force::
-	If the Git configuration variable clean.requireForce is not set
-	to false, 'git clean' will refuse to run unless given -f, -n or
-	-i.
+	If the Git configuration variable `clean.requireForce` is not set
+	to false, `git clean` will refuse to run unless given `-f`, `-n` or
+	`-i`.
=20
 -i::
 --interactive::
@@ -53,16 +53,16 @@ OPTIONS
=20
 -e <pattern>::
 --exclude=3D<pattern>::
-	In addition to those found in .gitignore (per directory) and
-	$GIT_DIR/info/exclude, also consider these patterns to be in the
+	In addition to those found in `.gitignore` (per directory) and
+	`$GIT_DIR/info/exclude`, also consider these patterns to be in the
 	set of the ignore rules in effect.
=20
 -x::
-	Don't use the standard ignore rules read from .gitignore (per
-	directory) and $GIT_DIR/info/exclude, but do still use the ignore
+	Don't use the standard ignore rules read from `.gitignore` (per
+	directory) and `$GIT_DIR/info/exclude`, but do still use the ignore
 	rules given with `-e` options.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
-	conjunction with 'git reset') to create a pristine
+	conjunction with `git reset`) to create a pristine
 	working directory to test a clean build.
=20
 -X::
--=20
1.8.3.msysgit.0
