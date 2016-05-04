From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v6 3/4] githooks.txt: Minor improvements to the grammar & phrasing
Date: Wed,  4 May 2016 22:58:11 +0000
Message-ID: <1462402692-24712-4-git-send-email-avarab@gmail.com>
References: <xmqqa8k5eakb.fsf@gitster.mtv.corp.google.com>
 <1462402692-24712-1-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 05 00:58:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5kc-0002U0-6F
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbcEDW6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 18:58:35 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33050 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbcEDW6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:58:34 -0400
Received: by mail-wm0-f49.google.com with SMTP id g17so438371wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 15:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PeSH7k7zqZevajKMsWxUn9Kvz04GS7TbxxJ18oOUOA=;
        b=Mbb17orpHylCkqxQTPLINiph5Gvg1uIWA7VoCcJWvZacrB+OxuAV6IbDkCwYJhYZfN
         jTReXnXz71LCXSneklFjxIajpYraASly8lNgcqfHvOImk45UobIUCyO1gJYbRsO+4UpL
         lGbmNE4pPsoJhdwok8sN+RJRF1w09GbMSOuFbFvYau5GrbwyWCho1zHtiTXZLEAxcLXj
         8nxHQkGUAkupcEn0jq3n86sQkgrlVxO2q/F7PQi5HTRXGmM3fs0s+DFmPBL6OY83Ib5p
         nBhWBtAQRyIS6mXBLSlWUukoP2g4VONMbJN+rWXL9wpCAV7oN8IWCOUe1j56ybYl73L4
         ESdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PeSH7k7zqZevajKMsWxUn9Kvz04GS7TbxxJ18oOUOA=;
        b=jl1091/Aaepr+18IXuudjJquQhqBhOYGIvebGRIG0bh6xYH675R9u1AB/ycXFs11Sf
         Yfw6qUL+qOMG3PN3BY5OVfXjDyfvu2LfeKSdNgMGUENW+2wznBi0RlnZqwmiJCuKRxcS
         AVwL0pN+B433OTTwmW0Ql3+Z7fTUJEde9NJLm21FVF1pRf7y5nkvLsPfzg8gBAy00K8p
         cWIdt3Bs8HBAyxiGvxkSbIH4tZSNVUPcaq7BRSfTrksjR3JgIlOT3l6zmlwnYfvTi5xg
         gqES4Be/F/1dHQsTq+U0FFHxYDqFlcNinS9VPwS2WIEt2o5U42emW1SFlsJVuNhbCNzn
         RUWw==
X-Gm-Message-State: AOPr4FXZ2GHpPQVxQ3pbcLyPGkMJcpFqjp/nkNUGeTKSWgiP763SrYqKH9hcWqNmd6uh0A==
X-Received: by 10.194.118.5 with SMTP id ki5mr10759796wjb.138.1462402712304;
        Wed, 04 May 2016 15:58:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id us3sm6557967wjc.41.2016.05.04.15.58.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 15:58:31 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1462402692-24712-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293616>

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
index 0dd618a..3049574 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -39,15 +39,15 @@ HOOKS
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
@@ -80,10 +80,10 @@ pre-commit
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
@@ -122,15 +122,15 @@ commit-msg
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
@@ -138,8 +138,8 @@ The default 'commit-msg' hook, when enabled, detect=
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
