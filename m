From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: [RFC/PATCHv2] t5525: test the tagopt variable and that it can be overridden
Date: Sat, 14 Aug 2010 17:32:05 -0400
Message-ID: <201008141732.16214.ComputerDruid@gmail.com>
References: <AANLkTimYm+GmJ4BmZKOmcZkJf_wgeUiKhTs06qxex+0q@mail.gmail.com> <1281734852-21413-1-git-send-email-ComputerDruid@gmail.com> <AANLkTikP5xsvfBt7Rq9CoNnF=7SE4-V6LBML=tDMtT_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1703082.9a66YgaydP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 23:31:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkOKH-0005MF-04
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 23:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166Ab0HNVbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 17:31:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34272 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab0HNVbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 17:31:31 -0400
Received: by ywh1 with SMTP id 1so1491846ywh.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=FbVHoGK+3gG6kaJYEOG3mEaDcbfTvaav5HQzy88qHTg=;
        b=dtTbJjU1R3C8Spk0DUgzmWzQ+Ff7e6pcEVYIN3K6s3oMASy6oV+Ve/v4PmJ+5SIElk
         JwO7H+GOkjV/R8KpHQ10DhZJEbvjc8ZvmaHc9w5NMIgIFfHHV76hOEYIkQUVnkogrNho
         VSw9leXe6wlWlWLZv1OU8M2a7NJqWekKZ1re4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=RzgWA6L14/5kA0Evz6eIsOcXKoSC35ZV5PYmE3JbfVnG9IQdLqXo3A/qcS71BK5PcC
         Zol70WkMtyN+aNkwxn9hg2RVc9BceCayJEv9nOC18uQDCRF3DSqEs6ylzBlLQL7v17QR
         NlDci93cZMF50LtP1EiOwPDMp2R/ucl0SA/8s=
Received: by 10.150.215.17 with SMTP id n17mr3670204ybg.276.1281821490738;
        Sat, 14 Aug 2010 14:31:30 -0700 (PDT)
Received: from hyperion.localnet (pool-71-163-16-224.bltmmd.fios.verizon.net [71.163.16.224])
        by mx.google.com with ESMTPS id p14sm4663083ybb.21.2010.08.14.14.31.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 14:31:29 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.34.1; KDE/4.4.5; i686; ; )
In-Reply-To: <AANLkTikP5xsvfBt7Rq9CoNnF=7SE4-V6LBML=tDMtT_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153581>

--nextPart1703082.9a66YgaydP
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 13 August 2010 17:39:04 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wr=
ote:
> On Fri, Aug 13, 2010 at 21:27, Daniel Johnson <computerdruid@gmail.com>=20
wrote:
> > ---
> >=20
> >>> @@ -0,0 +1,44 @@
> >>> +
> >>> +#!/bin/sh
> >>=20
> >> Is that an empty line before the test begins? The shebang should be on
> >> the first line.
> >=20
> > Embarrassing. That's what I get for using yank/put and not paying closer
> > attention. The rest is fixed too.
>=20
> Nice, I haven't actually *run it* but it looks good, so provided that
> it passes tests when our beloved maintainer applies it:
>=20
> Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Well, now that we have a fix and a test to help guard against future breaka=
ges,=20
can someone tell me the next step as to getting them included?

Thanks,
=2DDan

--nextPart1703082.9a66YgaydP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkxnC18ACgkQhP2Vm0oJTty/ewCfd+Gp9MvlyFJ0fDO/4Kw66lh4
N+QAn3QPsNPuXAFLblK17d2TQD8xSCsM
=LNRi
-----END PGP SIGNATURE-----

--nextPart1703082.9a66YgaydP--
