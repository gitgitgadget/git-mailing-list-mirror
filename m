Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5D31FDEA
	for <e@80x24.org>; Tue,  9 May 2017 17:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbdEIRAh (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 13:00:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32878 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbdEIRAg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 13:00:36 -0400
Received: by mail-io0-f196.google.com with SMTP id l196so813668ioe.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B46jdoTWDm6vvZYGOrBAgnTT4/us96/Ghay/GILUE1I=;
        b=T6cqJDMByeFrB/J636nF0Jzy4tzCYTVTNp1lUIZ1lRLSR+Ioo0XUeQCmn99yyCjKay
         Z0fW3R5I/C8pxhT4UO/OWaFgdwSOqIoL9sFAgc1c+SA3nHQ1e+88Zo7qpf+5o+bEBO3J
         Mt4e3x5Pxw41WqjaYks385IZrk0FdoWYpL3IWxA0osZWMpnYPs9H89vx67kLGAbBAkNr
         1/RTe43an8lXWs9rPvtn6oDuv3OeblOz7B8Xx5G0wNO1ihufq2AlXyJJK+OqQrM72Yxk
         zlY7ACVmr3Kyooai/YUPoXe0cKAKdNKVzVUWhSQ68B/znjd+wZ2iLBjb08YUHruvynk6
         1AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B46jdoTWDm6vvZYGOrBAgnTT4/us96/Ghay/GILUE1I=;
        b=j9Oh8xGIGYCUf+x1Ia3W/nv29xsteTLjsbHD9pySXLj7lyE/G83zLBu3skgpISAXWR
         SL5+IKI6ZzKAgj2q0nTqiPM5lBhytVSapewQCuRIsKWnWLLjSfSj4zbhvP9zRvirKn2V
         2SWJx+2Vw18rhYA9k9+S0W69+B8vCI8ZqRIFbywqle94NLlI+nPf/e8VEdZo12fNgHeo
         r3mc3j7ZRrHv6Xu54G2p0aIngcV2k3oj0VBTfiZmmBZZNa+pRhYkGZeu3ZOo2wryDsYM
         LBS5xzjGB49dOApVmBxzAWKCAmUTNnWL0NANvJH9uKL4auobRLiTNtw9Gyg+lrqVJBRU
         Px1A==
X-Gm-Message-State: AODbwcBW1ZPgzDR1KXkJHaXvokzR29n+8LtMRwiBAPophK54qnOi9TYM
        7V5/S774dhsCdxDPU1+27aUHHxn/jw==
X-Received: by 10.107.138.21 with SMTP id m21mr971999iod.80.1494349235346;
 Tue, 09 May 2017 10:00:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 10:00:14 -0700 (PDT)
In-Reply-To: <20170509164515.31942-1-jonathantanmy@google.com>
References: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com> <20170509164515.31942-1-jonathantanmy@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 19:00:14 +0200
Message-ID: <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! use perl instead of sed
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 6:45 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>
> Thanks - I didn't realize the existence of the test lint. Here's a
> fixup. Let me know if you prefer a full reroll.
>
> I had to use perl because "push" is a binary file (the first line
> contains a NUL).
>
>
>  t/t5534-push-signed.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 0ef6f66b5..3ee58dafb 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -152,11 +152,11 @@ test_expect_success GPG 'inconsistent push options in signed push not allowed' '
>         # Tweak the push output to make the push option outside the cert
>         # different, then replay it on a fresh dst, checking that ff is not
>         # deleted.
> -       sed -i "s/\\([^ ]\\)bar/\\1baz/" push &&
> +       perl -pe "s/([^ ])bar/\\1baz/" push >push.tweak &&
>         prepare_dst &&
>         git -C dst config receive.certnonceseed sekrit &&
>         git -C dst config receive.advertisepushoptions 1 &&
> -       git receive-pack dst <push >out &&
> +       git receive-pack dst <push.tweak >out &&

The test should have a PERL prerequisite now, that's missing.

Also using \1 will likely be deprecated in future versions of perl at
some point:

    $ echo hifoo | perl -wpe "s/([^ ])bar/\\1baz/"
    \1 better written as $1 at -e line 1.
    hifoo

Finally, you can just use -i like you did with sed, no need for the tempfile:

    $ echo hibar >push
    $ perl -pi -e 's/([^ ])bar/$1baz/' push
    $ cat push
    hibaz

>         git -C dst rev-parse ff &&
>         grep "inconsistent push options" out
>  '
> --
> 2.13.0.rc2.291.g57267f2277-goog
>
