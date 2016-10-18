Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C88020988
	for <e@80x24.org>; Tue, 18 Oct 2016 13:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761240AbcJRNfW (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 09:35:22 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33937 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755225AbcJRNfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 09:35:20 -0400
Received: by mail-qk0-f178.google.com with SMTP id f128so279989900qkb.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BKUWwrm0MgNvxQGJSyT0mbCYOdw1gjlHwA7OOzN+WKY=;
        b=Z0NpNY4newgoGXSoNgSA/QbBr9RfJX9MAa1gaqABnZkfcWiWRxc9o1k+zaFr9zWJGp
         SLWV09ES3lA4+uoZTjuEitpebJ3Tm7r6pGKOpJx6hSMAYbQqJSc1jUlkGWYxBydcUv7E
         /64YoEO5eg+tkjMpqly9rIuqEFgJ6+FksAsvo5Te1zaK29HsV9uDwe6vCo7TwEuulBtV
         Tby9ySZc+58yf6vKNoUZ6NOXWngsyw4rJ4QqMmjEntyl5wZm5rJhXjVFaRBThAk3Cu0M
         ZagrzU9/mLQhfNSoBOHAJdKVqodN0DUKcQxPSFMVdMOGTcZxihqW3jUlT5mquifezaYs
         xT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKUWwrm0MgNvxQGJSyT0mbCYOdw1gjlHwA7OOzN+WKY=;
        b=KQJvdry1fDbZkafsIdkWsvbzZwMPfMRLm+tyQA/631uTjPki+wJ8BZ9fWB/6G1UDRq
         ZvKUDFhlAqggEgHX8a/Z/O8dvjpZ0deCk6T6JsKkWRSA2s3ApfOwGPcHKjnORtLKvT4L
         g0AVisJ/t4cAUzrO3VeW+HtPJdPGWbKO55tnXH0IqZixzFasTE0wda3TTPcIV113OHUX
         SHVsi31zPLB7MAUsjJMsoosA/wSpn3F0o5YAuH/R3Cu6VCU2zP52j90WlSCqoqE4xCEo
         d6CUGQdcwX8XgZiAzL2sYKboeVVzRjF4yNODyzAgomQUneqWvTaQtovxmpiwE9minhvL
         ChyA==
X-Gm-Message-State: ABUngvew37noVsLILyjtSh5N8FzqS9n1bbKq238VDytVKqkSzB3qrilAHuB3dYxIq+CeAX4q
X-Received: by 10.55.192.24 with SMTP id o24mr591616qki.3.1476797719747;
        Tue, 18 Oct 2016 06:35:19 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-11.NATPOOL.NYU.EDU. [216.165.95.0])
        by smtp.gmail.com with ESMTPSA id l8sm18000323qtl.18.2016.10.18.06.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2016 06:35:19 -0700 (PDT)
Date:   Tue, 18 Oct 2016 09:35:18 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
Message-ID: <20161018133518.hwbv3gbeddjjfvcz@LykOS.localdomain>
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tsyccm7ryotr737n"
Content-Disposition: inline
In-Reply-To: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tsyccm7ryotr737n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> * st/verify-tag (2016-10-10) 7 commits
>  - t/t7004-tag: Add --format specifier tests
>  - t/t7030-verify-tag: Add --format specifier tests
>  - builtin/tag: add --format argument for tag -v
>  - builtin/verify-tag: add --format to verify-tag
>  - tag: add format specifier to gpg_verify_tag
>  - ref-filter: add function to print single ref_array_item
>  - gpg-interface, tag: add GPG_VERIFY_QUIET flag
>=20
>  "git tag" and "git verify-tag" learned to put GPG verification
>  status in their "--format=3D<placeholders>" output format.
>=20
>  Is this ready for 'next'?

Hi, I saw this on the previous "what's cooking." Is there anything I
need to do on my side to make sure this is ready for next?

Thanks!
-Santiago.

--tsyccm7ryotr737n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBiUVAAoJEEaPEizoFiKVrowP/jjAoy0gt0DN1BIz3PoaEt5b
vb2RuZe2S0HAZQEK33XboMpWyki0/SzJlK4s1PvWhpFW9jR81C99AOjsayawBeRX
0nvCrjFXTvjS2WpX8FglsNBRuhA2LZ14HNNG8hBQMOKRah9k6lyLJApYOFWpsCuF
EIqnhybwfXCkFPgZHTWWJ/sM1lPZ4kL5HqVnaDXWYX0Rki5rhil9ewmNNQpvJVzT
37vZ/WcjAEdOe8f8XaO5mFZgNqvb82HgMIW2nsZgfOkaJe47IZUjYofztjEUzmD6
YEopNlUa2XBcZ9YpsQF9VBIsgbmBOc1+nOm87Z5vkVETVgveQSx54S4HTanfbWIY
BPA6BjweipRbcCMfpxMFhMGMRuAXsvrmPY/XWMP9nvp6X2Vc+9QRIQdfZhZk+UFF
zJPQdkqy7azmBhouY761loKDFTXIFekZYS1n8WHOnhGSqEuEeF0bPG7Zr61ETPGW
A/4Hhirajt1LX/bs4nCEDaxdXZrlRgE76NhUe8HFN/s82xTsu5ZEsWaOfI15hbB8
9du/Uty7kOXP9giN64kkdRtfb41D8vGgeO+/LIIVYqXRXHHvfW+tPysgbQ2fqQ2g
v/mTFXmfnzJNUTdgu3mD5PEmLgP6eYV/4qIQYUHQPob9gmQx4upIajkr6BzuVDFw
zrklkYpI4H40AwYroV7Y
=fE0B
-----END PGP SIGNATURE-----

--tsyccm7ryotr737n--
