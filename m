From: Joey Hess <id@joeyh.name>
Subject: Re: GIT_INDEX_FILE relative path breaks in subdir
Date: Tue, 17 May 2016 14:26:45 -0400
Message-ID: <20160517182645.GA27396@kitenet.net>
References: <20160517171836.GA12183@kitenet.net>
 <xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 20:26:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jhl-0008S1-4z
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbcEQS0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 14:26:49 -0400
Received: from kitenet.net ([66.228.36.95]:42706 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbcEQS0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 14:26:49 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=UpYMiTdc;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1463509605; bh=IKodlfB23PPQWoC4eRGURwxQ0iKcq35zLo9sQEgmqEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpYMiTdcUHLRZ1bkdY/Tie47m5EoxkLZ76hodXs/hOa40/a1HjFZZ1V3XNcjLtluO
	 VmQVDt5FZ9KuIXNMR6ziMRo8IcoiAKjBGDdSkkHqgPCUetorHNPC4n9jiWoDM1l3nm
	 CBhn9L7iJcPH9348Z/dKLUGyHaNgalBOIbwpuy9c=
Content-Disposition: inline
In-Reply-To: <xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-98.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RDNS_DYNAMIC,SPF_SOFTFAIL,
	URIBL_BLOCKED,USER_IN_WHITELIST autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294892>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Joey Hess <id@joeyh.name> writes:
>=20
> > Appears to be a bug in git. Seems that it's assuming GIT_INDEX_FILE is
> > relative to the top of the worktree and not to the CWD.
>=20
> I think that has always been the case.  You can always specify it as
> relative to the top.  Of course, you can use absolute.

I think it *has* always been that way, but is there anything in the
documentation that indicates this is the case? This could well be best
fixed in the documentation.

Hmm, at least GIT_OBJECT_DIRECTORY also behaves this way.
(OTOH, GIT_DIR does not behave this way).

--=20
see shy jo

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVztiZckQ2SIlEuPHAQLUww//c/U9/wo+OKdVk/bzanJTEfXORtdm8nfI
q45E9/2icjNxKzVQJuDL7psZa/mTMDwxi1xmIjAq18PNPiuxSlKlY5y13BUQIC+b
Cau6T9MveFCvSJBzATTZDAThPyEzpbSpyLsdYoPkv06l04t6UgY0IKTTvVGA47nK
xu4cv4NCZum6Rd7+9CxUZ2F5MQqcyvs1UMrZC62olyK1gA0WGtDu0RPTK0nUP3cg
1Kx5QPG/5/FyrpxO07HN1/w8OeivKbLivNPhvS/pLVOMTp26vxyWdE6v+sDg7+b8
EI4UX1Y9bb+DMgsF5/pgKKJId0BpckZ1wlevTrbQ+GxXjJrlaDrqUsML5u4Uickg
YXEv5AcNwj/Svd9DZhbCYgr9P+GCXAvgaXjke6YrOLQJfhmXHZd5STNy59njZ6+g
xOApAYaE6GZxh3s5XXZcegJkjhzzqdrkjrmUohp31+CqeFEecW0e2TrmAGoDPkf5
Bq2tf9ETVvyxuxNzuK7y5GNI4O+ByFbugeqR/ioZRvxtL5DqJ7iyMmRT0+bQhc7f
GPVl990SpPXTn1s/fLoYyk27n4qi0DAS87ORV+nm0nH36IojE5E6ju2hlRu5KMzn
x6fqgo0vhNyKF1Xid7gAklXzvG1+7uJTOISqmcRFiprr8NB6L1nvY5fV4Twva6lk
UN60fWePbNg=
=L4IS
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
