Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6C7209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 20:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdFFUV6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 16:21:58 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33283 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdFFUV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 16:21:57 -0400
Received: by mail-wr0-f177.google.com with SMTP id v104so59045943wrb.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XMdaRDs701e8Gk3xpK5ca1Dwto1/prTUvYZ6Ras0wds=;
        b=lHpFoP7pkySbJVLY7lZryjM8+T8JeygcENXoeUd83e38GnCYHLRgvvwbRFwlXLZ5ki
         SVUK9pQsin3YsyoQC28bDw1LiMG8xEzQYdBWwPt/nHWwIthRllAQjbW2hKUI37T+sDpC
         KWR01GuvdKmWZmAB3UNFXI1w9pjrJ7hNHMvvc65pcOqHMy6vuZC+n9DTcib1PmhP8pXe
         JUtxs/4H/4wI+avvuxLFrWFat382dBF+MfW4nWOGmy5+jSTTx+zysEqYOghEp+nsmQ1X
         /cRS4CwDnhrpZxtJ3XNjaqKpDphZ+AGr0MkzfdtNuUu4W9N2rFWFlcQ3Ue4BalrsxWkC
         YB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XMdaRDs701e8Gk3xpK5ca1Dwto1/prTUvYZ6Ras0wds=;
        b=Pfo+hSMeIKVwSuE4Ijo1vQS3AXpMzelNlWlSECjHPyLfOZRYp6pJTIJxtFVTprzXVQ
         C/YSAm6yAVN8T/s8gulHRfV3QwYklqtoiqYdtX/zW0xf3GOLq3Z4AnNHff4FIvN+O0Lw
         BT7UfP9dDRFlret7QEQivQIylYIT/WsQKacApI8GBzOF+wvYFybPJhObM0U1nN/ks75h
         yiELV7yt0k2dQpd724Qm22Rd0BZQPYyW2nEdmYnZWn0pNG6FszhzYQSfXUf3eS/vqDPS
         JQCO+y38GbFE+5sz3SeN4hi3kiXOFNzTRLYpibeivlnRm1PO/DjrNBTiyZPmXXLQAwKQ
         MF9A==
X-Gm-Message-State: AODbwcCVpCF0EkdJg0AjF6TczOilCy6pGu023XbicDoW+wAlVwZ2+DQ9
        9b6bbvNTqHvTAA==
X-Received: by 10.223.172.113 with SMTP id v104mr21390006wrc.112.1496780515545;
        Tue, 06 Jun 2017 13:21:55 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4687.dip0.t-ipconnect.de. [93.219.70.135])
        by smtp.gmail.com with ESMTPSA id x37sm61685015wrb.42.2017.06.06.13.21.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 13:21:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] t5313: make extended-table test more deterministic
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170605191525.666opa3se7gabdbv@sigill.intra.peff.net>
Date:   Tue, 6 Jun 2017 22:21:53 +0200
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D6527BB-A642-4C63-B1C2-245BF0E759C9@gmail.com>
References: <20170605185601.yzbq5e6r2tfbgzqw@sigill.intra.peff.net> <20170605191525.666opa3se7gabdbv@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 05 Jun 2017, at 21:15, Jeff King <peff@peff.net> wrote:
>=20
> Commit a1283866b (t5313: test bounds-checks of
> corrupted/malicious pack/idx files, 2016-02-25) added a test
> that requires our corrupted pack index to have two objects.
> The entry for the first one remains untouched, but we
> corrupt the entry for second one. Since the index stores the
> entries in sha1-sorted order, this means that the test must
> make sure that the sha1 of the object we expect to be
> corrupted ("$object") sorts after the other placeholder
> object.
>=20
> That commit used the HEAD commit as the placeholder, but the
> script never calls test_tick. That means that the commit
> object (and thus its sha1) depends on the timestamp when the
> test script is run. This usually works in practice, because
> the sha1 of $object starts with "fff". The commit object
> will sort after that only 1 in 4096 times, but when it does
> the test will fail.
>=20
> One obvious solution is to add the test_tick call to get a
> deterministic commit sha1. But since we're relying on the
> sort order for the test to function, let's make that very
> explicit by just generating a second blob with a known sha1.

Works for me! Thanks for the explanation!

- Lars

>=20
> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> t/t5313-pack-bounds-checks.sh | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/t5313-pack-bounds-checks.sh =
b/t/t5313-pack-bounds-checks.sh
> index a8a587abc..9372508c9 100755
> --- a/t/t5313-pack-bounds-checks.sh
> +++ b/t/t5313-pack-bounds-checks.sh
> @@ -139,7 +139,13 @@ test_expect_success 'bogus offset into v2 =
extended table' '
> test_expect_success 'bogus offset inside v2 extended table' '
> 	# We need two objects here, so we can plausibly require
> 	# an extended table (if the first object were larger than 2^31).
> -	do_pack "$object $(git rev-parse HEAD)" --index-version=3D2 &&
> +	#
> +	# Note that the value is important here. We want $object as
> +	# the second entry in sorted-sha1 order. The sha1 of 1485 starts
> +	# with "000", which sorts before that of $object (which starts
> +	# with "fff").
> +	second=3D$(echo 1485 | git hash-object -w --stdin) &&
> +	do_pack "$object $second" --index-version=3D2 &&
>=20
> 	# We have to make extra room for the table, so we cannot
> 	# just munge in place as usual.
> --=20
> 2.13.1.662.g6e89c999d

