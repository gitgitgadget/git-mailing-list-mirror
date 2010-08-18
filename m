From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: fully deepening a shallow clone
Date: Wed, 18 Aug 2010 08:54:07 -0400
Message-ID: <201008180854.18474.ComputerDruid@gmail.com>
References: <20100817004905.GA8305@gnu.kitenet.net> <AANLkTi=qEwcE6qSmAoNnqE-2Z41rjqPBSfgbaesQBPrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3878453.Amkdzs4zdC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <joey@kitenet.net>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 14:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oli9J-0000H9-G4
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 14:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab0HRMxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 08:53:41 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34424 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab0HRMxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 08:53:40 -0400
Received: by vws3 with SMTP id 3so526288vws.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=YFNJwbf2M7Sk9lxMJvAerHpqRUl3EcYRuyL5+Vzcsqk=;
        b=N9/rSy7jNJJNX+dzw2BLvKSIMF4DCAtABu/YK8IYnDmz62DYlYQU0n8vCI7kcwkWWN
         f0srmGceDddKhAO2IXuv2MF4GUvTc3aagWKdPucIBm0SLx/7gm2QNnAe5uXR58MtIVft
         togfSzJ4n0fBQamjB9gPdsmixI9q+I3B7Mymo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=Id41V6BgkBYhyH9TjXBLVGVaVSCQnEOq/0yGpVFN2OMk6DWte8PPUkGkJ/Ocvx0Rdo
         yNNWRtTwg9t3Z6ppHXZHzuF4DH4PPQ1RuhoVeqUX11hcbwNb4/xKMqUV/0wEAEucYs39
         luf4Dxj+w0me6ifDAhiI+mG7X+Nm2lDSjYzEg=
Received: by 10.220.72.78 with SMTP id l14mr1210471vcj.24.1282136016904;
        Wed, 18 Aug 2010 05:53:36 -0700 (PDT)
Received: from hyperion.localnet (pool-71-163-16-224.bltmmd.fios.verizon.net [71.163.16.224])
        by mx.google.com with ESMTPS id r15sm98494vbp.10.2010.08.18.05.53.33
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 05:53:35 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.34.1; KDE/4.5.0; i686; ; )
In-Reply-To: <AANLkTi=qEwcE6qSmAoNnqE-2Z41rjqPBSfgbaesQBPrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153834>

--nextPart3878453.Amkdzs4zdC
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 August 2010 05:36:08 Nguyen Thai Ngoc Duy wrote:
> On Tue, Aug 17, 2010 at 10:49 AM, Joey Hess <joey@kitenet.net> wrote:
> > git-pull(1):
> >       --depth=3D<depth>
> >           Deepen the history of a shallow repository created by git clo=
ne
> >           with --depth=3D<depth> option (see git-clone(1)) by the speci=
fied
> >           number of commits.
> >=20
> > Well, what if I want to deepen an existing shallow clone to include
> > the full history? In practice, something like --depth=3D100000000 is go=
ing
> > to work, but in theory, that will eventually fail some day when there a=
re
> > enough commits. :)
>=20
> I have always thought --depth=3D0 will make full repo again. Have you tri=
ed
> that?
I tried it myself. --depth=3D0 is the same as leaving the depth argument of=
f=20
entirely. If you are already working in a shallow clone fetch or pull witho=
ut=20
arguments won't deepen it at all, only pull in new commits.

I haven't been able to figure out a good way to solve this yet though.

--nextPart3878453.Amkdzs4zdC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkxr1/oACgkQhP2Vm0oJTtx4LACeNFd1AiCYHggdjD1aVrwY60SZ
H2gAn16HlPUc7GS0523de5bqvORH3jOm
=T2FU
-----END PGP SIGNATURE-----

--nextPart3878453.Amkdzs4zdC--
