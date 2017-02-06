Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6BFD1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 22:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbdBFW4c (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 17:56:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36153 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbdBFW4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 17:56:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so24961710wmd.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/8PB9F6iJ1e4I3/aJTbY9ILLpZhBRCkSzvVSv40PKS4=;
        b=JOd1NrmNgLGX0TfoZzchE4f8Eajc79g3sUDvXYyLHTJ3g4tdhobPY+NelgFJjgfqAs
         Vnxd11o7dbIpUGYs0drfLhkvXQq67/4D4IM8M1r6Q9m5yiiuZvh8G8MFj4fqgIfizlPa
         z6T8I9VizF8bu74dF6JgFTLCcYCZly6T73mVTNKDgZkrD++w9oyCJ3Ji0M948A3YClyp
         KRcj8CwfSdMgrk2WQQYgjcZO8aFrYJFv9pHWumub9d+GvSytlhdUfdxtoszYwfidCGzw
         ore2mBK4ldoUbUgi9wzCHQveQD9rDys+JT3iSlm2kRUdFzkuNuUsyUU9MasQ6eF9QhL2
         T2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/8PB9F6iJ1e4I3/aJTbY9ILLpZhBRCkSzvVSv40PKS4=;
        b=Wf7Kfd2hjouEOTLsm3lwTqfsgM41alXzI5gfX5f4M8pShk/ty9eDU57lfAYv/uNfCu
         DqtUzecSVPQhBnc0iXLKwXBZg64dQFaf3PrYWaJZLotAhtZj23VU4Q55lAO5IVCMCjAj
         T/52gsW1OgiYODkQ3Y6quILQqKO5sOSWCDHqIDtVkLeP7K34Uqw8k+nFi9IHpa8QtTvF
         oaD75yqAvrYyDdLTjtli0lWXHkx05QwpqI6WZC1TxYjuQOVROBoimDEc3zAHbD5KimYd
         agtepPlWtIHyQojx9qJodRIExGqiqf/PqBTb+nY2BJLaiOYhCiAYGOt2ojl3DHgkDB5Z
         VMow==
X-Gm-Message-State: AMke39ngTvOnQ1tmAyoo2cqfSFSMxXirCfxMQ85+8up+Tl01T/E3KLmzrUvVGnbkeWZKJoxRRvjb7/Sy/kCFIw==
X-Received: by 10.28.150.202 with SMTP id y193mr10946374wmd.106.1486421789464;
 Mon, 06 Feb 2017 14:56:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.167.100 with HTTP; Mon, 6 Feb 2017 14:56:09 -0800 (PST)
In-Reply-To: <xmqq4m0gtakk.fsf@gitster.mtv.corp.google.com>
References: <20161204144127.28452-1-peterjclaw@gmail.com> <CAKoneT+Bn+MdbeNnPJsu23rbLCZ=jxADNVtpNefw9zNYMq26dA@mail.gmail.com>
 <xmqq4m0gtakk.fsf@gitster.mtv.corp.google.com>
From:   Peter Law <peterjclaw@gmail.com>
Date:   Mon, 6 Feb 2017 22:56:09 +0000
Message-ID: <CAKoneTL3-1ohv22mm-RpZ-2sNbFeAV62wOS-JoE0r2Dcn_2E3A@mail.gmail.com>
Subject: Re: [PATCH] Completion: Add support for --submodule=diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano <gitster@pobox.com> wrote:
> Peter Law <peterjclaw@gmail.com> writes:
>
>>> Teach git-completion.bash about the 'diff' option to 'git diff
>>> --submodule=', which was added in Git 2.11.
>>
>> I posted this patch back in December, but I've not heard anything. I'm
>> sure as maintainers you're all quite busy, but I was wondering how
>> long it usually takes to get a response to patches? (also whether I'd
>> gotten some part of the submission process wrong?)
>
> When there is clear "subsystem maintainer(s)" in the area, I try to
> refrain from commenting until they speak up, and completion scripts
> are one of these areas.  I usually ping them after a few days but in
> December with holidays and things people are usually slow, and so
> was I X-<.
>
> Will pick it up.  Thanks for a reminder; you absolutely did the
> right thing (i.e. sending it out with people who are likely to know
> about the area CC'ed, waiting for a while and then sending a
> reminder).

Awesome, many thanks!

Peter
