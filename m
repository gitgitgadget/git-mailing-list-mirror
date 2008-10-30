From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next  CLI revamp
Date: Thu, 30 Oct 2008 17:43:57 +0100
Message-ID: <20081030164357.GJ24098@artemis.corp>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030143918.GB14744@mit.edu> <20081030144321.GF24098@artemis.corp> <20081030163056.GA8899@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="SLfjTIIQuAzj8yil";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 30 17:45:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvaeA-0000J8-My
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbYJ3QoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753897AbYJ3QoG
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:44:06 -0400
Received: from pan.madism.org ([88.191.52.104]:50191 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbYJ3QoF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:44:05 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id ECD853B3DD;
	Thu, 30 Oct 2008 17:43:58 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id EEC1F5EE23A; Thu, 30 Oct 2008 17:43:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081030163056.GA8899@mit.edu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99497>


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2008 at 04:30:56PM +0000, Theodore Tso wrote:
> On Thu, Oct 30, 2008 at 03:43:21PM +0100, Pierre Habouzit wrote:
> >=20
> > git format-patch origin/next.. works already. I'm used to the asymetric
> > git format-patch origin/next syntax, and I would be sorry if it
> > disappeared though, and I see no really good reason to get rid of it.
>=20
> The reason why it annoys me is because I often what to cherry-pick a
> single patch to send to someone, and so while "git show 332d2e78"
> shows me the patch, but if I want to use git-send-email for that
> particular patch, "git format-patch 332d2e78" doesn't DTRT.  I have to
> type "git format-patch 332d2e78^..332d2e78" instead.  I've learned to
> live with it, but it's annoying each time I have to do it.
[...]
> (And I get annoyed when I want to run git format-patch on a single
> patch not at the tip of the tree; but if it's just me, I can write a
> "git format-single-patch" wrapper script to get around it.)

In fact I believe that what we lack is a shorthand for:

$sha1^..$sha1 because that would solve both of your issues, and it's
something that has bothered me in the past too for other commands.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJ5E0ACgkQvGr7W6Hudhx3PQCgpokvxysxKB1zIXhTlYWg3GWP
Gs4AnRiEDQsOjmAeDLZ3EE9AJQVgRnp0
=0zQi
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--
