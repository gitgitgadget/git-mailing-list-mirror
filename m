From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Git Questions
Date: Mon, 20 Aug 2007 20:35:33 +0200
Message-ID: <20070820183533.GC8542@efreet.light.src>
References: <1187603749.11595.10.camel@tom-desktop> <87bqd2bgb0.fsf@morpheus.local> <1187612156.11595.17.camel@tom-desktop> <200708201346.21557.andyparkins@gmail.com> <e1dab3980708200559v3f1def4ft85e31afb08394790@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Tom Schinckel <gunny01@gmail.com>,
	David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INC6V-0005UR-CJ
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 20:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbXHTSfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 14:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbXHTSfo
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 14:35:44 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:43906 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbXHTSfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 14:35:43 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 46A77572CD;
	Mon, 20 Aug 2007 20:35:42 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Xf-6aEFZzQIV; Mon, 20 Aug 2007 20:35:38 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3EB1B5727C;
	Mon, 20 Aug 2007 20:35:37 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1INC69-0006eT-1m; Mon, 20 Aug 2007 20:35:33 +0200
Content-Disposition: inline
In-Reply-To: <e1dab3980708200559v3f1def4ft85e31afb08394790@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56237>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2007 at 13:59:41 +0100, David Tweed wrote:
> > On Monday 2007 August 20, Tom Schinckel wrote:
> >
> > > The reason I want to do that is so I can set up blind commits that I =
can
> > > add in a anacron job or something. The information about the files is=
n't
> > > really important
>=20
> Regarding your basic intention, I've worked on something _similar_
> using git and put it up on the web (although not got around to editing
> the git wiki) at
>=20
> http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.htm
>=20
> (with a minor update is going to go up when 1.5.3 gets released & I
> test it works.) There are two important differences with what you want
> to do:
>=20
> 1. As I recall someone else saying when talking about using SCM
> on their home directory (Joey Hess?), if you blanket record
> everything you then end up being careful about, eg, piping a
> grep search into a temporary file for some purpose, etc. So
> chronoversion takes a python function that decides if a file
> is "worth recording" (which can be by suffix or more general
> analysis).
>=20
> 2. As I've got a nervous tick of saving every couple of minutes
> (in case the editor or network I'm on dies), recording on save
> is too fine a granularity for me, so the script is designed to
> run from a cron job (I have it at once an hour) and not make
> a commit if it finds nothing has changed.

There's inotify interface in recent Linux and there is an incron
(http://inotify.aiken.cz/) tool to run action when a file changes. I didn't
actually use that tool, but from description of the Debian package it looks
like it could be used to run git whenever you save something.

> As I say, not exactly what you're looking for but it might be
> in the right direction.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyd71Rel1vVwhjGURAqXxAJ9S0zXA0fchq/nguFg+4J1+Y4ERbgCfW22n
uV9t8CnGCcuvJVqQXpx+VHk=
=dWpV
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
