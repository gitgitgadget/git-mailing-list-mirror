Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D381F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 11:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCXLPa (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 07:15:30 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:39574 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCXLP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 07:15:29 -0400
Received: by mail-io0-f170.google.com with SMTP id v13so18029738iob.6
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d0Pe7JLxTmJwb8ohunnXN06jjW9rWGoA1MWGZBl5HAs=;
        b=EpvBJ5orfbGgHQP9nzvcMeqn+jRAzsZRXsmPcKLUqo2cz4C/yB530yRKIlyN7FBCeb
         mLhHw/w7MqjuuD3py0cCCzFSbxZ519dH1+4IXWlFhGmHieN5p3VxH3qPjxfEuc91goU9
         zZMOC/95frG+ZH+VixlqkjJ/t3fN0LWUf6ZAgOvmf38SGgaVez0ydX6qEL19v5CJrk3x
         Ma57kIr10QJMmfYj9mmduTr7JNP9TfUwMZZ2xmZKAEB1TFWWLmCPq2xN0XzydltiG7A8
         uyYkTigeZzJ0B/QAFvc2Nw254HCTuKDUrDPp7s4Yk8do/6kkBGOXWv1dwWmImn5+Q+YP
         CSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d0Pe7JLxTmJwb8ohunnXN06jjW9rWGoA1MWGZBl5HAs=;
        b=uLZM0Sx6nQOyrIZiYfo7/7173XO276ji03vVJzQwQkg+uTf8eWMWtJCopa6JM5bF92
         3S1Uc6/6SNj7h9l0WOVjYIa9yDInDKEsiXkn14Nt+f9RxZmzwZCnixVY3ihpAMlvEaEr
         J8xGkoVIL6sIufJr4X1T0UMS9GAK5RpWdwdgyFDPkaBO+OgKshKC3fehExCbrYKUwhsR
         dtbDO+2ijnmvHSIWvp7emrg/494uzH7fIpa0NCcyhXNgR6gX7suXE1WY+CCsB766n80J
         cr21/c7KWkN+pOwlJ4lNC8VYN4ibnBF8jVFMSiN52J0X/7QOiTKMXOlkWsO3BdPpwFa4
         lO6Q==
X-Gm-Message-State: AElRT7ETHfjsBhC+PeBBepjhELWUl/smQHyMkLfZgSRyk6ANYCPe1BYd
        FwKmvyw3bLvb8AhXcRFmZPoSXUMzzO6Uuk0MdxXWt2Ue
X-Google-Smtp-Source: AG47ELs0hhIjYqROJvLPeiZughp+AlFLYb2HfbOcmHTNBA3sGNaXGmJiB4vGjhvv6Lh9A9whF9FG5feGdFfPeKdmzXw=
X-Received: by 10.107.150.19 with SMTP id y19mr22852294iod.272.1521890128313;
 Sat, 24 Mar 2018 04:15:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sat, 24 Mar 2018 04:15:27 -0700 (PDT)
In-Reply-To: <20180324084103.3367-1-predatoramigo@gmail.com>
References: <CAP8UFD2D-XU=YeJD7A+9wauu0WKHwkXgVxbEBkOGPyZE7GiOZA@mail.gmail.com>
 <20180324084103.3367-1-predatoramigo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Mar 2018 12:15:27 +0100
Message-ID: <CAP8UFD3Q26oiusO-+0SyFd=J+DTnrL5Xemrk+LLOk3hAUEVe9Q@mail.gmail.com>
Subject: Re: [GSoC] Re: Info: git log --oneline improvements
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Mar 24, 2018 at 9:41 AM, Pratik Karki <predatoramigo@gmail.com> wrote:
>
> Hi Christian and Johannes,
>
> Though I sent a mail earlier, saying I would like to submit another
> proposal, I am now skeptical on re-writing another proposal as you
> guys are only available mentor for GSoC

Well Stefan Beller wrote in

https://public-inbox.org/git/CAGZ79kax5Hip1wP3U60im__Dm0GvH8nNd+ByxG5OxMXrRkRvdQ@mail.gmail.com/

that he would be ok to co-mentor, but I am not sure which projects he
would be ok to co-mentor. I just Cc'ed him so he can tell us more.

> and I believe Git doesn't
> select more than 2 proposals.

Yeah, because mentoring is a lot of work, and doesn't always work out
as well as we would expect, (mostly because it is difficult to explain
to new contributors that review cycles for significant patch series
take a lot more time than they could imagine), so not many people
volunteer to mentor or co-mentor.

I still hope though that over time some former GSoC student will
become (co-)mentors as this happens quite often in other projects that
participates in the GSoC.

Best,
Christian.
