From: Simon Hausmann <simon@lst.de>
Subject: Re: git-p4import.py robustness changes
Date: Thu, 14 Jun 2007 00:34:42 +0200
Message-ID: <200706140034.45968.simon@lst.de>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <200706122347.00696.simon@lst.de> <46705C69.8000500@slamb.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3461306.NVQKlD3URn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:34:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HybQG-0006ar-NC
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 00:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbXFMWei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 18:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbXFMWei
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 18:34:38 -0400
Received: from verein.lst.de ([213.95.11.210]:56034 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879AbXFMWei (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 18:34:38 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5DMYOo6018065
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Thu, 14 Jun 2007 00:34:25 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <46705C69.8000500@slamb.org>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50139>

--nextPart3461306.NVQKlD3URn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 13 June 2007 23:06:49 Scott Lamb wrote:
> Simon Hausmann wrote:
> > _If_ one of you decides to pull then my plan is to discontinue the git-=
p4
> > branch in the fast-export repository and instead work in a git.git fork
> > on repo.or.cz (similar to the fastimport repository).
>
> So you'll continue maintain this code and others should submit changes
> through you? What is the best way to do so? (Not sure what it was
> before, or if it would change under this plan.) Email a format-patch To:
> you? Cc: this list? some other list? no list?

I would say whichever you prefer :)

=46or the fast-export repository multiple people have access and for exampl=
e=20
after Han-Wen made a lot of patches I asked Chris Lee (owner of the module =
on=20
repo.or.cz) to add Han-Wen to the list of people with push access and he=20
pushed his changes directly. I actually like working that way for a project=
=20
that is as simple as that, I don't mind if somebody pushes simple changes=20
directly as much as I like discussing bigger plans if they potentially clas=
h=20
with somebody else's work or use-case.

So if git-p4 continues to live in fast-export I'll continue to encourage Ch=
ris=20
Lee to give git-p4 contributors push access, if it's in a git.git fork I'd =
be=20
happy to do so myself (give access).

If git-p4 also ends up in git/contrib/fastimport and somebody likes to send=
=20
patches to Junio or somebody else and CC this list that's fine with me, too.

It's just a few lines of python code after all ;-)

Simon

--nextPart3461306.NVQKlD3URn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcHEFWXvMThJCpvIRAmGcAJoCRmr8mfCCRToX28pHXTdFt+7m3QCfUCkT
va/HZ/TKCAArYzELTDQyb28=
=HbUn
-----END PGP SIGNATURE-----

--nextPart3461306.NVQKlD3URn--
