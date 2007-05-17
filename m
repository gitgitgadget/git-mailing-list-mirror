From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 22:26:55 +0200
Message-ID: <20070517202655.GB3079@efreet.light.src>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 22:27:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HomZb-0002ih-IK
	for gcvg-git@gmane.org; Thu, 17 May 2007 22:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761680AbXEQU1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 16:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761704AbXEQU1O
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 16:27:14 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1710 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762224AbXEQU1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 16:27:12 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.316970;
	Thu, 17 May 2007 22:26:56 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HomYp-0001C5-Uo; Thu, 17 May 2007 22:26:55 +0200
Content-Disposition: inline
In-Reply-To: <20070517124006.GO4489@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47553>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2007 at 14:40:06 +0200, Petr Baudis wrote:
> On Tue, May 15, 2007 at 10:10:06PM CEST, Jan Hudec wrote:
> >  - Can be run on shared machine. If you have web space on machine shared
> >    by many people, you can set up your own gitweb, but cannot/are not a=
llowed
> >    to start your own network server for git native protocol.
>=20
>   You need to have CGI-enabled hosting, set up the CGI script etc. -
> overally, the setup is similarly complicated as git-daemon setup, so
> it's not "zero-setup" solution anymore.
>=20
>   Again, I'm not sure just how many people are in the situation that
> they can run real CGI (not just PHP) but not git-daemon.

A particular case would be a group of students wanting to publish their
software project (I mean the PRG023 or equivalent). Private computers in the
hostel are not allowed to serve anything, so they'd use some of the lab
servers (eg. artax, ss1000...). All of them allow full CGI, but running
daemons is forbiden.

> >  - Less things to set up. If you are setting up gitweb anyway, you'd no=
t need
> >    to set up additional thing for providing fetch access.
>=20
>   Except, well, how do you "set it up"? You need to make sure
> git-update-server-info is run, yes, but that shouldn't be a problem (I'm
> not so sure if git does this for you automagically - Cogito would...).

No. If it worked similar to git-upload-pack, only over http, it would work
without update-server-info, no?

>   I think 95% of people don't set up gitweb.cgi either for their small
> HTTP repositories. :-)
>=20
>   Then again, it's not that it would be really technically complicated -
> adding "give me a bundle" support to gitweb should be pretty easy.
> However, this support has some "social" costs as well: no compatibility
> with older git versions, support cost, confusion between dumb HTTP and
> gitweb HTTP transports, more lack of motivation for improving dumb HTTP
> transport...

The dumb transport is definitely useful. Extending it to use ranges if
possible would be useful as well (and maybe more than upload-pack-over-http=
).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGTLqPRel1vVwhjGURAhGRAKDHxz7ihMKj6tApm4sf2D99H5uaIwCgkYOt
0QP8EBeKWV3Tw9I1MCQf6p4=
=J9SX
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
