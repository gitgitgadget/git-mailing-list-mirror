From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] po/hi.po: Add Hindi Translation
Date: Thu, 9 Sep 2010 21:03:52 +0530
Message-ID: <20100909153350.GB27725@kytes>
References: <1283971131-25106-1-git-send-email-artagnon@gmail.com>
 <AANLkTi=geJoBzDw4z-pWytCi9XmzwXvzyzFHUpVYnmMJ@mail.gmail.com>
 <20100909140205.GA13472@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Antriksh Pany <antriksh.pany@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 17:35:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtjAH-0000uJ-Cw
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 17:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095Ab0IIPfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 11:35:48 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39985 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0IIPfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 11:35:46 -0400
Received: by gxk23 with SMTP id 23so661307gxk.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fz6g+3dHwUTXaH4GvlCKcAOcFReZG+iavXXrw+EdrA8=;
        b=SqqXG3qrjQDAUfnc8y9aVtbLgbCR4MrCvgBEQC1TdV+ZIHHdlw3344p5z/3fdJudVD
         VGoUZljeWx1CW2UcoDsgdfI2gjcLHSWbp9frC2bjl4bRVWXCrA/rVgUeIi0HABlYtdaL
         g1PQLfrf5XDb602PPbWwVvIGNgWFOWoy4EBss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QJC61T4B0Dj2mPRK3C9ymlSq/XKnMhbWgh2vXJSAAkCO+DHZS0wRd4sxmx4O4ioPha
         cJLgWVhsXDo/vHk3Qi9sx8aCHz11K27lSvQehvMlnPHFxZ+G4RoMKQ9pcCSk9X9pkkPs
         EwYROsgR9qXS3SNxI4Z0/EUaQ2Xz39jmobLgY=
Received: by 10.100.250.11 with SMTP id x11mr233359anh.95.1284046546132;
        Thu, 09 Sep 2010 08:35:46 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id f29sm2113772anh.31.2010.09.09.08.35.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 08:35:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100909140205.GA13472@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155863>

Hi,

Ramkumar Ramachandra writes:
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Sun, 5 Sep 2010 23:49:38 +0530
> Subject: [PATCH] po/hi.po: Add Hindi Translation
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Translate a few Git messages to Standard Hindi. It uses a phonetic
> script called Devanagari. Focus especially on transforming grammar an=
d
> tense in a sane manner to serve as a guideline for future translators=
=2E
>=20
> Note that Devanagari rendering is broken on many applications by
> default at this time- the latest Emacs, Vim and Chrome render it
> incorrectly.
>=20
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Acked-by: Antriksh Pany <antriksh.pany@gmail.com>
> Cc: Sitaram Chamarty <sitaramc@gmail.com>
> Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Couple of silly mistakes that were breaking the build spotted by
=C3=86var. Here's the diff.

-- 8< --
diff --git a/po/hi.po b/po/hi.po
index 85890fa..8f25f02 100644
--- a/po/hi.po
+++ b/po/hi.po
@@ -2,6 +2,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"PO-Revision-Date: 2010-09-09 20:55+0530\n"
 "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Last-Translator: Ramkumar Ramachandra <artagnon@gmail.com>\n"
 "POT-Creation-Date: 2010-09-05 16:05+0530\n"
@@ -60,7 +61,7 @@ msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=
=E0=A4=B2=E0=A5=87=E0=A4=9F=E0=A5=8D=E0=A4=B8 =E0=A4=A8=E0=A4=B9=E0=A5=80=
=E0=A4=82 =E0=A4=AE=E0=A4=BF=E0=A4=B2=E0=A5=87: %s"
=20
 #, c-format
 msgid "not copying templates of a wrong format version %d from '%s'"
-msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=A4=B8=E0=
=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=A4=B8=E0=
=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %d =E0=A4=95=E0=A5=87 =E0=A4=9F=E0=A5=
=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F=E0=A5=8D=E0=A4=
=B8 =E0=A4=95=E0=A5=80 =E0=A4=A8=E0=A4=95=E0=A4=B2 =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87 =E0=A4=B9=
=E0=A5=88=E0=A4=82"
+msgstr "'%2$s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=A4=B8=
=E0=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=A4=B8=
=E0=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %1$d =E0=A4=95=E0=A5=87 =E0=A4=9F=E0=
=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F=E0=A5=8D=E0=
=A4=B8 =E0=A4=95=E0=A5=80 =E0=A4=A8=E0=A4=95=E0=A4=B2 =E0=A4=A8=E0=A4=B9=
=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87 =E0=A4=
=B9=E0=A5=88=E0=A4=82"
=20
 #, c-format
 msgid "insane git directory %s"
