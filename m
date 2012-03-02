From: Jiang Xin <worldhello.net@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20Update=20l10n=20guide=3A=20change=20the=20repository=20URL=2C=20etc?=
Date: Fri,  2 Mar 2012 15:41:06 +0800
Message-ID: <1330674066-4490-1-git-send-email-worldhello.net@gmail.com>
References: <7vk434q4eg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 08:41:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3N7H-0005Id-4K
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 08:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245Ab2CBHlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 02:41:22 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60880 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab2CBHlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 02:41:21 -0500
Received: by pbcup15 with SMTP id up15so1851536pbc.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 23:41:21 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.68.134.234 as permitted sender) client-ip=10.68.134.234;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.68.134.234 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.68.134.234])
        by 10.68.134.234 with SMTP id pn10mr12595409pbb.89.1330674081600 (num_hops = 1);
        Thu, 01 Mar 2012 23:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9TOsUI7WhvSfFDJob3Mmv93k2oVtMFX8r0qF8M6WXw8=;
        b=BxPkTPgHcGHUUys//LUuEA8XAiCDzPb2KDi1gQKRv+RQn+WTh63ecQDzzN7dHzOY6x
         5SKQrhISGM7vB2hEa7AhsllpPBqd6gV2+t9JBNHyUtMkEJFba3NM7u3exFI4eSMsOWcC
         /RGovkcDWrBGtBpZ+579ZEymYO+suscjL4GOyBKLDIr7KPuEB6OFq0D1IkD+7BlYRRWU
         aArKmIZHSHsbQu6eCOpS3hg07985QkAnIy6bkiwxED54Ox92fgcOcNFk7rTP7gc+P9+o
         BC2HJT9WPmFP/e7BmM3Bs4QEkT0Cc6tMBX6Kza87AceFUIAKn+YCtCxWXfkoNJmuJ+5b
         zrZw==
Received: by 10.68.134.234 with SMTP id pn10mr10432763pbb.89.1330674081427;
        Thu, 01 Mar 2012 23:41:21 -0800 (PST)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id m3sm4328979pbg.44.2012.03.01.23.41.18
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 23:41:20 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.322.g7ac1c
In-Reply-To: <7vk434q4eg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192012>

Host the l10n coordinator repository in a dedicated github organization
account "git-l10n", so that the team may have a more permanent home.
Also add a hint about reference of TEAMS file for l10n contributors.

Update TEAMS file with new zh_CN l10n team members and a repository URL=
=2E

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/README |   17 +++++++++--------
 po/TEAMS  |    9 +++++++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/po/README b/po/README
index 64808..188ea 100644
--- a/po/README
+++ b/po/README
@@ -6,22 +6,23 @@ describes how you can contribute to the effort of enh=
ancing the language
 coverage and maintaining the translation.
=20
 The localization (l10n) coordinator, Jiang Xin <worldhello.net@gmail.c=
om>,
-coordinates our localization effort in his repository:
+coordinates our localization effort in the l10 coordinator repository:
=20
-        https://github.com/gotgit/git-po/
+        https://github.com/git-l10n/git-po/
=20
-As a contributor for a language XX, you would fork this repository,
-prepare and/or update the translated message file po/XX.po (described
-later), and ask the l10n coordinator to pull your work.
+As a contributor for a language XX, you should first check TEAMS file =
in
+this directory to see whether a dedicated repository for your language=
 XX
+exists. Fork the dedicated repository and start to work if it exists.
+
+If you are the first contributor for the language XX, please fork this
+repository, prepare and/or update the translated message file po/XX.po
+(described later), and ask the l10n coordinator to pull your work.
=20
 If there are multiple contributors for the same language, please first
 coordinate among yourselves and nominate the team leader for your
 language, so that the l10n coordinator only needs to interact with one
 person per language.
=20
-For the list of exiting translations and language teams, see TEAMS fil=
e in
-this directory.
-
 The overall data-flow looks like this:
=20
     +-------------------+            +------------------+
diff --git a/po/TEAMS b/po/TEAMS
index 8ee61..1d173 100644
--- a/po/TEAMS
+++ b/po/TEAMS
@@ -5,6 +5,11 @@ Language:	is (Icelandic)
 Leader:		=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
=20
 Language:	zh_CN (Simplified Chinese)
+Repository:	https://github.com/gotgit/git-po-zh_CN/
 Leader:		Jiang Xin <worldhello.net@gmail.com>
-Members:	Yichao Yu <yyc1992@gmail.com>
-		Riku <lu.riku@gmail.com>
+Members:	Riku <lu.riku AT gmail.com>
+		Zhuang Ya <zhuangya AT me.com>
+		Lian Cheng <rhythm.mail AT gmail.com>
+		Yichao Yu <yyc1992 AT gmail.com>
+		ws3389 <willsmith3389 AT gmail.com>
+		Thynson <lanxingcan AT gmail.com>
--=20
1.7.9.2.322.g7ac1c
