Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2EC420248
	for <e@80x24.org>; Mon,  8 Apr 2019 14:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDHOxo (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 10:53:44 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46260 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDHOxn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 10:53:43 -0400
Received: by mail-wr1-f49.google.com with SMTP id t17so16730191wrw.13
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4eiYHiHaHx3KYUEenFNwwwZ1eAH8RqjyQxt4G0w2APY=;
        b=Mq6xZUZ0PQLXpheyVOb094jDY3M6RnY1GMRQxzLl+td1mn8eixjKDzVkOwyOr3Udo5
         D0bOkuClPRtl677TWMehoSsJOOhOjrqhYRnOXumpBCjvyAzStKJzHMvqGZ8laDUenJEn
         7LRQJy1Yi46xqLkoqYCDa3PSbC4uQi1c8krMlKtN6yH0+WEyGkeOgu9Z2QR1yi41wWna
         6MNyJl6QmxBnpb9oKGwXaggQYIYOU+pWHw7Py7XdcAqAr3XiPEXq2WCvKR+OE2Ht58RP
         wmsROnSAdbwGqXIdBV0w2W6s8nNRtnNdwZl6mpfIow9PoVdv2V0j+LIwxnz0cFIczQ80
         Vn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4eiYHiHaHx3KYUEenFNwwwZ1eAH8RqjyQxt4G0w2APY=;
        b=WuGcoHiMfHW8aJeV/fC0BkzFy5CMH/y1BL2PqfLO0Rj4uWGKlBHJMGq3pT8kosIOnh
         p8w/j1EuEH/inIyfvfALiAEs2UfnsFGAh9Kb3bjILCZnQ44Nv+hhPkk6zAjGNCWziQ/j
         8hBU1Xrqfa4n+b5e7jCRz17jT9iDk1ORObcXPb4U+MTsmu+96oe7jYCkDB93YoMucEa0
         s24AiTYDpjAxLtS3XzS+UEV2EmK4lZfQ08ITulKs/dWYqdtzX/D20Df1qmaPXCTNBcAQ
         RrA2US3v2SFwee8hdVZRqKN0mFX1zgacE3S3KAfBNlMIL7G6vov5EOlH9WxSkDhWlFek
         U1xg==
X-Gm-Message-State: APjAAAWMLHpGCBxCxuWUl/LJKxwUMKX3gf51CDhJgP/QzDMPWH9xuM7X
        zsFMyD5u7rjRe3NooTNODpKugcqs
X-Google-Smtp-Source: APXvYqzZiSdRyhoa8Y0cJ2ZxkU9kZ+k+VslUzsC1X02UYO6DDk/cK9ZXSDyAkHDXddG6r4FiAMzzuw==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr20200597wru.266.1554735221906;
        Mon, 08 Apr 2019 07:53:41 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id i17sm26512098wrs.44.2019.04.08.07.53.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 07:53:41 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:53:40 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Pull without fetch
Message-ID: <20190408145340.3rdprg3yu5shpelu@feanor>
References: <20190406131200.xcd7gtf7dlc567uh@doriath>
 <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Mon, 08 Apr 2019 16:43:13 +0200
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Mon 08 Apr 2019 at 10:34:07 (+0900) :
> In that simpler world, what you are trying to do would have been:

> 	git fetch
> 	# did I get anything worth integrating?
> 	git merge FETCH_HEAD

Indeed.

> That obviously would not work for those with "pull.rebase", and I do
> not think it makes much sense to teach "git rebase" the same trick
> to read FETCH_HEAD as "git merge" does in the above sequence.

Yes, it could learn to read the first branch not marked as not-for-merge,
but I agree this would be more confusing since it would introduce another
special handling of FETCH_HEAD, different from `merge` (which handle *all*
branches not marked as not-for-merge) and the other reference parsing
mechanisms (which simply look at the first branch in FETCh_HEAD).

> Others may have a better idea, but I do not immediately see any
> solution better than inventing a new option to "git pull".

Indeed, I was wondering if I was missing something since this is something
I do often (granted in practice it's not too hard to type `git merge` or
`git rebase` after the fetch for a branch; but when handling a lot of
branches at once I prefer to automatize this somewhat, and when I find
myself writing a script that needs to read branch.<name>.rebase values I am
left wondering if this would not be better to be directly supported in `git
pull` directly).


> Another and better option that may be harder to arrange is to make
> sure that a no-op "git fetch" incurs very low cost.  If you did so,
> "git fetch && git pull" would perform just like your "git fetch &&
> git pull --no-fetch", and we won't need a new option at all.

I am not sure I understand what a no-op `git fetch` means exactly.
In the "git fetch; <review changes>; git pull" scenario,
after I do the real `git fetch` and want to merge/rebase the changes, how
would I prevent `git pull` to pull new commits that were pushed in between?

-- 
Damien Robert
