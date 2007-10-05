From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 17:56:47 +0200
Message-ID: <20071005155647.GC20305@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp> <20071005143014.GA18176@glandium.org> <20071005144540.GM19879@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="2/5bycvrmDh4d1IB";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Mike Hommey <mh@glandium.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdpXv-0001of-2h
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbXJEP4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 11:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757269AbXJEP4u
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:56:50 -0400
Received: from pan.madism.org ([88.191.52.104]:45976 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672AbXJEP4t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 11:56:49 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 35AB3238E4;
	Fri,  5 Oct 2007 17:56:48 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D85211E11F; Fri,  5 Oct 2007 17:56:47 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>,
	Mike Hommey <mh@glandium.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60099>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On ven, oct 05, 2007 at 03:45:36 +0000, Medve Emilian-EMMEDVE1 wrote:
> You probably already considered and rejected the GNU argp parser. I
> used it before and I'd like to know reasons I should stay away from
> it.

  Because it's GNU and that it's a heavy dependency to begin with.
Moreover, getopt_long doesn't deal with argument types (like integers).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBl6/vGr7W6HudhwRAqFYAJwNgMhHkdvwH+ggaOlXGIcSMOKp5gCdHwJT
dJkJF2Majr0gh81rHkkteTU=
=0x8d
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
