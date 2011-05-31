From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Git global usage and tests
Date: Tue, 31 May 2011 11:05:54 +0200
Message-ID: <20110531090554.GE28708@centaur.lab.cmartin.tk>
References: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
 <20110530153620.GA24431@sigill.intra.peff.net>
 <B369AA28-DEF2-48F3-8E4E-F387E8A57D26@gmail.com>
 <20110530161230.GA25291@sigill.intra.peff.net>
 <buor57f78s0.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Cc: Jeff King <peff@peff.net>,
	Romain Geissler <romain.geissler@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 31 11:06:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRKtn-0003in-Tx
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 11:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756577Ab1EaJF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 05:05:58 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:33750 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab1EaJF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 05:05:57 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9cba1.pool.mediaWays.net [77.185.203.161])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 43872461D9;
	Tue, 31 May 2011 11:05:28 +0200 (CEST)
Received: (nullmailer pid 30353 invoked by uid 1000);
	Tue, 31 May 2011 09:05:54 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Romain Geissler <romain.geissler@gmail.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Disposition: inline
In-Reply-To: <buor57f78s0.fsf@dhlpc061.dev.necel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174798>


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2011 at 02:12:47PM +0900, Miles Bader wrote:
> Jeff King <peff@peff.net> writes:
> >> Yes and No. We have already copied some code from git : parse-option,
> >> the error handling functions, a part of the run-command block and a
> >> part of the compatibility layer. To my mind, there is no reason to
> >> pull it into libgit2 as it's only a client feature that works on
> >> strings, and libgit2 does not aim at being a client, only a git
> >> library.
> >
> > Yeah, good point. Definitely it should not be part of the libgit2
> > library itself.
>=20
> But maybe there's room for another library to hold such things
> (libgitapp...)?

There are already several libraries to parse command-line options,
though IIRC from the last time I used getopt, git's parse-options is
more usable. That could be made into a new library (but which should
be git-independent)

The git-specific part of figuring out commits and commit ranges could
live inside libgit2.

Cheers,
   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN5K9yAAoJEHKRP1jG7ZzT7nwH/RBR5lBbxANV6xU04mOSYrwH
3yqMPL2OCkbp2pmxoX+VTT44WihohDvoSy9mKq3K9VepGyAdDXrbFQ2NgtDTyrG3
TexMB2hrwIyad7SMoQpq+yiRX/CrgzuKxnlBys1uBF/W5SSZKKVMEjKQLHCZ8pwB
liyjyph2GX4qDgTZK8j5zQJmAV1JZXA1WS1XrvULyaQK56ITboQ+a300IJ3Dl6yX
W32p4GnwdPvsZp2YdHJJLzx218noAlC79E1i5PWO3Oq6/fx3V3GOSlzE5wdKOzy9
JV1tU34Kn1rpp7ymyuKJQeg/ZZRLO1j1pxWw6cpdQKF8GdQ5A6aMfa0gN5O8AWk=
=zqn1
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
