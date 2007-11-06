From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Tue, 06 Nov 2007 20:37:00 +0100
Message-ID: <20071106193700.GA4382@artemis.corp>
References: <20071105175654.GD6205@artemis.corp> <20071106175627.GB9517@artemis.corp> <20071106180910.GA25934@sigill.intra.peff.net> <7vwssvgrm6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="BOKacYhQ+x31HxR3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 20:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUEj-00052w-9j
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 20:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbXKFThG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 14:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbXKFThF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 14:37:05 -0500
Received: from pan.madism.org ([88.191.52.104]:34941 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbXKFThE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 14:37:04 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C4F0126487;
	Tue,  6 Nov 2007 20:37:01 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id DC853F9B9; Tue,  6 Nov 2007 20:37:00 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vwssvgrm6.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63705>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 06:23:45PM +0000, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Tue, Nov 06, 2007 at 06:56:27PM +0100, Pierre Habouzit wrote:
> >
> >>   On the same vein, with today's next:
> >>=20
> >>     $ git push origin :teaser
> >>     To ssh://git.corp/srv/git/mmsx.git
> >>      - [deleting]        teaser
> >>     refs/heads/teaser: 05518bc7df1af680447f58b034b108f66668db03 -> del=
eted
> >>     Everything up-to-date
> >>     fatal: Invalid revision range 05518bc7df1af680447f58b034b108f66668=
db03..0000000000000000000000000000000000000000
> >>     fatal: ambiguous argument 'refs/heads/teaser': unknown revision or=
 path not in the working tree.
> >>     Use '--' to separate paths from revisions
>=20
> Isn't this coming from a loosely written post-receive hook that
> wants to send mail or something and forgets that a ref could be
> removed?

  oooh you may be right indeed. it's probably it, I was too quick in
assuming this was a new issue with git push, I never removed a branch on
that remote yet, and it indeed has a post-receive hook.

  thanks and sorry for the noise.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMMJcvGr7W6HudhwRAgf/AKCd3Qpw+H9qxGaGUfOIoKOXh/tgigCfTg5T
XTvW3ZWMDgUVfle462uPon4=
=dwuJ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
