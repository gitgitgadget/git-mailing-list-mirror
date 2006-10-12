From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Fri, 13 Oct 2006 00:27:03 +0200
Message-ID: <20061012222703.GA31152@admingilde.org>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com> <20061012201646.GC10922@admingilde.org> <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com> <452EBF99.5020108@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Cc: apodtele <apodtele@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:41:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY91C-0004Sd-4Q
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWJLW1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWJLW1H
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:27:07 -0400
Received: from agent.admingilde.org ([213.95.21.5]:8112 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751213AbWJLW1E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:27:04 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GY915-00014X-Qe; Fri, 13 Oct 2006 00:27:03 +0200
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <452EBF99.5020108@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28813>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Oct 12, 2006 at 03:20:09PM -0700, A Large Angry SCM wrote:
> >+    if (it)
> >+        return it * width / (it + width) + 1;
> >+    else
> >+        return 0;
>=20
> No conditional needed:
>=20
> 	return it * width / (it + width - 1)

But then it would start scaling much earlier
(for width 10: at 2 instead of 4).
This is not bad per se, but different...

--=20
Martin Waitz

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFLsE3j/Eaxd/oD7IRAqUgAJ9isjZH51m+hKu8WCHvAf+yI/s3bACeNrv9
fPQ1AiFo0YTm0hw0wc1Q4cA=
=kXz6
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
