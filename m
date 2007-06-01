From: Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 1 Jun 2007 22:47:52 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706012247.57273.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr> <87zm3ju6tg.fsf@wine.dyndns.org> <7vr6ovzcgr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2088245.3TvnYBLTG4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuD6L-0001qj-7e
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 21:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763240AbXFATrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 15:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762864AbXFATrm
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 15:47:42 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:56089 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763071AbXFATrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 15:47:41 -0400
Received: from southpark.local (unknown [85.96.75.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 1B6D560132B6;
	Fri,  1 Jun 2007 22:47:32 +0300 (EEST)
User-Agent: KMail/1.9.6 (enterprise 0.20070508.662491)
In-Reply-To: <7vr6ovzcgr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48876>

--nextPart2088245.3TvnYBLTG4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 01 June 2007 22:44:36 Junio C Hamano wrote:
> Alexandre Julliard <julliard@winehq.org> writes:
> > Sorry for the late nack, but it turns out that this patch breaks diff
> > output on the Wine server for files that are not utf-8.
> >
> > The cause is apparently that decode_utf8() returns undef for invalid
> > sequences instead of substituting a replacement char like
> > decode("utf8") does.
>
> Thanks for noticing.  Will revert.

Why are reverting a correct bugfix? :( He's at most using outdated software=
=2E=20
*sigh*

/ismail

=2D-=20
Perfect is the enemy of good

--nextPart2088245.3TvnYBLTG4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmB37Ue9qviWcMsnAQLivRAAxB6nAcEc65ueHdsgBmglU08OQSS86lTC
+5lkk83a9zj372UxnbXa83nVdTNnKq9mSecej9Daowlkbr3GnuJNHJJ/Vj55E1ZM
lfQTSgwCgX+6c0nJXcjwzn+OPO0Tl6y9qRd0i/gwLXA3ZQrvO8xPRb1p0ItnadTw
/DZAWAy+DeflLS1X8JhfAI8R5d3/NPf552JmVVlcm6ep44gtIFU0whkYS9hJ+sSK
NWCpWw+TwFB0yMnyWxs0uCALhH6yN3aO4chEedFIwHy9sVl6ZNis75cB/56re7Qv
ruGH1Dt2NDVMEMw4RYQvF3SDDm7/u0kSm8t5hHZx9jhTaLPNnJaaLX5cLsRDv0Dg
2SPBd+hDFBqWEMyoFLhaLY28UTMnVhTjgJk2mX2qzS/9WICw9NDvGp/uLoROxYhA
3L7vBsoBEGrUM0fgO/Z7ttwjJVXCK/fKoCYpX5GVEWJdKnFvbrW2vtRIQTQnZy7s
K8nx06dsOyiDS+ekl1A94ikd9zUVp+lthrOOI42hOk23YEFTM4OCFH5tSVZw3Nwa
BIgtwMkDZOKqYlYChBzJudnT0tZ30A2+crd41YbuGyEIP2jZuinPho1kmQayK4LR
xpBKZU5rb2e89C0UHbY1SrG6mchw6JKyqz4CjGWBedYpC8nh+AqqQu4r1RWoasAw
yfYmx3MQ3Uk=
=5X/u
-----END PGP SIGNATURE-----

--nextPart2088245.3TvnYBLTG4--
