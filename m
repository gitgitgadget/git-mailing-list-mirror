Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47D81F453
	for <e@80x24.org>; Mon, 24 Sep 2018 16:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeIXWMz (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 18:12:55 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36005 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeIXWMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 18:12:54 -0400
Received: by mail-wm1-f45.google.com with SMTP id y13-v6so5869669wmi.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aluCes8eHK6l9toQtK1BdI7x7l56tSWrgWtuDw+ss0M=;
        b=NG2xXMzkWeI/EKCBQSwkU7jJOIl4E7WqKRBW6gYJWZ0B0knQ3IBw+FDBzGs1rS8BEQ
         kKrGYZcI/iKXDPY0MCydrQF4bz+MCvEfbifr1EmtQ358x2o1w6XH36AiNA9EQsWIi+lB
         u6wOR/18VdhFl6KP87Nhzfvw6UYzrNps1TuLpl/Hm///xEhBNtvYC9roWmuGVxLuhQyd
         c/HM/pY4xHIWFkC7VZxLoSSV/Yhdirv3OSmtICGB7pIwiZslvvkt6c0nW+S2Q3LDTLUm
         lgxR6wiSEuwpKSbW5usOGT2aQ3gHcVzf9HMu6YGp9/LD/901BJIldCHpl84eisy2JN5O
         +TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aluCes8eHK6l9toQtK1BdI7x7l56tSWrgWtuDw+ss0M=;
        b=UrmrtwdWhgA3Qb4vtG7a2Y7O94DpHa6jQyMw0Siagejnl14Rrrz6BGOgI47qCnbhYV
         u/3dDkEKyuNoGVAWGjoxDW3Sv/Qao0Wb1kv8K6dKPt4SvVHSzEYmlD1aaVJcCJ7WGw3y
         Dt48NOdViNlUF1rjdPoL9SJvC/S3+3oXK9lcDTTL3JMQsR2ZiR7Up72Hibur1eWdoSsd
         PFfDbpnARfIXtEzesKrOS6rotu7boYkC5kL1oNrXRDvSjOsw2hi3GTqsrXdimbXoJWuT
         Fp5xODlT1bwh076Pel4jRZbTWhNZwbOA49E53Lv9PCLa/m7SWYwcz1X1tfUqGAc3jdZc
         ge5A==
X-Gm-Message-State: ABuFfojnAHkkO/yh4Y4HlGYMtzdN4jYN8EWbYaBonvMMKkmzuVTv0goM
        B/IdjRq4FUNLoNbxcfq3kX6LJ3ci
X-Google-Smtp-Source: ANB0VdZe9iF2nlN0CV6utF1yZIKroE3j6SbwfLm8ETiIDwKbu9Pr4RI9Y82mEvbh506+iitLZnDrgA==
X-Received: by 2002:a1c:7305:: with SMTP id d5-v6mr8194111wmb.53.1537805400193;
        Mon, 24 Sep 2018 09:10:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x15-v6sm29499645wrt.53.2018.09.24.09.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 09:09:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] t7001: reformat to newer style
References: <20180921235833.99045-1-sbeller@google.com>
        <20180921235833.99045-2-sbeller@google.com>
        <7f77be2b-a084-5b8d-df65-1bb4b9c5da82@gmail.com>
Date:   Mon, 24 Sep 2018 09:09:58 -0700
In-Reply-To: <7f77be2b-a084-5b8d-df65-1bb4b9c5da82@gmail.com> (Derrick
        Stolee's message of "Mon, 24 Sep 2018 09:31:16 -0400")
Message-ID: <xmqq4leeubah.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +test_expect_success 'moving the file back into subdirectory' '
>> +	cd path0 && git mv ../path1/COPYING COPYING
>> +'
>
> Split at &&, use subshell?

Yes, I was almost going to point out the same, saying "'reformat to
newer style' is much larger than only changing how the test body is
formatted", but was debating myself, as a good "modernization patch"
needs both mechanical changes and manual/semantic clean-ups, and it
is very clear that these three patches deliberately limit themselves
to the former for easier verification.

It is relatively rare that files are not touched by any in-flight
topic in the codebase, which is a good opportunity to apply this
kind of wholesale clean-up, so I tend to agree that it is a shame
not to do the non-mechanical clean up in the same series.  Perhaps
the best way would be to keep these three mechanical steps as they
are, and then follow-up with non-mechanical clean-up like you
suggested.

>> +test_expect_success 'commiting the change' '
>> +	cd .. && git commit -m move-in -a
>> +'
>
> Drop "cd .." (and the comments about being in path0)

... when the previous step moves to "git -C path0 mv ..." or
preferrably "(cd path0 && git mv ...)".


> [big snip]
>
>> +test_expect_success 'moving to existing tracked target with trailing slash' '
>> +	mkdir path2 &&
>> +	>path2/file && git add path2/file &&
> This line in particular looks a bit strange. What is this doing? At
> least we should split the &&.

Create an empty file by redirecting the output from a no-op into it,
and then adding the result.  I agree with you that this would be
easier to read on two lines.

>> +	git mv path1/path0/ path2/ &&
>> +	test_path_is_dir path2/path0/
>> +'
