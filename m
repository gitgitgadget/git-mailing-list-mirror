From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] (squashme) gitcli documentation fixups
Date: Mon, 17 Dec 2007 09:51:06 +0100
Message-ID: <20071217085106.GA7453@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <20071213102724.GE12398@artemis.madism.org> <7v7ijdeq4w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="bg08WKrSYDhXBjb5";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4BhG-0001dB-AQ
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbXLQIvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 03:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbXLQIvL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:51:11 -0500
Received: from pan.madism.org ([88.191.52.104]:51301 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbXLQIvK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 03:51:10 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A8B9730612;
	Mon, 17 Dec 2007 09:51:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E6419F0A; Mon, 17 Dec 2007 09:51:06 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7ijdeq4w.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68522>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 07:28:47AM +0000, Junio C Hamano wrote:
> This comes directly on top of gitcli documentation patch and is intended
> to be squashed into it.

  I obviously ack.
> -Another things to keep in mind is that long options can be negated. For
> +Boolean options with long option names can be negated by prefixing `"--n=
o-"`. For
   ^^^^^^^
Though this isn't correct: you can negate any kind of option, even one
with strings arguments, and it does makes sense. E.g. if you have some:

  foo.stringOpt =3D "value"

in your gitconfig file, then it's very handy to be able to write:

  $ git foo --no-string-opt

to be sure the gitconfig from the user won't mess with what you intend
to do. The negation of commands can be disabled (in the recent
iterations of parseopt) using a flag I don't recall the name, but it's
on by default even for non boolean options. It may make sense to do a
re-read pass of all options and see which ones it makes sense to negate
and which not.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZjh6vGr7W6HudhwRAmz3AJ458ybHkPXPT/mGfpQj1pFEVzB6GwCfU/Pg
tG4TWNjBUTFRfDsbHDc/prQ=
=MOmI
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
