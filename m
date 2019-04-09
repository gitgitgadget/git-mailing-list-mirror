Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA852032D
	for <e@80x24.org>; Tue,  9 Apr 2019 07:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfDIHBh (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 03:01:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55160 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIHBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 03:01:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so606352wml.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k9i33DTg3u6LEgnIwEilOX+xLZB9CEdqM045BkmwfnU=;
        b=gqf4kCVVb5K+x7y5m9kOZI24B1G9v5atXJv4kEp0VWdDTAhtLmE7zvrvBzD28Aqveg
         nRNKHD5x6LPtG4u259DdZj0ikMEiFfiYDPJU5XO3EmaKb4IKkYfUROnaNpuABacK7xxC
         v96cV+e2zZq0N6nY/cexyts4shuKZNEo2rif85bshuXlbBR4hRH3I7i4hPRY3fXQ+8vy
         bNrWsNBc3pNIoyvIuViVVZrVMl/svXPpzuH1dsU9KUSrTjoBg9UBNW4abtHo+dRyZVmS
         Rht+0KGcWtz0jtlG5gLKyZR97UK35VUVWo+WJQrtoYk4RLnlc/2o9zZwKzdkSGo2MYtK
         LqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k9i33DTg3u6LEgnIwEilOX+xLZB9CEdqM045BkmwfnU=;
        b=bVJRbuAg/MQsg0xHo8JKi4agh7F1idq5l9hWhrtg6GSIbxFXwVgH1cAEvJSz1utECI
         DqzILBBAggkvGdvBSBOWN/N+31VPnVA7cVFk9p2PAVZXHR9riBqGVTvYr4+Lg8TrG8Xr
         CukNjcQLqjiK9rudrn/5VTpbtsk3H9+Chu4WNz0C1V4EBUhpVw+8RbrZWYuM072E6x+w
         b66F29LPtYCcNGo1FsqUsIFZD5rUedCL/nA6OcIG6Cb6f8qz6jmnXYHAUGmdn1zOinn2
         WxvOCrnLT9ZHYGuJ4bq16mePhEW3I7rzmtMhJfeob5II6RW/Eyclcfpo1cCSe3RR+65m
         zGEg==
X-Gm-Message-State: APjAAAXrMHSMTLsnQGXoquLNbCNhIOM9tLAqORAmCb1p/a/EIN/wxFVO
        5iYczfbCyFplNK3tJFheWOw=
X-Google-Smtp-Source: APXvYqy3FOTAwa5l1fpV7FCAz+cTD72Mb2mOu6yRLDe/zBtguLkV4NeTJtTweZlhyVicwyQ44KI+wQ==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr18693273wmg.14.1554793295370;
        Tue, 09 Apr 2019 00:01:35 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id q4sm44993549wrx.25.2019.04.09.00.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 00:01:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/docs] make slash-rules more readable
References: <20190405200045.10063-1-admin@in-ici.net>
        <xmqqftqt7x49.fsf@gitster-ct.c.googlers.com>
        <CAKrvxcVgMLNEEY6U+ybm6n4WtUCdOaYRjBrDKFvRwzYbZyB2UQ@mail.gmail.com>
Date:   Tue, 09 Apr 2019 16:01:33 +0900
In-Reply-To: <CAKrvxcVgMLNEEY6U+ybm6n4WtUCdOaYRjBrDKFvRwzYbZyB2UQ@mail.gmail.com>
        (Adam Nielsen's message of "Mon, 8 Apr 2019 12:27:51 +0200")
Message-ID: <xmqqy34j7jci.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

> I agree with you. How about we make up the word "intermediate slash" and
> explain it in an extra paragraph?

I am not sure if that is any better than "in the following, pretend
that a slash at the end of a pattern does not exist", which is how
the current description avoids repetition and aims for clarity.  It
probably is worse than than the current one if we need to introduce
a new term that is otherwise not useful elsewhere---a new term adds
to the cognitive load of readers.

>> I also wonder if "in all directories" is clear enough that your
>> "all" is limited to below the level the ignore pattern is defined
>> for (i.e. "*.1" that appears in "Documentation/.gitignore" does not
>> ignore "foo.1" at the top-level of the tree).
>
> Its mentioned at the start of the page that the pattern is always
> relative to the location of the `.gitignore` file. However, I see that
> since its said "in all directories" its necessary to restrict it again.
> How about
>
>          If the pattern contains no intermediate slash "`/`",
>          the pattern will match in all directories at or below
>          the `.gitignore` file, with infinite depth.

It is unclear what "with infinite depth" means in this sentence.
There is no depth-limit in the exclude mechanism, and I'd prefer
not to confuse readers by making a casual mention of "depth" to
imply as if there is some depth-based logic.

Also, as you defined "intermediate" as a slash that is neither
leading nor trailing, the above paragraph says "/foo" matches any
filesystem entity whose final path component is 'foo', e.g. a file
'foo' at the current level, a directory 'foo' in subdirectory 'dir'
(i.e. 'dir/foo'), etc.  I do not think you meant to say that (and
this is why I do not like to introduce a new term---even its
inventor cannot get it right).

>> So I can tell that this patch is trying to address a problem in the
>> original that is worth fixing, but I cannot say the result is good.
>> At least not yet.
>> ...
>> Once you write consistently that a path for a directory foo/bar is
>> foo/bar, not foo/bar/, then this example would become much easier to
>> write and read, I suspect.
>>
>>         An asterisk "`*`" matches anything except a slash.  A
>>         pattern "foo/*", for example, matches "foo/test.json" (a
>>         regular file), "foo/bar" (a diretory), but it does not match
>>         "foo/bar/hello.c" (a regular file), as the asterisk in the
>>         patter does not match "bar/hello.c" which has a slash in it.
>>
>> perhaps.
>
> I agree, this is much better. Although I would leave out
>
>>  "as the asterisk in the patter does not match "bar/hello.c"
>>   which has a slash in it."

I happen to think that the part is the more important half of that
whole "example".  By explaining why it does not match, it enforces
"matches anything except a slash" we gave upfront.

Thanks.  I think we are making progress...
