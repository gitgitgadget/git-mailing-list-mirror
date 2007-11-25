From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Sun, 25 Nov 2007 23:23:14 +0100
Message-ID: <20071125222314.GC21121@artemis.corp>
References: <200711252248.27904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Izn7cH1Com+I3R9J";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 23:23:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPt6-0006BG-Cv
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 23:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbXKYWXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 17:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755109AbXKYWXS
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 17:23:18 -0500
Received: from pan.madism.org ([88.191.52.104]:55882 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbXKYWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 17:23:17 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D0AC72C2F7;
	Sun, 25 Nov 2007 23:23:15 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 01D69C4EB; Sun, 25 Nov 2007 23:23:14 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200711252248.27904.jnareb@gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66017>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2007 at 09:48:27PM +0000, Jakub Narebski wrote:
> If you would write git from scratch now, from the beginning, without=20
> concerns for backwards compatibility, what would you change, or what=20
> would you want to have changed?

  * reset/checkout/revert. The commands to wonderful things, but this UI
    is a mess for the newcomer.

  * pull/fetch/push: I would have had pull being what fetch is, and
    added some --merge option to actually "do the obvious merge". But
    pull encourage "bad" behavior from the user, and confuses newcomers
    a lot.

  * I would have hidden plumbing more, using a really distinguished
    namespace (stupid example, there are probably better ways, but we
    could have git-_rev-parse or git-plumbing-rev-parse instead of
    git-rev-parse) so that it's clear to the user that those are really
    internal commands, and that he doesn't need to understand them.

    This is a big issue with git: the list of commands of git is the top
    of the iceberg from the UI point of view. People _feel_ they are
    comfortable with a tool if they get say 75% of the UI. I don't say
    it's true that understanding 75% of the UI makes you a $tool expert,
    but it's how people feel it. With git, 75% of the commands (and
    don't get me started with the options ;P) is a _lot_. bzr is way
    better at that game: there are at least as many commands, but those
    are completely hidden to the user.

    Of course having our guts easy to grok and find is a big advantage
    for the git gurus. But for the newcomer it's a disconcerting.

  There is probably more things I'd change, but those were the first UI
rumblings from me :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHSfXSvGr7W6HudhwRAkZIAJsHDujC9frweHddZodrt6XXDLGYbwCeI1Sn
8HOHM65ZmQLeXmGJm3AsDeY=
=QyTi
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
