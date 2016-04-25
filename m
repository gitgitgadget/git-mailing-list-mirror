From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 3/3] githooks.txt: Minor improvements to the grammar & phrasing
Date: Mon, 25 Apr 2016 14:14:25 +0000
Message-ID: <1461593665-31395-4-git-send-email-avarab@gmail.com>
References: <1461593665-31395-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 16:15:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auhI1-00085C-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 16:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbcDYOO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 10:14:57 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38830 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbcDYOO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 10:14:56 -0400
Received: by mail-wm0-f45.google.com with SMTP id u206so129747350wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nlaqa+ud5QIMvdaY18bSsg2i8kC8LtoxQpM497cdX7w=;
        b=GbG5jMsrUf/ZXjhuZnr011IPfrYIv7rUyJjWdpfhdtjTc+NSc40lG6atufhlnTROOV
         yp5YGUQvLy6wJIMo6Ftlsj2CozKeymVXsH5Gev/RKZMJQjQiF2ob/6rYYdeME9y6RIfu
         sui00II+M8Z4VWyLxbmrvUZH0ovijQfL+RszrihVB5vD5FpjTn4OosD9y5IBL04lzaS4
         uDNEJBonHXp9EurC3UBbn9hladLGSKlViVhQ0jS55rnixuYwjXG5y5anc7Rc8YsUEG6O
         /Myw7uhbSkueydTba3t5i0D6AscaoVyLq6WYMm+6ZBEDHOv0Fq8+GbAtRDeRjk0pIb25
         hCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nlaqa+ud5QIMvdaY18bSsg2i8kC8LtoxQpM497cdX7w=;
        b=bzbKKCic56vsZjJjGtxwHzGvrJcJuh9AhG20beHVmgLSqA6SQeKgWTNN7ojWsm0j5p
         mlOr1cMGWoDgpP+xlUK7fYp4OBZKD8yoHaW1EXf6mBjtGD63ODLhPZbZljmKgKI5FNrg
         +Q1WwLWncsM6CpUvaSqIwN045sBa5zALySMRQrYW4tMNh84S9lC3NRYR/tGTlIleeGre
         yj/fKfnjYV/RK7+DnnrKnirmPanvyhD99mBVB329xORLeFwr6WNAlpB/Qugcf9oK6CZl
         1iiEd5tXXF6J3BmGYztM09B7cef5hJ4wSBQDAOBFmW/64cDYigL3MSzOwKKMt3kFLDmN
         1R+Q==
X-Gm-Message-State: AOPr4FW+kYxq+nPs65FPWBKJEpdrFWWMWOZg+XPAN45ts5tL5xOQCKdQypf7jQUpKYRcYg==
X-Received: by 10.28.184.22 with SMTP id i22mr12572621wmf.41.1461593689540;
        Mon, 25 Apr 2016 07:14:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d1sm23768565wjb.47.2016.04.25.07.14.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 07:14:48 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461593665-31395-1-git-send-email-avarab@gmail.com>
In-Reply-To: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
References: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292484>

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
index 38bea7d..339e9ca 100644
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
