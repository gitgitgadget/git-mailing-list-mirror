Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B19E20286
	for <e@80x24.org>; Wed, 13 Sep 2017 13:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbdIMNn3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 09:43:29 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:43269 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdIMNn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 09:43:28 -0400
Received: by mail-io0-f175.google.com with SMTP id k101so2104892iod.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/MihbfjNjW08PVQjZzAeWuxDGzj7qYi1onOz+d+j2yg=;
        b=Gm8IhnmiLTyh4TQ0RVEwyc0v1ZFfYP+L2B/2i+8ZV1vKUga6sumgx7m1w41upOYevO
         +UD0DELNq3Yh1ZdrPqtuD3tkulxiVlBZWI035Eg4bMw5isnfq6L2+ZddoT0ZtEzAbTXz
         pr2VuFxgk8Yk1IC2g0F4Xo3xCp3erhOy1A3Dp2yNof+NvfstfQsx5cwaBsUNwzdmNdSF
         Eq/kvbjp6I6jD0FpWCcNLJ63MTqtfGVzOSeOOaFCiV5wVBGKrrqCXK/QikLQk9YFdssJ
         Zkz13XqV3t2ARn6g6R8SBbfKvtex8TTZe1JPy92lnq0ztI2HxJwFfJCnaT4f0v5K4b9N
         7Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/MihbfjNjW08PVQjZzAeWuxDGzj7qYi1onOz+d+j2yg=;
        b=P2YnAh/yY/2SDNKeEp6+m3TP5DNZVRqZ2jkhpXi5HXFECqxPDE94IT9A54gsWAtxsZ
         1h6esCkFL0q9O5t8z74AGneblPYO+6/xo7CoKqgVKFZkMC7+b9oydDy1z5jj46rLTO+7
         p2c0zr9KHedz776hdwzHZ5DcB6cdcdGv4j1vACaSTiBRrS1J4fj35E7jKvK4indVhCem
         TRjMaZM8pS6ly3Uver4Mdgw06YtQvlm2npMI6zgjNLVLttjyuv8TRLrO7E3aLrPPxUZ4
         hiPvc/2XX+B7zX8MzHdr6++Io4ABMUVxb22j6EclU4Aglj9uSQD720sQSriwpfL+fs7L
         cz7Q==
X-Gm-Message-State: AHPjjUh7S6Py4tEGuMYUHo4/RlNPrRuGI6kRI7XtvRXu9hTZdulUS0/6
        VdqOmOSyCU+zoZgCGJ5o/5J+W2EFu4srN3JmCgNZpQ==
X-Google-Smtp-Source: AOwi7QCfio+20fE703WODHMtGkzzZXzbu+Dm55dQXsdkEtXp8x+oJdOctG65LT3D/kOaXKp2bB2euNffdwi8Ly7BGXE=
X-Received: by 10.107.48.140 with SMTP id w134mr11770008iow.301.1505310207973;
 Wed, 13 Sep 2017 06:43:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.4 with HTTP; Wed, 13 Sep 2017 06:43:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com> <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 13 Sep 2017 15:43:27 +0200
Message-ID: <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
Subject: Re: RFC v3: Another proposed hash function transition plan
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 September 2017 at 14:05, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> For example, I am still in favor of SHA-256 over SHA3-256, after learning
> some background details from in-house cryptographers: it provides
> essentially the same level of security, according to my sources, while
> hardware support seems to be coming to SHA-256 a lot sooner than to
> SHA3-256.

FWIW, and I know it is not worth much, as far as I can tell there is
at least some security/math basis to prefer SHA3-256 to SHA-256.

The SHA1 and SHA-256 hash functions, (iirc along with their older
cousins MD5 and MD2) all have a common design feature where they mix a
relatively large block size into a much smaller state *each block*. So
for instance SHA-256 mixes a 512 bit block into a 256 bit state with a
2:1 "leverage" between the block being read and the state. In SHA1
this was worse, mixing a 512 bit block into a 160 bit state, closer to
3:1 leverage.

SHA3 however uses a completely different design where it mixes a 1088
bit block into a 1600 bit state, for a leverage of 2:3, and the excess
is *preserved between each block*.

Assuming everything else is equal between SHA-256 and SHA3 this
difference alone would seem to justify choosing SHA3 over SHA-256. We
know that there MUST be collisions when compressing a 512 bit block
into a 256 bit space, however one cannot say the same about mixing
1088 bits into a 1600 bit state. The excess state which is not
directly modified by the input block makes a big difference when
reading the next block.

Of course in both cases we end up compressing the entire source
document down to the same number of bits, however SHA3 does that
*once*, in finalization only, whereas SHA-256 does it *every* block
read. So it seems to me that the opportunity for collisions is *much*
higher in SHA-256 than it is in SHA3-256. (Even if they should be
vanishingly rare regardless.)

For this reason if I had a vote I would definitely vote SHA3-256, or
even for SHA3-512. The latter has an impressive 1:2 leverage between
block and state, and much better theoretical security levels.

cheers,
Yves
Note: I am not a cryptographer, although I am probably pretty well
informed as far hobby-hash-function-enthusiasts go.
-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
