Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F811F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfBGU41 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:56:27 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40350 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfBGU41 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:56:27 -0500
Received: by mail-wr1-f44.google.com with SMTP id q1so1345920wrp.7
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6Pumg8Deg+lTqiQ4YO2zvDBMNL3Tzce8yhIzL+EWXro=;
        b=nBAK/b8Ws7+WdHP460Lae5sd7Le8LOLK6FM08NiKwQrMbcOOeQR5p+XLiOmmqRmFRB
         x3ilnYfalLqDRRBpcUuQBzy0oxOM3tPg5pZn28qCn0FVPiRGNRRhFq/Dhmo49wgp42Mo
         qWRxNtSbLhUYp4faMGNiUGI9ieCO7o5Xk7ofFQtrnyVf2ifI8l0efRbenPdZpftah4el
         UOBRHAi1FQwoP+s2CFY46R7LegrhC+Xe3UFz/UBh8EhAZKnBWmRYpQFRAoESWSRlLWTS
         WDD1282b3blugXpdM346CrCeqWYdXxtZJnKpgYidoDeDt0pwJZagTGjRwLmRTAua7APY
         otkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6Pumg8Deg+lTqiQ4YO2zvDBMNL3Tzce8yhIzL+EWXro=;
        b=M3xZ1l1qDlK7nHzAq8QBN239WCGP7wXAlgnGV/P9fEiOo5wM2A+EcV/cbye6nIz1UV
         f88OtxOV/BSh31UbaTq+E8njdvu4vmS1c6uG/IXXFUasxoKX3reqEQpyn3Ncv6uGGcOX
         4mYOyI3qebFEQJHGl9BUYb+rwofIJJv//2rf5vwoegch8JcS4PSR9yuyiI8QUiZsPByg
         cRQvs/Oni7EZJTnWUcgMETOqRNU24nElWuZKJhkM+yAJw1kdXUZnVBW/+3o+ZQU25h0i
         T0x3cyIwgc+4aJnj4iguoyte3jW5ORkdKbFjWw2bXaTGOgJY3WwADbXl8QZoVrJsKu5p
         NB7w==
X-Gm-Message-State: AHQUAubJNKhimYUtpld/D/kvQadqeHIjoFc/J/o++Ct0rVrvKvZjE0ua
        cUp8A/pH/gFs08PmykTZd4U=
X-Google-Smtp-Source: AHgI3Ibu96FasZUdu+sLsYJlLlmxSZTrk5QpMjYHT5Xm7MgSd+o2GZHSwM6ZNtsI8R3kGyfLU1UFzA==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr13739606wrq.260.1549572985145;
        Thu, 07 Feb 2019 12:56:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b13sm32860wrn.28.2019.02.07.12.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 12:56:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, TANUSHREE TUMANE <tanushreetumane@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc0
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902072049080.41@tvgsbejvaqbjf.bet>
        <xmqqef8jnxrf.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 07 Feb 2019 12:56:23 -0800
In-Reply-To: <xmqqef8jnxrf.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 07 Feb 2019 12:34:28 -0800")
Message-ID: <xmqqa7j7nwqw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Hi Junio,
>>
>> On Wed, 6 Feb 2019, Junio C Hamano wrote:
>>
>>> New contributors whose contributions weren't in v2.20.0 are as follows.
>>> Welcome to the Git development community!
>>> 
>>>   Arti Zirk, Brandon Richardson, Chayoung You, Denis Ovsienko, Erin
>>>   Dahlgren, Force Charlie, Frank Dana, Issac Trotts, Laura Abbott,
>>>   Patrick Hogg, Peter Osterlund, Shahzad Lone, and Slavica Djukic.
>>
>> Could you include Tanushree Tumane in that list? Granted, so far they
>> mostly cleaned up Pranit Bauva's patches, keeping the authorship, but
>> still...
>
> There is no provision for manual override in the machinery, so, no.

What I meant was "no, not easily and without risking fat-finger
mistakes".

But we can give a shout-out to particular contributor(s) outside
release announcement any time, with more personalized message
instead of just an entry in a dry and bland list.

Thanks, Tanushree for your work on "git bisect--helper".
