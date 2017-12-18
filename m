Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BC21F424
	for <e@80x24.org>; Mon, 18 Dec 2017 21:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934737AbdLRVez (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 16:34:55 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:44311 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934193AbdLRVey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 16:34:54 -0500
Received: by mail-io0-f182.google.com with SMTP id w127so11364502iow.11
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 13:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sjKhwUBlE0CeQUTvqpzkLle6nNyqBbAM718Dwrsl8W4=;
        b=SitB+aMb8uORPWPJlAke1830TRty9Cqt+kIxq+265qPoSOhz+j36NlIQifx1lICNPK
         iAq12tKxnVnyOv90mAyYgwIRlSC48KBs/R/JNwjQZ7UuHuLHg57r5uGx7qJ3uu5sM+X3
         leXkZRlMxufLPyaquCqzyGfF6o2Z4rYAovvJfuXu+j/zrYb9Y40h3Oa5kD908gbHGVFS
         1Jl2T10yusQ91c9drcdI2xSsqL1+wbZ5zBymQzwJLN/yFGPyDeBpJJbcoo7WGPLGce+G
         cl+v1GYR9sf6+AXpA/MheqiKISzv/MzmLXjvIpyPzvfBqIWPLeHaFaEVIyU+9DxMjUHj
         D+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sjKhwUBlE0CeQUTvqpzkLle6nNyqBbAM718Dwrsl8W4=;
        b=s2VOBAODZo5+MRZCLMh/GHHXA9NMkNB0x/5q65/X1XrYLnPLE7+ayqXbNCMuawiqMf
         pt9t/ynIHNlndO5GGHZ0SgNC+Om0HRG3OFaAi+c4LfKoS4dxPMuTuiJFqhEIjVqYW6/v
         tkFSLSZIxYop54jGs2cJr8cR9Izfb91yzQ2e4gK30MucQYtL74Nm4z1PzF9SWQVY6GrZ
         qLw76A3kJuuhKZIzfkID5ILE8Pd3Jb8O7EHzHwRQ/cyHxVuy6SY//6W/dSCXX8nthICL
         J81FY8Lu4SOiYhEzNvmEUbcBP4JiNl+EzUpZoqYsjPtrZdlfMVGGGmZ2eXQDOdzE3VWE
         Wxnw==
X-Gm-Message-State: AKGB3mLrnaJPkZ4kd4qnAi2wj/VCeXjQD1Zv8dnxB6D8bC9n58iEEJwo
        eZY7gLRnP9mQKzYI+ywwq9R3d5ZdHwdLtdqDF1E=
X-Google-Smtp-Source: ACJfBouzC80PYdf9FzbPyomuREREolSuqIWte5DnwG9VpW46Aq96OZLjdkWXkkIIeF2gYUDyVkArkILX6aEdraX8eG0=
X-Received: by 10.107.47.162 with SMTP id v34mr1320804iov.255.1513632893572;
 Mon, 18 Dec 2017 13:34:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.118.74 with HTTP; Mon, 18 Dec 2017 13:34:23 -0800 (PST)
In-Reply-To: <CAPig+cTmRiSfY9+DsvEB7X_cL4AiAmq0FUb-CoDyc3HNDJLtow@mail.gmail.com>
References: <CAJ4+5mHMD+yW1ZDD6KJSnMtyygLUGiHzNPgPDZUi7+KUvOczkg@mail.gmail.com>
 <CAPig+cTmRiSfY9+DsvEB7X_cL4AiAmq0FUb-CoDyc3HNDJLtow@mail.gmail.com>
From:   Seth Raymond <seth.c.raymond@gmail.com>
Date:   Mon, 18 Dec 2017 16:34:23 -0500
Message-ID: <CAJ4+5mHt-oJTYEeRUeTynbZ5MRNT_CXWQSHoTUP_i-gWeqvmuA@mail.gmail.com>
Subject: Re: commit-msg hook possible bad behavior with -F <file>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see that line of thinking, and agree that it makes sense. I'm having
problems with an IDE (Qt Creator) and I think I know where the problem
lies now. I believe Qt Creator doesn't actually call git commit until
after the user generates a message in the message box, meaning my
prepare-commit-msg hook is run after I've already written a message
out to <file>.

I don't think there's a fix to it due to the IDE's seemingly-poor
implementation of the git plugin. Thanks for the clarification!

On Mon, Dec 18, 2017 at 1:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Dec 18, 2017 at 11:43 AM, Seth Raymond <seth.c.raymond@gmail.com> wrote:
>> If a commit is invoked with -F <file>, indicating that the commit
>> message should be read from an existing file, the the
>> prepare-commit-msg and commit-msg hooks do not operate on <file>. The
>> first argument to the hook is always <git_repo>/COMMIT_EDITMSG, rather
>> than <file>.
>>
>> Am I wrong in this line of thinking?
>
> The content of <file> gets copied into COMMIT_EDITMSG, so the hook
> does see the supplied message, as expected. Given that the hook is
> allowed to edit the message, it makes sense that it works on
> COMMIT_EDITMSG rather than on <file> directly.
