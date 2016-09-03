Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7BB41FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 00:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbcICAwz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 20:52:55 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34036 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbcICAwz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 20:52:55 -0400
Received: by mail-qk0-f179.google.com with SMTP id t7so138098361qkh.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/24lzIGjm8bv+FxC8FOY2DRnkLc5dK0UwqEp8s4svhM=;
        b=Mrwp0itjDt2II6fmJJfdlQMbmFq4VHzqANzQ03MFPG4toccCXaZAohou8cnq5TACsg
         2rcAEISwmSlPSYIW2L4OoFJLbkHvos96YfonbIQ7N8OnD7Phf/2/Hh4bqmizi6YtcmuR
         +j5XY2PS+Arh+5da9DB4UWRbKdJ3Gr8cLa3/bsREnFsixQCs7osOxyLe1ISK7lATQSdV
         qcTzm3nBMEGKnOcr6Pss5+JXtfS2upYB+oKjP3V7UVE25c0zvgH6IhWeZ166C1DFenoa
         WgNiDFmaLAmrS9tlvavw3dElAKwQ5oxtU/9jUtxw5EJMGO4srWbFjZNbuGBRWlD7bPGi
         kIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/24lzIGjm8bv+FxC8FOY2DRnkLc5dK0UwqEp8s4svhM=;
        b=Lxm68JCjm0xgWfuNULrHXnsplX1JoHWXdv45v7eJPw6oqHovlvt2ujOihJ+pg0OblK
         iGmh9ZDWNvdSzv7WsRFJotZYzSQ1Np9fsK2EzwmMOYma+jUpJyk3W8R6VdixGUS8Pv9Q
         GmscYKCCTBLKmNnbCETh8xKOjm6gbxSuXry6KYn+jEof/IDb/tUJgxuW793cnii1BiwB
         OExAFTxz9EW0eUU3m2s89Z/fk5Sk1gFlzmE3ZLNRd72Ehdu1TNwOaYySlq9yiKTw9orq
         usU4psdtPP25qtg8BAtDZjaEEJZzfKUM9Da1cbIjz7Nl9b1tRvgc3HF0XEZvQnFbJlMZ
         0Osg==
X-Gm-Message-State: AE9vXwPilFiYkYzmGtgs2q1TQrcLD6l7coy4AA13ZGtNX4V6xra6lyU3Dho/F2YhUFjl2Q8MJJU1evyhoWmxxw==
X-Received: by 10.55.78.17 with SMTP id c17mr25071657qkb.168.1472863974000;
 Fri, 02 Sep 2016 17:52:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.41.241 with HTTP; Fri, 2 Sep 2016 17:52:33 -0700 (PDT)
In-Reply-To: <CAGZ79kYhV30AuXUKtp3oewMpnEk5vD=HvRUJTTFaEdsacu3tGw@mail.gmail.com>
References: <CAMbP-nS_MM0QXgw183DLQPx1YU1BH8ytKCv86p-JSxzdb2jpQA@mail.gmail.com>
 <CAGZ79kYhV30AuXUKtp3oewMpnEk5vD=HvRUJTTFaEdsacu3tGw@mail.gmail.com>
From:   Brian Levinstein <blevinstein@gmail.com>
Date:   Fri, 2 Sep 2016 17:52:33 -0700
Message-ID: <CAMbP-nR9fE0FBaFof6ajMbDFViKwpi4iX3mD0i6cReFveOB2zw@mail.gmail.com>
Subject: Re: Bug Report: Too many untracked files (gitignore)
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patterns in question do contain a slash, although they don't start
with a slash.

I tried changing it to "!/.vim/colors/*" as you recommended, with no
change in behavior. I even tried adding a leading slash to every
pattern in gitignore, with no effect.

Removing the line with "!/.vim/colors/*" still fixes the problem.

Brian Levinstein
blevinstein@gmail.com | bpl4ab@virginia.edu
(703) 673-8711
Google | Software Engineer
University of Virginia | MS Commerce 2014
University of Virginia | BS Computer Science 2013
Alpha Tau Omega | Delta Chapter
http://www.linkedin.com/pub/brian-levinstein/14/620/6ba
https://github.com/blevinstein


On Fri, Sep 2, 2016 at 4:58 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Sep 2, 2016 at 4:06 PM, Brian Levinstein <blevinstein@gmail.com> wrote:
>> The relevant repo is here:
>> https://github.com/blevinstein/dotfiles
>>
>> My gitignore file looks like this:
>> https://github.com/blevinstein/dotfiles/blob/2400ca8642a7b454a2bfc54e8402343d008836aa/.gitignore
>> It basically ignores all files, except for specifically whitelisted
>> files. However, when I run "git status" (git version
>> 2.8.0.rc3.226.g39d4020), I see the following untracked files:
>>
>> #       .bash_history
>> #       .bash_logout
>> #       .cache/
>> #       [private]
>> #       [private]
>> #       .profile
>> #       .viminfo
>> #       dev/
>
> For the specific files to be exclued, I'd recommend starting with a slash, e.g.
>
>     !/.bashrc
>     !/.vim/colors/*
>
> If the pattern does not contain a slash /, Git treats it as a shell
> glob pattern and checks
> for a match against the pathname relative to the location of the
> .gitignore file (relative
> to the toplevel of the work tree if not from a .gitignore file).
>
> See the notes section of https://git-scm.com/docs/gitignore
>
> So I do not quite see the bug?
>
> Stefan
