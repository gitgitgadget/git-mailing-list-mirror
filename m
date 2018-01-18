Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7A51FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbeARV2c (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:28:32 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:43689 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754789AbeARV20 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:28:26 -0500
Received: by mail-wm0-f47.google.com with SMTP id g1so24594287wmg.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WeaNTCJwgQXXV1noggE549GRnY9oSfPdqiMNuM1CS3M=;
        b=rcR4Lp/yKZcr6NWAbNdS+SVxg4tkvlKjyEy+AvFfLkvZbJtpahdaJ4glo8JSzKclrt
         u58pqClsY/bqr0Q434bEVLY5BLuW95UQqqfovpES47JGRHZyavwmFYqWfGnKBkaGgsbL
         x/29YBzqgRZ+mudkhPwQHQAce2Cq3wlhNKH+hHIqR1TP30GJTt1pyhfJdsMNPqr8aJ3i
         r4ojJFIj0XZpsOkCY1mheSLcdmKrCEGWt07i/+I7VZiVJHpfSy6umsXeApsRXnd4mTFn
         m1YD4sguHZvUdmElNQl8jxwOJ8dDgD2QCPDkKfVe9ODEe+w8ZaGmgZb0LpUkrpeE0LlU
         rHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WeaNTCJwgQXXV1noggE549GRnY9oSfPdqiMNuM1CS3M=;
        b=Fw8OohR3FPJwUIKdcDDHkbVlulmY0VmT+MB0M2bFA26j/72OC1cXvSeZD8O9QiGxdP
         54LM/YW+uGVKrcgslDQNkwy5cT+SNh89TMhLTh+UbS8ke0U9nzI4hTt6jmdetk4Ti10E
         E9w3diRGIO0aJz0pAk+NNTEU3OCdMCXG+ROqnh8zr8x6yfj7aFcjCNLjBaRU+6RuwAUh
         WL/hu09RMhxTdYevdsi36eOVi3gVGStvKcISdD4+hvEUBdWjLuaWTCPIRLCrDfCxMPeH
         cgGae62peNIGisr5NRmguRI6xvbgpFVYA6pP47YorCJI0XZ3O1kMQYo1YLnSn4QGVVSc
         qKEg==
X-Gm-Message-State: AKwxytfV1Q08PCkFGfaw5H/SLEvTWSf1IyU9Tqz7IXZakCQ8cy0pFvYq
        bxx9vGmPYWe8AuRiAlv76lV7a1g8rAC/NTrDtWM=
X-Google-Smtp-Source: ACJfBou3QydkFUyqkCpZjEq+Kv605tWzDS/90Zqv9M4obRBJmqR4haCpVkzJXzUX4giR2lvoqf7/81bx3IExvJMmeDg=
X-Received: by 10.80.184.77 with SMTP id k13mr10042133ede.187.1516310903148;
 Thu, 18 Jan 2018 13:28:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 13:28:02 -0800 (PST)
In-Reply-To: <F2A95961E128479484699EC5DDC9243D@PhilipOakley>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
 <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com> <F2A95961E128479484699EC5DDC9243D@PhilipOakley>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 13:28:02 -0800
Message-ID: <CA+P7+xqHZ58MEaj7KrCpk_-MprqipGwjXMvhPaeUP0MsBLPgsQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the revision
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 1:24 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Jacob Keller" <jacob.keller@gmail.com>
>
>> On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>>>
>>> This commit implements the commands to label, and to reset to, given
>>> revisions. The syntax is:
>>>
>>>         label <name>
>>>         reset <name>
>>>
>>> As a convenience shortcut, also to improve readability of the generated
>>> todo list, a third command is introduced: bud. It simply resets to the
>>> "onto" revision, i.e. the commit onto which we currently rebase.
>>>
>>
>> The code looks good, but I'm a little wary of adding bud which
>> hard-codes a specific label. I suppose it does grant a bit of
>> readability to the resulting script... ? It doesn't seem that
>> important compared to use using "reset onto"? At least when
>> documenting this it should be made clear that the "onto" label is
>> special.
>>
>> Thanks,
>> Jake.
>
>
> I'd agree.
>
> The special 'onto' label should be fully documented, and the commit message
> should indicate which patch actually defines it (and all its corner cases
> and fall backs if --onto isn't explicitly given..)

I don't think it actually relates to "--onto" but rather to simply
using "label onto" in your sequencer script allows bud to work, and
simply shortens the overall work necessary. It's equivalent to "reset
onto" if I understand.

>
> Likewise the choice of 'bud' should be explained with some nice phraseology
> indicating that we are growing the new flowering from the bud, otherwise the
> word is a bit too short and sudden for easy explanation.
>
> Philip
