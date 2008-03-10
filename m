From: Vineet Kumar <vineet@doorstop.net>
Subject: Re: [PATCH] Minor wording changes in the keyboard descriptions in git-add --interactive.
Date: Mon, 10 Mar 2008 08:47:19 -0700
Message-ID: <20080310154719.GA11449@doorstop.net>
References: <1204928211-7168-1-git-send-email-vineet@doorstop.net> <7vk5ke14hp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 16:48:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYkEj-0003YW-V0
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 16:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbYCJPrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 11:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbYCJPrX
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 11:47:23 -0400
Received: from doorstop.net ([69.55.226.61]:33428 "EHLO philo.doorstop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbYCJPrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 11:47:20 -0400
Received: from vineet by philo.doorstop.net with local (Exim 4.63)
	(envelope-from <vineet@doorstop.net>)
	id 1JYkDf-000385-JD
	for git@vger.kernel.org; Mon, 10 Mar 2008 08:47:19 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vk5ke14hp.fsf@gitster.siamese.dyndns.org>
X-Request-PGP: http://www.doorstop.net/gpgkey.asc
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76739>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Junio C Hamano (gitster@pobox.com) [080307 16:05]:
> Vineet Kumar <vineet@doorstop.net> writes:
>=20
> > There were some inconsistent mixing of "this hunk" and "that hunk" refe=
rring
> > to the same hunk; I switched them all to "this".  There was also a miss=
ing
> > "the".
> > ---
> >  Documentation/git-add.txt |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> > index 4779909..bc74fc0 100644
> > --- a/Documentation/git-add.txt
> > +++ b/Documentation/git-add.txt
> > @@ -207,10 +207,10 @@ patch::
> >    and the working tree file and asks you if you want to stage
> >    the change of each hunk.  You can say:
> > =20
> > -       y - add the change from that hunk to index
> > -       n - do not add the change from that hunk to index
> > -       a - add the change from that hunk and all the rest to index
> > -       d - do not the change from that hunk nor any of the rest to ind=
ex
> > +       y - add the change from this hunk to index
> > +       n - do not add the change from this hunk to index
> > +       a - add the change from this hunk and all the rest to index
> > +       d - do not add the change from this hunk nor any of the rest to=
 index
> >         j - do not decide on this hunk now, and view the next
> >             undecided hunk
> >         J - do not decide on this hunk now, and view the next hunk
>=20
> Hmm.  Do we perhaps want to match this with the help text in
> "sub help_patch_cmd" of git-add--interactive.perl?

Yeah, personally I like those ones better; I think they're more
readable.  Any ideas on how to have them use the same source, or should
I just duplicate the ones from git-add--interactive.perl into
git-add.txt?

Vineet
--=20
http://www.doorstop.net/

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1VgH7z3S33fUb9ERAoWCAJ0ehkc7hZ9kj5p8M8nTXH7EWSvgHQCgg9j9
Xqr6ztATCjIcK6mrGtenedE=
=oQ2F
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
