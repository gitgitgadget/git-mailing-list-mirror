From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 03 Jun 2005 12:09:41 -0400
Message-ID: <1117814982.32257.64.camel@jmcmullan.timesys>
References: <20050603152212.GA4598@jmcmullan.timesys> <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-ccEZcXxAjfS26gmddEE1";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:09:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeEh1-0003UO-Ia
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 18:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVFCQJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 12:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVFCQJu
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 12:09:50 -0400
Received: from mail.timesys.com ([65.117.135.102]:60805 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261310AbVFCQJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 12:09:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 03 Jun 2005 12:09:42 -0400
In-Reply-To: <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Fri, 3 Jun 2005 12:02:51 -0400
Message-ID: <1117814982.32257.64.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] git-daemon server
thread-index: AcVoVbHMF6NxEXf0Rc+ZsXOqNOoIAg==
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-ccEZcXxAjfS26gmddEE1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-06-03 at 09:02 -0700, Linus Torvalds wrote:
> ie it wouldn't be a deamon at all, it would be a foreground server. So I'=
d=20
> call it just "git-server" or something.

Server.. Sounds ok. Will do.

> Anyway, technically this looks ok, but I'd hate to apply it until there i=
s=20
> something that actually uses it and an example of that usage.

Well, I use it to keep my home and work repos in sync, but yeah,
users =3D=3D 1 doesn't make a good case for inclusion.

I just want to have this out there, because I find rsync a little too
heavy handed for my taste, and I'm still hesitant about the cg-rpush
locking semantics.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-ccEZcXxAjfS26gmddEE1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCoIDF8/0vJ5szK6kRAiWZAJ0adIAKQvf33dJHyWMXNmH44lIPRACdF8HD
DOy+foYBWK0hTtUVmJkf/RM=
=1LLL
-----END PGP SIGNATURE-----

--=-ccEZcXxAjfS26gmddEE1--
