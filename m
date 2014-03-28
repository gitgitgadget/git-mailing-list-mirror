From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Possible regression in master? (submodules without a "master"
 branch)
Date: Thu, 27 Mar 2014 19:33:39 -0700
Message-ID: <20140328023339.GC25485@odin.tremily.us>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
 <20140327155208.GM4008@odin.tremily.us>
 <53345E85.7070205@web.de>
 <xmqq8urvebok.fsf@gitster.dls.corp.google.com>
 <5334AC59.7010605@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 03:34:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTMce-0003X2-Ru
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 03:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbaC1Cdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 22:33:45 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:44693
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757135AbaC1Cdn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 22:33:43 -0400
Received: from omta04.westchester.pa.mail.comcast.net ([76.96.62.35])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id ipzV1n0020ldTLk54qZiFE; Fri, 28 Mar 2014 02:33:42 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta04.westchester.pa.mail.comcast.net with comcast
	id iqZh1n00S152l3L01qZip5; Fri, 28 Mar 2014 02:33:42 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id B246B10DE1A1; Thu, 27 Mar 2014 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1395974019; bh=sGamMjQfCiA4w7FU8xLJAlkOOFbBnbUO+5olXKJ59lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B3qgSQIVTpbi+4+sTefzeiu3JVr1mUqYz3AeYKMFC2uYEcrToIh1xAlPbfQDWu0Dp
	 yZenOevKJN+CqajaZu3lWVImubHdgFP5ZLjEeG6qnkvgddYbvQt8Q9Aa9JqV0xbP6m
	 tanpHPK7Mb0NjsPFH0QxuvT4yr+K4dkI4r08BkuY=
Content-Disposition: inline
In-Reply-To: <5334AC59.7010605@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395974022;
	bh=eF1KAasGxMYUgB/kWhE1UPQPWVqpE++L2ky7R/xCNqQ=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=hhxxcI16QbenychIcY7IopVhr7ftZwQpgr6XGFllP87GEncDVjoXVqtT08yN6qblg
	 /3VI0jSdSeabdJQkbHMjaOhHNWrjca7fe27x77EjiqqZ/uHZG3s3JdDHeOuy8eV2X2
	 WOL/0JhPxB3le9Zj623ZniVS7xwkjSBEhIFbSL7+SfSM6qc22jt/+Kz1uHSdA6nvDD
	 LJbaSrJwKUoE3oKLVXfEvjWDTjix33AMfFIrNq6a3cz6sBxEaS58BSio9SEHK10Kxx
	 8ma3m1xt2Ti0RcNiGd5O1/IOTnybyM6gFcosKmtxdwMBkdLn0CfD6T7dEqn95W5cp/
	 m4xJRgjnxPWug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245353>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 11:55:21PM +0100, Jens Lehmann wrote:
> Me thinks that when a superproject doesn't have 'branch' configured
> and does set 'update' to something other than 'checkout' for a
> submodule it should better make sure 'master' is a valid branch in
> there. Everything else sounds like a misconfiguration on the
> superproject's part that warrants an error.

submodule.<name>.branch should only matter for --remote updates (and
the initial clone, which is a special case of remote update).  So
having an alternative update mode and no submodule.<name>.branch *is*
a valid configuration.  It says:

* I want to integrate local submodule commits with superproject
  gitlink changes using the submodule.<name>.update strategy.
* I never use --remote updates, so I haven't bothered to setup
  submodule.<name>.branch.

I can imagine folks using a workflow like that.  And I think erroring
out if they *do* try a --remote update shouldn't be too surprising for
them.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNN+BAAoJEKKfehoaNkbtP5UQAI2ENk7lkfeI8IKTFDKs36zW
S7T3UHs//ZkXFD0qx25kvHdBVx0BrmccKjhhZsHZtUuel/G27KzVFdG2UWKknmhU
y8gmyOCu9CHAAFmC0OWTODZxGx0jux8Ua/QDi+uJ6M+uYkwRGPr/3HHGDlW3hIuf
yojJPfPn2IZCkg6ZT1ySsDY0if4No0VCFffwqX8ygUywuE+L/X8ag+PhsJsiUoyW
+z1yFf49//4aBWovjfQzHTsm+wIW1+4jaGV77idqY1Yohdr745B8AzKB9u9kiYpN
ddbVR3htV8SPm5Zly1JI2hBdx+E6DKqIAqtKF8DXRr13TwWD4yNRChVKPAXBjsi3
xsiDHGp8k2eOf/1SSdlWVbtP8bwts/Pgc+wsh/evZldZiAYNZRfXAnlMlwk84MZs
JB4X7wUDz1ED4wIKcDxu4eYAEE13ENR2uwbgDsFfRYY9Jy2qDnGwzk0Th85kwOWU
Re5E3QReosupsBf6wrH44D0REirW9lUMpwOMAakkdUNQG75H6czHTjGSSmzD9xm0
UX96vPua0TLUiMQtTKH+Eh7hDmGn3Zxi7pbMbzHIWgEDVmg5LV3F37lBiL5hL6Fz
yJl5ej0wItJeH0VDWe8EnkxxXe++vcYfNESDwhKI38oTJKTtRtoA6D0llZHKb/T2
FDR6jMPDh4xBFZ5d3X0b
=kV2c
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
