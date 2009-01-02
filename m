From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [CLEANUP PATCH RESEND] git wrapper: Make while loop more reader-friendly
Date: Fri, 2 Jan 2009 14:04:02 -0600
Message-ID: <200901021404.05811.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901021240270.27818@racer> <200901021228.07599.bss@iguanasuicide.net> <alpine.DEB.1.00.0901021947170.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1272099.P4JzOXJNq7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 02 21:08:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIqHL-00071o-F9
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 21:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbZABUDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 15:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbZABUDo
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 15:03:44 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:54150 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbZABUDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 15:03:42 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LIqF5-0003Ne-8r; Fri, 02 Jan 2009 20:03:35 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0901021947170.30769@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104413>

--nextPart1272099.P4JzOXJNq7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2009 January 02 12:49:53 Johannes Schindelin wrote:
> > > -	do
> > > -		--slash;
> > > -	while (cmd <=3D slash && !is_dir_sep(*slash));
> > > +	while (cmd <=3D slash && !is_dir_sep(*slash))
> > > +		slash--;
> >
> > I prefer the one-liner:
> > for (; cmd <=3D slash && !is_dir_sep(*slash); --slash);
>
> As I mentioned in the commit message: readability is something to be
> cherished and worshipped.

It's also subjective.  I think my one-line is more readable than your two=20
lines which is only slightly more readable than the original 3 lines.  Or i=
s=20
there some objective readability metric that of which I'm just not aware?

I also think that the lack of braces around your body on a separate line ma=
kes=20
it harder to read and easier to break, but I understand that is the git=20
coding style.

> For your pleasure, I will not go into details about the motions my bowels
> went through when I looked at those three lines.  Or your single line, for
> that matter.

Please do, although privately if you like.  I really don't see the problem =
the=20
patch is trying to fix.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1272099.P4JzOXJNq7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkleczUACgkQdNbfk+86fC2XDwCfUwytNxag5PuodMHlWr3TBQVf
oawAnRgfPNpwYhk2DLNi0VCYS/KW4GHI
=yfLi
-----END PGP SIGNATURE-----

--nextPart1272099.P4JzOXJNq7--
