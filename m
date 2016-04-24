From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/3] githooks.txt: Minor improvements to the grammar & phrasing
Date: Sun, 24 Apr 2016 20:20:29 +0000
Message-ID: <1461529229-15222-3-git-send-email-avarab@gmail.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:20:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auQWM-00079t-FA
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 22:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbcDXUUl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 16:20:41 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38478 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbcDXUUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 16:20:39 -0400
Received: by mail-wm0-f54.google.com with SMTP id u206so98703909wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nh6ouOWPqCqLQI6K+YA7RQa/C6W4E3g3SuFgXkLJFQc=;
        b=BWLIl4mCJVF/UXmrTelcuL8ad8pUiGlJc/PAkUXXo4yw3VjB331D/OXjCRpfjKphTD
         UnhDluKvhbm/BHY6gkzRrCJIwHset4Kif6Oj2ubDNN7/hHGFrmrAuWFziDnLeRpmZ7TK
         hEZ0SKnI374PPqWhl1MK2GWY2iTS8vbZiPDsjRIJUSp36pJh3FFgspqZxQyirHhxfgy4
         PWSSvI1Gy7e7tiuZ4nTB++w045NC++f19Sp1nx77/jag8+ivIx3yaG78rCe3x9cgYss1
         cMQ1y+P9AlFNkNkoadVxD0pof9c/sEqvKNCm8QgI4/AbndM/ZdsT7I0SxveykWayiAvG
         b7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nh6ouOWPqCqLQI6K+YA7RQa/C6W4E3g3SuFgXkLJFQc=;
        b=GCfyyHhgkrnBUI+RWkwbjFe66McRBrjoaz/HQdGJF/G+6WxKyJQmqlT9ucWz63CnNk
         +/17gDCplweediJVydR/5e403oWyErmUpJautxAgDoD3mRN3cHhAya7J49BSstYf33wt
         RG9+m3Rw4XsgY4GpSf0UtlB7J7NH6Oswp+FKZCix23Y2+VM21EV+g4O3PPGsketPu+o0
         6GplwXrIcMsyye7yEEVDmoEzvcetG4dytpmpN9UT8Uty9jneKhuZaGoD2uJjx7C1AYzB
         c8RlSAZjUW6OF/7d8jED7Zy8pLing/HCbyKn+V3rVA/FCH+AV06Oobmcm/Qxpv1u/Et0
         eDIg==
X-Gm-Message-State: AOPr4FXT4p/sbXaiFAtlHJ9/6jrUR/4eoRzhzfOFepDqwxo1MboWbSOCdghLazy3JJkYkA==
X-Received: by 10.194.234.101 with SMTP id ud5mr29874828wjc.34.1461529238111;
        Sun, 24 Apr 2016 13:20:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m20sm15233040wma.23.2016.04.24.13.20.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Apr 2016 13:20:37 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461529229-15222-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292440>

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
 Documentation/githooks.txt | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index e9d169e..d30492c 100644
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
+log message.  Exiting with non-zero causes 'git am' to abort
+before applying the patch.
=20
 The hook is allowed to edit the message file in place, and can
-be used to normalize the message into some project standard
-format (if the project has one). It can also be used to refuse
-the commit after inspecting the message file.
+be used to e.g. normalize the message into some project standard
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
+to e.g. normalize the message into some project standard format. It
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
