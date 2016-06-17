Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	T_TVD_MIME_EPI shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DAA1FF40
	for <e@80x24.org>; Fri, 17 Jun 2016 02:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbcFQCsR (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 22:48:17 -0400
Received: from kitenet.net ([66.228.36.95]:55060 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466AbcFQCsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 22:48:16 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=bB97qRRT;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466131683; bh=2yW5a+J5NlUwXXPnyWM5LwhPme8QXuOEdwyro0YckCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bB97qRRTfFxHsSsODlgDzEfvRXUmlKByFv+CVhxzkq0JsyCVv8e/kXZClEJvyf2Ru
	 oY6IN3reJH8g5sScTJBZI2W9K87GOniWPwcxH3RFavMosUHmUUcPqkQ1rdL34b/KEj
	 aiIc6/bLt+PlBFtWNHmn1PgJkCf1qwAudrDLdsBQ=
Date:	Thu, 16 Jun 2016 22:48:03 -0400
From:	Joey Hess <id@joeyh.name>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/4] clarify %f documentation
Message-ID: <20160617024803.GB17088@kitenet.net>
References: <20160616203259.5886-1-joeyh@joeyh.name>
 <20160616203259.5886-2-joeyh@joeyh.name>
 <xmqq8ty44y4t.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <xmqq8ty44y4t.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> I agree that "the name of the file" can be interpreted in many ways,
> and I agree that it would be a good idea to find a better phrase to
> name the path that is being worked on, but I do not think "the file
> in the git repository" is that phrase.

> I think using the word "path" somewhere in the updated description
> is more likely to have the effect you desire.

"path" is also very ambiguous. I see that "tracked" is often used to
describe what %f is, so how about:
=20
+ Note that "%f" is the name of a file tracked by Git. Depending on the
+ version that is being filtered, the corresponding file on disk may not
+ exist, or may have different contents. So, smudge and clean commands shou=
ld
+ not try to access the file on disk.

--=20
see shy jo

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV2Nk48kQ2SIlEuPHAQJNig/+JpzGGYmTOrjyixNa6VNZmr+4vwDonRHR
qu8c8Mkg+6j/JXZofMaSuseghEi701tnpHAAn4Yu+uBgXxA8xE/n4qpLK+050tD9
XrmYrR/hr+sK4Y2wzwbmtWYyb7XIdwC28URDP23ReRhcwf7fIFilFoYpKtCw0IZA
fW6yhfoVLLzYCS7PyjqSQ1DWatJxp9QqekmuWtdo1h59MJvF4txFaxu0HnQU5LwX
flC83An88T1gaQSdAAfL7WkYvR8BNSDFUOG1YDMj3bA4+hm6zon1A4wj69vTGUdB
giWCYeITGyrnOLESTcIZ8YnirIo9/kmHKydzE9dm9Kprm3Qf7l05XvXaZdozCMkX
ms1c5Hf+sbI6gWPuxZ45zSnBrujajALWwEKr0ExSUUBIAU8hnUi7A+jHcAXfq+z5
MIWmiKP27gzw8+SQepM7r9/qGQHTjS7eEVSQWP9evS/ufr+vLy7DUsEbOZsQ9NPx
FufzNuQsK7IdOu0BgExe1HYRNDlgKZxMr+E2lKiaa3uUn8f28GPFHvU20ejbMtkS
qNI5aGWjVBUQZv+O5ABwoH1muE1MqLEaSL3LWaAp2aXnd22rruN2xW0l+4dS0sLT
qSCcTxpjvlnPX3Z8PcxZq9GraqNYQK4Jap7jVgb++3XGb4Wzx6iMnT0WtwkLJGLC
Mg4U/gb5i/c=
=NvW2
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
