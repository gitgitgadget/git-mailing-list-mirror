From: martin f krafft <madduck@madduck.net>
Subject: Re: publishing a forked^W cloned directory with ancestry
Date: Thu, 30 Aug 2007 21:47:16 +0200
Message-ID: <20070830194716.GA19861@piper.oerlikon.madduck.net>
References: <20070830192533.GA18751@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Cc: mdadm development team <pkg-mdadm-devel@lists.alioth.debian.org>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 21:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQpzP-0001V9-8W
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 21:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849AbXH3TrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbXH3TrZ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 15:47:25 -0400
Received: from clegg.madduck.net ([82.197.162.59]:57468 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbXH3TrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 15:47:24 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 3B5D6BE93;
	Thu, 30 Aug 2007 21:47:17 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C8BE19F161;
	Thu, 30 Aug 2007 21:47:16 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 84A6843F4; Thu, 30 Aug 2007 21:47:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070830192533.GA18751@piper.oerlikon.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4109/Thu Aug 30 19:18:52 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57060>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2007.08.30.2125 +0200]:
> And then I wonder: how do I now publish this result of my work? I'd
> like to push my repository to git.debian.org so that others can
> clone it and help or submit patches against the debianised upstream.

With this I mean: it would just be nice if people cloning the
git.debian.org repo could also use the upstream refs. I am aware
that the pack they download is complete in the sense that they can
just build after cloning (thanks to Harri Ilari Tapio Liusvaara
though for clearing this up for me a bit). After all, this is what
I meant when I wrote:

> I guess the cleanest solution I can come up with is to branch off
> upstream/master into branch "upstream" whenever *I* decide it's time
> to snapshot. Then, people using my repo would basically be confined
> to the state of the tree as it was the last time I rebased
> "upstream", but could work freely on the Debian-specific stuff.

But I guess in the Debian world, a bug may be fixed upstream before
it is fixed in Debian (not only because Debian is allegedly
outdated, also because our users and developers often cooperate
directly with upstream), and then when someone jumps in for me to
release a new mdadm package, they might just need to rebase to the
latest upstream HEAD.

Is it possible to enable this with git without asking those people
to first set up their local repo to reference git.debian.org *and*
upstream, all of which is likely going to be more than four
commands?

Harri hinted at using Makefiles, and sure, I can use the Makefile to
set up upstream if it's not already present, but I'd much rather
have a standard way that's going to be the same across all
git-maintained Debian packages.

Comments welcome,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"no woman should ever be quite accurate about her age.
 it looks so calculating."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG1x7EIgvIgzMMSnURApxSAJ9tQMhGDrRtrm1hnJOj4r5A3IT4HQCgxhZK
Hq4TybjKfBRN3r5s1dIVMIU=
=oxXl
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
