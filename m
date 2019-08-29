Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3924F1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 09:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfH2JfL (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 05:35:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40001 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2JfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 05:35:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id e27so2327460ljb.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=s3UZyfIBNTe648+QtZ+hvXNjlsGWH7TBhPO6EYwxx0M=;
        b=g8u+0lisgNTW5nauwOYpb7D7jZvn+inHJlCYyeifc4jZRFlcao+3gOjRMoGH0d6jLw
         MiU8k4AYzhWoqXeQSSPAMBSaWBCOXSLnI2G80ofo+TurdATjXvIGrsRWU6g2JLJPedpT
         HKY09xBz5kXbOZUw2IrdC9rjOcm3EolDffLW5yszLEQnQbJ79dMOkC1Ze6o+OU8Ydye3
         fUJh+0Vtfs1J21vR30v717DLboeWcE6VXdFslBo+JJpM2lLnEpjhZts8pR+71/bogkkA
         stc3VAIcDepwKvFZDvuLP9T5BUPH4Y+9pFIoYLu/ySlLSoFm5xzKM8WKWQT4X3WWxBeg
         wlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=s3UZyfIBNTe648+QtZ+hvXNjlsGWH7TBhPO6EYwxx0M=;
        b=tMIlVEGpAhKLUtt+z1a7BhC7EJqYLwIu61eHgz7bPgBW6X0EKdJlELmoOSDtA24W/v
         uW2z6SkZd9/WYry8TBDEQsuvMx4rndSTOFQxvicNzOz47hVWLCs+RaePqMP7XFTS8dFE
         epNOh8U6CHzXiW8PpqeCz3r/rNxmJ5yD9e0mipTchvckrWwRR2h+rQz8f3IV8zzHXWy5
         nnA5OV7WsWOqCQIl1XmivXzQPCYoCCOsCQuIH0wkTDGuT90gnVjSRMD9ql37aomwjXOP
         GgzWy44rnJ2uEA6mxnIbHf81/2kTcGw4SL756gpfqcmZGJ928PmWdZ31SO6+BMHqkFj6
         BcbQ==
X-Gm-Message-State: APjAAAW4JpVcJ+nOO+HGJhuk77O0BzXhg8lhk7CqoYh4obRFNp8VDS1V
        zWOldOIGm09gz38uvmw08D7HMgUQ
X-Google-Smtp-Source: APXvYqxK3MqEOr6aX8uymg0a+XluDutv35I3V3teYrOIxJG+Oo4oNhwyNXlGz1IdDp8n9CspUvZ6Qg==
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr4789938ljg.70.1567071309069;
        Thu, 29 Aug 2019 02:35:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm306243lfi.91.2019.08.29.02.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 02:35:08 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various ff-related options
References: <877e6x3bjj.fsf@osv.gnss.ru>
        <20190828155131.29821-1-newren@gmail.com>
        <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
        <87a7btqeyx.fsf@osv.gnss.ru>
        <CAN0heSpcFgNwBKHzUjcvb0W46LQwGoOSpihLg1arOPJJKC9PTQ@mail.gmail.com>
Date:   Thu, 29 Aug 2019 12:35:07 +0300
In-Reply-To: <CAN0heSpcFgNwBKHzUjcvb0W46LQwGoOSpihLg1arOPJJKC9PTQ@mail.gmail.com>
        ("Martin \=\?utf-8\?Q\?\=C3\=85gren\=22's\?\= message of "Wed, 28 Aug 2019 21:53:47
 +0200")
Message-ID: <87zhjsmi0k.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> Hiya,

This one was new to me :-)

>
> On Wed, 28 Aug 2019 at 21:15, Sergey Organov <sorganov@gmail.com> wrote:
>> > I was sort of expecting these to be listed in the order "--ff, --no-ff,
>> > --ff-only", and I see Sergey suggested the same ordering. The way your
>> > proposed text reads does make sense though... Would it read as well
>> > turning it over and going through the options in the other order? That's
>> > the way it is before your patch, so you could argue "but people don't
>> > grok that!". What your patch does well is to offer an overview before
>> > describing each option in a bit more detail. Would that work with the
>> > reversed direction as well (compared to this patch)? Dunno.
>
>> Dunno if it helps, but here is what I came up with somewhere in previous
>> discussions:
>>
>> --ff::
>> --no-ff::
>> --ff-only::
>>         When the merge resolves as a fast-forward, only update the
>>         branch pointer (without creating a merge commit).  When a fast
>>         forward update is not possible, create a merge commit.  This is
>>         the default behavior, unless merging an annotated (and possibly
>>         signed) tag that is not stored in its natural place in
>>         'refs/tags/' hierarchy, in which case --no-ff is assumed.
>> +
>> With --no-ff create a merge commit even when the merge could instead
>> resolve as a fast-forward.
>> +
>> With --ff-only resolve the merge as a fast-forward (never create a merge
>> commit). When fast-forward is not possible, refuse to merge and exit
>> with non-zero status.
>
> I think this could make clear that the first paragraph talks about
> `--ff`. I know that we often list `--foo` and `--no-foo`, say "This
> option does bar" and leave it to the reader to figure out which is which.
> Most of the time, that's fairly obvious though (foo=bar). With this
> tri-state option, we might be past the point of fair obviousness.
> Then again, seeing "ff" and "fast forward", it's not /that hard/ to
> figure out.

Yeah, I've noticed that myself, but decided to keep it, as this was
meant to be a quick re-arrangement of already existing description, and
be as short as at all possible, as lengthy descriptions tend to obscure
problems.

Being this way it shows how difficult it is to document flawed design. I
guess the author of --ff-only would think twice should --ff/--no-ff be
originally documented similarly to the rest of 2-way options. At least
he'd likely call it --only-ff, as:

--ff::
--no-ff::
--only-ff::

looks much better. Yeah, I do realize all this is historical and such...

>
> Apart from that, this reads well. Of course with the usual caveat of
> the topic being fresh on my mind, so in general, I'd be more likely to
> understand what it is I'm reading. ;-)

... and I'm in even worse position here ;-)

-- 
Sergey
