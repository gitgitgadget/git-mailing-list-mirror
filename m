From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2] Documentation/githooks: Explain pre-rebase parameters
Date: Sat, 23 Feb 2013 16:35:13 -0500
Message-ID: <20130223213513.GF1361@odin.tremily.us>
References: <20130220163621.GI14102@odin.tremily.us>
 <c8b19dc074a81b009399ff1011102737761658ec.1361633106.git.wking@tremily.us>
 <7vobfa7mko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=27ZtN5FSuKKSZcBU
Cc: Git <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:36:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9MlH-0001zO-1e
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 22:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759411Ab3BWVfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 16:35:34 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:51308 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759381Ab3BWVfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 16:35:30 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIO00103ZYPXJ10@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 23 Feb 2013 15:35:14 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 4C1388C0706; Sat,
 23 Feb 2013 16:35:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361655313; bh=Q87rUR+JHvMUSPEiJiUJfDomh9ixcW7qEHU12mfDfYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jI9UupgGv7IZS5BEgi7kZI56Q6I5QAaK7wf3YEiw2cJWZoxPHwnAEMODien0JmRAM
 cbf56rBdcIrTNFPPuxcd4qFx60tqt7VnZpiMDhUFXPse3G+zojYcT/NWPX+90fGPSz
 ec36COeVo5bmsQYNaJb2s3Bat6MB8lYO1F2DNzXY=
Content-disposition: inline
In-reply-to: <7vobfa7mko.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216918>


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2013 at 01:21:59PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > +This hook is called by 'git rebase' and can be used to prevent a
> > +branch from getting rebased.  The hook takes two parameters: the
> > +upstream the series was forked from and the branch being rebased.  The
> > +second parameter will be missing when rebasing the current branch.
>=20
> takes one or two parameters?
>
> Other than that, looks good to me, but it took me two readings to
> notice where these two parameters are described.  I have a feeling
> that a comma s/forked from and/forked from, and/; might make them a
> bit more spottable, but others may have better suggestions to make
> them stand out more.

How about:

  The hook may be called with one or two parameters.  The first
  parameter is the upstream from which the series was forked.  The
  second parameter is the branch being rebased, and is not set when
  rebasing the current branch.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRKTYPAAoJEEUbTsx0l5OMc+QP/RZ/QSFhI2QPRGmolVvxgsFb
GR2mTD0a5FX/D4RsG0yOguMb6xVUODISVrbzrqEnhPrCFnLnrM+5NuaVcImE+rKo
J4YqiJm/PlbJ2TD+tLWIcZ0UwPFzI4YEwMKrcASRZXi59jweEi0DeVwoVUNPdTrG
qRFMdpQBbryS42WQqI9725C8W8bhmBvFdAdjJLuHX1Pibhj6ORgUREzCqxIV2qWb
ydMjJvGpjV22Cs1bFKFcUAYffRg78EgETZ+hNUBib9xCed8xjGeti3AM2s7fcQD8
guMYIyTOuwLmrCATRcHqmRq9atdVsYyPlaeMmS4fvDmKlyUcDDiMk/SNdWxwx3ls
AP5FFe2I8GCc8ZFTSjScjtj8iLpvjgsk01oOmhJtzvtAMQP5uKkNcV9Bm+9WDqnl
9MXG28Bz3dWDisX9l5WV1Auz5cnC3+su0TedVGDK+nmWJuBYdhOqipI4Q6V9UL6j
O3lrCTZgndooxoBWhuPo3rJPEI0k/JcKU3u53LOMggvQa00VPWvtrsUQKTQrRBiX
NVlam7SigUm+uunmxF757ZUE4urwqpnQmgbq/KtXfGJhJ1EOfH3XmugFlOm+Elnj
2HDhRlwH24ggKVDJLe+wietbYF9YJn9zCe4+YzfJrGj65Pe4FmlDP42Px2sBxSrG
UnGFY5iAZP8pIFIU8Tpg
=KiP6
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
