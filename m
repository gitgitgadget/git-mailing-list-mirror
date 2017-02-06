Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34E91FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 20:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbdBFU1Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 15:27:25 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35101 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbdBFU1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 15:27:23 -0500
Received: by mail-ua0-f194.google.com with SMTP id 96so8418873uaq.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l9dRCMo0eitzXLbVs6Jn6nCGZOunC2CWkI5gLPbROAM=;
        b=hWTkaICdWfB2gRU2MjxgxY2+mmVyvQqB/0Ut1mFmuD5NieMQ2q5ttofVKRx3skDwgU
         ZZ+xeCbv4Kg2StRovv9XC/kTKdtxuzULgv7D6Yk1litySVtukEoiUq7qTpHVv7E72iOd
         4wv0KEdoZxq9vmHEWTOagJEtbiz+cEdZ3ghffsPGd1EQi0hHCVe/Vn16uZpb+5lP9YdF
         r9oq7HrOyb9fQ0vQPKMRnJ88eoiXUl/N5yS7gLM3Uhwf/9g7dR2+w1kFMBYHSGQn/YtL
         rmaeVDDn1dCks+6HjoE7lD/as3p4o9jdhM0fcD+O33IfT2HTBcmuHYa4MZDlBxQX1Mi8
         Ge+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l9dRCMo0eitzXLbVs6Jn6nCGZOunC2CWkI5gLPbROAM=;
        b=qoufxTUsLdGxAhuOaUa+2b2qcA6ZCK5urHaZwGkNzQq07fV3olvzO/WTQ2fOA7R0YT
         MZQpzaQxWzMyCmhHSl0wEGmdY7N03kDvfMSLxaBBZNmZvqpepykxxlJHJa0s4tWR5VWu
         /o0zU05I7+onh/DXqALUpwcx1qJEBwVro0UvC2zguR3bJsa0V93OZclrKideDkDdUesN
         EexwepetxeqqNdHucHoyXQsF5UBwTkPjIPWyNVaUEJLJo9h4YUjgzwFly2CNRorVDGZW
         keO8Tj6MQ5Ne/zKz43Z5EX4gUE89gvgYNB4LNDRjpNJqM596q9ROP0Fsg+qwYxgr7wgO
         CeYg==
X-Gm-Message-State: AMke39njCguaadWcxgiQoTidBXJtgwEins+kSj1LarUGcDTC1DOBXLe41Zt5j/ow/A+CkTvo/tiXGyk/2xpfiA==
X-Received: by 10.159.48.79 with SMTP id i15mr4959090uab.13.1486412842534;
 Mon, 06 Feb 2017 12:27:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Mon, 6 Feb 2017 12:26:42 -0800 (PST)
In-Reply-To: <CAJZjrdWq+xSEoTypA_hWdQJgioGOHJd3V7djeQ0YxpzvhuoM=g@mail.gmail.com>
References: <CAJZjrdWq+xSEoTypA_hWdQJgioGOHJd3V7djeQ0YxpzvhuoM=g@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 6 Feb 2017 14:26:42 -0600
Message-ID: <CAJZjrdUdQ4JMTG9sciP3N_qQ4OgB-o+f-G=ooDikwpgasFnEXg@mail.gmail.com>
Subject: Re: warning in tree xxx: contains zero-padded file modes
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 2:23 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> I'm just going to go ahead and split this off the git/git-scm.com
> issues thread since this is a distinct topic.
>
> On Mon, Feb 6, 2017 at 12:49 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Feb 06, 2017 at 05:18:03PM +0700, Duy Nguyen wrote:
>>
>>> On Mon, Feb 6, 2017 at 1:15 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>>> > # Irrelevant but someone should take a look
>>> >
>>> > 693
>>>
>>> To save people some time (and since i looked at it anyway), this is
>>> about whether "warning in tree xxx: contains zero-padded file modes:
>>> from fsck should be a warning or error. It is a warning now even
>>> though "git -c transfer.fsckobjects=true clone" treats it as an error.
>>> There are some discussions in the past [1] [2] about this.
>
> I think you forgot to link to [2] :p
>
>> The bug that caused the trees is long-fixed. There's a question of
>> how severity levels should be handled in transfer.fsckObjects. By
>> default it treats everything as a reason to reject the object. Dscho
>> added configurable levels a few versions ago. It may be a good idea to
>> tweak the defaults to something more permissive[1].
>>
>>> There's also a question "And I failed to find in the documentation if
>>> transfer.fsckobjects could be disabled per repository, can you confirm
>>> it's not possible for now ?"
>>
>> I don't know why it wouldn't be, though note that it won't override
>> the operation-specific {receive,fetch}.fsckObjects.
>>
>> -Peff
>>
>> [1] If we had a more permissive set of defaults, it would probably make
>>     sense to turn on fsckObjects by default. Some of the checks are
>>     security-relevant, like disallowing trees with ".GIT",
>>     "../../etc/passwd", etc. Those _should_ be handled sanely by the
>>     rest of Git, but it serves as a belt-and-suspenders check, and also
>>     protects anybody with a buggy Git downstream from you.
>>
>>     GitHub has had the feature turned on for ages, with a few caveats:
>>
>>       - we loosened the zero-padded mode warning, because it was causing
>>         too many false positives
>>
>>       - we loosened the timezone checks for the same reason; we've seen
>>         time zones that aren't exactly 4 characters before
>>
>>       - we occasionally get complaints from people trying to push old
>>         histories with bogus committer idents. Usually a missing name or
>>         similar.
>>
>>      So those are the ones we'd probably need to loosen off the bat, and
>>      they're all pretty harmless. But it would be a potential irritating
>>      regression for somebody if they have a history with other minor
>>      flaws, and Git suddenly starts refusing to clone it.
>
> The linked issue on bugs.debian.org has seen activity recently, which
> is the main reason I mentioned it separately as still relevant:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=743227

I take it back: last activity was in Feb 2016. >_<
