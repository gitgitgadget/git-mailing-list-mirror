From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Pushing to a remote repo from a remote repo?
Date: Sun, 15 Apr 2012 01:02:21 +0200
Message-ID: <1334444541.7825.1.camel@beez.lab.cmartin.tk>
References: <CAAnwhhWTcfOi+qqXPnGNXSKHbFh5L=+6eSKaaex5mq6VTwSxEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-oH1ooCxeKb4Ipj03Q6U7"
Cc: git@vger.kernel.org
To: Brian Cardarella <brian@dockyard.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 01:02:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJBzJ-0008H8-HT
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 01:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab2DNXCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 19:02:32 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:49343 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992Ab2DNXCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 19:02:31 -0400
Received: from [192.168.1.2] (brln-4d0c3c42.pool.mediaWays.net [77.12.60.66])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id D3D3C46051;
	Sun, 15 Apr 2012 01:02:10 +0200 (CEST)
In-Reply-To: <CAAnwhhWTcfOi+qqXPnGNXSKHbFh5L=+6eSKaaex5mq6VTwSxEw@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195530>


--=-oH1ooCxeKb4Ipj03Q6U7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-04-14 at 18:08 -0400, Brian Cardarella wrote:
> So I have a destination repo that is remote. And I have a source repo
> that is also remote. I would like my local machine to act as a proxy
> to allow me to push to the destination from the source without ever
> download the repo to my machine. Is this possible?

Using your computer as a proxy and avoiding downloading the information
to your computer are mutually exclusive goals.

At any rate, git doesn't support this kind of operation. If you want to
move data from A to B, you need to push from A or fetch from B (or fetch
from A to C and then push from C to A).

   cmn


--=-oH1ooCxeKb4Ipj03Q6U7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPigH9AAoJEHKRP1jG7ZzTyb4H/jrwZmzchsFwtjbjTD8kiRxt
3fKf5phHC3TyEaR0BMCqrcR5AC7jXgXOyUaru8E6nL7foMWj8txIOK4EWLKu6L9t
gJLK4j6Xc6mC3DLsIRBTSkcz4IutXt3P3IaOQI54ZGRPjb483RXXwVHILwzixRr4
OvziiJcuJOG1xxVfUeBiK7nIejQznY/tVUJT0n/vhBO3TYAjNfeZLXeGRG6tDZs0
KTeNhX4sHcHmBnFj3lFGrfL1m33h0oSf8LYKsVUAWrCo0QaCiVzkXAg1VLiIVe4j
oaAnpp4WfghnHckBGQ2/8xGaxUKDXOsVYAsD41T21Vd0Qlt88lfxF4zdNjSlX+k=
=9u1L
-----END PGP SIGNATURE-----

--=-oH1ooCxeKb4Ipj03Q6U7--
