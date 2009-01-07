From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Wed, 7 Jan 2009 09:48:33 -0600
Message-ID: <200901070948.34117.bss@iguanasuicide.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com> <200901070027.21721.bss@iguanasuicide.net> <slrngm92hr.72d.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1610605.0nBRT8nrEQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 16:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKaep-00058O-SF
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 16:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZAGPsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 10:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbZAGPr7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 10:47:59 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:57038 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbZAGPr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 10:47:58 -0500
Received: from [206.104.164.114]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LKadR-0006HF-R0; Wed, 07 Jan 2009 15:47:57 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <slrngm92hr.72d.sitaramc@sitaramc.homelinux.net>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104805>

--nextPart1610605.0nBRT8nrEQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2009 January 07 04:55:56 you wrote:
> On 2009-01-07, Boyd Stephen Smith Jr. <bss@iguanasuicide.net> wrote:
> > On Tuesday 06 January 2009, Sitaram Chamarty <sitaramc@gmail.com>
> > wrote=3D20
> >
> >>    chmod g+ws .git
> >>
> >>Now set the group to something (I use "gitpushers" ;-)
> >>
> >>    chgrp -R gitpushers .git
> >
> > ISTR this breaking here when someone on the team had a umask like 077
> > and=3D20 was using file:// or ssh:// to push.  I tended up "fixing" thi=
ngs
> > with a=3D20 cronjob, (which is a bit of a hack) IIRC.
>
> That doesn't sound right.  "git help init" says:
>  - 0xxx: 0xxx is an octal number and each file will have mode 0xxx
>  - 0xxx will override users umask(2) value, and thus, users
>    with a safe umask (0077) can use this option
>  - 0660 is equivalent to group.
>
> So when you say "group", you're saying "0660", and when you
> say "0660", you're overriding users umask value.

Very good then.  It is from when I was significantly less experienced in us=
ing=20
git and managing repos, so I may have forgotten to use the correct options =
OR=20
it could just have been the version of git I was using (1.4.4.4, IIRC) --=20
still using that in at least one place, as it is the current version in=20
Debian Etch.

It's good to know it works properly now, if all the right switches are set.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1610605.0nBRT8nrEQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklkztIACgkQdNbfk+86fC3iQgCeKgKlv71lBnNxRSjEMW1yvBJ9
/KEAn20r8k6KqtNb7H3Mj4CDdyKO6u/V
=j4tc
-----END PGP SIGNATURE-----

--nextPart1610605.0nBRT8nrEQ--
