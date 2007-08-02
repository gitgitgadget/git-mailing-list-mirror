From: Robert Schiele <rschiele@gmail.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 2 Aug 2007 19:22:25 +0200
Message-ID: <20070802172225.GR29424@schiele.dyndns.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <20070802140011.GN29424@schiele.dyndns.org> <86sl72j9vn.fsf@lola.quinscape.zz> <20070802161902.GP29424@schiele.dyndns.org> <Pine.LNX.4.64.0708021804090.14781@racer.site>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9g2r9e2kvGs7M7R"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 19:22:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGeNe-0000NM-A2
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 19:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbXHBRWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 13:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbXHBRWa
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 13:22:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:22178 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbXHBRW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 13:22:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so154809nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 10:22:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=ioKuSdkx5yLmuEciapJ3ZZQm0zb1nY+M4PVgvVdn+PymEijzeUokegkRZmyVz/ObJn7nR5FcHrAzh1zHjRSa1LPLIj6cm++uYj1RhgQtecaEiUlKsBe8I7CTDW5ot2+NDWTD/iQranvkFd19LKfbFuNPyTX79DuTidaF6nWptes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=aprVcidLhZF9/ZOvswl7/lHJdNxbufN8Z2cQOUUb7yTq7NdESb3F/ZDxoO1++SzNleOo3xnQsgSZLSkhWjBpFR0wZ5GLBGW/wK40MA4WLPu1wpitWGNftMvuEUZoLgosHxssE+MUsvpJEjZ7kAkLNiz+dKot8R/NIcQYfYF/ZKo=
Received: by 10.86.60.7 with SMTP id i7mr1531701fga.1186075348414;
        Thu, 02 Aug 2007 10:22:28 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id i5sm6860079mue.2007.08.02.10.22.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 10:22:27 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 33EF1C0D900; Thu,  2 Aug 2007 19:22:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708021804090.14781@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54574>


--v9g2r9e2kvGs7M7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2007 at 06:05:00PM +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 2 Aug 2007, Robert Schiele wrote:
>=20
> > On Thu, Aug 02, 2007 at 04:20:44PM +0200, David Kastrup wrote:
> > > Sigh.  It's in Posix.
> >=20
> > It is in latest POSIX but latest POSIX is not in Solaris.
>=20
> It has been a really long standing tradition in git development to not=20
> care about POSIX if it disagrees with reality.  A good tradition.

Sure.  I mean if Solaris was really a system nobody uses nowadays there wou=
ld
be no reason to care about it but it actually still is one of the mayor
platforms availlable and thus not supporting it would be quite stupid.

It would actually draw away my interest (and most likely the one of many
others) from git since I need a system that works on _all_ systems we suppo=
rt.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--v9g2r9e2kvGs7M7R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGshLRxcDFxyGNGNcRAhYTAJ9Kpa7MhG7d0GwuzAoanVj63rJlBQCgnY3e
1n+/yjuv3bncXpriHmw1U3s=
=1IJ6
-----END PGP SIGNATURE-----

--v9g2r9e2kvGs7M7R--
