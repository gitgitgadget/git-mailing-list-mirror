From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/3] gettext: update test/is.po to match t/t0200/test.c
Date: Sat, 28 Aug 2010 17:54:21 +0000
Message-ID: <1283018063-4256-2-git-send-email-avarab@gmail.com>
References: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 28 19:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpPcD-0001Lz-Nl
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 19:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab0H1Ryi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 13:54:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39604 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab0H1Rye (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 13:54:34 -0400
Received: by wyb35 with SMTP id 35so5021859wyb.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PaFKA4Q/QxJY1nv3bOx+zTUmsyH9ipIqmuWUsb2FdDg=;
        b=AUUsJGc6hqL8dh8+b0YAQG1wkQLBZB/NV3Kmu9T5Az01WpC5DX/o86QI8lHekelLJF
         3VdXJvQM7pOk3leY0kYH+GrBwJNzd9B2ATrTq43Qcuquj3Q09x+j5D044GjdlrpG2c6K
         6SHOuqxURlE4x7JXDG7PN856RAeLCFkJ93kRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GQD+ZPVMaJSV+srHXiRq7wo29V5iGp9xTpomx7iLWMG75Klp+o/fDcBjCglOVeaOvM
         PlZ77nbHcQ+1rqA273HlUeyxOYIwzZedEyIddc/+hCeHSAfzR4cChEDX65VAw8Ys9u4c
         k0uzrLCU0aGK6R2S+oYNMX2lUW0o3zdbAoB8A=
Received: by 10.227.69.134 with SMTP id z6mr2299079wbi.201.1283018072810;
        Sat, 28 Aug 2010 10:54:32 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id o15sm78280wer.39.2010.08.28.10.54.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 10:54:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.g82b8
In-Reply-To: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154652>

Change test.c to use '' quotes around "git help COMMAND" as git.c
does. An earlier version of the gettext series didn't use '' quotes,
but I hadn't run msgmerge since then so I didn't spot it.

=46or reference, the msgmerge command:

    msgmerge --backup=3Doff -U is.po git.pot

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/is.po                 |    4 ++--
 t/t0200-gettext-basic.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 522338d..e8b7710 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -69,7 +69,7 @@ test_expect_success GETTEXT_LOCALE 'xgettext: C extra=
ction of _() and N_() strin
     printf "Sj=C3=A1 git help SKIPUN til a=C3=B0 sj=C3=A1 hj=C3=A1lp f=
yrir tiltekna skipun." >>expect &&
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
1.7.2.2.513.g82b8
