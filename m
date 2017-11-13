Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52D61F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 23:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdKMXZl (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 18:25:41 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:48251 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdKMXZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 18:25:40 -0500
Received: by mail-qk0-f172.google.com with SMTP id a142so21938144qkb.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 15:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/F9bgbU1mO/4fZI16ET7UlB337oyryCHcIm8Zw/pGvw=;
        b=TMFe0phyV61TnGoevxMSMx9iZjXZoJdcR//MWfV/GG3lv1pNqk5uZyeghTMO4dwdpo
         UANDo+EzusqF9FEgLOpyfk9gOcHG+lc6NHO//EWSUSSmFHsTfnfvL8V3TI01S5+s5UdK
         eAQPN2SpFAd1sKW38aYHgpxdpNv3mUsNt6Iez5qWnc6Mxxijp8Ymke2210hJ+7qJD6lY
         8rebPhXUzOQrQMM2gdR7B5CpFuED1EELzFcXyObhuugpZBaTPVAzyqq5bKU2lYn1+8kc
         ZS7gGGlHgmD2v/6JAX3xYNt3RwhwSZkWu6JNanh1lh+KZOJ2wZ4PeHBuFXHaBA5SNe43
         GjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/F9bgbU1mO/4fZI16ET7UlB337oyryCHcIm8Zw/pGvw=;
        b=YKxKHKZJHLDfpbGa8Q7IzmS0ze9VvZ8Jzalbg2+6a5fQWL5aLiHCJXNxsGt/rOGe2O
         xLnKm+SEIH3w+z52DWIeOMjWdckuTaVLrUFN3Rga3jbqY3Llyy/UDE19q2Ejj6+NClah
         aG3BaGDSQoUdwoOxnFalteo6KaQE3drw+ZLmQIA4ayHScPX7hzklXpabEWSJGe0ZKt2N
         /7wAF8cg8z+g5RLYI3evld1KDRynkEBrRQxI0uvOPBOXObKoDFy4f8rYODVkJBy+K3xz
         EOgIXHGRvYtHojTAQ+h1ZbR2Ov3I99FIEjdq+SazVF4z9xlR2+7IatCU8O7mjGsc1N3W
         bvQg==
X-Gm-Message-State: AJaThX5uSpv3BHuPqEh0W7kFSJO8DJb1N+rcYVSMiStkfZ4iaBJTVl9Q
        qNZoG5QiuPTUmR4eb+fLuH/iDBMPjgAY2ZvNXVc7og==
X-Google-Smtp-Source: AGs4zMY2l62uCctkGfKOMgEGWHGq4La6dNiPbq1CoXqvjNjPXTsx3BbLE/JHkhG3U1Kyl7sHnYtfdLiY/GIb1swcBlA=
X-Received: by 10.55.111.3 with SMTP id k3mr15932788qkc.332.1510615539863;
 Mon, 13 Nov 2017 15:25:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 15:25:39 -0800 (PST)
In-Reply-To: <20171110190550.27059-7-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-7-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 15:25:39 -0800
Message-ID: <CAGZ79kYOW9+pP5ApKDHR2_VwPXyiLEEbbO0-3ka-SDCP6ryLPw@mail.gmail.com>
Subject: Re: [PATCH 06/30] directory rename detection: testcases to avoid
 taking detection too far
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6043-merge-rename-directories.sh | 137 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index 00811f512a..021513ec00 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -513,4 +513,141 @@ test_expect_success '2b-check: Directory split into two on one side, with equal
>  #   messages are handled correctly.
>  ###########################################################################
>
> +
> +###########################################################################
> +# SECTION 3: Path in question is the source path for some rename already
> +#
> +# Combining cases from Section 1 and trying to handle them could lead to
> +# directory renaming detection being over-applied.  So, this section
> +# provides some good testcases to check that the implementation doesn't go
> +# too far.
> +###########################################################################
> +
> +# Testcase 3a, Avoid implicit rename if involved as source on other side
> +#   (Related to testcases 1c and 1f)
> +#   Commit A: z/{b,c,d}
> +#   Commit B: z/{b,c,d} (no change)

This could also be an unrelated change such as adding w/e?

> +#   Commit C: y/{b,c}, x/d
> +#   Expected: y/{b,c}, x/d


> +
> +# Testcase 3b, Avoid implicit rename if involved as source on other side
> +#   (Related to testcases 5c and 7c, also kind of 1e and 1f)
> +#   Commit A: z/{b,c,d}
> +#   Commit B: y/{b,c}, x/d
> +#   Commit C: z/{b,c}, w/d
> +#   Expected: y/{b,c}, CONFLICT:(z/d -> x/d vs. w/d)
> +#   NOTE: We're particularly checking that since z/d is already involved as
> +#         a source in a file rename on the same side of history, that we don't
> +#         get it involved in directory rename detection.  If it were, we might
> +#         end up with CONFLICT:(z/d -> y/d vs. x/d vs. w/d), i.e. a
> +#         rename/rename/rename(1to3) conflict, which is just weird.

Makes sense.

>
