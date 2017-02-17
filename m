Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B04201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935114AbdBQWe6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:34:58 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35740 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935084AbdBQWe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:34:57 -0500
Received: by mail-wm0-f53.google.com with SMTP id v186so28135737wmd.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R7ocegmC66DAU4St4pXazo8vatuBpnSD8HlL5q10orU=;
        b=cE4fp/kbImc2OnLtwqp3qzYCkt49aNpEUTtHjBcOOu/zpdEF3j+TOXI5T6AmnMNPOe
         MtE8ZfRd6u6U7q8F6BPsGqTUpuIqfKKZmQCqdFN/l1y2a0tIhM6hAQlgX/16Q4Ss/rSH
         9C5JKv9kjmN0Fr1dtV0Bj8PuW/bA3GM70ionNg5k+UpdrsNW9tz9ENjf0spuAR5cWbvZ
         UbDkf9NTAVUw9xxn+hKlLAyCk52mroyvGG+eGRZ9HPkuKE+bffFmAJ4sYxosVTv8aX1R
         gN0Fovqec/yHVMjG6/gfMMd16NlIwUIRuE0Q6OtXT0rNQv+7GcFgX1C2JiGi535nDCkl
         Wppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R7ocegmC66DAU4St4pXazo8vatuBpnSD8HlL5q10orU=;
        b=eq1pPTeyjk8PX0wXVD6UWBis+FCkMZlsh2MX0Uu2uyzDV2i5bNYOKeDYG0GI0AhRIM
         hjOrNC23Osbr2l8czDp5VwRHqX6SqBP0N2z8vrSBhaO5YpoZi/r3U2NknKNGo51WZz4E
         Xm04BP2h6E89zAFlk49S1tgNRopwGo0PqO98XwyAHZFWq/o09QyItA/IKZ8GaslRyDi1
         n7wYPl5zHV4wgS1imGdF01vkfTDHCP5dMlUtE+5ig21zEJwyZs2386c4OVAZrExStG/U
         un9f7DX+5KhJ/12OV1Bk+/D7NzNsDi5syW0ekwlCqdtp63qsvV5Vvy3SFtzT/pdXSbgN
         Jq7A==
X-Gm-Message-State: AMke39n13diR6CsjhhDStw+CyCCpBp0YdIQZpmHSYa3pyaC1PldKJsHVHY3/uWwCGjBbHRTwl2UJIAVpttyO7w==
X-Received: by 10.28.129.147 with SMTP id c141mr6376129wmd.12.1487370895973;
 Fri, 17 Feb 2017 14:34:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.62.208 with HTTP; Fri, 17 Feb 2017 14:34:15 -0800 (PST)
In-Reply-To: <xmqq4lzsqwjy.fsf@gitster.mtv.corp.google.com>
References: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
 <CACBZZX4Zmwb8ZHGBXCpm6=yH_uxc-K1X1vv1jQ+wwnUPneqM4A@mail.gmail.com>
 <20170217204227.kreormjoo5lr6zu4@sigill.intra.peff.net> <CACBZZX7nJkRmSxTdvhgXz5Zuk0KeovSZM1D_eGqbBn7i20+ePQ@mail.gmail.com>
 <20170217221317.e5kby2jwutdznnlk@sigill.intra.peff.net> <xmqq4lzsqwjy.fsf@gitster.mtv.corp.google.com>
From:   hIpPy <hippy2981@gmail.com>
Date:   Fri, 17 Feb 2017 14:34:15 -0800
Message-ID: <CAM_JFCzoouREM5-6aq9wb0ouT34GKCoJ_pcsww5TYKAdztR9sA@mail.gmail.com>
Subject: Re: git alias for options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think the conversation has drifted away from what I am asking / hoping for.

I apologize but I do not feel in the position of submitting patches
yet. I'll first need to read some code first before that.

I'm coming from the angle where currently I can alias just the command
(ex: l for log) not considering the 'command with options'.

[alias]
  l = log

Currently, the order is as follows:

If built-in git command then it wins.
If custom git command (script as git-l) then it wins.
If alias for git command then it wins.
Else throw as unknown command.

In short, built-in git command > custom git command > git alias.

So I think, the same could also be used for options.

Say I want an alias for option --name-status as -s, so I can type:
$ git log -s

But there is already a -s option and that wins so the built-in option
alias wins.

However, I think I should be able alias it as --ns.
$ git log --ns


Thanks,
hippy
