From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] convert shortlog to use parse_options
Date: Sun, 02 Mar 2008 09:11:40 +0100
Message-ID: <20080302081139.GA5407@artemis.madism.org>
References: <20080301090231.GA16937@coredump.intra.peff.net> <7v8x124wfd.fsf@gitster.siamese.dyndns.org> <20080302061541.GA3935@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wac7ysb48OaltWcw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 02 09:12:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVjJI-0007ik-F0
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 09:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYCBILo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 03:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbYCBILo
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 03:11:44 -0500
Received: from pan.madism.org ([88.191.52.104]:44473 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbYCBILn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 03:11:43 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B110730555;
	Sun,  2 Mar 2008 09:11:41 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 1E48A7935; Sun,  2 Mar 2008 09:11:40 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080302061541.GA3935@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75747>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2008 at 06:15:42AM +0000, Jeff King wrote:
> #define OPT__REVISION(x) \
>         OPT_BOOLEAN(0, "no-merges", &(x)->no_merges, "don't show merges"),
>         OPT_BOOLEAN(0, "boundary", &(x)->boundary, "show boundary commits=
"),
>         ...
>=20
> and we could have unified options tables. I seem to recall some work
> being done in this area early on in the parse-options history, but I
> can't seem to find any mention of it in the list archive. Pierre, does
> this ring a bell?

  Yes, I didn't had the time to finish that, I just started some ground
works in the diff options area, I hope I didn't lost that work, it's
probably somewhere on my public repository. Though revision parsing are
special because of --not, but I think the proper solution wrt --not and
--all in revision parsing is to ask parse-opt to "let" some options stay
as arguments, and do the final revision parsing with them kept.

  Like you may have noticed, I didn't have a lot of time for git
recently, and that's a shame :| But maybe your mail will beat me into
working on this again now that 1.5.4 is released, because I also feared
that reworking diff and revision parsing options will probably introduce
quite a few regressions, and it's rather better doing so at the
beginning of a release cycle :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHymE7vGr7W6HudhwRAsj4AJ9urBg7UsPnL8QfTQdlnG/DzwMe8QCeP0hF
eglMMyjQ55dVVrzGv/BVaSg=
=GPR+
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
