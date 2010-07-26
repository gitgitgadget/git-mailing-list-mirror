From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH 0/24] Documentation: refactor config variable 
	descriptions
Date: Mon, 26 Jul 2010 22:25:32 +0000
Message-ID: <AANLkTinxEFxOcTeDTBz6fSxAGaqSlHgq0dQvrYYgWH78@mail.gmail.com>
References: <cover.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 27 00:25:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdW7D-0005J9-5a
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 00:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab0GZWZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 18:25:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64789 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab0GZWZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 18:25:36 -0400
Received: by iwn7 with SMTP id 7so3093973iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 15:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WbrXT6Fny0boUDy/Cta3KcCPMkoRC8VW/tBL1HFPy0E=;
        b=SgOubCo0r6w3D3QnuFvh0YKKTbiE2cc2+J2Nd7mEHEPT/OTKeC+Efn9JY1rWUp3l1r
         QttPflGNgoJVyQMrOsOKzDeljUIkP0gkhX78u9e655K874Y63pd8wevSXAWi69vxl2s6
         SoMXUwXYEEYrIRw0HIBsrUdiHauJLAazvW0X4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qTihVUuE0p35YK+au2XhTrJiwLHVfryB1cOVIwFXAv8nUGs9dzLS5G/+qJHUx4edvG
         nnmim/PZl06EeL8Uz98v83AgLstLUfIsYTDKEY7AL+sDIlRTry3+ukZsP127F82JyUFY
         8geDH3a9MphnLGoVHmJQrfFz9ztUUcGgDGkMo=
Received: by 10.231.17.12 with SMTP id q12mr8992698iba.160.1280183132802; Mon, 
	26 Jul 2010 15:25:32 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 15:25:32 -0700 (PDT)
In-Reply-To: <cover.1280169048.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151899>

On Mon, Jul 26, 2010 at 18:48, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> This little series is a bit of a spinoff from

Here are some minor but needed fixups (also in my branch at
http://github.com/avar/git/compare/t/doc-config-extraction)

=46rom 522a0e384c1e8b29339aecb8cbf0cccdf42ce3ce Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bj=
armason?=3D <avarab@gmail.com>
Date: Mon, 26 Jul 2010 21:56:30 +0000
Subject: [PATCH 1/2] gitignore: Add *.cv files made by var substitution=
 script
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Ignore the *.cv files being generated as of the "Documentation: Add
variable-substitution script" commit.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 1c3a9fe..623f1d1 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -3,6 +3,7 @@
 *.[1-8]
 *.made
 *.texi
+*.cv
 git.info
 gitman.info
 howto-index.txt
--=20
1.7.1


=46rom 2cdb7349fd65b246cdd01cfcd7444ed3c5e6120b Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bj=
armason?=3D <avarab@gmail.com>
Date: Mon, 26 Jul 2010 22:20:48 +0000
Subject: [PATCH 2/2] Documentation/Makefile: Specify -f user-manual.con=
f
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The user-manual.xml target was broken in the "Add
variable-substitution script" commit.

It broke because asciidoc(1) will implicitly search a configuration
file alongsite the .txt file it's generating, but that didn't work
with the preprocessed .txt.cv file (which would need a
user-manual.txt.conf file)

=46ix that by specifying the path to the config file explicitly like th=
e
other asciidoc invocations do.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c20d580..8b1e797 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -269,7 +269,8 @@ manpage-base-url.xsl: manpage-base-url.xsl.in

 user-manual.xml: user-manual.txt.cv user-manual.conf
                  $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-                 $(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book -o
$@+ $< && \
+                 $(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book -f
user-manual.conf \
+                             -o $@+ $< && \
                              mv $@+ $@

 technical/api-index.txt: technical/api-index-skel.txt \
--=20
1.7.1
