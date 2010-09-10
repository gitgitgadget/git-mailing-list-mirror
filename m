From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/5] gettext docs: add "Marking strings for translation" section in po/README
Date: Fri, 10 Sep 2010 19:35:50 +0000
Message-ID: <1284147353-18000-3-git-send-email-avarab@gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 21:36:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9Om-0006Xz-W1
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab0IJTgR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:36:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58786 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab0IJTgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:36:16 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so3171634wyf.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=59ZXTmsk2Wi/rd/iuKm4qO61xwG3dYUyplXSSw4mKfY=;
        b=dzkZ8q2P6gdQ7vivqT+q9nNp2k13IKESDUpjeFLGu127ZFfwH5Xf4CmikTACDtmt15
         eZcG6R2ccGhgTpNF/lCPmeFbbMvgyhUJtndlvjQz29x3lJMxyyJn6ZjModgEHrKQcFcL
         xGjCRDJI8Q58UbvzPHpdLKkK1IHJNZHnL2rRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lntVJBx06IWEHBpIdFuAc1KxFcEZscaMK9h6wvicm8ZDAy97t8ZHZx42ibWI6fJnKo
         4xTK61rXNfSe3fs743RrrwDzIa0PpClXA8rrtSgSm5wrXEpvC3SfG4XV/yaU/kZybdWU
         u3I6WGMDjPo2zN8wJPys2+fnEBVgNJQRQlgX0=
Received: by 10.227.145.16 with SMTP id b16mr412235wbv.187.1284147373288;
        Fri, 10 Sep 2010 12:36:13 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2534921wbb.8.2010.09.10.12.36.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:36:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155965>

Add a "Marking strings for translation" section to po/README and
mention it in Documentation/CodingGuidelines.

This section documents how the maintainers of Git's source code should
go about properly marking strings for translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/CodingGuidelines |    7 ++++++
 po/README                      |   41 ++++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index b8bf618..2e114d6 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -70,6 +70,10 @@ For shell scripts specifically (not exhaustive):
      are ERE elements not BRE (note that \? and \+ are not even part
      of BRE -- making them accessible from BRE is a GNU extension).
=20
+ - Use Git's gettext wrappers in git-sh-i18n to make the user
+   interface translatable. See "Marking strings for translation" in
+   po/README.
+
 For C programs:
=20
  - We use tabs to indent, and interpret tabs as taking up to
@@ -132,3 +136,6 @@ For C programs:
=20
  - When we pass <string, length> pair to functions, we should try to
    pass them in that order.
+
+ - Use Git's gettext wrappers to make the user interface
+   translatable. See "Marking strings for translation" in po/README.
diff --git a/po/README b/po/README
index 4d23ca6..372cb9c 100644
--- a/po/README
+++ b/po/README
@@ -2,7 +2,8 @@ Core GIT Translations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 This directory holds the translations for the core of Git. This
-document describes how to add to and maintain these translations.
+document describes how to add to and maintain these translations, and
+how to mark source strings for translation.
=20
=20
 Generating a .pot file
@@ -80,3 +81,41 @@ changed PO file with `msgfmt --check`, the --check o=
ption flags many
 common errors, e.g. missing printf format strings, or translated
 messages that deviate from the originals in whether they begin/end
 with a newline or not.
+
+
+Marking strings for translation
+-------------------------------
+
+Before strings can be translated they first have to be marked for
+translation.
+
+Git uses an internationalization interface that wraps the system's
+gettext library, so most of the advice in your gettext documentation
+(on GNU systems `info gettext` in a terminal) applies.
+
+General advice:
+
+ - Don't mark everything for translation, only strings which will be
+   read by humans (the porcelain interface) should be translated.
+
+   The output from Git's plumbing utilities will primarily be read by
+   programs and would break scripts under non-C locales. These strings
+   should not be translated.
+
+ - Adjust the strings so that they're easy to translate. Most of the
+   advice in `info '(gettext)Preparing Strings'` applies here.
+
+ - If something is unclear or ambiguous you can use a "TRANSLATORS"
+   comment to tell the translators what to make of it. These will be
+   extracted by xgettext(1) and put in the po/*.po files, e.g. from
+   git-am.sh:
+
+       # TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+       # in your translation. The program will only accept English
+       # input at this point.
+       gettext "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+
+   Or in C, from builtin/revert.c:
+
+       /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
+       die(_("%s: Unable to write new index file"), me);
--=20
1.7.2.3.313.gcd15
