Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D3A20756
	for <e@80x24.org>; Fri, 20 Jan 2017 19:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbdATTQi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 14:16:38 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:32886 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbdATTQi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 14:16:38 -0500
Received: by mail-lf0-f47.google.com with SMTP id k86so63624715lfi.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TbYtJQXXDmgHzuWLPgZMsjbylbFVn22wHjcKLYLtGQ8=;
        b=EiWtrdNJOtPghGqWx1MDDvmircIyoHadxWkLK8i3ZPWZlV9VnkaeBX+81ObbnY7IM1
         wNSoJycozeMiqfKLLOMfZPC9W/Oqn2UCtBKOTPO18dNRkKOXCcUi8bgtjUq9JrSWhS4x
         c0qF7AsBUlcM1vOOGRaUl9PHj9lmFfiJp17tbZDzuNdAsNGiyek7lX8o2jel6dxQmXGr
         5G8Wl8P9GtvIsG1/rF5sTUF3i5XG7EYS43uoTFthHjwf+DzEx+fFu1D8U+LBAxljKDVh
         YtWBfC2OQS2/p9OVag25DDsj8QHiUkGbyS+9nyaG4YQS2ik9zPBpQAvW7aTNO0hydHwZ
         Wniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TbYtJQXXDmgHzuWLPgZMsjbylbFVn22wHjcKLYLtGQ8=;
        b=LV1WfHfCHiu/NoycJT8H84gbGOLvxYqWYXax7MUoZtYveAHewsWBAGQUfaB1lyAJal
         xc8DXrfeTkeaxkFpghrArl4H9muVifyJ1/25YuWXFq4GQc9qiYcf31wTiz/XLEmFDYuQ
         AyBfvMbldUjt1NRf1dX+Y4jtQSwtLlVP1W+b0WC+owGhYdKxPV2esEHtsXoqRd26XlaP
         MK5YLoIjPoSu1apNl3ss3Gt1KR7LlX3P/cd0aZapXp0FfYqGhSxPXMlx7wEiUKe76D8o
         1XGDxuFjLXCj1eAokvfXChCOLTpuT6UwQNfkACaa9xnb3UkDocrGRNrH9PLYLXacWxlk
         o+Tg==
X-Gm-Message-State: AIkVDXK/U0cZ8PlPlzV6WclNBZd6kWKJjq1Opgw4V/CQFjONQAu8QgNFl7s3boE5HXbZ8I56CPMzGaFQuPiwgQ==
X-Received: by 10.25.33.21 with SMTP id h21mr4884591lfh.114.1484939796208;
 Fri, 20 Jan 2017 11:16:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 20 Jan 2017 11:16:15 -0800 (PST)
In-Reply-To: <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
References: <20170120102249.15572-1-pclouds@gmail.com> <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 20 Jan 2017 11:16:15 -0800
Message-ID: <CA+P7+xoMTX5n_h+5MytZwVqKjqa0wdNKCeDtH29A_+WSfr6gTQ@mail.gmail.com>
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with keyboard
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 8:09 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 20, 2017 at 05:22:49PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> OK This patch is horrible. Though the idea is cool and I've found it
>> very useful. So here it is. Perhaps the idea may be revised a bit
>> that's more suitable for more than one user.
>>
>> The problem is old, SHA-1 name is not keyboard-friendly, even in
>> abbreviated form. And recent change has made abbrev form longer,
>> harder to type. Most of the time I just go with copy/paste with the
>> mouse, which I don't like. name-rev helps a bit, but it's still long
>> to type (especially with all the ^ and ~ that requires holding shift
>> down).
>
> Not really a comment on your patch itself, but I think a lot of people
> solve this at a higher level, either in their terminal or via a tool
> like tmux.
>
> I recently taught urxvt to recognize sha1s and grab them via keyboard
> hints, and I'm finding it quite useful. Here's what it looks like if
> you're interested:
>
>   http://peff.net/git-hints.gif
>
> The hints technique is taken from pentadactyl (which I also use), but
> the urxvt port is mine. I'm happy to share the code.
>
> Which isn't to say solving it inside Git is wrong, but I've found it
> really convenient for two reasons:
>
>   1. It works whenever you see a sha1, not just in git commands (so
>      emails, inside commit messages, etc).
>
>   2. It doesn't take any screen space until you're ready to select.
>
> The big downside is that it's scraping the screen, so you're guessing at
> what is a sha1. False positives are a little annoying, but usually not
> that big a deal because you're already looking at what you want to
> select, and the hint pops up right there.
>
> -Peff

I would be interested in the code for this.. I'm curious if I can
adapt it to my use of tmux.

Thanks,
Jake
