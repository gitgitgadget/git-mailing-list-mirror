From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [REPLACEMENT PATCH] parse-opt: fake short strings for callers to  believe in.
Date: Thu, 26 Jun 2008 11:37:32 +0200
Message-ID: <20080626093732.GC7237@artemis.madism.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <1214298732-6247-1-git-send-email-madcoder@debian.org> <1214298732-6247-2-git-send-email-madcoder@debian.org> <1214298732-6247-3-git-send-email-madcoder@debian.org> <1214298732-6247-4-git-send-email-madcoder@debian.org> <1214298732-6247-5-git-send-email-madcoder@debian.org> <1214298732-6247-6-git-send-email-madcoder@debian.org> <20080624205801.GG9189@artemis.madism.org> <20080626083506.GA7237@artemis.madism.org> <7v7iccsi6n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="A6N2fC+uXW/VQSAv";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 11:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBnw0-0003in-55
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 11:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbYFZJhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 05:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbYFZJhg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 05:37:36 -0400
Received: from pan.madism.org ([88.191.52.104]:33835 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376AbYFZJhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 05:37:35 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 09CCB3884C;
	Thu, 26 Jun 2008 11:37:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9B9E2A54F; Thu, 26 Jun 2008 11:37:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7iccsi6n.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86421>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2008 at 08:40:16AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   I saw that you merged this series into pu, for which I'm really glad,
>=20
> Heh, you shouldn't be glad to have "landed" on 'pu', as being in 'pu' is
> just a sign of "undecided" ;-)
>=20
> And thanks for a reminder.  Every bit of help to make integration smoother
> really helps.

  You're welcome.

> I've been swamped and I still have your "revisions: refactor
> init_revisions and setup_revisions" sitting in my inbox.

  Well I'll resubmit it probably in some kind of improved way that mixes
better within the parse-options stuff. Trust me for not forgetting about
it. IOW the refactor will remain, but it will probably become some kind
of series with a second refactor where parse_revisions has a
'eat-one-option-at-a-time' behavior as well.

  Though I believe the current stuff I point you to, to be quite ready
(except for the builtin-blame proof of concept that is .. a PoC, not
really meant for next), and once it'll be ready for next, I'll try to
work on the options in git again, because it can be done in an
incremental way now :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhjY1wACgkQvGr7W6HudhwIlgCgkQ6q1FvWvFegbxXa/VEpmyXn
dfUAn1b8rcjWdZgnozeOWCPGnq+w5n98
=etMy
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
