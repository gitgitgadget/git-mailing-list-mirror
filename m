Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B4C1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeCZSfk (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:35:40 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35015 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCZSfj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:35:39 -0400
Received: by mail-yw0-f181.google.com with SMTP id c20so6446035ywa.2
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/oQRsVRPeQov7vEq5DS4huEFWnEYrZJ0AFiMtPsBtDM=;
        b=qmshQr2aYUrWAeqkYfioyST98xJqxi8tISYYEBhdbmHBAy0Q3r8lwbiTwMY9J9gzQD
         FRKQrc8zOa7Y2Q4oe7raUhTK1zzJGcODKZvZF/v4cFdeCCJ3dlvl6Aw5YQe1g7X0UJAt
         RJvyqeVcvW9qSpV+xptq/QiwspYqcufsYsr5dAr0r9anFkOaa6SSQRHZVz+pVC6ooe4Y
         VQp/AEupypnwW7NnI7i5mhseZ9sY3ZlzGdaIYrcpv9aXKx46p3867b9v5hOoQeMB38EU
         6mQKgju6wa+fxzQgn6TLiaDbB54yc2a6f0Taf1mlqh2NAmB9hkbWzp1wK7pIpEI0OWfn
         GAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/oQRsVRPeQov7vEq5DS4huEFWnEYrZJ0AFiMtPsBtDM=;
        b=BCQTs6yqQtaE0HQqXBfHW499YRi1BjV0fFJYjErNHpWf+NVwYpCGT85wekpxb8iTdd
         dgtzr2HNcklHKCAt/I5+Ot37LbWeHEEgebsUP+EX+Qlxcy4tDSsSF27vEKkEAF3CBqG3
         lprB4duWzp2Zz+lcWK1ngXNSzD7cS8782/1z3bVPPJ9+M8pkrjHpiehWSVykO6eWQSEt
         mK4Ch2FvX92zuN5L+A91Lx1vynlk3JOmfqIatM5qEUtdg7fjVhc51yACj9M79LUWkxOA
         h5CV2pRJKhPii63ic+LnCTde21rZWRr28WjerF0usanVFCVwsO772LJEJV2Cop1njBQr
         68fA==
X-Gm-Message-State: AElRT7E61iJ1/9D0HRb4WferfreNWWnlku3GOKf8uIvtKj7phIARjGmS
        QRGwO73+G3YK/oLywX/3GzM12P7iSu/iEZcjyeRA6Q==
X-Google-Smtp-Source: AG47ELtIsLbLXGlAuZsJKDq1IhwkovTl0v26OfrbzYfuUObxYrTbKjuF0xJzo8uO1RkjmkGlQrARy8G5Pdl4XDzKiBg=
X-Received: by 10.129.232.5 with SMTP id a5mr10409325ywm.421.1522089338066;
 Mon, 26 Mar 2018 11:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180326182708.26551-1-avarab@gmail.com>
In-Reply-To: <20180326182708.26551-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 18:35:27 +0000
Message-ID: <CAGZ79kYcX6z6276c1R8k0qya56G5UzuM96mOxhAOtG7OFw=TqA@mail.gmail.com>
Subject: Re: [PATCH 0/2] doc hash-function-transition: minor & major clarifications
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Marc Stevens <marc@marc-stevens.nl>,
        shumow@gmail.com, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 11:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com>
wrote:

> Having read through the hash-function-transition.txt again, a couple
> of things jumped out at me:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>    doc hash-function-transition: clarify how older gits die on NewHash

> We weren't accurately describing how "git status" would die on NewHash
> repos on new versions.

>    doc hash-function-transition: clarify what SHAttered means

> I don't think we had a good summary of how SHA-1 vulnerabilities
> overlap with concerns Git has, now that we've moved to the hardened
> SHA-1.

> I may very well have gotten this new summary subtly wrong though. So
> please review.

>   .../technical/hash-function-transition.txt    | 40 +++++++++++++++----
>   1 file changed, 32 insertions(+), 8 deletions(-)

Both patches look good to me.

Stefan
