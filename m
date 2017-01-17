Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B56820756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdAQVrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:47:53 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:36717 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdAQVrw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:47:52 -0500
Received: by mail-it0-f49.google.com with SMTP id c7so105116944itd.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6fTIEif+uMHfEMwE9R7yi0axXZdO+NiQbvtlmhX7ucE=;
        b=bXgqrc+N6bbm2q1ZQs1ojYSieW2pkX0DR/3EVP+s7PAwSqgxFxj8/D0kJplTDXXPMY
         1+hgnRu37BqeUeIVvwXWc3qpd2AT2ghub9gTIrC5A6v+HWWkuXL/7+h/gslrLDOe4nDS
         y4MX8EGL9HvtQ85nYTE98dQJCQEggsAaEc4txJtIFWAarK/dwIxOm/YWNbOaDbvKxqKM
         icp4JN4+oXIpO/hJxwSsRIj3n7bSH4OanQneQfU0UjfNlLXh9hL5f/KOb+RUXFNhBb4j
         ZMjY0z1tIYXFUkVDN0FyXmKx705x7wmQGJvUjkMpR0xhF0RLSrZ696mgpkVb3ORnDGmu
         wfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6fTIEif+uMHfEMwE9R7yi0axXZdO+NiQbvtlmhX7ucE=;
        b=gvTibbZ8cacnuMNCz639agV+G80/Zokc37hV2yJ/05KinFms1bIIxCiTdoPHpxTAtO
         6RqocXk9hL3yJHFTwN3he9zKxqmciMnUrwZrF3oXwHQM8qp4xEDQfCBsEVJmhZCvxPVQ
         wq6hYOkbpKdvYF2s3+lJGSmTwTqYlCxtY1cXF1cmhM3T+IDvdIxrHlWgdeG8TVTfVpdy
         hspp7tgiGgmNc+wRWP1k6YFizLSIc2zN2gLlj/tT6Va0hjhI04p9EXtfAOgowWuZUBFr
         eKRU6P94wwZuTTyV2FfP+5yMVdZAoQLGxAMz8SkMhCAVsVkIe5Ev3UJSCec0S3S2ts7w
         0Exw==
X-Gm-Message-State: AIkVDXLOOZEgB6yTSBnw46dNSf+QF5CHsk4esOZSH7zTmQDC6nglFfkaeFq2oFEda/MDThMbuPl1Rg4Xq8hyzHPo
X-Received: by 10.36.193.135 with SMTP id e129mr22537703itg.69.1484689666323;
 Tue, 17 Jan 2017 13:47:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 17 Jan 2017 13:47:45 -0800 (PST)
In-Reply-To: <xmqqo9z5cqh8.fsf@gitster.mtv.corp.google.com>
References: <xmqqpojle85c.fsf@gitster.mtv.corp.google.com> <20170117204642.31514-1-sbeller@google.com>
 <xmqqo9z5cqh8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jan 2017 13:47:45 -0800
Message-ID: <CAGZ79kbZamLJqPW-sajL4LUxbJHo_v9j0S=_nLwA30JCYmqQLQ@mail.gmail.com>
Subject: Re: [PATCH] document index_name_pos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 1:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>> These placeholders are meant to encourage those people who dove into
>>> the code to update it, so from that point of view, I think removing
>>> it is backwards.
>>
>> Yes, I am currently understanding and writing up documentation for
>> index_name_pos. If I recall the latest discussion where we want to have
>> documentation, I think a quorum favored documentation in the header itself,
>> c.f. strbuf.h, string-list.h for the most desired state. (Although we do have
>> Documentation/technical/api-string-list.txt as well ...)
>>
>> So maybe starting like this?
>
> That is very good.  Let's drop that file from Documentation/technical
> and do it like this (meaning, take both patches from you).
>
> Thanks.

This patch is incorrect, as we need to do s/b -> -1/b -> -2/.
(Wrong documentation is the worst)

Also we'd probably want to see more of the functions documented.
I'll see if I can extend this into a series documenting more functions.

Thanks,
Stefan
