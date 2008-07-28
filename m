From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 22:59:23 +0200
Message-ID: <20080728205923.GC10409@artemis.madism.org>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="MnLPg7ZWsaic7Fhd";
	protocol="application/pgp-signature"; micalg=SHA1
To: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 23:00:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZpR-0000Fr-CZ
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 23:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbYG1U7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYG1U7Z
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:59:25 -0400
Received: from pan.madism.org ([88.191.52.104]:47645 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbYG1U7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:59:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 47C383484F;
	Mon, 28 Jul 2008 22:59:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 37EE9A288; Mon, 28 Jul 2008 22:59:23 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080728205545.GB10409@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90505>


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2008 at 08:55:45PM +0000, Pierre Habouzit wrote:
> On Mon, Jul 28, 2008 at 08:23:39PM +0000, Nigel Magnay wrote:
>   That too indeed (the "easier to clone" bit). OTOH, I don't like the
> .git/submodules idea a lot, if you mean to put a usual $GIT_DIR layout
> inside of it. With what I propose, you find objects for all your
> super/sub-modules in the usual store, which eases many things.
> Especially, I believe that when you replace a subdirectory of a project
> with a submodule, git-blame could benefit quite a lot from this to be
> able to glue history back through the submodule limits, without having
> to refactor a _lot_ of code: it would merely have to dereference so
> called "gitlinks" to the commit then tree, hence twice, and just do its
> usual work, with your proposal, we still rely on having to recurse in
> subdirectories which requires more boilerplate code.

  And of _course_ this is also true for git-log, which is like 10x as
important for me (like I don't remember if I used git-blame this year,
whereas I used git-log in the last 10 minutes ;p)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiOMysACgkQvGr7W6Hudhz/+wCgo36NACFYEFi8smT3PktwGvk5
0QoAnRvrwjX1AYVjRZ9AmmGuuqLEfd5E
=/TDx
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
