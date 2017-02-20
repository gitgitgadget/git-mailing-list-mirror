Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4FB201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbdBTUG1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:06:27 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34311 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdBTUGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:06:24 -0500
Received: by mail-pg0-f67.google.com with SMTP id s67so3701229pgb.1
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 12:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LDLqstsAUDtrpWoGioGMW5SYxjD2DSmodv6feNrSjo0=;
        b=QMPsn+/1qG7STWPLDNhDD+ZhTFHVEcnQ0dEcbCKwyiwSnoXtnU5c/OEfjeXQT+3/lu
         sCRLQoubcvnypH5dspkjbKp0h0+FjSaWlmxOWSVkpdq47vGZDJWIDfZiIuHonHeaolWa
         BDJm103JUW/exP5M29cJGQcJeleDX8V121eEGTiAO5bkfNOOHQURQ55cCm8Z5MNvXmR6
         yqAh1sxlmImMePSlz98KQHuAMFmgT7DGHKqYzvuOmNLqGkyTs1DVy+sQ0A0q5X7d9eiV
         yWviwRYSc7+DW69feVnzTdOGg1+qcxnJ11IHcP8t4PdvuiZlblYuNYRRR4JwPQVANTI0
         7jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LDLqstsAUDtrpWoGioGMW5SYxjD2DSmodv6feNrSjo0=;
        b=P5lqyrjRS6LtLtmo2WMLjbhHH/qWr/mNgza/RLCwdT9rzOIEbhmBAON2WevKSYiW5O
         mmqVwcuh+4qMuqaqrOs3LARKzIHWp760fExyJ/qeTGFlxD4RQEfZw7NVQpcnl3kJjSwu
         9UNWgu6w8ZejrEMEVeChCJhTv1ZRojilKgvsOl6GYdyMrtqEFmk8XDCfMkJH1GjMaJ+J
         mgOp2hdQOtWvGd2M1wH1+Azb0QZkdfI6noM4FUQZRiTjhG3H2BeDtmFPz9yha6NCGVha
         xGLAB07PxzIWgTo+8qvHf/1yJeTjy108kq2/zx3kv+8m4RpuKSFGzgq+IV6FTbY+bs7N
         vYKg==
X-Gm-Message-State: AMke39nrrWgY3fpb/3HTEKD1L8HvyKYIw8gN8J9zmN4luHTEVqyIZtX1m+CfN75ksa0H9A==
X-Received: by 10.84.195.164 with SMTP id j33mr34223599pld.171.1487621183778;
        Mon, 20 Feb 2017 12:06:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id d63sm36624327pfg.65.2017.02.20.12.06.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 12:06:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their corresponding commits in `pu`
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
        <alpine.DEB.2.20.1702171841450.3496@virtualbox>
        <xmqqefysk67v.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 20 Feb 2017 12:06:20 -0800
In-Reply-To: <xmqqefysk67v.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 20 Feb 2017 11:33:24 -0800")
Message-ID: <xmqq60k4k4oz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> There is a third category, and this one *does* come as a surprise to me.
>> It appears that at least *some* patches' Date: lines are either ignored or
>> overridden or changed on their way from the mailing list into Git's commit
>> history. There was only one commit in that commit range:
>>
>> 3c0cb0c (read_loose_refs(): read refs using resolve_ref_recursively(),
>> 	Michael Haggerty 2017-02-09)
>>
>> This one was committed with an author date "Thu, 09 Feb 2017 21:53:52
>> +0100" but it appears that there was no mail sent to the Git mailing list
>
> I think this is this one:
>
>     <ff0b0df6-9aed-9417-d9d4-1234d53f05c3@alum.mit.edu>
>
> Recent "What's cooking" lists the topic this one is part with this
> comment:
>
>  The tip one is newer than the one posted to the list but was sent
>  privately by the author via his GitHub repository.

We didn't have any pull from sub-maintainers during the period you
checked, but when we do, those could also fall into the category.
Even though I see some l10n patches Cc'ed to the list, I won't be
surprised if not everything that is sent to Jiang Xin (i18n/l10n
coordinator) is, for example.  It also is OK for sub-maintainers to
have their own commit to describe or otherwise improve their area
and without sending a patch before doing so if they deem it
appropriate [*1*].

I actually think automation like yours would help another category:
There is a newer version of the series or an entirely new series on
the list, but the project's tree has not picked them up (yet).

I from time to time sweep my inbox in an attempt to find and pick up
leftover bits.  Sometimes the authors remind me by pinging [*2*],
which greatly helps.  But another set of eyeballs that may be
enhanced with a mechanised filter that catches "messages without
corresponding commits", which is the opposite of this "third"
category, would be of great help, too [*3*].


[Footnote]

*1* ... like trivial fixes, for example, at their discretion.  After
    all we entrusted their own area and we should give them the
    flexibility they can exercise with good taste ;-).

*2* e.g. <2f67fc21-92f9-a03e-1b09-a237af6dbc46@alum.mit.edu>

*3* ... even if a mechanised filter alone might strike too many
    false positives.
