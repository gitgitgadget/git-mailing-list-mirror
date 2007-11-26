From: Jan Hudec <bulb@ucw.cz>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 22:00:06 +0100
Message-ID: <20071126210006.GG25784@efreet.light.src>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz> <alpine.LFD.0.99999.0711261417580.9605@xanadu.home> <854pf8243i.fsf@lola.goethe.zz> <20071126195750.GD25784@efreet.light.src> <85prxwzqvn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwl4F-00044a-NE
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbXKZVAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755955AbXKZVAP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:00:15 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:49375 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589AbXKZVAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:00:13 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3ECA85777F;
	Mon, 26 Nov 2007 22:00:12 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id mW+Ul23bDY-K; Mon, 26 Nov 2007 22:00:09 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 82FBC5770F;
	Mon, 26 Nov 2007 22:00:08 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1Iwl3m-00071H-Qq; Mon, 26 Nov 2007 22:00:06 +0100
Content-Disposition: inline
In-Reply-To: <85prxwzqvn.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66122>


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 21:35:56 +0100, David Kastrup wrote:
> Jan Hudec <bulb@ucw.cz> writes:
>=20
> > On Mon, Nov 26, 2007 at 20:34:25 +0100, David Kastrup wrote:
> >> Nicolas Pitre <nico@cam.org> writes:
> >> > On Mon, 26 Nov 2007, David Kastrup wrote:
> >> >> Get rid of plumbing at the command line level.
> >> >
> >> > We can't get rid of plumbing.
> >>=20
> >> What about "at the command line level" did you not understand?
> >
> > Which part of we neither can nor want did you not understant?
> >
> > The availability of plumbing is really big part of a reason why git is
> > so good and has so many scripts and tool built on top of it.
>=20
> Which is the reason I proposed making the plumbing available at a
> scripting level, not at the command line level.

But scripting in the first place means *SHELL* scripting. Or you normally u=
se
Lua command line for your daily work?

> The actual trend we are getting nowadays is locking the porcelaine,
> previously available as shell scripts, down into C code, _without_
> making use of a reasonable plumbing layer suitable for any scripting at
> all.

For myself I would say I don't think C is an appropriate tool for the job. =
It
is nice when you need to optimize things to the last instruction, but for my
taste it's unwieldy for the high-level stuff.

> So the git community at the same time praises shell scripting and
> simultanouesly replaces it without even using the available plumbing,
> _and_ claims that _both_, exclusive and incompatible approaches, are the
> perfect solution.  At the same time.  While fighting the shell
> portability fight continuously, on Unix as well as Windows.

Well, the builtins *do* use the plumbing. They just use the C functions
without using streams and forks. Isn't that what you wanted?

But the key reason for keeping the plumbing around is prototyping and
especially tailoring. Junio has many scripts (you can look at them in the
todo branch in git repo) to support his particular workflow and plumbing is
useful there. And shell is really the right tool for such things.

> I may have a big mouth, but swallowing all of this at once is beyond me.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHSzPWRel1vVwhjGURAsgvAJ4hMEJRgWqgLa+xgGWnEAG7EwuNzgCg7thF
gCAnEk5/ZiXyM76dosCSndg=
=xl5D
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
