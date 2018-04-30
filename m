Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5130D215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 13:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeD3NQl (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 09:16:41 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:50545 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeD3NQk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 09:16:40 -0400
Received: by mail-it0-f50.google.com with SMTP id p3-v6so9789272itc.0
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RrEaYYBlNcik7wZsWt4xABn2Mo9VC0yz93ipKZtHC4g=;
        b=iUWr957RG2+LZXI8FiWkyG5w8I3AWOeOHx175S1XXOiQWBVFNP3io+bs6lHpioqste
         may4HCKkqmF7DVL+nL6mFWpN9xKUNQKG37nKN9YVgmvI8uL0CeQvFcFdGl9l8wYfTsrF
         M/QBjUZwlg5Lv5qNO3WcD1SNzjIH+7qiy4asSRuob6iE3LKboDuYy2qXXoD9M0ZgZQaZ
         tHnhZaTw91tTti6mWx7N7iV1yAjIwHqSYE3YB22M8a9rl1h8VGG+HDVJYr4U8Gw2Ebvv
         jGQvUzpjb/tpvNnNyETtRYH57IeynMpCyGFURCgwL0GqzEyrDN6SUambkwjLTBcjO5p5
         0Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RrEaYYBlNcik7wZsWt4xABn2Mo9VC0yz93ipKZtHC4g=;
        b=EkqdNl+V1gK5WnxqAAbiLqW/7CP0EWqLTH4l7L5C72J9ubJf+2RX8QcS2T5/r5d5Ft
         enQoOq4Zc9nrAly7+hDJNi6PH3pUmB8xB93u19tlsjViL5TG6FqgBs60nnTkKiTCIrx7
         wHH9JZGouCA6W1OV1wSGvE/ZQidIjChF+juyztOmBxhe3xMg8+ykjHcEXWxw5Fm3nbIt
         P9kCMhcwVpk4dB1Lv8um18iQFQeYBQU7JGJYJOBx0hrv6KUoFFlFPqtJEP8kUNfFsp9G
         qL0UW6DeBIV6tQy7kNBld9rAxzxJUlV3vL3caja70YGKS+cmjMqNWPPdSOTNkk/202UM
         HTww==
X-Gm-Message-State: ALQs6tDfyyquVVNl0OJo/TZq2sMyx+Buuj+P7wRMRJTwOqxEBYVs7SZD
        NqQfJlFiTqZycOmDraDNZTtGhFGd1Jnc6BUOJqKEYhWC
X-Google-Smtp-Source: AB8JxZpEKzA09TfjSZsUGSWUwNDN97fb5Khs4fmOch8pTmyLsr9Pwdk2wUEaX4jpOk4tmbN9WHTw6pjhJFGCgPUVxFw=
X-Received: by 2002:a24:d88b:: with SMTP id b133-v6mr11504566itg.119.1525094199713;
 Mon, 30 Apr 2018 06:16:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.114.23 with HTTP; Mon, 30 Apr 2018 06:16:19 -0700 (PDT)
In-Reply-To: <CAEp-SHXXwtgDb=bzTmT88aPQ267ANLCN6S3teC4hjHYDL9NQ3Q@mail.gmail.com>
References: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
 <CAEp-SHXXwtgDb=bzTmT88aPQ267ANLCN6S3teC4hjHYDL9NQ3Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 30 Apr 2018 15:16:19 +0200
Message-ID: <CACBZZX4NMJE0kcgb0aB0z3X6yGhL8VJVx6V3tYfA3socbjTQfA@mail.gmail.com>
Subject: Re: git-submodule is missing --dissociate option
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 1:30 PM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
> It also seems to be missing "--progress", and I imagine others.
> Perhaps submodule add/update should be reworked to automatically
> accept all the options that clone would?

--progress is not missing, but I see that it isn't documented. It was
added in 72c5f88311 ("clone: pass --progress decision to recursive
submodules", 2016-09-22). What you're suggesting makes sense, but as
shown in that commit it's not easy for it to happen automatically,
there's a lot of boilerplate involved.

But since you're interested you can see how to add new options with
that patch, it should be easy for anyone not experienced with the
codebase, it's all just boilerplate + adding a test.

> On Mon, Apr 30, 2018 at 4:29 AM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
>> This seems to be a hole in the git feature set. I believe it is fairly
>> easily worked around, but it would be best to provide the option for
>> ease of use (and maybe performance?).
>>
>> git clone has both a --reference feature and a --dissociate option,
>> with dissociate allowing for a reference to *only* speed up network
>> transfers rather than have the resulting clone rely upon the reference
>> always being there (creates an independent repo).
>> But git submodule only allows for --reference, so there isn't a an
>> option to make a speedy independent submodule clone in one shot:
>> https://git-scm.com/docs/git-submodule
>> I checked the latest online documentation (currently at 2.16.3) and
>> the documentation in the latest sources (almost 2.18):
>> https://github.com/git/git/blob/next/Documentation/git-submodule.txt
>>
>> As far as I am aware this can be worked around with 'git repack -a'
>> and manual removal of the objects/info/alternates file afterward.
>> Though I don't know if this results in a less speedy clone than
>> dissociate would.
