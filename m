From: Jan Hudec <bulb@ucw.cz>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 20:27:03 +0100
Message-ID: <20071126192703.GB25784@efreet.light.src>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwjcA-0002QK-FX
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbXKZT1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbXKZT1M
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:27:12 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:48140 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588AbXKZT1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:27:11 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 928F776D7D;
	Mon, 26 Nov 2007 20:27:08 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id hvtdRY8waclw; Mon, 26 Nov 2007 20:27:05 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3743257671;
	Mon, 26 Nov 2007 20:27:05 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Iwjbj-0006qW-Cz; Mon, 26 Nov 2007 20:27:03 +0100
Content-Disposition: inline
In-Reply-To: <858x4l2apc.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66097>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 18:11:43 +0100, David Kastrup wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > If you would write git from scratch now, from the beginning, without
> > concerns for backwards compatibility, what would you change, or what
> > would you want to have changed?
>=20
> Get rid of plumbing at the command line level.  It is confusing to

No, please. It's extremely useful. It should be a bit more hidden, but it's
a big advantage of git that the plumbing is available.

> users, and command line arguments, exec calls and I/O streams are not
> efficient and reasonably typed mechanisms for the kind of operations
> done in plumbing.  Instead using a good extensible portable scripting
> language (I consider Lua quite suitable in that regard, but it is
> conceivable that something with a native list type supporting easy
> sorts, merges and selections could be more efficient) and implementing
> plumbing in that or in C would have been preferable for creating the
> porcelain.

POSIX shell is really the best extensible portable scripting language
available for the job. Because the whipuptitude is the most important
property and shell is simply best at one-liners. And since you use it
for regular work (running editor, compiler, git porcelain), it is the
obvious choice for whiping up a short function.

> That would keep plumbing out of the hair of users and make it easier to
> cobble together extensions and variations with non-trivial internal
> dataflow.
>=20
> Shell scripts have also proven to be a constant hassle with regard to
> portability and bugs (like underquoting).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHSx4HRel1vVwhjGURAktvAKDH/Jhi/KAwy8qEyTuGOHEFZrejFQCgtuX5
Lye4eCRPjQlorFChasXZtmY=
=t4uX
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
