From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 1/2] Documentation: Update 'linux-2.6.git' -> 'linux.git'
Date: Wed, 19 Jun 2013 07:48:23 -0400
Message-ID: <20130619114823.GK15550@odin.tremily.us>
References: <cover.1371606791.git.wking@tremily.us>
 <3286ddfe2dd6cbf9c435bd7f9eb579782eb32e1f.1371606791.git.wking@tremily.us>
 <CAJDDKr75PwVjJ-hs=1eBQEKG0O7FaZROfHRT-oujANeFN-ErMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=u3W6riq+uV6J42Ub
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 14:48:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpHoo-0004nW-4E
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 14:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934599Ab3FSMsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 08:48:54 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:57202 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934408Ab3FSMsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 08:48:53 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jun 2013 08:48:53 EDT
Received: from odin.tremily.us ([unknown] [72.68.89.128])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MON004HN24O6L50@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 19 Jun 2013 06:48:36 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id ADB53A3AC45; Wed,
 19 Jun 2013 07:48:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371642503; bh=nKQ4f1G6AgnONxlIMMe17GGcF9LarhOdr1Psa2JN9jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kxkk38s4cyJE3OuGZKt66XDTY+PntNgbnmYyAgcCnLFcarAlON7VyFJsUBrcuvKwz
 SnqsmwTwkP1iL60px6PKlAyO5K+NYp05ca3RRnhWlfRms0ev0kiwEMYJqime7UL0pJ
 rjYWe2+QsA6eVjcJ6WdTt7FWOozfWOTREmsglz6o=
Content-disposition: inline
In-reply-to: <CAJDDKr75PwVjJ-hs=1eBQEKG0O7FaZROfHRT-oujANeFN-ErMw@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228393>


--u3W6riq+uV6J42Ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2013 at 10:05:50PM -0700, David Aguilar wrote:
> On Tue, Jun 18, 2013 at 6:55 PM, W. Trevor King <wking@tremily.us> wrote:
> > -$ git clone --bare -l -s /pub/scm/.../torvalds/linux-2.6.git \
> > +$ git clone --bare -l -s /pub/scm/.../torvalds/linux.git \
> >      /pub/scm/.../me/subsys-2.6.git
>=20
> Perhaps subsys.git instead of subsys-2.6.git too?

Good point.  `git grep -- -2.6.git` also turns up a few references to
git://linux-nfs.org/pub/nfs-2.6.git, but I can't figure out where that
has gone.  It looks like the NFS folks only have personal repositories
anymore [1].

Cheers,
Trevor

[1]: http://git.linux-nfs.org/

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--u3W6riq+uV6J42Ub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRwZqBAAoJEKKfehoaNkbt7AgP/iuPuSwob8+OylqCDXUX660J
4yBigbhSGwBXbz2xCzL3FpwVJKx+cxnja6l9ZMG+GMNVPP0PQLCTfWmmkBdtn09q
743srtMPNgBCmk3ADMSPS0i+kcLdErhPsHCByGLvZBndz8X5uQ1FzbqrreVSbZCB
Uj7KLO5XwltKMm50JaywUXjcAJOg7ZZ1305IR2ItJ5ysejBbyAPIqDy9nsuR0fa5
OFg0JEPA1mzJwNRdmoUcc34pCv/fVZFIfujKA9UduzsazuLReWKSA+fXF7tU8A7p
WbC2xb3OpplMV8YJ9RlsqpOBx7hauKDP47h72xeD+XI1AqDT0nsid99OcRIXC+Em
ZDd5u3NUpLXopcNZn/1n99kHd4wIjCvgMgpAwusrYo9QolwxvVDR/RVLGo87ZXLd
cI/QTafU6PuOLkYR0/HbQWhEk3mXHdVVQa1i4j4Z6/Ii66rf98MzHixGIVdZlOXj
SPNv9kPyKyR3LGawKHsmD80YDFJRNvVUecIJ2S3BssbewfMggvdvAU89Yy0ldwzF
QwT5+psbCWk5hEEF81SvrsJMqbVwqJNd1W7LEPSkaQSd9KEepVgzh6p+HppFJR2l
mg18PRW5zpb4YdkLh5mYJ8qE7BAXN8UR9UvJ7v7glcsgogUmm2LhE8yXw4PNTLXF
Bws+bP5xLH3IF57bs2A7
=u9Ms
-----END PGP SIGNATURE-----

--u3W6riq+uV6J42Ub--
