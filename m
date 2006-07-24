From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] support cover letter before commit log, using "+++"
Date: Mon, 24 Jul 2006 09:04:38 +0200
Message-ID: <20060724070438.GD20068@admingilde.org>
References: <20060723214524.GC20068@admingilde.org> <7v1wsbfq75.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 09:04:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4uUh-0002Oo-G9
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 09:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWGXHEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 03:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWGXHEk
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 03:04:40 -0400
Received: from admingilde.org ([213.95.32.146]:2717 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751426AbWGXHEj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jul 2006 03:04:39 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G4uUY-0003ez-6y; Mon, 24 Jul 2006 09:04:38 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wsbfq75.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24128>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jul 23, 2006 at 11:54:22PM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
>=20
> > We already have a "---" separator to end the commit log.
> > But writing the cover letter after this separator looks strange.
> > Now it is possible to put the cover letter and comments both before
> > or after the commit log, as the author sees fit.
> >
> > Just put the commit log between lines starting with "+++" and "---".
> >
> > Signed-off-by: Martin Waitz <tali@admingilde.org>
>=20
> I do not have problem with the implementation itself, but
>=20
> * I always had an impression that cover letters are tolerated
>   not encouraged.  In other words, as a good practice it would
>   be nice if necessary information is described in the commit
>   log messages themselves.  Do we want to start encouraging the
>   cover letter with this patch?

that's right, but:

 * before using automatic tools to generate mails from patches people
   started their mails with "hello" or something similiar.
   As these lines are frowned upon in the changelog people just stop
   being polite.

 * I have often seen patches evolving in an email thread.
   With such an separator it is possible to keep the thread history
   in one part and a clean change message in another part.

I don't really know if this +++ thing will be used much. It's just
something that I thought might be missing and it was easy to do ;-)

> * Has anybody ever used that "+++" as an auxiliary separator?
>   In other words, is it an established convention?  If not,
>   would it be a good convention that we would want to establish
>   here?

I haven't seen the "+++" before here. People have used their own
"cut here" markers somethimes but I don't think their is an
established convention already.
The "+++" just felt good in combination with the "---" end marker.

--=20
Martin Waitz

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFExHEFj/Eaxd/oD7IRAjSrAJ4m1S6KqMFeFcMrl8YSjCjQktsGuACfVUyh
btiswE93PfQdx66yhCH7tCY=
=2PTP
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
