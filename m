Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC721F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 15:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbcHUPcU (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 11:32:20 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:32966 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcHUPcS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 11:32:18 -0400
Received: by mail-yb0-f170.google.com with SMTP id a88so3982653ybi.0
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gsr0Ttz0RODCQO2GYqOB4So3FQ/mxmOG7O3qjqa+7Qg=;
        b=WhYy+YTb7bfSOnYiDpIK3OD8LM/EA0qtO71cZu8YhjqxHHzKSswN2lDmO8nny5lCK6
         kYMPRwFhAqk9ENe/1tSHmmud/Y883s9lrXRgtWju4Nsq4Lvwim96LxmsuGzT9ifkrs3b
         XEwXWkhekjTO4U+N4NMVQ/pIllRpN877a9U7W08Tl6YNqoiPcyT+Pf1zG1uQKfw1KUmf
         jiXAiOVOrgm8VufOjU/YGfyCS6t7vdFc/gEFQ5vwL9JozVt7Oa+BDlWsg5GSpzOM5J2B
         30Ki8Smk8skCkfiWAM80JpUrW/sWgUL2z05koJiVB8ehW6xCwW5J5SQWfTkZ92U8t98o
         M1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gsr0Ttz0RODCQO2GYqOB4So3FQ/mxmOG7O3qjqa+7Qg=;
        b=PAwmhn4tavgDDly+3ZiLr4n7Rh3czyyw1WFx1JJ6NX2LlLa28cN6+QpiyP16bDNXqq
         ag0f+ChfVFV1DwxtySUt94gK2IIv9HnU34aKEme5oGNW62djxG/76gW7Mc2drHDeJe5Q
         nM4GGgSHidWTy+NdzBCZrtwe9WpsCR+J2E7pFTbKkF4a6uQNU4mWyJNMkzlr3JzpqfK5
         USCHdXTkycHhSVWJtA96M1Z8/YFT9o1kEjrDLVqe6HXBQH8aUhZ4XOWz6/XLTVN3gWQu
         TmoShQyz0IVtQuh+hFbGJYoxvRcpyWGucbLfRicJNIpRFPpyi0oVchZOxP25Do3uCi1S
         r61g==
X-Gm-Message-State: AEkooutwNJ3PNnrofY7ZqxCa7v8ItJpk5cY8aJA8cpWt+3yd1Y+Qr3hWfFWkE822ZbGMrii4/zxIQZR4M0V2OQ==
X-Received: by 10.37.215.16 with SMTP id o16mr2384263ybg.21.1471793537783;
 Sun, 21 Aug 2016 08:32:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sun, 21 Aug 2016 08:32:17 -0700 (PDT)
In-Reply-To: <201608211519.u7LFJiMR090069@shell1.rawbw.com>
References: <201608211519.u7LFJiMR090069@shell1.rawbw.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 21 Aug 2016 21:02:17 +0530
Message-ID: <CAFZEwPP=d6fN4MC09JGm4neY5MuXv1JBzx87HC+8=XjEp=DS_w@mail.gmail.com>
Subject: Re: Editing a typo in the message given to "git commit"
To:     Norman Shapiro <norm@dad.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Norman,

On Sun, Aug 21, 2016 at 8:49 PM,  <norm@dad.org> wrote:
> I am learning how to use git. I would like to know:
>
> How can I correct a typo in the message I gave to an old "git commit"? I see
> that the typo occurs in exactly two files in .git:
>
> .git/logs/refs/heads/master
> .git/logs/HEAD
>
> /usr/bin/file says that they are both ASCII English text. So I could just
> hand edit them. But that seems somehow sacrilegious and might break git.

Messages to commits aren't just stored in these two files.
Hand editing them will definitely break git and its highly advisable
not to do that. In fact, for beginners its highly recommended to never
visit the ".git" folder. What you need in this case is `git-rebase
-i`. Using that you can go to the commit where you want to edit the
message and mark it as "reword". Also if you want to make some
modifications in the code, then you can mark it as "edit". Try `man
git-rebase` for more info on the command.

Also on a side note: This is a developer's mailing list. Please try to
use the user's mailing list[1] for doubts. But if you have a doubt as
to why this commands functions in a particular way (in which you think
it should not) or you find a possible bug then feel free to discuss it
on this mailing list. Also to save other people's time, first search
for the doubt in the archives or google about it.

[1]: https://groups.google.com/forum/#!forum/git-users

Regards,
Pranit Bauva
