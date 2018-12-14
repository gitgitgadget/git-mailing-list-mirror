Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_FM_MR_MRS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0007E20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbeLNVdd (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:33:33 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35818 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbeLNVdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:33:32 -0500
Received: by mail-yb1-f196.google.com with SMTP id z2-v6so2864675ybj.2
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fCI6xcXWTo9Kkcr9Hd5CqwsEL1nCjpE8tA3DuN3Q3Fo=;
        b=AmAl9dtQ9ugjihnZ4fGXBlLwlshksmUhbU4aQlIZgV+WxIQ6FnKLf1l1kmteJFq9UD
         iHQ9ZGCE6wYMK2VDrUm/JBKd1ZvzqeUEbiE7y7E2EOvf5QJqhsW+DYNdnxkbQ0QZ6KWW
         JiiOx0ZjvV8KsfLpZd6Ausi1K/W86kdyXaDWErvsz4ca/ivmKDejpJjPLjn97Sg5BsSy
         Kblsbh6jHfISIoe1KQwxLSjpx29VyXV9Fr1MBgn/2JyJITo7lxbrneIm/3ykwu/Hrl9N
         fHiIhOcku+9W8E2yHMf9KBhJX+CjaK0U5xpcAIGSPpL6J2d2akZo1ej68kVgfsDLeDPQ
         xr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fCI6xcXWTo9Kkcr9Hd5CqwsEL1nCjpE8tA3DuN3Q3Fo=;
        b=jgjt3SxEIR9C55ucCCZ7JA7MbL+vt2k/JE9DZ2l0zRePs3e8j5d3Uim+XV4H1KXbjs
         wJ+11MHf6fSrnGAV2tDPWQu0rbQwIu7hdeio6lf+CrS/HEcLL7fxHV/92WeCDWY7sCu1
         33nhyF7gZNtxkyYlnjLLkqN2L0sAEznGgnaz0v+gK5PAGvXZFWZW03sijXjCbZlTso32
         jlG0wHoIPEbBfHjOjAyl2/CKU/onZrczjINuFAGE8ZCakPLfmw8pezpxzlNchzRzC67W
         I7ZQRZfKeFVEcRbWp/sZB6+Xfz+4/9kxOkBVbf+VGocdTw7pdj01gLEvUSMclX8tCh6k
         NCaA==
X-Gm-Message-State: AA+aEWaMGbpBA6L+v1QlYvpCEWHlw3gZ2UE8s589XXj3o1R1Gnb8xULC
        bTFFLqlqcJn6fk6RZ7EBk3+41SvpCajPrO6Ll2I=
X-Google-Smtp-Source: AFSGD/VD555k/7gk4EqNbBzpqLthYI1THnK2iZN0NXtfiQW8s+956Owu+vLsTdNJQUxebP4AXUjChdNPjZk61ADVn+s=
X-Received: by 2002:a25:185:: with SMTP id 127mr4795946ybb.41.1544823211423;
 Fri, 14 Dec 2018 13:33:31 -0800 (PST)
MIME-Version: 1.0
References: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
 <CAJdN7KitOpH=WFJW2SgU8mt75pFzF2mhD0TrCkyfnYugRdTkxw@mail.gmail.com>
In-Reply-To: <CAJdN7KitOpH=WFJW2SgU8mt75pFzF2mhD0TrCkyfnYugRdTkxw@mail.gmail.com>
From:   "Mr&Mrs D" <the.ubik@gmail.com>
Date:   Fri, 14 Dec 2018 16:32:54 -0500
Message-ID: <CABRG_PHC+iufcv2j4CMLHioBZ7sea5qvYzsohzxDaiGwEW0R1g@mail.gmail.com>
Subject: Re: Bug in lineendings handling that prevents resetting checking out,
 rebasing etc
To:     john.a.passaro@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git --version
git version 2.19.2

Mac os mojave

Hmm the latest version here: https://git-scm.com/download/mac seems to
be this one - where do I get 2.20?

Thanks!
On Fri, Dec 14, 2018 at 4:22 PM John Passaro <john.a.passaro@gmail.com> wro=
te:
>
> On Fri, Dec 14, 2018 at 4:08 PM Mr&Mrs D <the.ubik@gmail.com> wrote:
> >
> > Hi all,
> >
> > I maintain a python project you can clone from:
> >
> > git@github.com:wrye-bash/wrye-bash.git
> >
> > For reasons unknown git sees a particular file as changed
> > (Mopy/Docs/Bash Readme Template.html, sometimes others too). This file
> > was probably committed to the svn repository this git repo was created
> > from with CRLF line endings. When we moved to git we added a
> > gitattributes file (
> > https://github.com/wrye-bash/wrye-bash/blob/dev/.gitattributes ) and
> > this file was edited to explicitly state htms are text - all to no
> > avail. From time to time - on windows - as in when checking out an old
> > commit - git would see that file as changed. The only workaround that
> > worked for me was
> >
> >     git rm -r . --cached -q && git reset --hard
> >
> > For more details and discussion see this SO question I posted almost
> > five years ago:
> >
> > https://stackoverflow.com/questions/21122094/git-line-endings-cant-stas=
h-reset-and-now-cant-rebase-over-spurious-line-en
> >
> > I used to work in windows and the bug was tolerable as there was that
> > workaround. Now I moved to mac and no workaround works anymore - we
> > have a special page on our wiki  with workarounds for this one btw:
> >
> > https://github.com/wrye-bash/wrye-bash/wiki/%5Bgit%5D-Issues-with-line-=
endings-preventing-checking,-merge,-etc
> >
> > Well after 5 years and countless hours trying to solve this I reach
> > out to you guys and girls - _this is a full-time bug in git line
> > endings handling_. When someone issues a git reset --hard this should
> > work no matter what - well it does not. So this bug may be really a
> > can of worms.
> >
> > Please someone clone this repo on linux or mac - probably just cloning
> > will have the files appear as changed (by the way hitting refresh on
> > git gui I have different sets of files appear as changed). If not then
> >
> > git checkout utumno-wip
> > git rebase -i dev
> >
> > and then select a commit to edit should be enough to trigger this bug
>
> Does not reproduce on git 2.20.0 (mac high sierra fwiw). What version of =
git
> are you using?
> >
> > Needless to say I am  well aware of things like `git add --renormalize
> > .` - but renormalizing is not the issue. The issue is that _files show
> > as changed and even a git reset --hard won't convince git that
> > nothing's changed_.
> >
> > $ git reset --hard
> > HEAD is now at e5c16790 Wip proper handling of ini tweaks encoding - TO=
DOs:
> > $ git status
> > interactive rebase in progress; onto 02ae6f26
> > Last commands done (4 commands done):
> >    pick 3a39a0c0 Monkey patch for undecodable inis:
> >    pick e5c16790 Wip proper handling of ini tweaks encoding - TODOs:
> >   (see more in file .git/rebase-merge/done)
> > Next commands to do (19 remaining commands):
> >    edit a3a7b237 Amend last commit and linefixes:  =CE=95=CE=95=CE=95=
=CE=95
> >    edit 432fd314 fFF handle empty or malformed inis
> >   (use "git rebase --edit-todo" to view and edit)
> > You are currently editing a commit while rebasing branch 'utumno-wip'
> > on '02ae6f26'.
> >   (use "git commit --amend" to amend the current commit)
> >   (use "git rebase --continue" once you are satisfied with your changes=
)
> >
> > Changes not staged for commit:
> >   (use "git add <file>..." to update what will be committed)
> >   (use "git checkout -- <file>..." to discard changes in working direct=
ory)
> >
> > modified:   Mopy/Docs/Bash Readme Template.html
> >
> > Untracked files:
> >   (use "git add <file>..." to include in what will be committed)
> >
> > .DS_Store
> > .idea.7z
> >
> > no changes added to commit (use "git add" and/or "git commit -a")
> > $
> >
> > I really hope someone here can debug this
> > Thanks!
