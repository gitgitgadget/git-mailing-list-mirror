From: Keith Packard <keithp@keithp.com>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 21:02:27 -0700
Message-ID: <1151985747.4723.102.camel@neko.keithp.com>
References: <1151949764.4723.51.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
	 <1151973438.4723.70.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JoDekWSRWve2I/ykgFwv"
Cc: keithp@keithp.com
X-From: git-owner@vger.kernel.org Tue Jul 04 06:02:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxc7Z-0005ba-QP
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 06:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWGDECc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 00:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWGDECc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 00:02:32 -0400
Received: from home.keithp.com ([63.227.221.253]:47374 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751158AbWGDECb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 00:02:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 926C413001F;
	Mon,  3 Jul 2006 21:02:30 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5TjTl09FGAVg; Mon,  3 Jul 2006 21:02:30 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 32FD413001E; Mon,  3 Jul 2006 21:02:30 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 29E6214001;
	Mon,  3 Jul 2006 21:02:30 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 390A06AC24A; Mon,  3 Jul 2006 21:02:28 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23246>


--=-JoDekWSRWve2I/ykgFwv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-03 at 20:21 -0700, Linus Torvalds wrote:

> Keithp, can you try this trivial patch? It _should_ say something like

Yeah, it says that only once. And, it runs the fetch-pack in about .5
seconds. And, now the whole process completes in 4.7 seconds; perhaps
the remote server is less loaded than earlier this afternoon? It's also
possible that I was running old git bits here, but I don't think so.

> And then it should leave a "fetch.trace" file in your working directory,=20
> which should show where that _one_ thing spends its time.

It looks boring to me and spent 0.55 from start to finish. I can send
along the whole trace if you have an acute desire to peer at it.

--=20
keith.packard@intel.com

--=-JoDekWSRWve2I/ykgFwv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEqehTQp8BWwlsTdMRAkO3AJ9CV6qPVynyLD+kh5E2AqDQwxR6KwCguWeG
z9VVmhdHuEn4EtMvm88q97s=
=bbLJ
-----END PGP SIGNATURE-----

--=-JoDekWSRWve2I/ykgFwv--
