Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF981FEAA
	for <e@80x24.org>; Sat, 16 Jul 2016 22:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbcGPWDN (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 18:03:13 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58992 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751524AbcGPWDM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2016 18:03:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E5956282AF;
	Sat, 16 Jul 2016 22:03:09 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1468706589;
	bh=sphjdBJTX8egVxL0R12TcHcHsO9DxSgdvqzlm8QNTHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMZB4sHbLyF0m6jQVPDCpojEgppVK0eAqofgwPNfoeUIgmFGG+DV0BICbIqgdbb1B
	 Wrjml6SVjrvl6LVueJ9EeWg+Ij+guXXcJ3zk6URb1mWv/49FjK8guQFUofOIyEfjsq
	 I6Et68nD0sooPq/w4VC0AwUwAACwQBARMlihifJCjDgs6e45FFGXiki/ugJiCPiPto
	 pS4knVjEtcp2tBoXCEw/UHG3MoN1S35UKFzhRiQTO9q9l8QOR6NtEpocx0bjrg37Wx
	 xNtZb95LvVXw++qWeUvcV1Y0Gfg5YaWp8jCSjnkhs63gbzdN5h1OdBbjPG91vhw4TV
	 zEjbzy2dMbw77Bzt3YnNeX1JIODPH/x9Ao2U/5kUvV9b41RM96DNzn+CEuLO9nAr07
	 jyMgTzQOfY1BlBT++Az7Gw8vLOkPr68dihRrEptVJv4cJ3PdjpYwXkTYFQmDeXD8Ba
	 jIXOJ2L+ZiuVWFctYdmz0FKnkzPY74jL/PzpyASyFZhRvfxVSpJ
Date:	Sat, 16 Jul 2016 22:03:05 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Herczeg Zsolt <zsolt94@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160716220305.GA409690@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
 <CAPp-Vrb5MQw-S25sTmdeatrFv5bv2pLG_mS5=9-ew8J_GNi+kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CAPp-Vrb5MQw-S25sTmdeatrFv5bv2pLG_mS5=9-ew8J_GNi+kQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 16, 2016 at 11:46:06PM +0200, Herczeg Zsolt wrote:
> Dear Brian,
>=20
> Thank you for your response. It very good to hear that changing the
> hash is on the git project's list. I haven't found any official
> communication on that topic since 2006.

There's been some recent discussion on the list about it.  It is less on
the Git project's list and more on my personal list.  It's my hope that
Junio and other contributors will decide to accept my patches when they
are ready.  Also, the plan is to keep SHA-1 available, probably as the
default, for backwards compatibility.

> I'll look into the contributions guide and the source codes, to check
> if I can contribute to this transition. If you have any documentation
> or other related info, please point me towards it.

The major work at this point is turning instances of unsigned char [20]
into struct object_id, as well as converting hardcoded 20 and 40 (and
derivative values) to GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ.  This work
allows us to make as little code as possible know about the size of the
hash, as well as generally being easier to maintain.

You can look at the bc/cocci branch which was recently merged into next.
(It doesn't exist independently outside of next, so you'll have to
search through the history).  That work is what in my branches is called
object-id-part4.  I'm currently working on getting to the point of
converting get_tree_entry to use struct object_id, which is what will
become my object-id-part5.

I recommend if you're planning on doing some of this work that you try
to avoid areas which are under work by other developers, especially the
refs code, which is undergoing massive changes.  Other people will
appreciate it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXiq8ZAAoJEL9TXYEfUvaLh/IP/1T4GZoBRo08Ive7tI+bN+RS
On05AP6T730WDe1ai6pfRRM0dVC4aCY+tQyozGmaF0yvSOjxg4dE0/eTJM7c2bFQ
3TFMR3l01H0MH+5CwUSEWIGOO7a1VCOJIf0rpKe65i8hbo6kc2Fi4nW4nAJLmCZ3
LEjTqSbYPn0mFvsqZhuIKn9/XQwY+6mBGMPcGfsBWYk6scrbitX37ejUiWNBRIkd
lEoGf+pZolB8Z4JGgQPaaPApqlC3CovP1MI2/Rec808QHaMXyw9qnaUF4QWq7coM
fIcA/GtdZDoPl8qNbtql9OK6TGxdm57kn85TctTmO6T6YggkHnbDClSKOxR2j/L6
U6jG6WXH3HgAKlQi9zNLKeoRP8JBui3GbmzdUMAQyJ1FtSz5w3ygLEsl2W8LCcSk
qt/fmqH6iYmaybL7JoDYjKLHF9objX9+6bvtpcYzhFUSql+LRvsrXex/mFxOxl7+
h9D1LfIbLFtIWx6u81dNtMo3O5aQysqbbZb+lIDq18sJMwif97DWorE/kCiRvliA
rs7GIr1eMJXE8CMKaPksTZ6TsrlvtfLIMRy7mxjWwvLnV/U5yHQJcWQkCsVrLOJS
RPwZ+R+le1E/d1STrjZHCEyGgQkSO3J7H2TeOJjXbHEefL90FVXAz6WinzmA9w4n
VJM0wo6G/iTA7hr7MDWZ
=o8B9
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
