From: Florian Forster <octo@verplant.org>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 10:24:48 +0200
Message-ID: <20060612082448.GA11857@verplant.org>
References: <11500407193506-git-send-email-octo@verplant.org> <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 10:25:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FphjB-0002oy-E0
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 10:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWFLIYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 04:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWFLIYu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 04:24:50 -0400
Received: from verplant.org ([213.95.21.52]:20426 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1750843AbWFLIYu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 04:24:50 -0400
Received: from octo by huhu.verplant.org with local (Exim 4.50)
	id 1Fphj6-0000Ga-NT; Mon, 12 Jun 2006 10:24:48 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
X-Pgp-Fingerprint: E7F2 3FEC B693 9F6F 9B77  ACF6 8EF9 1EF5 9152 3C3D
X-Pgp-Public-Key: http://verplant.org/pubkey.txt
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21694>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Mon, Jun 12, 2006 at 10:02:05AM +1200, Martin Langhoff wrote:
> good! git-blame/git-annotate are quite expensive to run. Do you think
> it would make sense making it conditional on a git-repo-config option
> (gitweb.blame=3D1)?

sure, that it's a big change and if it helps the kernel.org folks ;)
I'll follow-up with a patch for this in a second..

Would it help to cache `git-annotate's output, e.g. using one of the
`Cache::Cache' modules? Or is browsing of blobs too sparse for this to
result in a performance gain? I'm sure the modules could be integrated
as a weak precondition.

I have two more points regarding gitweb's configuration:
- IMHO it would make sense to move the general gitweb-configuration
  (where are the repositories, where are the binaries, etc) out of the
  script.  As far as I know the Debian maintainer of the `gitweb'
  package has asked for this before but was refused for some reason..
  Possibly a file `gitweb.conf' in the same directory as the script
  could be read and overwrite the builtin defaults..?
- If `GIT_DIR/description' is only used by gitweb it may be more
  consistent to use the git-repo-config option `gitweb.description' in
  the future.

Regards,
-octo
--=20
Florian octo Forster
Hacker in training
GnuPG: 0x91523C3D
http://verplant.org/

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEjSTQjvke9ZFSPD0RAvfXAJ9e1tV7fREojuzhsai1Quof2b5qFgCgiaQg
CurHLbHdNkRM6od8nuZOho4=
=6mkx
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
