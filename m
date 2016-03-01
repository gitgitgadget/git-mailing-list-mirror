From: Joey Hess <id@joeyh.name>
Subject: Re: bug: git submodule add fails when .git is a symlink
Date: Tue, 1 Mar 2016 19:17:20 -0400
Message-ID: <20160301231720.GB3731@kitenet.net>
References: <20160301204218.GA4083@kitenet.net>
 <CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
 <xmqq8u217tqa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:17:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aatXo-000840-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 00:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbcCAXR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 18:17:29 -0500
Received: from kitenet.net ([66.228.36.95]:43936 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbcCAXR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 18:17:28 -0500
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=OJ7CMdOk;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1456874240; bh=sSNrNF4/Z5uOkXPiA+hSP4Oc5ZMjdukeq5hdrMnHmCs=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=OJ7CMdOkJfaPUl0AxY1CorJnaOUPdqnOrfi8bOdPWTOlKGKqseRt/AHIxgNqjq5T6
	 D2f1t7e57wDEKDDuworj7SWkDVp/1aVr/AHKxyESJFwDYuhoYuwPCIjD+MDVsaT9HB
	 Zf/4YhEM1uyrNJtobwOIdYZ95tsalWvRIc8ZllnE=
Content-Disposition: inline
In-Reply-To: <xmqq8u217tqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-93.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288079>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> A more pertinent question may be which version of Git did the above
> ever work, I guess.  We fairly liberally chdir around and I do not
> think we deliberately avoid assuming that "cd .git && cd .." might
> not come back to the original directory, for example, so I wouldn't
> be surprised if it never worked.

IIRC git used symlinks for .git in submodules before version 1.7.8, so I
guess that older versions supported that pretty well.

This one case is the only time I've seen a symlink for .git present a
problem so far.

--=20
see shy jo

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVtYjAMkQ2SIlEuPHAQJe3xAAmRWTlD48e19lYkZZhFqutuserAZGU4BJ
yUGbJcx82IKDBwc5YI2BQg5RLRWAaHt5cThoBuJ0Vvgt7YahNTWt5/bJ74vVKFi7
jdd1AYKTfcXGU9ToC54Dx3QFvDP9l/NLGdfQz9GNUmVRlDPRA6pyO9SjGzZM5XUE
4LAUFnTSVC/lfCbnomMothVRZB028ujke7nkr5DdjgclyoYTwRc6R4oXSirxE/QJ
lciqHjotDNLmRhtR7fJiu/BarC0sAhpU0fBVNdi5aAo1rhr5nFxPloiYfsuHmygb
r1sHExBAV6GnF54xtgRKA+MuoEwoToaCclvr3pi6E8Yi/aJuOxw80Tpk4dq7tp9F
alytZNrGJ6gSbjCIftTcyVSb5GHNYGeGrzNBCo+6pzlih7k70pbmvca6xGn7Y48q
Lbux+O8e3vYduKz2deDGamxdZQt7EG3yB7D2cZhZ9B4vF3X62pgnlMl2yRPMXAhI
gYFsFivvuImHl/g9MD8kNECTtW4IH+pohMhrqR+/FwZjq7NACV0w2Gu3owJe9O3C
ViZTWn6n58f5SoGFVdG8a/ctj6JUL5qQlhVl65rs56mMiVW5K3zfmNSv63y3ccc1
WQjugrwErurxlB2Kl92pL/LSUpNv55wqa/44QCfkgbkIkkMkMygaRWZv1r0wbYfS
hYYjEeID50U=
=QQKI
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
