From: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 18:08:20 -0400
Message-ID: <200504191808.26559.pmcfarland@downeast.net>
References: <20050418210436.23935.qmail@science.horizon.com> <1113874931.23938.111.camel@orca.madrabbit.org> <4264677A.9090003@qualitycode.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart33761097.nbFnd1nHun";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Kevin Smith <yarcs@qualitycode.com>,
	Ray Lee <ray-lk@madrabbit.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:05:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO0qH-0003Xx-RI
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVDSWJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVDSWJN
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:09:13 -0400
Received: from downeast.net ([204.176.212.2]:40173 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261682AbVDSWJG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:09:06 -0400
Received: from absolute (diablo-d3@[65.99.190.188])
	by downeast.net (8.11.6/8.10.1) with ESMTP id j3JKnaA13313;
	Tue, 19 Apr 2005 16:49:38 -0400 (EDT)
Received: from infinity ([192.168.0.2])
	by absolute with esmtp (Exim 4.50)
	id 1DO0tR-00022E-KM; Tue, 19 Apr 2005 18:08:29 -0400
To: darcs-devel@darcs.net
User-Agent: KMail/1.8
In-Reply-To: <4264677A.9090003@qualitycode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--nextPart33761097.nbFnd1nHun
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 18 April 2005 10:05 pm, Kevin Smith wrote:
> The big feature of a darcs replace patch is that it works forward and
> backward in time. Let me try to come up with an example that can help
> explain it. Hopefully I'll get it right. Let's start with a file like
> this that exists in a project for which both you and I have darcs repos:
>
> cat
> dog
> fish
>
> Now, you change it to:
>
> cat dog
> dog
> fish
>
> while I simultaneously do a replace of "dog" with "plant", resulting in:
>
> cat
> plant
> fish
>
> We merge. The final result in both of our trees is:
>
> cat plant
> plant
> fish
>
> Notice that just by looking at my diffs, you can't tell that I used a
> replace operation. I didn't just replace the instances of "dog" that
> were in my file at that moment. I conceptually replaced all instances,
> including ones that aren't there yet.

I think that's the best explanation of how it works. And that is partially =
why=20
darcs is so powerful.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart33761097.nbFnd1nHun
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCZYFa8Gvouk7G1cURAu9RAJ90H3DrZTmkHc81pSBUVXgNW7uWnwCdHRdc
+BJn5loO5apMrsLd7OY2/Zo=
=E9Ks
-----END PGP SIGNATURE-----

--nextPart33761097.nbFnd1nHun--
