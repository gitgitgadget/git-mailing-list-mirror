Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61BE51F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfHZQgw (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:36:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42297 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbfHZQgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:36:52 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so38704026iob.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 09:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWbBRq4SIwh6MJ8bwxNhdcjVmF/imInxH/zTTjyykSk=;
        b=N5DVktmHoOJduGG0IiJYj7goKilxHA02kSO2SilfW6S9GOddeE+CgwofF+Iuz+rzq2
         HOo7vZNtdE98+H512Os2KOMk5/Uqz4z5s99fq/kRFlk4//5CkxrdB3i7G0xxn03dIss0
         QxYHAk3xE4EYz1Mt4RGIYCl2eyW5+0TtcX4cbFJ1WsN+ZFZvLka/wcpQ2pxUenkpXn2k
         6JV5c3urySGGNxwwrRXA0zCIyw3yonOu/W8Vv2kfI0VMSCzHHhQvqpy8vT1PYaR+z/tr
         lYx6PBBDRCkTgaYQi6XTYur/+yyFUlcljJhLK8RK50lP3DS0odb1dD8ABdciT5eNr9+F
         n7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWbBRq4SIwh6MJ8bwxNhdcjVmF/imInxH/zTTjyykSk=;
        b=VNOimoDETmYrrCICVj7BJhuoXYj2fbhLnRHWUAhCbrcwSnstthnvqHWH8Rd9TwCMjM
         w8nOGr7KKYshAcmbID+XycY8qJDl3UaGYi7MrAiQBsZaqo/ZM8kz7JGvcl1Y1H9TL/Lm
         t+XWjQQ+aQPc6XiLuqrOsorb0cp2lmp2vCd5QOVRndvbVvu79nbd4xclWt97VindCtBX
         PIQkCLg4joE+G7OZm7E79h5LplXdDVpOrO2gVGP5li18gHZWXc2wjUuzwzKRl4pc8bJx
         lSFJBgAQ3/Hqk4qst4QToBHBtlFOKzmX7Vglr+0klqmVNNzNCTjtp0SZ5RCzvvwp3QFk
         Kckg==
X-Gm-Message-State: APjAAAUzbeBZZ+HDFDaHBunRwSbsugaSm/gcJrxT7xEmEmAdEJczI14t
        TlJL6f9RknSILnDgueRwjc55Xq3cYq8/YYxHH+HvFGyy
X-Google-Smtp-Source: APXvYqxzHbilP5wxpsFC1HtqinY7YCWPjB7zwLvM5YoT8knl3eEZ5MQaSHdaTOwzqMmL7vEy8NLgD+GkQ7qEsJIeKms=
X-Received: by 2002:a6b:6010:: with SMTP id r16mr13770859iog.124.1566837410779;
 Mon, 26 Aug 2019 09:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190818201727.31505-1-dev+git@drbeat.li> <xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.com>
 <CAPUEspg9F7RutCUCoRAAXmRePjiunq3-zG7cN3uz_t5DVMxP=g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1908261626450.46@tvgsbejvaqbjf.bet> <CAPUEspivEfc82ZM=VaUA_sYhQbz+GtoOODVZK2i9LcCkmHq=Sg@mail.gmail.com>
 <xmqqftlnkj98.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftlnkj98.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 26 Aug 2019 09:36:38 -0700
Message-ID: <CAPUEspj4BJLjXorUXMiZnFtNcmhym_2QL5GUqeaGaCoxk=zjtw@mail.gmail.com>
Subject: Re: [PATCH] grep: under --debug, show whether PCRE JIT is enabled
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 9:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > ... but
> > ab/pcre-jit-fixes and UTF-8 validation are likely to make that more
> > difficult (even if it is a mostly self inflicted wound AFAIK)
>
> Hmm, in what way?  Do you mean that we'd be invested even more in
> pcre1 in an effort to keep supporting, that the sunk cost would
> dissuade us from deprecating the support even more, or something?

on the contrary, PCRE1 works fine but our recent changes make it worst
unnecessarily (IMHO)

 for example 685668faaa (grep: stop using a custom JIT stack with PCRE
v1, 2019-07-26) adds 2 regressions as discussed in [1]

* git grep -P will now throw an error if there are non UTF-8 documents
in the haystack (even if JIT is available)
* git grep -P '^([/](?!/)|[^/])*~/.*' will now fail with a cryptic
PCRE error instead of succeeding (but at least will be consistent and
show the same error with PCRE2)

Carlo

[1] https://public-inbox.org/git/CAPUEspgStVxL=0SoAg82vxRMRGLSEKdHrT-xq6nCW1sNq7nLsw@mail.gmail.com/
