From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] Add a few more values for receive.denyCurrentBranch
Date: Sat, 8 Nov 2014 18:48:32 +0000
Message-ID: <20141108184832.GA167774@vauxhall.crustytoothpaste.net>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
 <f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de>
 <20141108111855.GA21620@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 19:48:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnB40-0002Nc-QJ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 19:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbaKHSsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 13:48:40 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49901 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752119AbaKHSsj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2014 13:48:39 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 04D362808F;
	Sat,  8 Nov 2014 18:48:36 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20141108111855.GA21620@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2014 at 06:18:55AM -0500, Jeff King wrote:
> On Fri, Nov 07, 2014 at 02:58:17PM +0100, Johannes Schindelin wrote:
>=20
> > Under certain circumstances, it makes a *lot* of sense to allow pushing
> > into the current branch. For example, when two machines with different
> > Operating Systems are required for testing, it makes much more sense to
> > synchronize between working directories than having to go via a third
> > server.
>=20
> FWIW, I do this without a third server (and without resorting to pull),
> with:
>=20
>   host1$ git push host2 master:refs/remotes/host1/master
>   host2$ git merge host1/master
>=20
> You can even set up a push refspec to make "git push host2" do the right
> thing.

I do something similar, but it's inconvenient when the repo you're
pushing into is $HOME, since you have to type something like "exec zsh
-l" in order to fix things up.

> That being said, I do like the premise of your patch, as it eliminates
> the extra step on the remote side (which is not that big a deal in
> itself, but when you realize that host2 _did_ have some changes on it,
> then you end up doing the merge there, when in general I'd prefer to do
> all the work on host1 via "git pull").

I agree.  This is very useful.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUXmWAAAoJEL9TXYEfUvaLjAIQAIaTeCNuD1R0tcLvK+EHctk0
4fnuM5+ylRX4X288KUegyTnJfP5cre/LV3aiynciDQMmv0/ZZltCM+50TAWUWrLP
KJ/B3muOC6bvDrkIxhCZM6FkbPGrBiTn0/9e6fP2pt3YHU/t7wNJJpSpINF2liUh
8ciIJXaT58bnpzpbPIJTydUSiHlQe/2Ntue9M2NeI2pGw20WcFhYtUhJ/QhUHW53
Y3W+ZIjZLh7VKzFAwjs/l4/N4ext4AaDPomVGqW2t5x+zciPrNgQkoIBXpoIP7O6
w+NT89aUnWz0zxd/AjpKhXbJhNqFZG9ayOXYrtayYHXxqKWNYNT0xnjFPuuvZs0d
1elAWfMNCx0oh86lskEZ7USpfV+o+R4e6tQRlUi1cLevcbR+3RmT1NKq6qzdmZ3l
Ywq0XUnXBPzYzQrDCl1CNh/Z8diqzw9hSmzmDsVrWGqx9hrWSSoxD0bWmenPVr45
Hzd2rqiynSqT/HnkO9PdZ4rESHfcX1/A+JhiAhFRz65dzSw8s62Rww4D+6M0Wlwc
dhVmmGCykG3cGufzmZEWClQtHsAavBFiBT/l50QlIKm3aivKoe+RN9AnbaTdfIJ5
K89ZKgYAX5B14ouL0SjlKSLzvILx9AArZixmh1/fQtYl020Qsy5uJX/xrXrZrOOz
10LNMeBsJfkZhUnp/VKY
=N/4A
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
