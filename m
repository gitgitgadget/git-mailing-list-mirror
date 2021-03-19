Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D865C433E1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 21:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177CE61994
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 21:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCSVbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:31:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44550 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbhCSVaj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Mar 2021 17:30:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4CD0460766;
        Fri, 19 Mar 2021 21:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616189438;
        bh=D9tW1wN3L7zMS65LYdwIZuCIqVagg4EZRHTlca7OcL0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B1aJzBuIUbTfEJrybo03/DYmp4SjnANWsPTaz2q2QcODkwcvr4HFdNUX/LfJKww1b
         41PT8tM4KGSRBM7S+G9kmuRfSp55XOa+3ad1kjose24+PwuwGkf28YI8C32ci86CrT
         9Kx2TiB2+aylgdhHl5ivPg/WdoSs/WFb3SzbvkjfpRNzcyTKwupZ2+I8jLqHm7dW6j
         fFDWT2NvuNDGOJLZnhBqjPPAITOfjmPpTiC1YQi/lvGhg4wwEqp7XBAWN5bQeTsqrR
         nyMntwsYVwnERh1wc4gUc3ZnEcheMjvz/eh4Ry4SzURaCYh1FcZjMgPQYYc9LmxWx7
         yJ8ccX/12v7tu4X+EWhIjwamCQmSpvk+D9V9ymWCxHLbKX2A72tI7rmo/Bc8LWoeXn
         3bsHYKtTJXWnrvissxJ+YcKHVdAhC5rxB/zSrwzLVfYVJ2UB3A1Xyg+lg+xtmQjuRD
         /pmc4a6X1yfcV6x7zLMXsBgahy/9MYzvRhMJV/EICOW06VTA0mI
Date:   Fri, 19 Mar 2021 21:30:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Renato Botelho <garga@freebsd.org>
Cc:     git@vger.kernel.org
Subject: Re: --no-edit not respected after conflict
Message-ID: <YFUX+Rqdj3gteyql@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Renato Botelho <garga@freebsd.org>, git@vger.kernel.org
References: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MArrKPzEUugJt+YE"
Content-Disposition: inline
In-Reply-To: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MArrKPzEUugJt+YE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-19 at 14:44:30, Renato Botelho wrote:
> I was reverting multiple commits using --no-edit parameter and after one =
of
> those commits conflicted and I resolved using mergetool, no-edit option w=
as
> not respected anymore and next commits opened editor for me to review com=
mit
> message.

I'm not sure I understand what you're seeing here, and I think maybe if
I knew that I could provide more useful information.  Could you maybe
provide the set of commands that you're running up to and when you see
this problem, or even better, a reproduction testcase?
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--MArrKPzEUugJt+YE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFUX+QAKCRB8DEliiIei
gaT3AQCvUZOmbgs/HXz0bF1fVMYl+/R4Ei2sboqd91dxpt/3dwD/ech9YpVV+t3F
bC8iE7vz3N/1sOl2EuJxKXPEZ1xOpQA=
=xaiG
-----END PGP SIGNATURE-----

--MArrKPzEUugJt+YE--
