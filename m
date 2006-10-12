From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 22:16:46 +0200
Message-ID: <20061012201646.GC10922@admingilde.org>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 23:13:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY6z5-00007M-G0
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 22:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWJLUQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 16:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWJLUQs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 16:16:48 -0400
Received: from agent.admingilde.org ([213.95.21.5]:27565 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750742AbWJLUQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 16:16:48 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GY6z0-00086B-OE; Thu, 12 Oct 2006 22:16:46 +0200
To: apodtele <apodtele@gmail.com>
Content-Disposition: inline
In-Reply-To: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28797>


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Oct 12, 2006 at 03:37:17PM -0400, apodtele wrote:
> Instead of conditionally scaling the stat graph for large changes,
> always scale it asymptotically: small changes shall appear without any
> distortions.

very nice idea!

> +	return it * width / (it + width) + 1;

but wouldn't this formula result in at least 1, even for a 0 change?
Perhaps we'd have to special case an input of 0?

--=20
Martin Waitz

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFLqKuj/Eaxd/oD7IRAm0wAJ9Gnxp6lUjr4N/gsBHsP7EPkrg+kgCfZY4s
+ZLawNizMmwhpVzw4mf4KMA=
=jgUX
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
