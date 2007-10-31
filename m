From: Johan Herland <johan@herland.net>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 15:37:26 +0100
Message-ID: <200710311537.30384.johan@herland.net>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se> <200710311343.58414.johan@herland.net> <Pine.LNX.4.64.0710311340500.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart19580535.Hxp9lTjWbq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 15:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InEiC-0007dZ-Jt
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbXJaOiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 10:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbXJaOiL
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:38:11 -0400
Received: from sam.opera.com ([213.236.208.81]:60065 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551AbXJaOiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 10:38:09 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l9VEbUIQ004295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 31 Oct 2007 14:37:30 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710311340500.4362@racer.site>
X-Virus-Scanned: ClamAV 0.91.1/4647/Wed Oct 31 12:43:08 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62840>

--nextPart19580535.Hxp9lTjWbq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 31 October 2007, Johannes Schindelin wrote:
> On Wed, 31 Oct 2007, Johan Herland wrote:
> > On Wednesday 31 October 2007, Johannes Schindelin wrote:
> > > On Wed, 31 Oct 2007, Peter Karlsson wrote:
> > > > Johannes Schindelin:
> > > > > Why should it?  This would contradict the whole "a commit sha1=20
> > > > > hashes the commit, and by inference the _whole_ history"=20
> > > > > principle.
> > > >=20
> > > > Does it?
> > >=20
> > > Yes!  Of course!  If what you want becomes possible, I could make an=
=20
> > > evil change in history long gone, and slip it by you.  You could not=
=20
> > > even see the history which changed.
> >=20
> > Well, technically, if the grafts file was part of the repo, you wouldn'=
t=20
> > be able to change the (in-tree) grafts file without affecting the SHA1=
=20
> > of HEAD. In other words, given a commit SHA1 sum, you can be sure that=
=20
> > someone else who checks out the same commit (and has no local=20
> > modification to their grafts file) will see exactly the same history as=
=20
> > you do.
>=20
> All this does not change the fact that installing a graft and 'git gc=20
> --prune'ing gets rid of the old history.  D'oh.

So will rebasing and --prune'ing, or pulling a rebased branch and --prune'i=
ng.=20
Git already gives you _plenty_ of different ropes to hang yourself with. Th=
e=20
question is whether adding yet another one is worth it.

> Automatically installing grafts is wrong.

I tend to agree with you here, because the possibility for massive confusio=
n=20
is huge, but that doesn't deny the fact that, if used properly (and that's =
a=20
_big_ 'if'), this is a very powerful feature.


=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart19580535.Hxp9lTjWbq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7-ecc0.1.6 (GNU/Linux)

iD8DBQBHKJMmBHj4kl4fT1wRAq0zAJ9ZIAubnmnGHYX3gZ8IN2wkXDBaPgCgnxHv
Rj5Vdtsi2EciChphvDIjAhs=
=PWy2
-----END PGP SIGNATURE-----

--nextPart19580535.Hxp9lTjWbq--
