Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A1C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 20:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5726D6144F
	for <git@archiver.kernel.org>; Fri,  7 May 2021 20:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhEGUJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 16:09:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49744 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229925AbhEGUJ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 16:09:27 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 08AA860459;
        Fri,  7 May 2021 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620418075;
        bh=6MR6cT64cyYjaV0yJ3ERbfSrBHNmo/1AlssTuOyoWYI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ASiJfLB2mArgG7xj1aBULZt6vFvwcD2FbiHf8EUz5BnnYz9RK5aYbr1wn1hoJaYIT
         QD2CjGapwVxwF0EPXoPGnf/0iJQrnKShQreTvhKoyZzl0cOi9AC/fL9hXsVMBOdmvU
         5w4gx1bw9DHxTEXQbLpCWLT2po8RNEMZDyBS7FOtlTQsz6mDXfVRjH9a5r3kTBV3I4
         59M5mTz2EamKuy+JbSUCWXPJh5GxseOg80WScb19x9jbhqKjWfUkYxmq0tN9b+IiU6
         IEvttzQgBLpciU4hjhuh356Dv2EsflBCj9FoTXQCgDKRTc5I3pfXupBj6JQVRt3/91
         y2JxVGe8LV2nzErqMP2QGQ9XFTzEiQsxo/XK5WHJIXres42KloyxHns76yGb7YDIVV
         cVOnjNfkrR/GmiKLNC/FMwQ1mmiDLItUw1XI3QsSEtgvUCe9+Q+hLor0Lz2ETOlJmH
         t5X/C68y7WuYsQkJWjNutHz4AZyfyJS/aqwMEE71iUtVE50KnxO
Date:   Fri, 7 May 2021 20:07:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 01/13] hash: add an algo member to struct object_id
Message-ID: <YJWeF8iaWcegWACa@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
 <20210426010301.1093562-2-sandals@crustytoothpaste.net>
 <CAHd-oW4N7GB=E6hFc4GAD-b+1QzTR9+hL-hDXwAQkuss4Y4Ddw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XCJY5dS8jUKhNcwl"
Content-Disposition: inline
In-Reply-To: <CAHd-oW4N7GB=E6hFc4GAD-b+1QzTR9+hL-hDXwAQkuss4Y4Ddw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XCJY5dS8jUKhNcwl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-07 at 13:58:42, Matheus Tavares Bernardino wrote:
> Hi, brian

Hey,

> 1. Make oidcpy() only copy `hash_algos[src->algo].rawsz` bytes. (But
> then we would probably need to branch in case `src->algo` is zero,
> right?)

Yeah, this will likely incur a performance cost.  I'd recommend avoiding
this if possible.

> 2. Reintroduce the oid_pad_buffer() function from your v1, and use it
> in parallel-checkout.c:send_one_item(), after oidcpy(). This would
> then zero out the copied uninitialized bytes (with the cost of one
> additional memcpy() per item, but this might be neglectable here).

This is fine with me.  I didn't have a use for it anymore, but you've
clearly found one, and I think this is probably the best approach here.

> 3. Use oidcpy() as-is, without additional padding, and let Valgrind
> warn. This false-positive warn might not be so problematic after all,
> and maybe I'm just overthinking things :)

I'm okay with this, but I don't know if the other end is security
sensitive and might need unused data zeroed.  If so, we should
definitely avoid this option.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--XCJY5dS8jUKhNcwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJWeFgAKCRB8DEliiIei
gfSKAQDQ9uZ9JTttpl6fcOmAOqDgZiQECbGC/17XQ4GH6LkrnQEA9Qh1tssBrbxO
AzgFi9Fs2s7++WN4Hreyuu7DhfAExw0=
=4UEp
-----END PGP SIGNATURE-----

--XCJY5dS8jUKhNcwl--
