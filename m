From: Martin Waitz <tali@admingilde.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 18:44:28 +0200
Message-ID: <20070327164428.GR22773@admingilde.org>
References: <1174930688.5662.20.camel@localhost> <20070327115029.GC12178@informatik.uni-freiburg.de> <20070327155306.GQ22773@admingilde.org> <200703271856.09492.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZqRzwd/9tauJXEMK"
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 18:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWEmm-0005T2-6A
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 18:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933222AbXC0Qob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 12:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933226AbXC0Qob
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 12:44:31 -0400
Received: from mail.admingilde.org ([213.95.32.147]:45727 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933222AbXC0Qoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 12:44:30 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HWEma-0002yD-Mb; Tue, 27 Mar 2007 18:44:28 +0200
Content-Disposition: inline
In-Reply-To: <200703271856.09492.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43282>


--ZqRzwd/9tauJXEMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Mar 27, 2007 at 06:56:09PM +0200, Josef Weidendorfer wrote:
> On Tuesday 27 March 2007, Martin Waitz wrote:
> > For any other way to separate the odb (project id, whatever), we
> > can't get a list of references into it by a path-limited traversal
> > in the parent. Thus separate odbs which are not bound to a special
> > location have some serious downsides.
>=20
> For path-limited traversal, you still need to know all the paths
> with super/subproject boundaries somewhere in the history.
> Do you store this information somewhere?
> If so, how is this different from directly storing the boundaries
> (aside from size)?

You only need the path-limited traversal when you want to look at one
individual submodule.  And then you start the operation in this
submodule, so you know the path.

--=20
Martin Waitz

--ZqRzwd/9tauJXEMK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCUnsj/Eaxd/oD7IRAoeSAJ9K7emwGk93g8RWj7TXMU+OwfmNsQCbBeb7
2QMjFy8IkBjVibKh3TxZUxg=
=a2DK
-----END PGP SIGNATURE-----

--ZqRzwd/9tauJXEMK--
