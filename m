From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Use parseopts in builtin-fetch
Date: Mon, 05 Nov 2007 20:48:16 +0100
Message-ID: <20071105194816.GA8939@artemis.corp>
References: <Pine.LNX.4.64.0711042233590.7357@iabervon.org> <20071105085513.GB25574@artemis.corp> <7vir4gqzdu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="M9NhX3UHpAaciwkO";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 20:48:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7w3-0003oj-7n
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbXKETsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 14:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXKETsT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:48:19 -0500
Received: from pan.madism.org ([88.191.52.104]:39399 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbXKETsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:48:18 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8BF432899C;
	Mon,  5 Nov 2007 20:48:17 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A06F320E80C; Mon,  5 Nov 2007 20:48:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vir4gqzdu.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63542>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 07:13:33PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Mon, Nov 05, 2007 at 03:35:34AM +0000, Daniel Barkalow wrote:
> >> I mostly did this and the next one for practice with the API. I'm=20
> >> impressed that "git fetch -vv" is even handled correctly without anyth=
ing=20
> >> special.
> >
> >   About that: OPTION_BOOLEAN increments the associated variable, to
> > support this case specifically.
> >
> >   The last thing that really miss in parse-options is a way to recurse
> > into a sub-array of struct option, to be able to port the generic diff
> > and revision arguments.
>=20
> Another micronit is I found lacking is that it is a bit too
> cumbersome to accept only a subset of integer as a value
> (e.g. "this option takes a positive integer, not zero nor
> negative").  The caller can set up a callback to handle that,
> though.

As a general rule we may want to have some kind of "ranged" integers.
but like you said the callback is always here for that, and if we begin
to have dozens of those we may consider creating a new type for those if
needed.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL3OAvGr7W6HudhwRAqURAJ9XS8Pwz35KAKKYzfLHLyRTqDb8PgCfQKzt
tYv/iEB2tLCZ5Ucxw+N1sNk=
=G8u7
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
