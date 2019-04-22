Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9D41F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 17:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfDVRrf (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 13:47:35 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34305 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVRre (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 13:47:34 -0400
Received: by mail-ed1-f42.google.com with SMTP id a6so10112654edv.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=BFhPnZ+PsDISt6xW6esKV+o5RGhkxAF5cah4Xtkix9s=;
        b=WUxOceE9knuGyPKcMfr/lGTg5HB85aml5qGK3obqlFMbze9HdM2YLp7KeYurrAmZeC
         dpylAY1dkgYwwDc1r6YTL+aYC3n0nWcsPcaHCoaRojXjTLnat9buAwZWTPIYg2COI042
         NRJeOaNByzD4JBXmzdc9GjXAv3VOJsX59PVGLMP+HTOdKSxCMcvSCRyLrrTBf+y019y7
         poBn4V1my1xSmn623SLbrIAJP4W8GamvcBke6F+6Ilzifu3Bhi8U4TYo/hRsYv9i3+FO
         vDuisSYfoq9vh6uG2wzD0OL/U1xea51TgbTMENQTyNDilLT0AdqrauTLtIQqSZDHYlxh
         SEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=BFhPnZ+PsDISt6xW6esKV+o5RGhkxAF5cah4Xtkix9s=;
        b=IKRjvCRhyP+PCicBHn1aWt5SyMiIq0/ALUcA2RFepAUNOiVDYkcrk6LhGs3KgYqwMn
         Ge9E2QfILIP0jLZ8JkUak51n6/GJnqik/JsyDyB4lOGX9hcWXvG91pjoHhlgVQxO8f5J
         8Vf0Rd3wjLJK+ubkRXtcnkZ5PTHFNAJMHVT3VFbKfZcUARYiL3SmmjFnQL/4NoW2GOBo
         Ik0vL0vOLkywzhY+dH5CeDCw/5kcOzfrxcG0aHCt3XCPfQM3dRvjhJoW7Kzg39RD/Fvt
         BTNkuhnn0VjjTRqyJfZBrm/f1Agz6kHq92fqPKNxuIBr3U84Gv3hyEryS5vGh0e5y2Fa
         eaGA==
X-Gm-Message-State: APjAAAXkOuOTq8reuLpr4tFkYcefpgfHH43tWXlkob1WUbZkGqbgW3vH
        dgPgxmRxwTIgyOeZi+f+1fo=
X-Google-Smtp-Source: APXvYqxmTm/MjczqgitjZ07jahOXZtzNzLIdlgQUFX4t7wDpAdWPyO+4f9aqC1yTsAKmWYc0xUtHrQ==
X-Received: by 2002:a17:906:18a2:: with SMTP id c2mr10270734ejf.9.1555955253172;
        Mon, 22 Apr 2019 10:47:33 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id q12sm2332421eja.45.2019.04.22.10.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 10:47:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrew Janke <floss@apjanke.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: gettext, multiple Preferred languages, and English
References: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net> <CACsJy8C1w0zJm71KFb21MC+c2NAGnRLDtE3KNK21hO7U4Ax7Hg@mail.gmail.com> <9d7a2fb4-8bab-2d28-1066-fbace688a5cc@apjanke.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <9d7a2fb4-8bab-2d28-1066-fbace688a5cc@apjanke.net>
Date:   Mon, 22 Apr 2019 19:47:31 +0200
Message-ID: <875zr6szik.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 22 2019, Andrew Janke wrote:

> On 4/21/19 8:35 PM, Duy Nguyen wrote:
>> On Sun, Apr 21, 2019 at 6:40 PM Andrew Janke <floss@apjanke.net> wrote:
>>>
>>> Hi, Git folks,
>>>
>>> This is a follow-up to https://marc.info/?l=git&m=154757938429747&w=2.
>>
>> This says the problem with "en" detection has been fixed. Would
>> upgrading gettext fix it?
>>
>> You would need to upgrade something (git or gettext) and if it's
>> already fixed in gettext I don't see why we need a workaround in git.
>
> From reading the bug report, that does sound like it would fix it. But
> from what I can see, that fix hasn't made it out into a released version
> of gettext yet. I haven't downloaded the development gettext to confirm
> the fix.
>
> Looking at the gettext ftp site at https://ftp.gnu.org/pub/gnu/gettext/,
> it looks like gettext does not make frequent releases, and the last
> release was two and a half years ago. Who knows when the next release
> will be. And then it'll take longer to trickle down into Linux
> distributions and such.
>
> From your release history at https://github.com/git/git/releases, it
> seems like Git is a lot more active in making releases than gettext. So
> including this fix in Git would get it into the hands of affected users
> sooner. And it seems like a pretty low-risk change to me.
>
> Then once the new gettext release is out, their fix is confirmed, and it
> makes it out into common distros, the workaround could be removed from Git.

What does Linux distro release schedule have to do with this? Your
initial report and the linked-to bug on GNU savannah only talk about
this being an issue on OSX. Is there some more general issue I'm
missing?

People have reported issues with OSX's weird language selection in the
past. I think it makes sense to do whatever we need to hack around it as
long as it's some well-understood and OSX-only hack.

I'm paranoid that the suggestion of adding an en.po *in general* would
break stuff elsewhere. I'd be surprised if the project linked-to
upthread that used that hack is as widely ported as we are, and that
includes a lot of i18n implementations, not just GNU's.

Ultimately setlocale() is *supposed* to be a well-understood thing. You
set your preferred locale, programs have translations, the OS takes care
of it. I'm concerned that us trying to be specifically smart in git will
backfire (e.g. it's been suggested in the past to have core.language or
whatever..).

But it looks like we don't need to go there, this seems like a
workaround needed for some specific OSX version.

That can just live behind a flag and be detected in config.mak.uname,
no? And then we'd do whatever hack digs us out of that specific hole on
OSX, e.g. maybe generating an en.po *just* there, and just for that list
of known broken version(s) of OSX.
