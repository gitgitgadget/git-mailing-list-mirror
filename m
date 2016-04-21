From: Joey Hess <id@joeyh.name>
Subject: Re: 'next'ed --allow-unrelated-histories could cause lots of grief
Date: Thu, 21 Apr 2016 14:19:17 -0400
Message-ID: <20160421181917.GA3628@kitenet.net>
References: <20160421161043.GK7907@onerussian.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:19:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atJCX-00023X-Oz
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 20:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbcDUST3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 14:19:29 -0400
Received: from kitenet.net ([66.228.36.95]:55136 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbcDUST1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 14:19:27 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=Hcbt46Xs;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1461262757; bh=im1i6zAVcS3oO+fHheBjntvZoDhJmlX8nx2TXJs7HmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hcbt46Xs/R0Zg9AytgJnUbKM4m3YZ6Kyz86l3RfwwZizLV3SrXNWln3cuX4G3hol9
	 +9wNFjr2FZtcDRfqyp5tqpFjA8SDOx2nGaEU3t0DVUFodqDOib8/dRxlH0ZUUImuS8
	 6crmtPEcF/l43zIO1TFsABb919BrLhumTabK24VY=
Content-Disposition: inline
In-Reply-To: <20160421161043.GK7907@onerussian.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-94.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no autolearn_force=no
	version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292141>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yaroslav Halchenko wrote:
> which is planned for the next release.  I guess it is indeed a
> worthwhile accident-prevention measure BUT not sure if it is so
> important as to cause a change in behavior on which some projects using
> git through the cmdline interface might have been relying upon for
> years!

Not only through the command line interface. The git-annex webapp has
common use cases that will be broken by this change.

> Moreover, it was explicitly stated that "no configuration variable to
> enable this by default exists and will not be added", which would cause
> 3rd party scripts/code/projects relying on previous behavior  to provide
> version specific handling (either to add that
> --allow-unrelated-histories or not)... very cumbersome!

Agreed, a configuration setting that could be passed via -c would be
much less cumbersome than checking the version of git in order to only
pass the option to git versions that understand it. This would also
provide a way to get git pull to allow such merges.

Compare with, for example, the change to default to an interactive
merge, where GIT_MERGE_AUTOEDIT=3Dno was provided to ease compatability.

--=20
see shy jo

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIUAwUBVxkZo8kQ2SIlEuPHAQIOAQ/41l2F1Q42V93+BM6FrYeXRRmUyDOZUGaz
k591zN2C9fpnzr3KMzj/bRShu9RkNLZxeEL5lF6G179UdHfwRVTerC8XQ135DHDg
jPmFNp/RNVX2LQb3hejIBlzg8wEvC5bfzVCSbha90fU+pmONR+Ds8apuXyqKf76S
TIT8QWbr4pLzhJ9c3Da7eevqZbR4uwAjcZ9jkUxSl5T7fr/xA2lel8QOOgHt85z9
QHFt/MZjn4M73nBvjTHsryGTxgh/REN+FERDkN3I/6dbBUr/Ms6w4r8dVjmnAYKl
KoyGVM+VE4pFSUFn1ZWqxsCvJW/wh15fSH3UfuVmpTz03wMXH2p88q4lJ0R0RFW8
YA+pu0z6VfhR2UMrbPlc9Cvrk39Aa3xtSDxmEHTMzmwVYV7Z9Ru8Ymhee7nXxIdq
3mmC637E2gQA9ltogNxwMpJklumT+C/x/g0jgZ/rU3OahhKTIPU0ZA4O2RJTP+Qu
vhdUBCETASQuJfq/7/Ern7WV8KDv1A9ViW5lrUUzfjQYi/gIVszN/PExhaJS1IgX
7lEaHmsVgCCvMFbX3MY2ZmwYdZJ/lciNUZPPqbg6+hQi2azaHoScG7AGyOtAMc2u
fjriWWqo7p8N9S3z6utYKaTjxV+ZRab4q7pNTwpsyOXRv+uVonlVztrlKlte0mvt
e9lYQBRmqA==
=S6d7
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
