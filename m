From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: [PATCH 1/3] clone: do not accept --depth on local clones
Date: Thu, 19 Aug 2010 10:31:32 -0400
Message-ID: <201008191031.40230.ComputerDruid@gmail.com>
References: <201008180854.18474.ComputerDruid@gmail.com> <1282214437-16384-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4650685.RTmfKZcfrT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, joey@kitenet.net
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 16:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om68y-0002g5-4N
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 16:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab0HSOaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 10:30:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48703 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab0HSOay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 10:30:54 -0400
Received: by wyb32 with SMTP id 32so2270122wyb.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 07:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=0zlUzeJ0XsLqYfIp2k2phh4JaBGG+YXcCBk8ax6yd1c=;
        b=TtCm+xA3wcZpmERFLbkuPE0QMzu3CgfpimYgw7oHiybUqcLE03r5RzpuIP6blngYUj
         DoCf2qBC26mxjmhzl5yufvPvxNktjEqL0vo9oNUa3owhi25irup4G42I+Hp5ath+Vcgg
         gvM+buEEf7tllVZ+JUNIrMAWgpj6eUcnbQhl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=CG1dviVaArkTnrqr0zuV46Ml2pT/tgmPmF4szmuvQG+oFJMmG551GMuhprgQXJcH7F
         OlGpzp2xUEpYYaGuuoIunVRMD6t/ASMd5JL+I7TsyJWMa5qEe32ETU/2V72WtCMyP0Mf
         PvMvTOyXhhYHtxhpsPfPGMkse06dlXMuDWpJ4=
Received: by 10.227.146.76 with SMTP id g12mr8443659wbv.82.1282228252853;
        Thu, 19 Aug 2010 07:30:52 -0700 (PDT)
Received: from hyperion.localnet (pool-71-163-16-224.bltmmd.fios.verizon.net [71.163.16.224])
        by mx.google.com with ESMTPS id k83sm1050375weq.14.2010.08.19.07.30.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 07:30:51 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.34.1; KDE/4.5.0; i686; ; )
In-Reply-To: <1282214437-16384-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153924>

--nextPart4650685.RTmfKZcfrT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 19 August 2010 06:40:35 you wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/clone.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
Can you make it a little clearer what the rationale is for this change? Why=
=20
wouldn't you be able to do a limited-depth local clone? Seems like this wou=
ld=20
break some tests, and even if not, would prevent the writing of them.

--nextPart4650685.RTmfKZcfrT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkxtQEsACgkQhP2Vm0oJTty7/gCcC2DXgBC1QQsVFJ5LzfBupSvf
flsAn3UwwRhTTFJ31kD+t0iRsD+J21JO
=fmJT
-----END PGP SIGNATURE-----

--nextPart4650685.RTmfKZcfrT--
