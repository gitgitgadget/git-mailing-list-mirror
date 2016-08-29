Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCE11FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbcH2VNu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:13:50 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33967 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbcH2VNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:13:49 -0400
Received: by mail-oi0-f41.google.com with SMTP id l203so176022oib.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NRNTGno+60QdgMMKoAi6ByECs8T89GAAyjOou8Sjv2g=;
        b=ezB+f4vaiPUt5VsT27m9VWdPXIWOOB44rM0x8iUZUgACKhwjEPsSYDYEvhzTCptWPb
         2f186oV7n/zv3h2QS27Hvqm4K9d+xbwbUa1MtNvfIOi20XEyi5ACmqkEDMgMYkKxzc8Y
         uPHUWlvETjVw9c+8HeFY7XGoBNTF8augQAjKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NRNTGno+60QdgMMKoAi6ByECs8T89GAAyjOou8Sjv2g=;
        b=CdYB/8oDIyiABZRTiVvX4qJAzMMbPXFgwCw6c0+5bXKmkkIf59Avw7BtRpr5tzMMAR
         eAMkf2p0SQ2IXfHKhfk6NuNDf+5gnG5X4jeEg7aYTLVC/43Oh5dQToD9dwdt8V/L6dux
         mCJNcsUxRe8boqgBP+Gyg5+kPACq7XcutFfNHoTuH5OACL1OGfFLCjIsctlGqw/953xq
         fld3ZAwcXxREZ2LY0a+adHnHUFQfn4Fxb7pVjDGvrKW214nVeBnUssRwuapbj9aK1fE4
         O1YzbCH+Zik9Y6UO3y9MALpFGrwzY21y2NwvgiGjFy3V993eD2iuF/g4fpx/Y25hAbuH
         ayQA==
X-Gm-Message-State: AE9vXwNDBULZOvZO9l76enwOwxefQmiTbkQxKWlvg4C1mlzIUjqcyErT2QbJckMaXHmNSwlJejgtV1yowYJ5M111
X-Received: by 10.157.55.183 with SMTP id x52mr111829otb.68.1472505228871;
 Mon, 29 Aug 2016 14:13:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Mon, 29 Aug 2016 14:13:48 -0700 (PDT)
In-Reply-To: <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Mon, 29 Aug 2016 14:13:48 -0700
Message-ID: <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok that makes sense. Thanks much.

Uma

On Mon, Aug 29, 2016 at 2:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Aug 29, 2016 at 2:03 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
>> On Mon, Aug 29, 2016 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> A top-level superproject can have a submodule bound at its "dir/"
>>> directory, and "dir/.git" can either be a gitfile which you can read
>>> with read_gitfile() and point into somewhere in ".git/modules/" of
>>> the top-level superproject.  "dir/.git" can _ALSO_ be a fully valid
>>> Git directory.  So at the top of a superproject, you could do
>>>
>>>         git clone $URL ./dir2
>>>         git add dir2
>>>
>>> to clone an independent project into dir2 directory, and add it as a
>>> new submodule.  The fallback is to support such a layout.
>>>
>> Thanks for the reply. However, in this case....
>>
>>       git clone $URL ./dir2
>>       git add dir2
>>
>> how will "dir2" get ever get registered as a submodule?
>
> With a separate invocation of "git config -f .gitmodules", of course.
> The layout to use gitfile to point into .git/modules/ is a more recent
> invention than the submodule support itself that "git add" knows about.
> The code needs to support both layout as well as it can, and that
> is what the "can we read it as gitfile?  If not, that directory itself may
> be a git repository" codepath you asked about is doing.
