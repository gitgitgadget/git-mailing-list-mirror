Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B009320A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbeLNVW2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:22:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34290 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeLNVWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so6810782otk.1
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qjOtf4/Y5ivTM0zn8LOO8UbhQf2pEvzMQbtpkfjmF7U=;
        b=eg1u8kCHO3KFNN39YotP6Ow2lVzJk2BHj6yP0Kn3MtS+JfkJPSN5hUrKhG7ZKOLCfu
         iGYm1XkbGTilFfmcvMrr4+h25ZK1zxW1/AR5xLTCbHjdFAnrcU3iSnDf7MRCQp7KYmaK
         w6Ur3qa8vuDJ1YIdzIS0T4XpyPW1lv9ci514476lSB6Vcfu0PqMHhP0yz/auKv8aJwA5
         xhwLl9YS7eCMujzL1JlM6By1ok9fSjWbvXb1tyntM3MZJbIfVfxbS3HWa1KmKosenIzt
         ald4MMxyztCBksAKmFyYhTdTZ2fAz/meD1TwnfPm7XdJrrRWcYRG9mDV2HVIBD4SGMwQ
         WY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qjOtf4/Y5ivTM0zn8LOO8UbhQf2pEvzMQbtpkfjmF7U=;
        b=j5/tU0Si0d6ForPV2E6UCGZtifg4AOfoMtw+WFfaROUmU4jfbEGDWTprKP/tBonQru
         v59Kqa9YBmJ1+k7GdIxjcQY2UjcyyjXuwF550DjPzhB91Q2zDDKLQRWcaDTiJxqJRlho
         gUjwYcF0XKwVqmhOMQuNIyC63FfuFd8QxszV1eCx8aiuv++cCnyL7JBjRysHEMbMWZ8u
         U+Vn32Qu+nvttJGrYb5kOZurwncL6VOad6f3gIFKv9HHDc1uX7jRdlq83vbePb/pqA0g
         PFmnqs1IWZsXHJm5CJiVNolisi265j7guashITmumzXI0MlTcf/m07rxKOqtGtG9FM67
         67kQ==
X-Gm-Message-State: AA+aEWYAcWKDg08yogcSCSJgahQL7nuCkR7SVHgk7qBEB6BymjhZumY0
        nOPj2ebrE4FjORdTmB8rhZMwmeySVpjiYd2V2Bo=
X-Google-Smtp-Source: AFSGD/XsjfbxhoUSjeu/litI92wG1C4uOoR/EUFk+C6AL/mcdOln8QMr2Meysf38ZOSu/RvaYjfqhXcbC7P/o2CK220=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr3128304otq.348.1544822544222;
 Fri, 14 Dec 2018 13:22:24 -0800 (PST)
MIME-Version: 1.0
References: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
In-Reply-To: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Fri, 14 Dec 2018 16:21:46 -0500
Message-ID: <CAJdN7KitOpH=WFJW2SgU8mt75pFzF2mhD0TrCkyfnYugRdTkxw@mail.gmail.com>
Subject: Re: Bug in lineendings handling that prevents resetting checking out,
 rebasing etc
To:     the.ubik@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 4:08 PM Mr&Mrs D <the.ubik@gmail.com> wrote:
>
> Hi all,
>
> I maintain a python project you can clone from:
>
> git@github.com:wrye-bash/wrye-bash.git
>
> For reasons unknown git sees a particular file as changed
> (Mopy/Docs/Bash Readme Template.html, sometimes others too). This file
> was probably committed to the svn repository this git repo was created
> from with CRLF line endings. When we moved to git we added a
> gitattributes file (
> https://github.com/wrye-bash/wrye-bash/blob/dev/.gitattributes ) and
> this file was edited to explicitly state htms are text - all to no
> avail. From time to time - on windows - as in when checking out an old
> commit - git would see that file as changed. The only workaround that
> worked for me was
>
>     git rm -r . --cached -q && git reset --hard
>
> For more details and discussion see this SO question I posted almost
> five years ago:
>
> https://stackoverflow.com/questions/21122094/git-line-endings-cant-stash-=
reset-and-now-cant-rebase-over-spurious-line-en
>
> I used to work in windows and the bug was tolerable as there was that
> workaround. Now I moved to mac and no workaround works anymore - we
> have a special page on our wiki  with workarounds for this one btw:
>
> https://github.com/wrye-bash/wrye-bash/wiki/%5Bgit%5D-Issues-with-line-en=
dings-preventing-checking,-merge,-etc
>
> Well after 5 years and countless hours trying to solve this I reach
> out to you guys and girls - _this is a full-time bug in git line
> endings handling_. When someone issues a git reset --hard this should
> work no matter what - well it does not. So this bug may be really a
> can of worms.
>
> Please someone clone this repo on linux or mac - probably just cloning
> will have the files appear as changed (by the way hitting refresh on
> git gui I have different sets of files appear as changed). If not then
>
> git checkout utumno-wip
> git rebase -i dev
>
> and then select a commit to edit should be enough to trigger this bug

Does not reproduce on git 2.20.0 (mac high sierra fwiw). What version of gi=
t
are you using?
>
> Needless to say I am  well aware of things like `git add --renormalize
> .` - but renormalizing is not the issue. The issue is that _files show
> as changed and even a git reset --hard won't convince git that
> nothing's changed_.
>
> $ git reset --hard
> HEAD is now at e5c16790 Wip proper handling of ini tweaks encoding - TODO=
s:
> $ git status
> interactive rebase in progress; onto 02ae6f26
> Last commands done (4 commands done):
>    pick 3a39a0c0 Monkey patch for undecodable inis:
>    pick e5c16790 Wip proper handling of ini tweaks encoding - TODOs:
>   (see more in file .git/rebase-merge/done)
> Next commands to do (19 remaining commands):
>    edit a3a7b237 Amend last commit and linefixes:  =CE=95=CE=95=CE=95=CE=
=95
>    edit 432fd314 fFF handle empty or malformed inis
>   (use "git rebase --edit-todo" to view and edit)
> You are currently editing a commit while rebasing branch 'utumno-wip'
> on '02ae6f26'.
>   (use "git commit --amend" to amend the current commit)
>   (use "git rebase --continue" once you are satisfied with your changes)
>
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working director=
y)
>
> modified:   Mopy/Docs/Bash Readme Template.html
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
> .DS_Store
> .idea.7z
>
> no changes added to commit (use "git add" and/or "git commit -a")
> $
>
> I really hope someone here can debug this
> Thanks!
