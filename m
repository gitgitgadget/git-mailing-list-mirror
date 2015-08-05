From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Wed, 5 Aug 2015 11:06:03 +0200
Message-ID: <20150805090603.GC1103@pks-pc.localdomain>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
 <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
 <20150804043401.4494.43725@typhoon>
 <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
 <20150804224246.GA29051@sigill.intra.peff.net>
 <20150805060852.GA1103@pks-pc.localdomain>
 <20150805084147.GC28212@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 11:06:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMueL-0003U6-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 11:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbbHEJGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 05:06:09 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43452 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111AbbHEJGF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 05:06:05 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 74E5320C75
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 05:06:04 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 05 Aug 2015 05:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=QboppiVA/hCoCmAmBztARHXh+Ok=; b=utmJj
	nNcypf5Jm2Zpbi8NDUlMcJora2y+G2JRlT2qIaym4ghwasGd8MVXfJJm2TuvaQ5e
	9wpsumaj0vWE5pGynhcB9sCv+n3a7vccZ+vA7dHicjVgjOsG0bPHUL+rgXSqsI9l
	Cuex/2uBMbbMTlFd2eyU5UhHrp1I/lnOsyjntA=
X-Sasl-enc: Mo+cACf5QxkTDcjb81pnn86kizv8RWz/6aDg5coffQM3 1438765564
Received: from localhost (x5ce10e86.dyn.telefonica.de [92.225.14.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0752EC00014;
	Wed,  5 Aug 2015 05:06:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20150805084147.GC28212@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275359>


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2015 at 04:41:48AM -0400, Jeff King wrote:
> On Wed, Aug 05, 2015 at 08:08:52AM +0200, Patrick Steinhardt wrote:
>=20
> > > Sadly we cannot just `strip_suffix_mem(repo, &len, "/.git"))` in the
> > > earlier code, as we have to account for multiple directory separators=
=2E I
> > > believe the above code does the right thing, though. I haven't looked=
 at
> > > how badly it interacts with the other guess_dir_name work from Patrick
> > > Steinhardt that has been going on, though.
> >=20
> > It shouldn't be hard rebasing my work onto this. If it's being
> > applied I'll come up with a new version.
>=20
> Thanks, it is always nice when contributors are flexible and easy to
> work with. :)
>=20
> Hopefully the new tests I've added can help you out, as well.
>=20
> -Peff

You're welcome. And yes, your tests help me quite a lot here. Got
tedious to always set up the chroot. Guess I'll still send my
fixes for the chroot-tests as a separate patch series, even
though I don't require them anymore.

Short question on how to proceed: should I mention that my patch
series builds upon your patches or just include them in my
series?

Patrick

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVwdH6AAoJEBF8Z7aeq/EsMMgP/3GzMlla7ZBc++HTWlbHquPU
Lfp2fOtDXTBRgY2YQNvfwtuHdu/Zmar1Dz35m0wBGhWcV3xj0TAFrqI0qxY/2xT4
gsK6Qy7VnQfRplTkre4+tEasIMiPstBib5d31/ZeXD20h4YFGsMmNXqz+zk9SvC6
Rr52aNRVgJJWzG2FiuGfg8A2GKDaF0BN0Uucn4RNa3TAx38JLRs4ZYpPXk32KvxF
Me2s7NaxSGv5mA5jn2NJRAcb9os6a0lQi+K/qhiLLVz61zxF9IADuNZg+LiuTnbo
fqWZ9nRBnDFJN1rEuCEVpofx+DWxJzv6SXV1JLLWnxC2PszWpXX+q7g5aYmq5ROC
H0LN871SgPO2Pu+85kS/nhJ773pTpYduEYmrLT4JZAY+1ZGnVHMeUR5kWXaAvYhb
UFbj3wCNTBJm6bC0TgxZ00yMnIJXinrjMLIDoVvDXh0VbB2XlNn75r1Ai7gABD2d
1DxU8QylzDWnZVuJjLE/FgCJvmrHNAaORCw07zqX0ORANY295HbHV87qUMTP7OEK
wOVTNvqIfUtJBgvRrRlyqgAz945pVEnw8GGiUyaWcTjABsHnTBQttOJiyDADqogL
TPC9cRGqibveplRE9IgPGFTZLr01kufHrUDSHoZnDqPtX4//XKZwu4ARD6azkcH4
CEuQPGI+Vu6MbwXFigHE
=kB0d
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
