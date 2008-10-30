From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Thu, 30 Oct 2008 16:01:35 +0100
Message-ID: <20081030150135.GG24098@artemis.corp>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <alpine.LFD.2.00.0810301024300.13034@xanadu.home> <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="reI/iBAAp9kzkmX4";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:03:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZ3Q-0000NV-1y
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbYJ3PBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbYJ3PBl
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:01:41 -0400
Received: from pan.madism.org ([88.191.52.104]:58573 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756568AbYJ3PBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:01:40 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id BF0B23B3DD;
	Thu, 30 Oct 2008 16:01:36 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0F8645EE23B; Thu, 30 Oct 2008 16:01:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081030145928.GA21707@glandium.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99481>


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2008 at 02:59:28PM +0000, Mike Hommey wrote:
> On Thu, Oct 30, 2008 at 07:52:53AM -0700, Shawn O. Pearce <spearce@spearc=
e.org> wrote:
> > +1 to Nico's NAK.
> >=20
> > Although I was at the GitTogether I don't remember this change to
> > checkout being discussed.  I must have been asleep reading email
> > or something.  I am _NOT_ in favor of this change; I think the
> > current behavior of "git checkout origin/master" is correct and as
> > sane as we can make it.
>=20
> Except he was talking about 'git checkout branch', not 'git checkout
> origin/branch'. And I would be fine with 'git checkout branch' doing
> what 'git checkout -b branch $remote/branch' does if $remote is unique
> (i.e. there is no other 'branch' branch in any other remote) and the
> 'branch' branch doesn't already exist.

Seconded.

Having git-checkout $foo being a shorthand for git checkout -b $foo
origin/$foo when origin/$foo exists and $foo doesn't is definitely handy.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJzE8ACgkQvGr7W6Hudhzn8QCcDL0xFLdz9cD0EzMGOFyGcyRt
IyAAnjQkKqq7t7TQvwetO9F8OhiE4XKB
=zU2W
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
