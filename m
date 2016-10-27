Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E1E20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034225AbcJ0WoX (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:44:23 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36496 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032469AbcJ0WoW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:44:22 -0400
Received: by mail-ua0-f182.google.com with SMTP id 64so35105030uap.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BsVCbo3BzoJOrj2rau4yps/lSpGriThLyFNLb9/PPJE=;
        b=N48aGMQ2pEfeJq++2HwkNYdckg9yW9yKYOE+Q5LYDJfQHde4SJnH9uZvno4ok97Kxk
         7o6V+X8iBJX149hd0DOxTh7FCuCVRi9yrlnylhnv/q91fAdg9V1ONVMnsPn9s4HdtMeS
         66074RK8WiEl+d1wWyGSCfSd7gWorjlJdocWH0HsnS+aVxtVnzJxs+19t/9A+Xt0rA6K
         AYdXhhOazOVAWu0W/K8uVwZWZ/nGxHPo5HNdXttqCcqvJL/dYgWKeq2yUO5WV0sk+NUz
         awEmshP5lqoR2FYMdDFtQ8AnrLy/9WjmIg6Jl1Euh8Uy7Su/nojL3alJjuRZkjP9uRdH
         n7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BsVCbo3BzoJOrj2rau4yps/lSpGriThLyFNLb9/PPJE=;
        b=cN8Tq9pQzOBhnxY9AXqAB6E7tkRfaqN0Hq9uAbF3KoiNbc7oOtWM2nrFvFrGGl1mXe
         fa9a6sd1ux8AYKR/CR8ylDS06U9v2TrBS7Cy4CI7Is9N0/vfVt/vRNimBiGfjgjIF8jn
         vW3q2GG0+X+9++PZ6ZW7zVWfB0L2c3bnb7DxJYnfH/CPRw78FB7jWQpRq3CTZRKa7vZY
         9gHbnS5Puh0xdsyqqFZCl4ssNswjNcjfteOf0B6fmS3+qf5oBkEezKd5VhLKRE5YcsnH
         J4rY3lQjy0CYF4MG5bcZ8/6CeRKJzakZ2SrIH2r8tzwosmEo8ImhsO3iOfNtJdnQzZkl
         vxUw==
X-Gm-Message-State: ABUngvdrZ+SZhPM7xfU/kfdrMJYu04SaG/geuWaIJO5VnYaSl5gL0pqfP3Ag5tnEcHS8MwsnJBIhjdL8NzvmWA==
X-Received: by 10.176.4.44 with SMTP id 41mr942280uav.96.1477608261307; Thu,
 27 Oct 2016 15:44:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.205.131 with HTTP; Thu, 27 Oct 2016 15:44:20 -0700 (PDT)
In-Reply-To: <CAGZ79ka7BvaW2pkjeXe68yKHFq6JsH__x2cXoe6U4tRmZ0rY1A@mail.gmail.com>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
 <CAGZ79ka7BvaW2pkjeXe68yKHFq6JsH__x2cXoe6U4tRmZ0rY1A@mail.gmail.com>
From:   John Rood <mr.john.rood@gmail.com>
Date:   Thu, 27 Oct 2016 17:44:20 -0500
Message-ID: <CALj-rGfAyimf0nFFcDHVHUgj8PQaz6Cvoz_PQfqdhr=QJEpbRw@mail.gmail.com>
Subject: Re: feature request
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I think changing the default for windows is a good idea.

The -m indeed accomplishes one-line messages when you are voluntarily
doing a commit. However, the scenario I mentioned is "When users pull
commits, and a new commit needs to be created for the merge"  In this
situation, the user isn't issuing the "git commit" command, and so
he/she doesn't have the opportunity to use the -m flag.

On Thu, Oct 27, 2016 at 5:30 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Oct 27, 2016 at 2:55 PM, John Rood <mr.john.rood@gmail.com> wrote:
>> Users should be able to configure Git to not send them into a Vim editor.
>>
>> When users pull commits, and a new commit needs to be created for a
>> merge, Git's current way of determining a commit message is to send
>> the user into a Vim window so that they can write a message. There are
>> 2 reasons why this might not be the ideal way to prompt for a commit
>> message.
>>
>> 1. Many users are used to writing concise one-line commit messages and
>> would not expect to save a commit message in a multi-line file. Some
>> users will wonder why they are in a text editor or which file they are
>> editing. Others may not, in fact, realize at all that a text editor is
>> what they are in.
>
> Look at the -m option of git commit,
>
> git commit -a -m "look a commit with no editor, and a precise one line message"
>
> I do not advocate this use though, as I think commit messages should be
> more wordy.
>
>>
>> 2. Many users are not familiar with Vim, and do not understand how to
>> modify, save, and exit. It is not very considerate to require a user
>> to learn Vim in order to finish a commit that they are in the middle
>> of.
>
> That is true, but vi is like the most available editor as a relict
> from ancient times;
> as you are on Windows, maybe notepad is the best on that platform.
>
> Maybe file a bug/issue at https://github.com/git-for-windows to change
> the default?
>
>>
>> The existing behavior should be optional, and there should be two new options:
>>
>> 1. Use a simple inline prompt for a commit message (in the same way
>> Git might prompt for a username).
>>
>> 2. Automatically assign names for commits in the form of "Merged x into y".
