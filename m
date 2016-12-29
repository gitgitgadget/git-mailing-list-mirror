Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120F31FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 23:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753284AbcL2Xpn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 18:45:43 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36407 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbcL2Xpm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 18:45:42 -0500
Received: by mail-qk0-f180.google.com with SMTP id n21so279478244qka.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KM/wq0/5ZuZBp7RbaAWEZx5BlylUhowLEhzH1aXodSM=;
        b=RvBh2uMBEls7y3rg5q13C6kHmWr0HCdMN2IypFmquEYQnxgQ9fJV4DG+ew66aojSSw
         6wF4U5yPcLzVmuR4q/TLCNrfSSIGPTxOb8bwGUCw2cpx7ftAvf6DJBX8GWoO60zjGS/Q
         3QjMGFx36aAsOiHZl41G0/ozYFRqkg6rWvZ5uJvUtVwCDCGfjPU44caAcQVlH8jbZD4B
         yOfeLGqEoip+QvB8pUiwfnTH4YKkgJiClF1JChzv4zjKO0+FGKbGnQCvzgV8ng9u5i+l
         Y96m6L2/bn8WCZWmy+RFEt6Qwvdc4cCVzjJ7Z+W1W0gHki+ZKGbLnp5C+O4oemHPnXvs
         MGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KM/wq0/5ZuZBp7RbaAWEZx5BlylUhowLEhzH1aXodSM=;
        b=dEknFVdgo6WIItpEg+uQpWmoF2p5I66XO3cJlyDavNVui15qAK2T5qWFPyvO8vcgf3
         nBwlD7bnTah/30M+XSx6TTs9N+Fc0acoJC2y2WZUOaY6Y5D8GT5LoEr8KasZP2vyxN6N
         M3X9cuSn+HwIBhKPjNX4z2gZVvgjBSAfiU5ZK/TdsTaTOHfLLx1u5PINrcV/L0ArSbxJ
         L370P5bIIl4asZtqK4yAzX14Vgxm9h1M/rpkI/XZ/cAbZdC8rDtvm3+YEmKNJJ464yQG
         EkoNUyTHSTo7kMkbVHzYmJClaFe6ItzaswLm4jpyT2wmOvCfwINZTsG6V//MLM2hmQe+
         oj/A==
X-Gm-Message-State: AIkVDXLrDX+a3cNDk+64NKNkwSqUfuLjgCBSbEDfMKZcZNXmG/KCFarP2M8dLevnVba9z7joGi/iH4KamOFyuMMA
X-Received: by 10.55.90.68 with SMTP id o65mr7411812qkb.47.1483055141905; Thu,
 29 Dec 2016 15:45:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 29 Dec 2016 15:45:41 -0800 (PST)
In-Reply-To: <CANmdXCEGTxgj8BuQZkaBQaktOBrGmLETcQJg9xfV27Kn-0aLGA@mail.gmail.com>
References: <CANmdXCEGTxgj8BuQZkaBQaktOBrGmLETcQJg9xfV27Kn-0aLGA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Dec 2016 15:45:41 -0800
Message-ID: <CAGZ79kaBsyt3=bYs+vyhKLKmnCKmeWcJC7bpxjpJU0pYF-osBw@mail.gmail.com>
Subject: Re: Bug: Assertion failed: function prefix_pathspec, file pathspec.c,
 line 317.
To:     Rafal W <kenorb@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 3:37 PM, Rafal W <kenorb@gmail.com> wrote:
> The following error happens when I'm running "git add ." in the submodule dir:
>

Thanks for reporting!

Please see the patch that I sent out earlier today:
https://public-inbox.org/git/20161229192908.32633-1-sbeller@google.com/

I wonder if the error message is sufficient, i.e. would you liked to have
more help reported by git?
