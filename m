Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD908C38142
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 01:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjATBrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 20:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATBq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 20:46:58 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF319EE26
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 17:46:53 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D17035A58A;
        Fri, 20 Jan 2023 01:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1674179212;
        bh=inOyK5RtDnu4JOkZ+2DokeawTllQoO/46go43xMpQws=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wWrtAnj9EWwIS2Ldq1iRBnjH8oCiv/690Goa6kigKHGunch4vIKLh2xpW8t/BSwvw
         NnHHeBTqis/efodtZGJedOyFnEigDYMksvHKBu07FIB+SklUmD9YmSXKKME+ddgaAM
         KPrq3/c+W5DP8Pn8TOwnKiXBw3DDzXhX/TmVblcXgkIZ0OC3XZDSC7vCTnQEv0XH+X
         JZgKS1h9rpUkYDqgDGRi3LPXprYh9UqHpQ7ZA++CtzT/BNlJEzTlmXBatDEDnghXSz
         ruTbdhvC3VrZxI5e5HrIIVRsEKrgDIJDMLYEWJKNSimpRLCdhoiT4CVRBmRUOG3nVG
         xRYFheh5DGhok79Aiyyx6UiBFI+vC+gsz75DhplSsNL4eF6rWIyBWdC4p3uiMIxPdv
         Pvk4e34Aqez3sILnPo0Qze7mPalexxl4l7O0QwH9K7oeWkpaj449O3HZjAIQLyEmOZ
         QAz4IcwimKAs/97fUfGqo7kdc5fFHrcPgmvVu3eoRDxoVnGlV/6
Date:   Fri, 20 Jan 2023 01:46:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
Cc:     git-mailing-list <git@vger.kernel.org>
Subject: Re: Redirect isn't working:
Message-ID: <Y8nyi2QxQN0+kOOk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jack Adrian Zappa <adrianh.bsc@gmail.com>,
        git-mailing-list <git@vger.kernel.org>
References: <CAKepmaibtbRsKqmiZEtDNoLHWr=JyZ7Fhang4dnmw5ROGmBQTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M6/eWjr6v/8K+K4T"
Content-Disposition: inline
In-Reply-To: <CAKepmaibtbRsKqmiZEtDNoLHWr=JyZ7Fhang4dnmw5ROGmBQTQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--M6/eWjr6v/8K+K4T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-19 at 18:06:17, Jack Adrian Zappa wrote:
> Here is the filled out form for submitting a bug report:
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
>   At the command line, I typed the following command:
>=20
>   $ git diff --no-index --word-diff --color=3Dalways <(od -An -t x1
> -w10000000000 file1.txt) <(od -An -t x1 -w10000000000 file2.txt)
>=20
> What did you expect to happen? (Expected behavior)
>=20
>   I expected to see the diff of the two files.
>=20
> What happened instead? (Actual behavior)
>=20
>   Instead I saw this:
>=20
>   error: Could not access '/proc/1961/fd/63'
>=20
> What's different between what you expected and what actually happened?
>=20
>   The difference is that I would get the difference between the two
> files as opposed to a critical failure message.

Thanks for the report.  This has come up before (and I attempted a
patch), but the ultimate problem here is that the /proc/PID/fd/* files
are symlinks on Linux, and instead of dereferencing symlinks, Git tries
to read them and print where they point to.  That doesn't work in this
case because the symlinks are symlinks to anonymous pipes, which can't
be resolved.

On other systems, the behaviour may be different because those files may
be represented differently.

My patch attempted to solve this by simply opening the contents instead
of stat'ing them as normal, but I think we found some edge cases and it
didn't get finished.  Note that this behaviour is what plain diff does
because it doesn't handle symlinks at all.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--M6/eWjr6v/8K+K4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY8nyiwAKCRB8DEliiIei
gSvAAP0RjFmbhDWL6gOufX0FKWmyTxC0LsAWsqEG83I2w9c2JQEAuKlCr0u5OwB0
mAFMEii0q+wxxOEeFqp00xPtUn/uygo=
=r6x6
-----END PGP SIGNATURE-----

--M6/eWjr6v/8K+K4T--
