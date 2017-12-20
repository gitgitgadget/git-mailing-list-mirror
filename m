Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A181F404
	for <e@80x24.org>; Wed, 20 Dec 2017 22:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756463AbdLTWV6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 17:21:58 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:36637 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756407AbdLTWV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 17:21:57 -0500
Received: by mail-io0-f180.google.com with SMTP id l10so18950976ioc.3
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UJTXCFt9BKRkLdyg8EQWJpI5tRbRG7fVWv08Oy2UUPg=;
        b=G6J8vkr8Mi6rg8qUMln16pBq/q1qJGSMxc/nNt9XNPapwpgydNQUZxHDqKE4bXD+vv
         zliFrLOazWqNhN6ZuJ0ResIwuosgjVAzZGnrpE/4/HME7PvQZuN55nzKyZWP9bEDw7XG
         XLONxS3xGJpKKkfW9/ZyfMsyP539NDUqbzQOM+q4jlkTWIKX+tyK2GhThqjf1ILrdT98
         fPsvqfqHlC/zlibswhsO9Y9VZIfLa8FmFRmel9smhEAXduebfcb1n1TLx1+3xvy/HFJl
         PibrolbUzBv/yL6UQQNsYGkX0uar+xoGoyf3LngOPwAOkCPTA2oZt3NHQze/bMTWP2p8
         eKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UJTXCFt9BKRkLdyg8EQWJpI5tRbRG7fVWv08Oy2UUPg=;
        b=kUKWuQ0sf8XF4WUPhF/LZoHNCuE5QHKQEQ9HTwx5iVYhtUwP1/3OtoBy/H27rhgFG/
         Ed+PpArcvFLN6Ht+GTTGxyh8uOaSLt41Kvf7B0JFdwv9DQjApc3kdUENHyOjdqTs3vJy
         GEK+AwY1GOQ4/uOIMMUW1vU/VqmDZIvbhCUwVHzv3izyfFV+xG0qY7DH/vQWReT7GX5M
         jvoqDg4yM5jjh2WI38ToOFnWAwEYAwFdKHQelSRmfiECasVibrxyPnSn1G5GSyxY9rfo
         BKJHjqQWUcBG+dVahI7C+3HhcurT0nIpFbCFWkOtqLymVyeq3Knwn1kiFZAhKR6soAs2
         hvpw==
X-Gm-Message-State: AKGB3mIfDBXqn8dtZGoaoT8bsFwqYU+Ul9xvlck4SsTWpNeca4OefBwV
        gkR/zZj5odyIZQv781VK2byIwQUdPPvIFc9M/tg=
X-Google-Smtp-Source: ACJfBotMK3jmeHOL2rtG+kbfosOGL2qxXsKrP0vYPh2WIbovrYTWdp3BakGBFGr9SgQJLo/32R4pmjWbcNTysFcYObE=
X-Received: by 10.107.164.147 with SMTP id d19mr10505209ioj.204.1513808516860;
 Wed, 20 Dec 2017 14:21:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.14 with HTTP; Wed, 20 Dec 2017 14:21:36 -0800 (PST)
In-Reply-To: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
References: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 20 Dec 2017 23:21:36 +0100
Message-ID: <CACBZZX7N+8yt2MsFJ7xsAQEMNkJvutX47VOED0SumsOzQK9tbg@mail.gmail.com>
Subject: Re: Usability outrage as far as I am concerned
To:     Cristian Achim <brancoliticus@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 5:40 PM, Cristian Achim <brancoliticus@gmail.com> wrote:
> All I will do is paste the stackoverflow question below. It covers the
> commands I made in chronological order and the way I would have
> expected git to behave differently.
>
> So I did
>
> git pull home_subfolder
>
> while in usb_subfolder. Can't remember the immediate output, but it
> included a part about two repos having no commits in common. Would
> have been wiser for git to just error out with a message that in one
> of the folders there is not git repository.
>
> At all times
>
> git status
>
> in home_subfolder gives
>
> branch master
> Working directory clean
>
> This is so stupid considering the circumstances.
>
> Doing again
>
> git pull home_subfolder
>
> at all times from usb_folder now returns U in front of 2 files in
> home_folder and A in front of another file and then says
>
> Pull is not possible because you have unmerged files
>
> Had the bright idea to do
>
> git clone home_subfolder
>
> from the usb_subfolder because of my worries going away when
>
> git status
>
> in home_subfolder conforted me that there must be nothing bad about
> the situation. Therefore I suspect that now doing
>
> git pull usb_subfolder
>
> from home_subfolder will do the same broken result as above.
>
> I do not want to resolve merge conflicts because git doesn't error out
> with a sane message of the situation when it should. I just want to
> get the home_subfolder and usb_subfolder repositories state to where
> it was before my breakage generating git pull and git clone commands.
>
> Ubuntu 14.04 64 bit, git 1.9.1.

Hi. While I'm sure you'll still find some fault with git's UI could you please:

1) Try to see if the latest git version (or some approximation) fixes
some of this, as you said you're on 1.9.1 which was released in 2014,
there's been a lot of UI work since then, including some that by my
reading of your mail should address some of your concerns

2) It would be really useful if you could distill the complaints you
have down to some sequence of commands to run, preferably just a small
shellscript with comments saying "the message at this point is bad for
such-and-such a reason". I may have just misread what you said (or
maybe it's since been fixed), but per my reading we're already doing
some of what you've pointed out we should be doing, and if not maybe
that's because I'm not imagining how you're running git exactly, a
reproducible recipe would really help.

Thanks.
