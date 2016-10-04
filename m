Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4283207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbcJDFuv (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:50:51 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:32797 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbcJDFuu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:50:50 -0400
Received: by mail-yb0-f194.google.com with SMTP id e2so4141022ybi.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ssf17zM/wiF7QyiQXNs0CCt9kzVqqHDbfhOL+xG/9cc=;
        b=ZeutHUZZeNYJDwM5XIWZvwJmI733L2u3bcYMwGHiX11CyIaqvERfFZgKd2MbzU6bXo
         BV+1xvcv27HAVbMN1fdKmyxgciBDJwMvjGhd/pML/nRJR8SrxDBdBaTU6IeGtEBdguje
         /7DNXD+JpieKhS7xci4CATdqR0LiAzwqkyYLGiHt8+nlDJwKgyFvucCRZdKuaYKKn4XT
         iAWWMi3OJB8oF/GeRQy3iA/QQ0n7Q5ARyw6ewoGyir8J+J3vuYQn/GMwfkK7kVkSBypk
         vDa2hmNcfc96OajpwSc2FwbCu/XRtwleEPJB0G/rA/+NbJHGlMPo0/cN99tqrkTn8UKS
         +q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ssf17zM/wiF7QyiQXNs0CCt9kzVqqHDbfhOL+xG/9cc=;
        b=Hs2Hu16s3xiEhMQ95UY8g5YZWzjcq0ngpQ7+XUg5khYd+1ksVLJWLjovTAfZI64LqX
         Q9U0qWXe4fTDuqjmdHSwkU1mJ/oGb86Ya1SlWAGVjKs5MInuvS+mPzLL6oDkl9lT2YrS
         7KNE8+HV19RNs7pLyw1DQCIK40TCjQSVZmFFjaZMMP7DUSZmOtQWo3tnoJaYCcpC7bgx
         oVszmXdrdrIT84HkuivJDgYEecy4C5hc2bHgTdeKiSSdwrHzAxxRFleqUCICHogyeMRf
         s28zMxMdS6Yioj+b6muz7FXQlMOJYNE+hF8oZMINsSqTbtZZ8Csnvkuj4V8TCNUzFB0v
         0Raw==
X-Gm-Message-State: AA6/9Rk2ZMZamXY1/+trtRhwf60eWkavPiQU/w6sBnySMKqs/LZhVJuaJzbGDYewHxjHyCuBuCePxYQH5CrkHg==
X-Received: by 10.37.174.1 with SMTP id a1mr1380006ybj.6.1475560249464; Mon,
 03 Oct 2016 22:50:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 22:50:29 -0700 (PDT)
In-Reply-To: <20161003203357.3cpeg2jyalzykm65@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203357.3cpeg2jyalzykm65@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 22:50:29 -0700
Message-ID: <CA+P7+xoUbOCRh0C6CAFHgw2NKLstUs_jGHbMQwvqTidfOoEHqQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] t5613: drop test_valid_repo function
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:33 PM, Jeff King <peff@peff.net> wrote:
> This function makes sure that "git fsck" does not report any
> errors. But "--full" has been the default since f29cd39
> (fsck: default to "git fsck --full", 2009-10-20), and we can
> use the exit code (instead of counting the lines) since
> e2b4f63 (fsck: exit with non-zero status upon errors,
> 2007-03-05).
>
> So we can just use "git fsck", which is shorter and more
> flexible (e.g., we can use "git -C").

This seems obviously correct. I didn't understand your comment about
the use of "git -C" at first, because I was confused about why "git
-C" doesn't work with "git --full", but then I realized you can't use
"git -C" with the shell test_valid_repo function.

Thanks,
Jake

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5613-info-alternate.sh | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index e13f57d..4548fb0 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -6,11 +6,6 @@
>  test_description='test transitive info/alternate entries'
>  . ./test-lib.sh
>
> -test_valid_repo() {
> -       git fsck --full > fsck.log &&
> -       test_line_count = 0 fsck.log
> -}
> -
>  base_dir=$(pwd)
