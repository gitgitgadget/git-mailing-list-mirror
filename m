From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/25] gettextize: git-format-patch --cover-letter message
Date: Thu,  2 Sep 2010 19:40:30 +0000
Message-ID: <1283456446-22577-10-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFfY-00061i-K6
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616Ab0IBTlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:44 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:41644 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604Ab0IBTln (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:43 -0400
Received: by mail-ww0-f42.google.com with SMTP id 18so59843wwi.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gEC14f9TNNTnc4HgTQtlLKda8lsCTcn4/HyipE2C0uc=;
        b=FyXVtI2Ug2tBgZhyH6IF0eXbZBNh+iSGJLz2DibNMRFYeCT9BNT3+5kw1WduAfov62
         TApC02LzssKvsv2+OycOg1MXO7PhSNOzwdASjvUj5UIKA9b4/7+eOaxLkgfC1FCAMAJ9
         N+TA0tvrYugSCjSYhxHE0UcenUW17sppFAoM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=o6cam88kDPyr0aA7xz5JMu89vrhptSyzF4zeXOLJ/MQ3258+NyH337K58p4x+CYCfz
         hH3nzY1Bf6OMIyMTE9vf0Wbic9eWu1pY2QMADMXQH/fK1uRgzFJ//CxMaxNVp90XJQJ7
         CT4M4wRCbtjaRSVV20xJy1H82W23APKAvrQR4=
Received: by 10.227.68.145 with SMTP id v17mr245210wbi.159.1283456502963;
        Thu, 02 Sep 2010 12:41:42 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155170>

Make the "SUBJECT HERE" and "BLURB HERE" output in git-format-patch
translatable. This is going to be edited by a human anyway.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 460353b..6a4a8f7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -826,7 +826,7 @@ static void make_cover_letter(struct rev_info *rev,=
 int use_stdout,
 {
 	const char *committer;
 	const char *subject_start =3D NULL;
-	const char *body =3D "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
+	const char *body =3D _("*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n"=
);
 	const char *msg;
 	const char *extra_headers =3D rev->extra_headers;
 	struct shortlog log;
--=20
1.7.2.2.614.g1dc9
