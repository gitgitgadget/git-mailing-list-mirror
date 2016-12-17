Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A25E1FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 00:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757905AbcLQAhl (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 19:37:41 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36718 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756770AbcLQAhk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 19:37:40 -0500
Received: by mail-yw0-f176.google.com with SMTP id a10so39769492ywa.3
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 16:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d63AT9oEQyYL9y2jYwdXWR/Ajnk0PNb9gWmrm/G7B1s=;
        b=HAFL1wELb07dctDbt64OTgNxmlVbTkI0ysyh24DMe5Qbs0JsNyniVVBd98qy8qUkxe
         ry5F8pC4l/Xxtn8BxQogqbOLIZhVBBVBAkOH1dyxLPd9z3I61C6DMbIpmG01Uzhc6AZg
         k1bR0rvZZLhsnFkIJ+5w6gazuLAaSKjuyjI5gH3929atr6jqzECjqNEI0hdD6c/tmhhF
         1WYUxRRIfc/c6H1w9lrKtWaREYdHXgg2/RJXbUuy9NYDw5iK/3HYcpzrukIpo5J4Mjnj
         JNEta6S3eo3cbGlQP/+CFbONdN5AeTRz2W4fOobIfawPgQp5PDAGLoEaTn6pQl/bLFDX
         d/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d63AT9oEQyYL9y2jYwdXWR/Ajnk0PNb9gWmrm/G7B1s=;
        b=kXjPfd5ybPayDGonOr4KJ0u4U5jOcL2k+8kSyFtxS/m2OFjcHPj9SZ3zWtyYwlsdQ4
         /Nt0nK/AkWURS1hbIQaY3klsz++DVLKbq9/XIVk40V0oyKFhtXrbZ/Uu0TY1KI1D0qY3
         1YoUAnTCLVz4OWBlO2iaogI1/nxapKRmZ/bjmmtN2NWGxLROmOMvsA2CoaV1iy1odD79
         xg7TLxdzrFBB5rFGyUyo7wbNTePVqHpJifYxHOeYEmuwScwPZSg9JrxwM3LvyJ9XTwEE
         p6wV6YSaMAjOfSJqEXoVn5GYQI+I+SK1PU6GbiIJyqb3P69gH8hcM1iRn3ceElupnt/R
         03AA==
X-Gm-Message-State: AIkVDXJbGHpxN3ZrOCZRytyvOcRNa+Nk5owG+iwFxgPaPbdX7G3ebQ7MIHGGxPWpv/r+P2pAUVpNIQNkCrSwZw==
X-Received: by 10.13.221.12 with SMTP id g12mr4981630ywe.257.1481935059469;
 Fri, 16 Dec 2016 16:37:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Fri, 16 Dec 2016 16:37:19 -0800 (PST)
In-Reply-To: <CAM+g_NsDLKxWLZCDOgrh2O3W23PRP8Zxf-Zzf_twSw5VX3=G=A@mail.gmail.com>
References: <CAM+g_NsDLKxWLZCDOgrh2O3W23PRP8Zxf-Zzf_twSw5VX3=G=A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 16 Dec 2016 16:37:19 -0800
Message-ID: <CA+P7+xpwL+jw=eJhBH6xTPCJoDrzXBHj4p86xtyMZ++eyyHkTA@mail.gmail.com>
Subject: Re: indent-heuristic, compaction-heuristic combination
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 4:28 PM, Norbert Kiesel <nkiesel@gmail.com> wrote:
> Hi,
>
> I started using compaction-heuristic with 2.9, and then also (or so I
> thought) enabled indent-heuristic with 2.11.
> Only after reading a comment in "Git rev news" I realized that these 2
> options are mutually exclusive.  I then
> checked the Git source code and saw that Git first checks the new
> indent-heuristic and then the old compaction-heuristic.
> Therefore, anyone who is as stupid as me and enabled both will always
> (and silently) end up with the older of the
> two.
>
> Apart from better documentation (I know that both are marked
> experimental, but nevertheless): could we not swap the
> order in which they are tested so that the newer heuristic wins?
>
> </nk>

This seems reasonable to me.

Thanks,
Jake
