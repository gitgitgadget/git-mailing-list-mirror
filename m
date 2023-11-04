Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222241E511
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G24kbVGL"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EAADE
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 15:06:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-408425c7c10so24446975e9.0
        for <git@vger.kernel.org>; Sat, 04 Nov 2023 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699135577; x=1699740377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puIyt7ATCqKSzJuSo3wQmgfV+z1DB1brb3UdgUUOaM0=;
        b=G24kbVGLXHaW6ab9oJFhS0Z+t16ylX/o/IrB4UcwWfDYsEomXU7C4Jzb+0YgQsAY3N
         8MQOVdP5oP2+V9tJ2Ei2A3B9fxkY4ErTTf168s6tF++yRBQopwnEHI0kC30DiyKxvKUw
         ASUGfPEjtnkMSOAmIYFf0jiY6FIDc6liZ7gx3iNcv9S5wc6exNOeuy9gi1lYzB4Pzgjb
         tQGJYYlwAF+qQ40LQNGWV030V5dOGm3Bdk0PnFXw70KE7Ygi5VKIrcGyupT245AoPyUr
         HRWo4TVHTCgMyQzZB+g/l+CGN9WMP3TpdfF8VuWL+TMB2aFl5JdAn7AqsnUDI7oMxuqQ
         nyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699135577; x=1699740377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puIyt7ATCqKSzJuSo3wQmgfV+z1DB1brb3UdgUUOaM0=;
        b=c/g4hsVFL1ka0a5cZzpAPZiHpPvBmhrSgrwnyenwF0qPRb6di2H+cwdUJqG/biXE5i
         WvyjTkk4XSobxFR/AiWThcq31TMyNgYjkdgfF5eXthWhfOtB1HGQGaXh3K6bEGCdGg5a
         2DhUDOPsGV1qYNlCKJnVfFQNxSlAQgjolFamc+HLBR9q1HyvZP8XwgM2Fg3q/P2E3Sc6
         8ZIpVuaB9uE5eCIO+fFTRjipaJWBtpLw18u3uALGtmiFW2lXN4wckhVbHlJWDdkxG5/5
         X7vQ0MTocGJNf+ikPbFWI5zz+vsBswjJ6qEzrAKZoXfpcX2wvQStFUabMGbJF0nSUppO
         1MOg==
X-Gm-Message-State: AOJu0YyVrvkdOfg275iSDvLmupLheNRyO1xF0lQ7VtwIp1Qzn6y+8t30
	8zot4fO6gbJmQT5bsMNPTResu7Zp2oJZm2Uy6qY=
X-Google-Smtp-Source: AGHT+IHl0T4RbHu3P9hQlqZ7F/fLIeAATlfkixc77Xtn4Q0iPA+Dcf00R91sJ3umgLFdNjaPwSZ4msTE5/BbQmttFsM=
X-Received: by 2002:a05:600c:4f55:b0:408:3707:b199 with SMTP id
 m21-20020a05600c4f5500b004083707b199mr19470463wmq.3.1699135576485; Sat, 04
 Nov 2023 15:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC7ZvybvykKQyMWcZoKXxFDu_amnkxZCDq2C6KHoyhmHN2tcKw@mail.gmail.com>
 <CAC7ZvyYGSa-sH1LZ8Lo=NRXbvJsujgFYGPOQR5ZwGHJHZgoDzA@mail.gmail.com>
 <orr5573q-7148-84ro-9rpq-nr7411s894r9@tzk.qr> <CAC7ZvyaQpYiVAszu_Oe5UoKgpe48dRJ8i1O8hLNOSo3UXfPVug@mail.gmail.com>
In-Reply-To: <CAC7ZvyaQpYiVAszu_Oe5UoKgpe48dRJ8i1O8hLNOSo3UXfPVug@mail.gmail.com>
From: Kache Hit <kache.hit@gmail.com>
Date: Sat, 4 Nov 2023 15:05:40 -0700
Message-ID: <CAC7ZvyacrYUmJ6sr3YVqevM0zB9W1yQb65uHFwrevBy2K5fmjA@mail.gmail.com>
Subject: Re: BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just reporting that I ran into this again, this time with some info to
help repro, though the issue may be fixed already.

I managed to avoid it by turning off core.splitIndex, so I'd suspected
the setting conflicts with feature.manyFiles.
It could very also be/instead conflict with fsmonitor that I also use,
as mentioned in the similar/related thread:
https://public-inbox.org/git/xmqqbkhv6dw3.fsf@gitster.g/T/#m13a5ad383f040bb=
3a6be7641bd04aa20424a274c

Which references a splitindex & fsmonitor bug that's since been
addressed since 2.41:
https://github.com/git/git/commit/3704fed5eae8ca2fa20bcf6adb277ee83b012ce0

