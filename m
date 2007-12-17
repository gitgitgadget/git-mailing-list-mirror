From: Sebastian Harl <sh@tokkee.org>
Subject: Re: git-clone: Unobvious error messages when update-server-info has not been run
Date: Mon, 17 Dec 2007 16:47:42 +0100
Message-ID: <20071217154742.GI14889@albany.tokkee.org>
References: <20071217105541.GG14889@albany.tokkee.org> <20071217124359.GA20800@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Cc: Junio C Hamano <gitster@pobox.com>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 16:49:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ICj-0000wt-D2
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 16:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882AbXLQPrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 10:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760570AbXLQPrp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 10:47:45 -0500
Received: from mail.tokkee.org ([212.114.247.92]:36070 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760483AbXLQPro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 10:47:44 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id C5BD0364001; Mon, 17 Dec 2007 16:47:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071217124359.GA20800@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68571>


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Mon, Dec 17, 2007 at 07:43:59AM -0500, Jeff King wrote:
> On Mon, Dec 17, 2007 at 11:55:41AM +0100, Sebastian Harl wrote:
> > I was just trying to clone a repository using http but missed to run
> > git-update-server-info on the server side. git-clone aborted with the
> > following error messages:
> >=20
> >   % git clone http://some/repo.git
> >   Initialized empty Git repository in /path/repo/.git/
> >   cat: /path/repo/.git/refs/remotes/origin/master: No such file or dire=
ctory
> >   cd: 482: can't cd to /path/repo/.git/refs/remotes/origin
> >   fatal: : not a valid SHA1
> >   fatal: Not a valid object name HEAD
> >=20
> > It's kind of hard to guess where the error comes from in this case (I b=
lamed
> > Git at first). Is there some way to improve the error message in a case=
 like
> > this?
>=20
> git-clone is supposed to detect this condition, but there was a bug in
> the error checking code. Can you confirm that this patch fixes it?

Yes, this patch seems to fix it. Thanks.

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZpoeEFEKc4UBx/wRAmRGAJ42BdauhWXUk0dlDeS5R88fXYy44QCdHG+k
QQ7HawR5ha5oQyPYL2yNoVw=
=LbiI
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
