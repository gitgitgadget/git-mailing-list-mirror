Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D87620248
	for <e@80x24.org>; Tue, 26 Feb 2019 15:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfBZPcS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 10:32:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35174 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfBZPcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 10:32:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id p19so6413087plo.2
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 07:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=djsbx-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=/5vVPCS1xRbu9HMLJ80OdbuCWPL0alQxHTqpkVxK6iA=;
        b=BAMrhlXMLHwM3yIrrUSa0UB6IRq9LYWOBoAhWganATBVdFPq5XObqC5h5iQODotvmE
         AzzyyNrCwDrHoCpjv0uYY2fR8P4GPftV3uAsnxp5QT7NTP7fgbdr+VbgUJddgtFsdmhC
         /PmngxLQjZ8WWCXZmsdO7el8JCZj8mA9pMs/1v7r/YOVdjbo/RGF0u7aZQQ305+qkNR6
         L90Hy4eu91z284ij6J94yqsrvMVqgqzjcWeygeNzWGQv3fTnxAip4B3ro831wQXzZp3M
         PhAGppfsDk2+83NNOXsHmCCoiQQGm6neVtYYtxKodqiLTkRU0TCdgVI6XA0tieC0ejB6
         26RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=/5vVPCS1xRbu9HMLJ80OdbuCWPL0alQxHTqpkVxK6iA=;
        b=iUbMbEC85P+BFak8YA6Xy+tVzEdSmXc+Ezl/6TEQYrbImVmEuA0dA8OppS47CHDUBJ
         4w5apewsLphUYhUe66n4MAhB3Cd+N0REmoEUZ9NfYnjGOfXJd5T2HGv2WhOTF3a797pT
         Yy0MiJyWZEyiT5egK5b88Gc5k3EJZDJvMpg6CFmmhDJqZHTmS5BJeZfCvN5I8V1Pjcdj
         OFpysBk8rAZjd8tHPOy5D5zTILjGbE18LGNC8Cdhe4/qgLdGHzFwKjSkMq3ZZFeMaeFq
         KvAq7d9/UKhdrzomWATK0OKMkBvwbw/k2RdukTIqEdi/BpiXP8U931tqMXTIru0LXlif
         W7FQ==
X-Gm-Message-State: AHQUAuadOazrm+I1jAGkMCNtzAHnBR0JIO9XivfLBp4vmFMUUk8A8vye
        7EwFETqWocs7eK3ANEKpXvcz0VxfDDtc71Xb0UEOqMwJlhnSwg==
X-Google-Smtp-Source: AHgI3IYee2X90GT5I0dw5tzfPxMdwHWidY4yUrGNedUgZsU53g6AiDL7IEckc1PMOW3chlXRquc62+mzeVZhkmmIBPg=
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr16298672plb.258.1551195137343;
 Tue, 26 Feb 2019 07:32:17 -0800 (PST)
MIME-Version: 1.0
References: <CANFDZM6PikancjUdm+HYgGknD0dPhzxU6yOYFLZpcnCmg8JKdA@mail.gmail.com>
 <CANFDZM7fsbwwqhyWTzfivm4L=GgtCMfCi+DekZurs+SFGqaOjw@mail.gmail.com>
 <CANFDZM5=ffu-=H=vrO3Kr0t2km-3Zg4=msYUWqqJQKGxGojnqA@mail.gmail.com> <31924311549922691@sas1-d856b3d759c7.qloud-c.yandex.net>
In-Reply-To: <31924311549922691@sas1-d856b3d759c7.qloud-c.yandex.net>
From:   Fernando Chorney <djsbx@djsbx.com>
Date:   Tue, 26 Feb 2019 09:32:06 -0600
Message-ID: <CANFDZM68A96YprMKhaHNfPRAtK18ad6Bo9=uesxHN=-tLONn=g@mail.gmail.com>
Subject: Re: git commit --verbose shows incorrect diff when pre-commit hook is
 used to modify files
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hmm looks like I forgot to send my reply to this back to the mailing list.

"Hmm, so I currently have it set to run vim as my commit editor, and
enter the message in there most of the time. I can definitely see
output from the hook into the shell before my vim editor loads up that
shows me the diff and lets me add in the commit message. This leads me
to believe that the pre-commit hook is being run before the editor
(with the diff) pops up."

Does anybody else have any insight to this issue?

On Mon, Feb 11, 2019 at 4:04 PM Sergey Lukashev <lukashev.s@ya.ru> wrote:
>
> At the time you see the diff the committing of changes has not yet been initiated. It's only after you type in the message that the ACTUAL committing starts and the hook runs.
>
> You can print the diff of what your hook has changed by running "git diff" in it before adding changes.
>
> 12.02.2019, 00:28, "Fernando Chorney" <djsbx@djsbx.com>:
> > Hi,
> >
> > I am trying to use a pre-commit hook to modify files before they are
> > to be committed. The problem I am running into is that if I use "git
> > commit --verbose", which I often do so that I can see the diff, the
> > diff it displays in the editor is the diff before the pre-commit hook
> > was run rather than what the diff would be after the pre-commit was
> > run.
> >
> > I would like to note, that the pre-commit hook is definitely running,
> > but when git grabs the diff seems to be in the wrong place.
> >
> > I have set up a simple example on my github to show the problem.
> > https://github.com/fchorney/pre-commit-example
> >
> > Is this intended behaviour, or perhaps an issue?
> >
> >  Thanks,
> >  Fernando Chorney
>
