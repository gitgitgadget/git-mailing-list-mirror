From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git push (mis ?)behavior
Date: Wed, 03 Oct 2007 18:28:16 +0200
Message-ID: <20071003162816.GA17403@artemis.corp>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site> <20071003160731.GA7113@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031718110.28395@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="azLHFNyN32YCQGCU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Wincent Colaiuta <win@wincent.com>,
	Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:28:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id75J-00038C-Hx
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 18:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbXJCQ2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 12:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbXJCQ2U
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 12:28:20 -0400
Received: from pan.madism.org ([88.191.52.104]:45889 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbXJCQ2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 12:28:19 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3306B7CF;
	Wed,  3 Oct 2007 18:28:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3CD0137BA3E; Wed,  3 Oct 2007 18:28:17 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Wincent Colaiuta <win@wincent.com>, Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710031718110.28395@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59856>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2007 at 04:18:56PM +0000, Johannes Schindelin wrote:
> This thread is getting painful.  Lot's of "I want"s, but nobody to date=
=20
> came up with a solution that makes both oldtimers and newtimers happy.

I think I made a proposal that tries to reach some kind of consensus:

`git push`::
    no arguments given just pushes the current branch you're on, into
    origin, if a refspec matches.

`git push <remote>`::
    works like now (aka pushes all branches that match a remote branch
    in the given remote).

This way, you can have current "git push" using "git push origin", but
you also have a convenient way to push only the current branch into your
default remote repository without needing to spell out:

  $ git push origin `git symbolic-ref HEAD`

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHA8MgvGr7W6HudhwRAnrcAKCPS7JsvYhy3p87NqtCmoB3vowdoACfWc2T
yZjHt6KCXzFL8czU+8vKb/Q=
=XGd5
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
