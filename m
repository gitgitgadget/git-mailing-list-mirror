From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 3/4] githooks.txt: Minor improvements to the grammar & phrasing
Date: Tue, 26 Apr 2016 18:13:21 +0000
Message-ID: <1461694402-9629-4-git-send-email-avarab@gmail.com>
References: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:14:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7VA-0006un-FP
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbcDZSOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 14:14:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34533 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbcDZSOT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:14:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id n3so7386945wmn.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Io3Ma93AmJzv+zsd8N9qPgM8hH9RHU6ZpWIGVStfJY=;
        b=UX4jQG23V+Y3zdLDg9FL25nWrlVo+iayNld0dOTqZdwIdBUYiYZfgnOaudvZG1BWxW
         QE/QNY/MrGRm+sW25PC3+1hi5JcmYTclsVMwfu9hgaGuJeGGVC0LpDNfdvdRuwUU5DW4
         7d2xbI/N4rNsj/0XjrEsDOO+L8ulvME5obwFx39VBYl1jtUn2+DtDfm0KxmSq0qXAoT5
         xVkUL9yNBhWN48aSwPVwej+qNGeDjTE6dcaWSKzwiNdReiRB0QM4SvM/k3vp1/e48w3p
         ZhsugZL4EgH2f+8s8OyxNp6Qrh2DgPtVVC79vlOpCfM6pRsl5p66JEiH+bsNg4holpeg
         fA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Io3Ma93AmJzv+zsd8N9qPgM8hH9RHU6ZpWIGVStfJY=;
        b=fAxrlHr4XovDlU9G8mV4GXS9kAojWtL7q3VqfxgR+Zve85i49EwR/BNprCGqr6pMuP
         aYmeWnuWUEytjogTnwZdhn2xJrRURQmh3izjQQ2P2+JbgmfC5IPalFdY3xGQiUlr0DM5
         5ZUHXanqQdpWlCa9MsrU2RR8lXUx5xrsy/pzGdyVS0Cqseahjx1pWSIacYgPs0QJ29Qz
         cz8qdBo5A7OWQYjqsGcS5HbAJ2osoKFQSSoK/HLV3ixoPjQclY31uLL+gjj7MEn8PPWr
         IUMdSxKoupYDMsyuq5/AVgnPXvxStG/TMJUq5pBpJHDaziMxqo9Yx/lZ2zVEOADHy8pB
         dUOQ==
X-Gm-Message-State: AOPr4FWh2XW28xYPI+8oP1ikMTr8ZoXonprEP9qINiFxEPdx7rrHYJVOdJ9IEa2mBXLZDw==
X-Received: by 10.28.0.87 with SMTP id 84mr18928669wma.68.1461694457960;
        Tue, 26 Apr 2016 11:14:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h8sm4392371wmd.2.2016.04.26.11.14.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2016 11:14:17 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292638>

Change:

 * Sentences that needed "the" or "a" to either add those or change the=
m
   so they don't need them.

 * The little tangent about "You can use this to do X (if your project
   wants to do X)" can just be shortened to "e.g. if you want to do X".

 * s/parameter/parameters/ when the plural made more sense.

Most of this goes all the way back to the initial introduction of
hooks.txt in v0.99.5-76-g6d35cc7 by Junio.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/githooks.txt | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9051584..a214284 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -40,15 +40,15 @@ HOOKS
 applypatch-msg
 ~~~~~~~~~~~~~~
=20
-This hook is invoked by 'git am' script.  It takes a single
+This hook is invoked by 'git am'.  It takes a single
 parameter, the name of the file that holds the proposed commit
-log message.  Exiting with non-zero status causes
-'git am' to abort before applying the patch.
+log message.  Exiting with a non-zero status causes 'git am' to abort
+before applying the patch.
=20
 The hook is allowed to edit the message file in place, and can
 be used to normalize the message into some project standard
-format (if the project has one). It can also be used to refuse
-the commit after inspecting the message file.
+format. It can also be used to refuse the commit after inspecting
+the message file.
=20
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
@@ -81,10 +81,10 @@ pre-commit
 ~~~~~~~~~~
=20
 This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes no parameter, and is
+with the `--no-verify` option.  It takes no parameters, and is
 invoked before obtaining the proposed commit log message and
-making a commit.  Exiting with non-zero status from this script
-causes the 'git commit' to abort.
+making a commit.  Exiting with a non-zero status from this script
+causes the 'git commit' command to abort before creating a commit.
=20
 The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
@@ -123,15 +123,15 @@ commit-msg
 ~~~~~~~~~~
=20
 This hook is invoked by 'git commit', and can be bypassed
-with `--no-verify` option.  It takes a single parameter, the
+with the `--no-verify` option.  It takes a single parameter, the
 name of the file that holds the proposed commit log message.
-Exiting with non-zero status causes the 'git commit' to
+Exiting with a non-zero status causes the 'git commit' to
 abort.
=20
-The hook is allowed to edit the message file in place, and can
-be used to normalize the message into some project standard
-format (if the project has one). It can also be used to refuse
-the commit after inspecting the message file.
+The hook is allowed to edit the message file in place, and can be used
+to normalize the message into some project standard format. It
+can also be used to refuse the commit after inspecting the message
+file.
=20
 The default 'commit-msg' hook, when enabled, detects duplicate
 "Signed-off-by" lines, and aborts the commit if one is found.
@@ -139,8 +139,8 @@ The default 'commit-msg' hook, when enabled, detect=
s duplicate
 post-commit
 ~~~~~~~~~~~
=20
-This hook is invoked by 'git commit'.  It takes no
-parameter, and is invoked after a commit is made.
+This hook is invoked by 'git commit'. It takes no parameters, and is
+invoked after a commit is made.
=20
 This hook is meant primarily for notification, and cannot affect
 the outcome of 'git commit'.
--=20
2.1.3
