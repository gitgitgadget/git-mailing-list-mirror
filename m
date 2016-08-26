Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DBB1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbcHZWp7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 18:45:59 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37579 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbcHZWp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 18:45:59 -0400
Received: by mail-it0-f53.google.com with SMTP id d65so15711407ith.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2XoA9f/QIwFQ/ctWsO9gBjxkcG34/ouuu1soKD6vm1Y=;
        b=hlTmRAf+TVKBdPVVmvVKo8J/rAs9KIGyke3E6DLBc3mt3xkWPjXEDTafbJkvz//Djg
         eIFsGnFdLdiP0a563nhrMBoeR7MYoa75m2u8ASMbbHgEQEbREb+KpZhUcLyxuhjCJfiw
         cQKvhJJiEuILgyI5oLX9z60CR9qzsynAHRRUBdWOQvfFy+Q02veHNrl1Pg14VGx7D8J5
         xMZVuY0a6JNM2hAUP/MUdEzvNrwzAqCdKR8gHJfKYTbPaaSkbxLxLZkl1v+fKZ/ZMRQi
         cGmnEBqT4nHyhfWgjC46vKjjRko/CnlDcZjumQ45JpjOmVwIsErW6boUm1IIO+BIAXAq
         PSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2XoA9f/QIwFQ/ctWsO9gBjxkcG34/ouuu1soKD6vm1Y=;
        b=Z+TyagWahk9n1Xz0dioJ6jSUA96aEEuGNK/Rag5nQkpRDFll9I4GR/mKCI1B5iN1ev
         0FCl9hSwhyJaKmSLMRWEN1hEVLXkgMdh9xPyntltD94CF2fVhEkCxTWf9RWJU6Qni0lX
         wz184BaGJdRZE8YWzsIqPqqOZPCK4Xpnl3itZ06GbfisKzEAJ1KxM9ak0zi5QuF9JAcS
         VvzH0qaUmG8L1EXC63N+xRwbqBhQ9MLvvnNz/EZduDzyFnkq9cRDaGd0reN0cy03jQ7H
         D2z8a9drPhuXj+sPc1JQh7khlDmlBEX+sX2GOxhEJwYC4E3Qbvyr2w1d8vZYUh+Pkkwp
         uaQA==
X-Gm-Message-State: AE9vXwPlNjTlBRcNMM8YTutyLF+fWB7DDAQfcW8nVeg+LAg/b/MgrOz+jOcRE8cU9/4SGWR5YjBeJ3ESXy9io0IH
X-Received: by 10.36.228.138 with SMTP id o132mr1332322ith.49.1472251558231;
 Fri, 26 Aug 2016 15:45:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 26 Aug 2016 15:45:57 -0700 (PDT)
In-Reply-To: <xmqqk2f3duf2.fsf@gitster.mtv.corp.google.com>
References: <20160826222714.31459-1-sbeller@google.com> <xmqqk2f3duf2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Aug 2016 15:45:57 -0700
Message-ID: <CAGZ79kag07E_n+4KjOqqv-mxLe0T1VYjnuu5mT1k_EXLBcaYvQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: add quotes to advised
 commit reference
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>, Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Perhaps something like this instead?
>
> -- >8 --

This is way better.
Let's take that.

Thanks,
Stefan

> From: Beat Bolli <dev+git@drbeat.li>
> Subject: SubmittingPatches: use gitk's "Copy commit summary" format
> Date: Fri, 26 Aug 2016 18:59:01 +0200
>
> Update the suggestion in 175d38ca ("SubmittingPatches: document how
> to reference previous commits", 2016-07-28) on the format to refer
> to a commit to match what gitk has been giving since last year with
> its "Copy commit summary" command; also mention this as one of the
> ways to obtain a commit reference in this format.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  Documentation/SubmittingPatches | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 500230c..15adb86 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -122,9 +122,14 @@ without external resources. Instead of giving a URL to a mailing list
>  archive, summarize the relevant points of the discussion.
>
>  If you want to reference a previous commit in the history of a stable
> -branch use the format "abbreviated sha1 (subject, date)". So for example
> -like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
> -noticed [...]".
> +branch, use the format "abbreviated sha1 (subject, date)",
> +with the subject enclosed in a pair of double-quotes, like this:
> +
> +    Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
> +    noticed that ...
> +
> +The "Copy commit summary" command of gitk can be used to obtain this
> +format.
>
>
>  (3) Generate your patch using Git tools out of your commits.
