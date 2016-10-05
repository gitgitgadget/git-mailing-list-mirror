Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7631F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 19:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbcJEToa (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:44:30 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33741 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754876AbcJETo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:44:29 -0400
Received: by mail-pa0-f52.google.com with SMTP id cd13so85360112pac.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6gApmwo92MA5g/J5tALjS8X8VmrzxaadK5FoQ2dAl/0=;
        b=PR9rEluSuzAjLwMUl8XHlXEZY4re4Xc84KCeJdwZ/bsb6cN2JKN+d50qaXaQS3CpOc
         4HhDoULbTz3Ju/JO46704illDc09XAGdTw2IwzmcvXn61q3lpbgjMHn0qQZkX76X4m20
         aeEqpV9qyvFeVcp5I7RWs/W76nhII8dNms75EBi4RLDFdp4d54crL6cM8lnAxbFgBBQe
         pw4ynf58G/P/AI8u1Z5ezj/R4MY/45ocyLuJfgaYeIAM2eFLJUoEFY/Mw4ISfLzmpmMy
         n7h/TgBORFy58ZlVYIpAYDGJF03BICvpqeGdyccLepjGSTyAvdLQrKJoazwOj07bwu9c
         FxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=6gApmwo92MA5g/J5tALjS8X8VmrzxaadK5FoQ2dAl/0=;
        b=SFQhurIDVpSfwXAvNZO0e3L0JxLvMZk9YwQD88jklPveuruIaA6AUYtfu01nwB71zf
         pd0F+RtlVq0C86KtvjAzdO4WhTQ1SQYXOgjpmUtWoB/uvk8WozbQbzUPsT/tfUCLcBUl
         6b7g5hRJSnOvcqLa3XpNzwlQCCAGm84hFBmKpwxrW2SDGfmdH72dApIYq7VUKb0JaWz5
         ByEVLbb8eTq2c0mtDEuBjI1/S6U1W0oIw4PX2Utomkw/NM3zwSe3A/J11Tsd74zdkxc6
         cQxMD70QO7Xvt+qaE52mGTW9ZCUs895x/VCkNPryt9VSWPJVxN5vXicHkwk4bdx4xNUz
         Vl9Q==
X-Gm-Message-State: AA6/9Rma2/XmA6gxQ9558oEfhfdR6d733pv97wIeig+Nn/LD3L1IR8dvZUrn5lZF40zfZi9y
X-Received: by 10.66.132.79 with SMTP id os15mr15788487pab.84.1475696668922;
        Wed, 05 Oct 2016 12:44:28 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:6000:6149:f0e1:de76])
        by smtp.gmail.com with ESMTPSA id x1sm16263762pay.41.2016.10.05.12.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 12:44:27 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
 <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
 <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
 <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
 <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
 <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
 <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
 <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
 <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
 <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>
 <xmqqwphouivf.fsf@gitster.mtv.corp.google.com>
 <xmqq37kcufya.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <b0e43079-498a-469b-c4b6-f4fc2b8e2aa4@google.com>
Date:   Wed, 5 Oct 2016 12:44:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq37kcufya.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04/2016 11:28 AM, Junio C Hamano wrote:
> An addendum.  We may also want to be prepared to accept an input
> that has some garbage lines _after_ the trailer block, if we can
> clearly identify them as such.  For example, we could change the
> definition of "the last paragraph" as "the block of lines that
> do not have any empty (or blank) line, that appear either at the end
> of the input, or immediately before three-dash lines", to allow
>
>     commit title
>
>     explanation of the change
>
>     Signed-off-by: Some Body <some@body.xz>
>     [some other things]
>     Acked-by: Some Other Person <some@other.xz>
>
>     ---
>      additional comment
>
> which (unfortunately) is a rather common pattern for people who plan
> to send the commit over e-mail.
>
> If we add a new field "const char *beginning_of_tail_garbage" next
> to "end_of_message_proper" that points at the blank line before the
> three-dash line in the above example, the parser should be able to
> break such an input into a parsed form, allow the trailer[] array to
> be manipulated and reproduce a commit log message.

How important is this feature? It doesn't seem too difficult to add, 
although it does break compatibility (in particular, "--signoff" must 
now be documented as "after the last trailer" instead of "at the end of 
the commit message").
