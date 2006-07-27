From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Per branch properties for pull and fetch
Date: Thu, 27 Jul 2006 14:02:20 +0200
Message-ID: <20060727120220.GD27593@admingilde.org>
References: <87lkqfcvm2.fsf@gmail.com> <20060727085516.GC27593@admingilde.org> <8aa486160607270240h412b0dcek1d57eeb2b254fb2e@mail.gmail.com> <8aa486160607270306s3f49a01cq91ef61e2c9f005e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 14:02:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G64ZN-0004wn-FF
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 14:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWG0MCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 08:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWG0MCW
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 08:02:22 -0400
Received: from admingilde.org ([213.95.32.146]:41882 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750720AbWG0MCV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 08:02:21 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G64ZJ-0005XF-0r; Thu, 27 Jul 2006 14:02:21 +0200
To: Santi <sbejar@gmail.com>
Content-Disposition: inline
In-Reply-To: <8aa486160607270306s3f49a01cq91ef61e2c9f005e@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24281>


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Jul 27, 2006 at 12:06:34PM +0200, Santi wrote:
> >> could we default the to-be-merged branch to "remotes/$remote/$branch" =
if
> >> that exists?. That could make life a lot easier when using
> >> clone --use-separate-remote.

> On the other hand, my patch changes the behaviour only when explicitly
> configured, and your proposed default would change the behaviour even
> without changes to the config.

that is correct.

The current default is to always use the remote's master branch, right?
What do others think: does it make sense to default to the same
branchname on the remote side?

It could make life a bit easier if you want to synchronize several topic
branches between different sites.

--=20
Martin Waitz

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEyKtMj/Eaxd/oD7IRAh57AJ4poOC23TuDSgjKedNtD+dQIDjvdQCfelLE
l4dh7OQtDNf4W7SKJfavbRA=
=HBtF
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
