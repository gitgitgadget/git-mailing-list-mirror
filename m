From: Martin Waitz <tali@admingilde.org>
Subject: Re: comparing file contents in is_exact_match?
Date: Thu, 6 Jul 2006 09:41:34 +0200
Message-ID: <20060706074134.GC12512@admingilde.org>
References: <20060706055729.GA12512@admingilde.org> <7vd5cj9rvm.fsf@assigned-by-dhcp.cox.net> <20060706071629.GB12512@admingilde.org> <7vwtar89wy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 09:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyOUY-0002X5-KX
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 09:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWGFHlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 03:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWGFHlg
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 03:41:36 -0400
Received: from admingilde.org ([213.95.32.146]:26797 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S964949AbWGFHlg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 03:41:36 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FyOUQ-0000UC-TT; Thu, 06 Jul 2006 09:41:34 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtar89wy.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23379>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2006 at 12:33:33AM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> > so perhaps we need three phases instead of two:
> > first sort out all renames that can be detected by the sha1,
> > then compare file contents and finally do the diff.
>=20
> Makes sort-of sense.
>=20
> Although I am not sure how much this would help with a regular
> workload, maybe something like this untested patch might help
> your situation?

patch looks good, I'll try it in the evening.

--=20
Martin Waitz

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFErL6uj/Eaxd/oD7IRAlQZAJwKFl/++1Ysjce2hfKPMjMzFxB65ACfTyCX
ovkyCkukkaSVySpqpc4TExg=
=AVF1
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
