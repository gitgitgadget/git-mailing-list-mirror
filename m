From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: Last mile for 1.0
Date: Mon, 06 Jun 2005 09:29:09 -0400
Message-ID: <1118064550.8970.29.camel@jmcmullan.timesys>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net> <7vzmu4weod.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-8uRQSm5RzcaLqrXWqkEr";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "GIT Mailling list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:27:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfHcU-00032d-Qu
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 15:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVFFN3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 09:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVFFN3g
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 09:29:36 -0400
Received: from mail.timesys.com ([65.117.135.102]:38890 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261449AbVFFN3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 09:29:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 06 Jun 2005 09:29:10 -0400
In-Reply-To: <7vzmu4weod.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Mon, 6 Jun 2005 09:22:11 -0400
Message-ID: <1118064550.8970.29.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Last mile for 1.0
thread-index: AcVqmr7leQiejFpkRsGLOtGncXb0eA==
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-8uRQSm5RzcaLqrXWqkEr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-06-05 at 16:45 -0700, Junio C Hamano wrote:
> I did not mention git-sync by Jason McMullan on my list of "what
> I want to have in 1.0", but that was not because I object to the
> idea of having a sync mechanism that knows and takes advantage
> of how GIT works.  Quite the contrary.
>=20
> [snip snip]
>
> I just do not feel, judging from its current protocol command
> set, it offers enough improvements over what git-ssh-push/pull
> pairs already give us; I'd be happy to be corrected, of course,
> if this is a misconception.

Oh, I definitely agree. git-sync is *not* 1.0 material. The protocol
and feature set are still being worked on, and git-ssh-* may even
be a better fix than git-sync for many scenarios.

What I *do* want to get into git 1.0 is a merge of git-sync's=20
verify-before-write update semantics into pull.c. I should be
able to get that to you before tomorrow.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-8uRQSm5RzcaLqrXWqkEr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpE+l8/0vJ5szK6kRAsHsAJ9OKUUBVHbWIDPfTuSo36EQOrGkXQCglFmE
1pU6wuIzutw6J0km3Vjw1y4=
=qydD
-----END PGP SIGNATURE-----

--=-8uRQSm5RzcaLqrXWqkEr--
