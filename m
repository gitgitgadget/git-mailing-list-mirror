From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: RE: Lack of detached signatures
Date: Wed, 28 Sep 2011 09:41:49 +0200
Message-ID: <1317195719.30267.4.camel@bee.lab.cmartin.tk>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
	 <7vty7xttxh.fsf@alter.siamese.dyndns.org>
	 <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
	 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-yth91ZvWAHRrDy8nj/sG"
Cc: Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joseph Parmelee <jparmele@wildbear.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Olsen, Alan R" <alan.r.olsen@intel.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 09:42:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8omN-0006u3-Ie
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 09:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab1I1HmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 03:42:01 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:50399 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab1I1HmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 03:42:00 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 420BC46180;
	Wed, 28 Sep 2011 09:41:37 +0200 (CEST)
In-Reply-To: <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182296>


--=-yth91ZvWAHRrDy8nj/sG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-09-28 at 04:17 +0000, Olsen, Alan R wrote:
> [Sorry for the top posting. Outlook is evil.]
>=20
> Detached signatures are created with gpg, not git.

Git delegates all the signing business to gpg.

>=20
> What I would like to see in git would be signed commits. I have looked

Every single commit? That sounds very heavy. You might want to look at
signed pushes (signed push certificates), which were discussed in the
list some time the kernel.org intrusion.

Due to the way git calculates the hash for each object, signing a tag
means that you also sign every single commit up to that point (with all
their tree and blob objects).

>  at what it would take to make it work, but I don't have all the
> details worked out. (Certain merges and cherry-picks would not work
> very well.)

This is precisely because of the cryptographic hash that is used to make
sure that history doesn't get changed.

   cmn

>=20
> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Beh=
alf Of Michael Witten
> Sent: Tuesday, September 27, 2011 5:08 PM
> To: Junio C Hamano
> Cc: Joseph Parmelee; git@vger.kernel.org
> Subject: Re: Lack of detached signatures
>=20
> On Wed, Sep 28, 2011 at 00:03, Junio C Hamano <gitster@pobox.com> wrote:
> > Joseph Parmelee <jparmele@wildbear.com> writes:
> >
> >> Under the present circumstances, and particularly considering the
> >> sensitivity of the git code itself, I would suggest that you implement
> >> signed detached digital signatures on all release tarballs.
> >
> > Well, signed tags are essentially detached signatures. People can verif=
y
> > tarballs against them if they wanted to, although it is a bit cumbersom=
e.
>=20
> Aren't tarballs used to get git on machines that don't yet have git?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> NrybX=C7=A7v^)=DE=BA{.n+=D8=A7=17=DC=A8}=C6=A0z&j:+v=07zZ++zfh~iz=1Ew?&)=
=DF=A2=1Bf



--=-yth91ZvWAHRrDy8nj/sG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOgs+9AAoJEHKRP1jG7ZzTKWwIAJLwjOxzDMV2FZfnvQ//a2KK
k018r06+xMcheiBsGHviYO5u4r49UFCeN0BNWwgxP8L6I5aFgj4nZzo8gzyngpLz
m3DnMRetXcWQujP0syRsIQKsz/PjYCvzNtVqZHpxBwXeGXcS3P0Z0EAzxw8a43m6
1kT8jysmhYJ+YR9Fe+eUiQKC5e8MhDl4HFCdRTWBgU2mEjhkDUDTIlCI3h4H74cG
haQDKoFpVzT33ifda7T6iw/J+JS7E+COMGuLh6gghPHDWEoNcMsHWwVoDBj/DIXE
YOcB6iZ3AmowytfaiggUuzoHUYoOr2VPlNG7X/v5ve3JTAXY1tdzZtrsTSsAYtA=
=g4/B
-----END PGP SIGNATURE-----

--=-yth91ZvWAHRrDy8nj/sG--
