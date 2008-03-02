From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] convert shortlog to use parse_options
Date: Sun, 02 Mar 2008 09:29:51 +0100
Message-ID: <20080302082951.GC5407@artemis.madism.org>
References: <20080301090231.GA16937@coredump.intra.peff.net> <7v8x124wfd.fsf@gitster.siamese.dyndns.org> <20080302061541.GA3935@coredump.intra.peff.net> <20080302081139.GA5407@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="96YOpH+ONegL0A3E";
	protocol="application/pgp-signature"; micalg=SHA1
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 09:30:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVjay-00024T-Lc
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 09:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbYCBI3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 03:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbYCBI3x
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 03:29:53 -0500
Received: from pan.madism.org ([88.191.52.104]:47111 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbYCBI3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 03:29:53 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 144F63117C;
	Sun,  2 Mar 2008 09:29:52 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6A0E632FCB7; Sun,  2 Mar 2008 09:29:51 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080302081139.GA5407@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75749>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2008 at 08:11:40AM +0000, Pierre Habouzit wrote:
> On Sun, Mar 02, 2008 at 06:15:42AM +0000, Jeff King wrote:
> > #define OPT__REVISION(x) \
> >         OPT_BOOLEAN(0, "no-merges", &(x)->no_merges, "don't show merges=
"),
> >         OPT_BOOLEAN(0, "boundary", &(x)->boundary, "show boundary commi=
ts"),
> >         ...
> >=20
> > and we could have unified options tables. I seem to recall some work
> > being done in this area early on in the parse-options history, but I
> > can't seem to find any mention of it in the list archive. Pierre, does
> > this ring a bell?

  In fact everything is here:
http://git.madism.org/?p=3D~madcoder/git.git;a=3Dshortlog;h=3Drefs/heads/ph=
/parseopt

  I just resent the first patch that I sent (with a bug) not so long
time ago. The last one is the current state of work for diff opts.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHymV/vGr7W6HudhwRAvdaAKCIQkeFQq7myWzC9HidCysUSX7ifwCfS7Jh
5FChoJy1NgFIaEe5m4HAfWc=
=yLc+
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
