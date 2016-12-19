Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2D41FF6D
	for <e@80x24.org>; Mon, 19 Dec 2016 00:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbcLSAsS (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 19:48:18 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:35759 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbcLSAsR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 19:48:17 -0500
Received: by mail-io0-f177.google.com with SMTP id h30so140949383iod.2
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PQXRbDrl3Xxul+cSgwerZmmCUfFVc0bgHCMBA9LnXBk=;
        b=aLq6Hj1qYbQf8jlY4EGIaFssblYAyZ2avzb2xE3eNlW1gj7dVEaW/LuN3BMk/osSQB
         sUD1oX1AKrouw4V5VbmgKX0DXlEPy79oT4EE3KSnf5ObNnZSjxYnUKC3GDDMnpp29CPv
         R2NK9VVJ+zOY16K687TQ2JZdro9an6/n/FcmBlUfYWk4FkT/W7SyoB7N0cAKgwBrT1IE
         /jYxQSbRQ6TM6VgRs/wf9VpbQ5lPlNS73odxzXTSgde7CI6hIhX26Ne/7PyC0Iyj9mBT
         GNCb4fvPeKM2Cbt16z4QSmUcs7GLo0LXRjUmJCOxin9KruOy5iz268K2P3BJMujGu8t8
         7WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PQXRbDrl3Xxul+cSgwerZmmCUfFVc0bgHCMBA9LnXBk=;
        b=Gu582emzJvpOhd1CLjrpoLOfelB+01hcpNW37Ses1U2BU5xkpSbqM90G+6rk4VS2eM
         ghuaAO4zM1V1yHDmpXPTluCzdQRJqyLu6oNVkSNzESXaFEgOlLUIVSd/2o6V/gYXkmac
         /aEJAsSvRk4CG8prwZPL8M+u2gzIhDu1ICDxGQN47PRcn86XHGoonl0jTzkZRIbpkZKj
         i1bkvjuxnG0nCJ9OPv2yH0i4juHPcjZp298Pc5RcVgz8bJ30DrdK7w7M9HsBy76WEQtT
         LrzRG1CYkwWED14dh/83SBV9lST9R/O+urzqTQjOnaWf4fvQeqhWnVrhQzwL6BBMntZz
         AyDw==
X-Gm-Message-State: AIkVDXIsBdcfBiVDSYhF7Zqv1qoak2oL8//OB+PwX3WzDzE+EzPTY1wWwJo5uHZau+UMDWNvOEFn2iqdRZzIRw==
X-Received: by 10.107.195.204 with SMTP id t195mr12471159iof.46.1482108496673;
 Sun, 18 Dec 2016 16:48:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.36.6 with HTTP; Sun, 18 Dec 2016 16:48:16 -0800 (PST)
In-Reply-To: <1482063500.10858.1.camel@gmail.com>
References: <1482063500.10858.1.camel@gmail.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Mon, 19 Dec 2016 13:48:16 +1300
Message-ID: <CAFOYHZDnpzdYq9j4-xGSdKZQX9deLBpZZhz209qV7cCtq537SA@mail.gmail.com>
Subject: Re: Suggestion for the "Did you mean this?" feature
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 1:18 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> Hello all,
>
> I have found the "Did you mean this?" feature of git as a very good
> feature. I thought it would be even better if it took a step toward by
> asking for a prompt when there was only one alternative to the command
> that was entered.
>
> E.g.
>
>> unique@unique-pc:~$ git hepl
>> git: 'hepl' is not a git command. See 'git --help'.
>>
>> Did you mean this?
>>       help
>> [yes/No] : y
>> usage: git [--version] [--help] [-C <path>] [-c name=value]
>>            [--exec-path[=<path>]] [--html-path] [--man-path] [--info-
>> path]
>> ....
>
> This would make it even better for the user as it would avoid having to
> correct the mistake long commands that had only a single error
> (considering history feature is enabled).
>
> Is this is a good idea ?

This feature already exists (although it's not interactive). See
help.autoCorrect in the git-config man page. "git config
help.autoCorrect -1" should to the trick.
