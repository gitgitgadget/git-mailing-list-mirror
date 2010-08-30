From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 09/17] gettext tests: update test/is.po to match t/t0200/test.c
Date: Mon, 30 Aug 2010 21:28:15 +0000
Message-ID: <1283203703-26923-10-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvf-0000N5-E8
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab0H3V35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44541 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab0H3V34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:56 -0400
Received: by wwb28 with SMTP id 28so137197wwb.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BcokiXKF/r67/dvVl4L9CTtAuoROz30R3yq2quHaYCQ=;
        b=Ng6gE22xCUPGmdT2Ev6tcvNnJfZOXKa5P+4qzobXe+iBr99KOjIqsPf3xy1Ct2mGf/
         vV61pNiIYTFJE4s8/lwqYQ8fsoW9EnBKNxTi6oCAI2Vm1z0RU9BmqlLMuB+FJVUg5RB9
         MUwUKcWv+/2p6UEvTYd/cODASpvZa027cIYlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AW5R6DinPlRsI1PvC2gHuw3feG6Jitdhnu7gk4M0iiGQCIdflwVHY89KopQgDa/3qs
         her9yjpo7qoqW4cD3Y/iU+KQa7UZIeVYvJM32Fna/UtutQr0kjmMODcZOMnatwi8Wm5O
         ndEn6GedOeyBI9ztBTpeC3Qdd8pLXDaswxv/A=
Received: by 10.227.156.11 with SMTP id u11mr5314237wbw.146.1283203743143;
        Mon, 30 Aug 2010 14:29:03 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154866>

Change test.c to use '' quotes around "git help COMMAND" as git.c
does. An earlier version of the gettext series didn't use '' quotes,
but I hadn't run msgmerge since then so I didn't spot it.

=46or reference, the msgmerge command:

    msgmerge --backup=3Doff -U is.po git.pot

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po                 |    4 ++--
 t/t0200-gettext-basic.sh |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/po/is.po b/po/is.po
index 95739f1..2f3a220 100644
--- a/po/is.po
+++ b/po/is.po
@@ -10,8 +10,8 @@ msgstr ""
 "Content-Transfer-Encoding: 8bit\n"
=20
 #: t/t0200/test.c:4
-msgid "See git help COMMAND for more information on a specific command=
=2E"
-msgstr "Sj=C3=A1 git help SKIPUN til a=C3=B0 sj=C3=A1 hj=C3=A1lp fyrir=
 tiltekna skipun."
+msgid "See 'git help COMMAND' for more information on a specific comma=
nd."
+msgstr "Sj=C3=A1 'git help SKIPUN' til a=C3=B0 sj=C3=A1 hj=C3=A1lp fyr=
ir tiltekna skipun."
=20
 #. TRANSLATORS: This is a test. You don't need to translate it.
 #: t/t0200/test.c:9
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 522338d..3846ea8 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -66,10 +66,10 @@ test_expect_success GETTEXT_LOCALE 'sanity: gettext=
(unknown) is passed through'
 test_expect_success GETTEXT_LOCALE 'xgettext: C extraction of _() and =
N_() strings' '
     printf "TILRAUN: C tilraunastrengur" >expect &&
     printf "\n" >>expect &&
-    printf "Sj=C3=A1 git help SKIPUN til a=C3=B0 sj=C3=A1 hj=C3=A1lp f=
yrir tiltekna skipun." >>expect &&
+    printf "Sj=C3=A1 '\''git help SKIPUN'\'' til a=C3=B0 sj=C3=A1 hj=C3=
=A1lp fyrir tiltekna skipun." >>expect &&
     LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: A C test str=
ing" >actual &&
     printf "\n" >>actual &&
-    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "See git help COMMA=
ND for more information on a specific command." >>actual &&
+    LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "See '\''git help C=
OMMAND'\'' for more information on a specific command." >>actual &&
     test_cmp expect actual
 '
=20
--=20
1.7.2.2.536.g3f548
