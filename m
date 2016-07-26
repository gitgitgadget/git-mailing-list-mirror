Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F81A203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 00:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017AbcGZAqA (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 20:46:00 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32810 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426AbcGZAp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 20:45:57 -0400
Received: by mail-io0-f176.google.com with SMTP id 38so185411529iol.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 17:45:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Eu6PvjYQ9Ly24FYbjaAzFTPZf3AhRQMUhoDYQw/Ols=;
        b=SZH8wpV2Nck/pHkcm8eBLCMrWLTM7ImPwW0U1M2zzbi+hRLPkilZ4LDN20Zag0fKgN
         J7hKcFnPHuXVa/eO7U0xoIb7pulnQA95CAKNU6wE6IPlrbYwMTteaY+8gtsVvDfgu6Og
         4qFFP+y+AoW1oMZPfvg5k2NGnutsUA0HxFTuufpCbdOahhU88wMQvVD6VWq1EP9L4gp6
         atULo+YDhLAdTG+uMp9+tS3qt8nw699R5c8I+kybIXdaMbwd3Se+QHpZQHmV9y/uyi+L
         KJfVAH4vn6uXS9TrmDkslCcP14steYCJyg2TywilQ1jMsxbRXksdc3AIesF2v0nCsSjb
         O56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Eu6PvjYQ9Ly24FYbjaAzFTPZf3AhRQMUhoDYQw/Ols=;
        b=Il0K+DJaVk738HCgCjDYPd1mms6pK960xXToFaAUBOP1muPGXk91AClaC4eQSGE3jn
         Z1XxQ8xyv765RNQDebZW2gWOWOANtEsxBJKTw+v8+uFRMbk8JmF3ZiSPxxPmxHqJLQJq
         QBaLCC+fvLOPa+Sv3eVs+OYjo+n6XDDhxlevyPOizd4zGGrmGlgiKIDShRvNYN6JVeeH
         hNkI9QxomOSpvrwUd/5qCQ45Qje2Gnvz4kM3Ezc4h+4vDbrVM51vsAWPvjGJJLtqyjjN
         cDWBb60yeIQambb72r3HN54LgYxcU1h9ffUVgVxGLMPHuR5PqhoQY5zzCM3DPUXDHZwR
         puUw==
X-Gm-Message-State: AEkoouvFhi5VPTTAMa0rZjOw8LRfBRVXhCgcTDy4EbeSCbwRkBc+XMUZXmiCGJy46Yids+g7AalYy3r6lWU1+7C1
X-Received: by 10.107.131.38 with SMTP id f38mr24064860iod.173.1469493956393;
 Mon, 25 Jul 2016 17:45:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 25 Jul 2016 17:45:55 -0700 (PDT)
In-Reply-To: <CAPc5daXP0E13zuQkBsxgwfVhLnJjG6U9zocpAHn0wUSfo6KN8Q@mail.gmail.com>
References: <20160719234508.7717-1-sbeller@google.com> <CAGZ79kaJf9jU-fnicnB+jDTOvqOPTJWBy+9oo=fGm82Z8+eQgg@mail.gmail.com>
 <CAPc5daXP0E13zuQkBsxgwfVhLnJjG6U9zocpAHn0wUSfo6KN8Q@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 25 Jul 2016 17:45:55 -0700
Message-ID: <CAGZ79kaKZmSDjxHYu4Eb7U2rS9_rZFv4eqDc3Y0v6N4NURQ4=A@mail.gmail.com>
Subject: Re: [PATCH] Documentation, git submodule: Note about --reference
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Jul 25, 2016 at 5:38 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Jul 19, 2016 at 4:45 PM, Stefan Beller <sbeller@google.com> wrote:
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>
>> Any comment here?
>
> I personally found it Meh in the sense that those who read
> and followed the previous note would find it adding no new
> information, and to those who don't bother the additional
> note would not help very much because they would not
> understand (and more importantly, would not care) where
> that "this affects ALL submodules" comes from, or why
> that leads to "so it is only useful...".
>
> But it may be just me.

Ok, I guess we can just drop it then.

Thanks,
Stefan
