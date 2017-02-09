Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ADEF1FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbdBIJnr (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 04:43:47 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33133 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbdBIJnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 04:43:32 -0500
Received: by mail-lf0-f66.google.com with SMTP id x1so11546466lff.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 01:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VLnvwhBSlZECaRt0KZLoWN2emnQnZfUucn0RITzc2do=;
        b=PlArXauFA0uGg2zilbNhK70tItgh9tiSrM9q7ddGuv/UO6MpUPVNRX2vSdZkkwnXxt
         ghLCMHSCgog11YFzlXfb1ax8EjD93Kh3o1/qi+fzkFcTR2OFHzOqsznLkVP7rgb7OBTS
         wTywi0O/R6FVgI2QfcwIoRyGiljctQe+OufNOU9m+VkZT7tcKQALKN9ONe2PdSllIWvt
         JEuqQ49Gspksm9A4HYeRza9UX8IW7DPH8zpUI1MMfr1sWkusgqm7MZG6KocqX2Lvaec6
         //cTCQOooro5Z73nK54FYsP8gmYaT+Ud+r41oPSkgLxFiqQ8kPhd6YWo44A7gjHjxyhM
         iRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VLnvwhBSlZECaRt0KZLoWN2emnQnZfUucn0RITzc2do=;
        b=SoLNfyJxJ3kN8HBIirdY/rPRLrnfwghy1A7iTQCLmFrmReLE9+L5gch5ZzVdsNF/CW
         M0bpHtBhIwV17zWikoJ9MDGdX0egqfbWRRdqha/j/xZZQq75rvrjQqXuyh9xUGCceS/5
         S10LYnK3u6z3/5kOKxE7wRx3NQ7pJSPNRIw2fdDOVquGaZbxNVYsBG3YWXjdYAOWk2S7
         DIUShH6iKVTdknb8jLSlmEctjbwRK7oLH7DSIOs2lWsj0YAjwuizF7eVE7U08lgPR4Lp
         5YS76mSIOV3ZFzjNLa89wMfQ3SHDEl26E9X23r+hwDwSx6Icap8wD06VqjxHNDnRcPE5
         sv7g==
X-Gm-Message-State: AMke39m4EQzW6Zok8VIz/XSxyzgzI2Tpvc27TJh71vST4jALlVqaQ9gNIeWftypGXSeKycV1pDnBF8x/r9X0Ig==
X-Received: by 10.25.210.79 with SMTP id j76mr650457lfg.129.1486633335194;
 Thu, 09 Feb 2017 01:42:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Thu, 9 Feb 2017 01:42:14 -0800 (PST)
In-Reply-To: <vpq37fowx5q.fsf@anie.imag.fr>
References: <vpq1svtstud.fsf@anie.imag.fr> <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
 <vpq37fowx5q.fsf@anie.imag.fr>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Feb 2017 10:42:14 +0100
Message-ID: <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 3:54 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Jan 23, 2017 at 04:02:02PM +0100, Matthieu Moy wrote:
>>
>>> * We need to write the application, i.e. essentially polish and update
>>>   the text here: https://git.github.io/SoC-2016-Org-Application/ and
>>>   update the list of project ideas and microprojects :
>>>   https://git.github.io/SoC-2017-Ideas/
>>>   https://git.github.io/SoC-2016-Microprojects/
>>
>> That can be done incrementally by people who care (especially mentors)
>> over the next week or so, and doesn't require any real admin
>> coordination. If it happens and the result looks good, then the
>> application process is pretty straightforward.
>>
>> If it doesn't, then we probably ought not to participate in GSoC.
>
> OK, it seems the last message did not raise a lot of enthousiasm (unless
> I missed some off-list discussion at Git-Merge?).

I think having 2 possible mentors or co-mentors still shows some
enthousiasm even if I agree it's unfortunate there is not more
enthousiasm.

> The application deadline is tomorrow. I think it's time to admit that we
> won't participate this year, unless someone steps in really soon.

Someone steps in to do what exactly?

I just had a look and the microproject and idea pages for this year are ok.
They are not great sure, but not much worse than the previous years.
What should probably be done is to remove project ideas where is no
"possible mentor" listed.
But I am reluctant to do that as I don't know what Dscho would be ok to mentor.

Also please note that you sent this email just the day before the deadline.
I know that you sent a previous email three weeks ago, but people
easily forget this kind of deadline when they are not often reminded.
(And there is a school vacation is France right now so I am having a
vacation in Alps with unfortunately quite bad Internet access.)

> If we don't participate, I'll add a disclaimer at the top of the
> SoC-related pages on git.github.io to make sure students don't waste
> time preparing an application.

Please submit our application like this.

Thanks,
Christian.
