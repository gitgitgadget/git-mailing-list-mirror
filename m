From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Wed, 07 Nov 2007 16:11:57 +0100
Message-ID: <20071107151157.GK18057@artemis.corp>
References: <20071105175654.GD6205@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6TC23+W66xmFESAX";
	protocol="application/pgp-signature"; micalg=SHA1
To: Nicolas Pitre <nico@cam.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmZp-0004re-EK
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXKGPMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbXKGPMA
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:12:00 -0500
Received: from pan.madism.org ([88.191.52.104]:52925 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbXKGPL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:11:59 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8380727DB3;
	Wed,  7 Nov 2007 16:11:58 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D06D018A55; Wed,  7 Nov 2007 16:11:57 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>,
	Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071105175654.GD6205@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63819>


--6TC23+W66xmFESAX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


oh and while we're at it, someone reminded me on IRC that when you:

  git push origin :somebranch

it does not removes origin/somebranch from your branches.  Now that git
push updates our knowledge of the remote branch, I believe that it
should also try to perform the equivalent of a:

  git branch -r -d origin/somebranch

And to be fair, I'd also say that git fetch <some-remote> should
complain about remote heads that match <some-remote> refspec that have
no corresponding reference _on_ the remote so that the user knows that
the branches have been removed.

I wanted to write a patch about that long time ago, but my plate is
already full with the diff option things.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6TC23+W66xmFESAX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMdW9vGr7W6HudhwRAt9eAJ9ic7HUmKP8twGceMiNsgfsIz0mTwCeKe2V
EDTSk2g9GsaQtl/aTcildIk=
=TxjS
-----END PGP SIGNATURE-----

--6TC23+W66xmFESAX--
