From: Johan Herland <johan@herland.net>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 16:21:04 +0100
Message-ID: <200710311621.09845.johan@herland.net>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se> <200710311537.30384.johan@herland.net> <Pine.LNX.4.64.0710311503120.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8723554.2ZN1ZYJtjD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 16:22:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InFON-0004VM-DK
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 16:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296AbXJaPVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 11:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756895AbXJaPVr
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 11:21:47 -0400
Received: from sam.opera.com ([213.236.208.81]:33519 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756286AbXJaPVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 11:21:47 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l9VFLAG3006030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 31 Oct 2007 15:21:10 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710311503120.4362@racer.site>
X-Virus-Scanned: ClamAV 0.91.1/4647/Wed Oct 31 12:43:08 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62843>

--nextPart8723554.2ZN1ZYJtjD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 31 October 2007, Johannes Schindelin wrote:
> On Wed, 31 Oct 2007, Johan Herland wrote:
> > On Wednesday 31 October 2007, Johannes Schindelin wrote:
> > > All this does not change the fact that installing a graft and 'git gc=
=20
> > > --prune'ing gets rid of the old history.  D'oh.
> >=20
> > So will rebasing and --prune'ing, or pulling a rebased branch and=20
> > --prune'ing. Git already gives you _plenty_ of different ropes to hang=
=20
> > yourself with. The question is whether adding yet another one is worth=
=20
> > it.
>=20
> But that is not the question here.  The question here is: are users=20
> allowed to hang _others_?  I say: no.

Well, to a certain degree (and depending on your level of paranoia), you're=
=20
always responsible for the code entering your own repo, and you could alway=
s=20
set up a hook disallowing ".gitgrafts" (or whatever it would be called) fro=
m=20
entering your repo.

But taking this (and everything else that's been said) into account, I tota=
lly=20
agree with you that adding this feature would open up a _massive_ can of=20
worms.


EOD

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart8723554.2ZN1ZYJtjD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7-ecc0.1.6 (GNU/Linux)

iD8DBQBHKJ1hBHj4kl4fT1wRAifnAKCbaqd/L+qqUrJ4qQumbC2cg4MbKwCggdfk
PmPWaC0jBmzscSQ/76R1Kpk=
=BqPm
-----END PGP SIGNATURE-----

--nextPart8723554.2ZN1ZYJtjD--
