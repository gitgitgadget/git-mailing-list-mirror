From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 3/3] Testing: XDG config files: Trivial: `xdg' -> `XDG'
Date: Tue, 17 Jul 2012 16:41:22 -0000
Message-ID: <a4dd97acf90340c1b07e52a20c33c594-mfwitten@gmail.com>
References: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
Cc: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:47:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrBsH-0004lP-El
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 19:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968Ab2GQRrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 13:47:49 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:49830 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2GQRrs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 13:47:48 -0400
Received: by weyx8 with SMTP id x8so439551wey.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=GSlsfatSxbzkRQzoiDR4nXACKPccBgO6MKAAGpUTLds=;
        b=UAWl7epW1AbW5cs4WG5/2nZL2+Lx8bB+8P2KK9Zn6A0P7ct4ujmi2lbHhmOVA1Idb6
         U7+WYDFaDxcL3iQ22YFWHhgMBTOUSZpejz1EbjLtbNuEdsnXsv6o7AaPGtfJLGEcDxt9
         7vUXYHAlSvlUr6sW7KFJ86ISPSpQnRzilrpyqq5ydRhI4a3k9mLuTKnfw14sep1Eipt9
         a4KSWEWyaC72LBgs48c+aLMFCKpTzUVbOaW7SSiAQNtiioP0BKxl3IxA3GTo17OZ+ly6
         GcrL7lozmE1uhQbxL3ejN039zbjDHfGhqW2ZostxbyyidJ4I6j32XPDQ2giJWQONOwWa
         JPOw==
Received: by 10.216.134.101 with SMTP id r79mr1858867wei.60.1342547266749;
        Tue, 17 Jul 2012 10:47:46 -0700 (PDT)
Received: from gmail.com (saito.countshockula.com. [65.183.151.13])
        by mx.google.com with ESMTPS id eu4sm28035560wib.2.2012.07.17.10.47.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 10:47:46 -0700 (PDT)
In-Reply-To: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201613>

For the sake of consistency and correctness, the acronymn `xdg'
has been capitalized (`XDG').

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 t/t1306-xdg-files.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 2327047..6a3ab09 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -11,7 +11,7 @@
 
 GIT_CONFIG_DIR=$XDG_CONFIG_HOME/git
 
-test_expect_success 'read config: xdg file exists and "$HOME"/.gitconfig doesn'\''t' '
+test_expect_success 'read config: XDG file exists and "$HOME"/.gitconfig doesn'\''t' '
 	mkdir -p "$GIT_CONFIG_DIR" &&
 	echo "[alias]" >"$GIT_CONFIG_DIR"/config &&
 	echo "	myalias = !echo in_config" >>"$GIT_CONFIG_DIR"/config &&
@@ -21,7 +21,7 @@
 '
 
 
-test_expect_success 'read config: xdg file exists and "$HOME"/.gitconfig exists' '
+test_expect_success 'read config: XDG file exists and "$HOME"/.gitconfig exists' '
 	>"$HOME"/.gitconfig &&
 	echo "[alias]" >"$HOME"/.gitconfig &&
 	echo "	myalias = !echo in_gitconfig" >>"$HOME"/.gitconfig &&
@@ -31,7 +31,7 @@
 '
 
 
-test_expect_success 'read with --get: xdg file exists and "$HOME"/.gitconfig doesn'\''t' '
+test_expect_success 'read with --get: XDG file exists and "$HOME"/.gitconfig doesn'\''t' '
 	rm "$HOME"/.gitconfig &&
 	echo "[user]" >"$GIT_CONFIG_DIR"/config &&
 	echo "	name = read_config" >>"$GIT_CONFIG_DIR"/config &&
@@ -41,7 +41,7 @@
 '
 
 
-test_expect_success 'read with --get: xdg file exists and "$HOME"/.gitconfig exists' '
+test_expect_success 'read with --get: XDG file exists and "$HOME"/.gitconfig exists' '
 	>"$HOME"/.gitconfig &&
 	echo "[user]" >"$HOME"/.gitconfig &&
 	echo "	name = read_gitconfig" >>"$HOME"/.gitconfig &&
@@ -51,7 +51,7 @@
 '
 
 
-test_expect_success 'read with --list: xdg file exists and "$HOME"/.gitconfig doesn'\''t' '
+test_expect_success 'read with --list: XDG file exists and "$HOME"/.gitconfig doesn'\''t' '
 	rm "$HOME"/.gitconfig &&
 	echo user.name=read_config >expected &&
 	git config --global --list >actual &&
@@ -59,7 +59,7 @@
 '
 
 
-test_expect_success 'read with --list: xdg file exists and "$HOME"/.gitconfig exists' '
+test_expect_success 'read with --list: XDG file exists and "$HOME"/.gitconfig exists' '
 	>"$HOME"/.gitconfig &&
 	echo "[user]" >"$HOME"/.gitconfig &&
 	echo "	name = read_gitconfig" >>"$HOME"/.gitconfig &&
@@ -127,7 +127,7 @@
 '
 
 
-test_expect_success 'write: xdg file exists and "$HOME"/.gitconfig doesn'\''t' '
+test_expect_success 'write: XDG file exists and "$HOME"/.gitconfig doesn'\''t' '
 	mkdir -p "$GIT_CONFIG_DIR" &&
 	>"$GIT_CONFIG_DIR"/config &&
 	test_might_fail rm "$HOME"/.gitconfig &&
@@ -138,7 +138,7 @@
 '
 
 
-test_expect_success 'write: xdg file exists and "$HOME"/.gitconfig exists' '
+test_expect_success 'write: XDG file exists and "$HOME"/.gitconfig exists' '
 	>"$HOME"/.gitconfig &&
 	git config --global user.name "write_gitconfig" &&
 	echo "[user]" >expected &&
-- 
1.7.11.1.29.gf71be5c