On Mon, Aug 22, 2022 at 9:53=E2=80=AFPM Kache Hit <kache.hit@gmail.com> wro=
te:
>
> Hi,
>
> I've not been able to successfully repro this after managing to
> recover from it by rebuilding the index:
> https://stackoverflow.com/questions/73044253
>
> I'm sorry I couldn't be more helpful.
>
> On Fri, Jul 29, 2022 at 8:59 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Kache,
> >
> > On Tue, 19 Jul 2022, Kache Hit wrote:
> >
> > > A thought: the 179457 is reminiscent of something else I did just bef=
ore this:
> > >
> > > I was doing some "code archeology" and was headlessly checking out
> > > some old SHAs in this large monorepo.
> > > During checkout, it said it was updating 174823 files in total.
> >
> > Do you think it would be possible to whittle this down a bit, and maybe
> > attempt to come up with a reproducible example? Something like what is
> > described in https://stackoverflow.com/help/mcve.
> >
> > If all else fails, and you _only_ manage to reproduce it in the origina=
l
> > repository, could you at least try to figure out a reliable way to get =
the
> > Git index into the indicated state (if I were you, I would start off by
> > switching to the pre-rebase revision, deleting `.git/index` and then
> > running `git reset --hard` and then see whether the bug can be
> > reproduced)?
> >
> > Ciao,
> > Johannes
> >
> > >
> > > On Tue, Jul 19, 2022 at 2:36 PM Kache Hit <kache.hit@gmail.com> wrote=
:
> > > >
> > > > Hi. Output of git bugreport:
> > > >
> > > > ---
> > > >
> > > > Thank you for filling out a Git bug report!
> > > > Please answer the following questions to help us understand your is=
sue.
> > > >
> > > > What did you do before the bug happened? (Steps to reproduce your i=
ssue)
> > > >
> > > > Wanted to retain git tree structure when pulling latest and rebasin=
g.
> > > > First indication of error was the `rebase -r` of the merge commit
> > > >
> > > > What did you expect to happen? (Expected behavior)
> > > >
> > > > successful --rebase-merges rebase of my commits on top of master
> > > >
> > > > What happened instead? (Actual behavior)
> > > >
> > > > ```sh
> > > > =E2=9D=AF git rebase -r master
> > > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the inde=
x
> > > > (179457 > 1040)
> > > > zsh: abort      git rebase -r master
> > > > ```
> > > >
> > > > What's different between what you expected and what actually happen=
ed?
> > > >
> > > > Anything else you want to add:
> > > >
> > > > I'm currently "stuck" in this state, not sure how to recover or rep=
ro:
> > > >
> > > > ```sh
> > > > =E2=9D=AF git s
> > > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the inde=
x
> > > > (179457 > 1040)
> > > > error: git died of signal 6
> > > >
> > > > =E2=9D=AF git log
> > > >
> > > > =E2=9D=AF git d head~
> > > > error: git died of signal 6
> > > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the inde=
x
> > > > (179457 > 1040)
> > > >
> > > > =E2=9D=AF git log # works
> > > >
> > > > =E2=9D=AF git status
> > > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the inde=
x
> > > > (179457 > 1040)
> > > > zsh: abort      git status
> > > >
> > > > =E2=9D=AF git commit --amend
> > > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the inde=
x
> > > > (179457 > 1040)
> > > > zsh: abort      git commit --amend
> > > >
> > > > =E2=9D=AF git checkout head
> > > > fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File =
exists.
> > > >
> > > > Another git process seems to be running in this repository, e.g.  #
> > > > All of this was run while git bugreport was running
> > > > an editor opened by 'git commit'. Please make sure all processes
> > > > are terminated then try again. If it still fails, a git process
> > > > may have crashed in this repository earlier:
> > > > remove the file manually to continue.
> > > >
> > > > =E2=9D=AF rm /Users/XXXXX/YYYYY/.git/index.lock
> > > >
> > > > =E2=9D=AF git checkout head
> > > > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the inde=
x
> > > > (179457 > 1040)
> > > > zsh: abort      git checkout head
> > > >
> > > > =E2=9D=AF git checkout head
> > > > fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File =
exists.
> > > >
> > > > Another git process seems to be running in this repository, e.g.
> > > > an editor opened by 'git commit'. Please make sure all processes
> > > > are terminated then try again. If it still fails, a git process
> > > > may have crashed in this repository earlier:
> > > > remove the file manually to continue.
> > > > ```
> > > >
> > > >
> > > > Please review the rest of the bug report below.
> > > > You can delete any lines you don't wish to share.
> > > >
> > > >
> > > > [System Info]
> > > > git version:
> > > > git version 2.37.1
> > > > cpu: x86_64
> > > > no commit associated with this build
> > > > sizeof-long: 8
> > > > sizeof-size_t: 8
> > > > shell-path: /bin/sh
> > > > feature: fsmonitor--daemon
> > > > uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Tue Feb 22 21:10=
:41
> > > > PST 2022; root:xnu-7195.141.26~1/RELEASE_X86_64 x86_64
> > > > compiler info: clang: 13.0.0 (clang-1300.0.29.30)
> > > > libc info: no libc information available
> > > > $SHELL (typically, interactive shell): /bin/zsh
> > > >
> > > >
> > > > [Enabled Hooks]
> > > > pre-commit
> > > > pre-push
> > >
