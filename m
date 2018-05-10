Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4111F406
	for <e@80x24.org>; Thu, 10 May 2018 13:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757210AbeEJNyV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 09:54:21 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33838 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeEJNyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 09:54:20 -0400
Received: by mail-pg0-f47.google.com with SMTP id g20-v6so1013756pgv.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CZTwyHN+0e9VC7Ean8o977qvrytkS2sp7YKZcVBjhFc=;
        b=ZpWYtCADxnEBiK4QixFh+XqojgPp9Jiwi5TxwHEgqFwv5TRlTZK4j+Kptg5vyYKIPZ
         BfwaoyjJ897ElI1n6ZmCeZoZVHj0irtizNOYHQpseAMUzoJL6tZZwhValvlZ5wAIKQ0I
         oeTPJZIYVC1gr48Emznx49NvuW0+/uT+6FX3FtrvwmEJgyPK1old7w/suS3yBjIo/mkI
         +mFxMHYXn4BtKsOnOjvNSnNzNI/YEpHihVOogvjT0xSBj8ZUCtmajuVZk0lXAYvoSULR
         OtC2udhirNa8BFyIq0DMO1N3RS6kwZM51Zr5o1Ys1W8pOCibIUy7T6aOSPJVP3O6prvW
         YARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CZTwyHN+0e9VC7Ean8o977qvrytkS2sp7YKZcVBjhFc=;
        b=UF0f7UIh0ZQ/w4qOLal3AT6C+HvDWbfHwnAtbI2ebjldhPqW98dx+DyiDURps8Kieb
         VwXjAG/KRta19ULKOfu4e9XmgMrIdWb8tqeugJyGm/lDvFv7ErcMmqbKqtbP0zHhxISl
         ZIi40qgDP+qlW6AuL3aDelYNp0fDRcBgTvOWMMpGXzBDQlroX1K2Rbv1S1ZpOHcp/oB9
         hVPH4hsrJSk5Bn/h9wPKkNtd+VBkF+GVx+JiBdqo51YN2MDkkr8UAwJd1NIIkvCdeB91
         Q4lrk5lMei18qqQA6JvR3AHoIR6mCdS0tSNpUbFU3iKFGDZ2rtLEEMj1nSQnOqI2+8Va
         yKgw==
X-Gm-Message-State: ALKqPwdTIki4KnskIigfMozWunvLOLYcjwDgowjcDVU92/Ds6aLZAFTP
        151CmluSpKrwEKle6dhMXwgftObEKg2cGq/+Ows=
X-Google-Smtp-Source: AB8JxZrTKzsZr3sCRvlHmo8v/QsWRU/bbCnvKaf4eorNjuKgdXcfwV+U87Ff2e+NVn7G8BQdbeNkHWYKvLLLHpznpPk=
X-Received: by 2002:a65:5c06:: with SMTP id u6-v6mr1279146pgr.316.1525960459757;
 Thu, 10 May 2018 06:54:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 10 May 2018 06:54:19 -0700 (PDT)
In-Reply-To: <20180510131626.17859-1-oliverjash@gmail.com>
References: <CAN0heSq5SyPgoEURRVHupcabVu3jX+tmX+0U-6azrJDDgfZ5Gw@mail.gmail.com>
 <20180510131626.17859-1-oliverjash@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 May 2018 15:54:19 +0200
Message-ID: <CAN0heSoNP6ZjoU4x=tjwXxN_4oeOdrPG2LuahTPvGz0Y9WPp3w@mail.gmail.com>
Subject: Re: Regression in patch add?
To:     Oliver Joseph Ash <oliverjash@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, mqudsi@neosmart.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 15:16, Oliver Joseph Ash <oliverjash@gmail.com> wrote:
> (Apologies, I accidentally sent this as a reply to the original post, instead of your email. I'm new to this!)

(No worries.) ;-)

>> does your test involve unusual file systems, funny characters in filenames, ..? You are on some sort of Linux, right?
>
> I'm running macOS 10.13.4. I don't have any unusual file system setup, as far as I'm aware. The filename in my test case is simply `foo`.

I'm not too familiar with Mac, unfortunately, but let's see..

> I tried the steps you suggested: on git 2.17.0, saving the patch, editing it, and applying it, and it succeeded.
>
>> should now show bar2 in the first hunk and bar1 in the second hunk, just like your edited test.patch.
>
> That was the case, although I had to remove the `--check` flag from `git apply`.

Hmm, you mean that `git apply --check test.patch` failed? With error
messages? Or, you had to remove the --check flag in order for the patch
to actually be applied on disk? I would guess it's the latter, but just
to be clear.

>> How comfortable are you with building Git from the sources?
>
> I've never done it before, but I assume it's well documented, so I'm willing to give it a shot!
>
> Happy to try any steps to debug this! Although I'm a bit surprised no-one else can reproduce it with the same version of Git, which makes it seem less likely this could be a bug, and more likely it's something in my setup.

Where do the git 2.17.0 and 2.16.2 come from that you have been testing?
Homebrew? Apple? (Ple

So you should be able to do `git clone https://github.com/git/git.git`
and read INSTALL. It might be useful to start with `git checkout
v2.17.0` to make sure you're testing roughly the same thing as before.

As for obtaining the dependencies, since I'm not familiar with Mac, I
cannot give any good hints.

I see now that Phillip has replied with a good guess. Let's hope he
has managed to circle in on what's causing your problem.

Martin
