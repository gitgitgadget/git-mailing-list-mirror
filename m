Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_FM_MR_MRS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EF91F405
	for <e@80x24.org>; Sat, 15 Dec 2018 20:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeLOU71 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 15:59:27 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42349 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeLOU71 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 15:59:27 -0500
Received: by mail-yb1-f194.google.com with SMTP id m129so3680125ybf.9
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 12:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zx5iqU2IQtf3Dq5XnqY4EznaVP4T5UUbKf1ARDuCgYQ=;
        b=E+X4DHljLbR3HAoZ6SRsRgwIXyAQCDWBamfmtPK4rQJyxrNO4HOrakY28awG+Ml+wS
         1h7JiSP0m88hc7qBQbFZO7z9qjMxrBG5rAsdpl6yggEA3DufOO9ft/B9SKPH02CiY2TB
         6YomQArJDUHONnplO3c/qFB9arwxWccnW5jJwpCnyrTLUiyCMKkZ0gOrf+Oy1oqs9blV
         raoiZ0m/sOW/llGjtVRvYPpwgj/0PaQv6Jdbs2ItTaGos76y+VNIaRH+1tQM5WaiCkNY
         dvLDGsCkXWbTuhNW9e+qdzSmbYGM33j1qTDEU0JE6XE74TLyRthva4Udw0dSY4bbj5M3
         xscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zx5iqU2IQtf3Dq5XnqY4EznaVP4T5UUbKf1ARDuCgYQ=;
        b=gPfACG2rDn85Itz/oVp+/APg85VVhc/55bQW2jdXqUVHgOEXTYtWH1Pu/VMQYFX+iJ
         UT+uYE8oSaML4p8YnRTjOdF28AEm5Px6GVnqD/TRWudJLJ+/TjbYniMwYuUYkwmdYV0z
         tOf99MWsfeU5NjfC4mY/YlePo4Iy90pjBCsbT0n9R+BIhiofuStgjhvUPTI8JozKpnXY
         SRcl7QRwlJbOPCOwiqs/MiP7BBD/rbtr1MqvUGKujKeM7AP9mYs2peDSLg5oMhq+NG4q
         tNH47xqCby/zzNKW4EFQRNZBiR8l3iWbFOiVFfj7CPXMUhPQ77sWQdh9ghunEZklXu/0
         mJLQ==
X-Gm-Message-State: AA+aEWZ7j400xu6trT89iwHt6DpnUN7AQ0LVsVarz4KvhhFauM+zcTIz
        O0AMW8xxRy2KgMcl9zN4BcZjlfgRa29Hp5vbg8c=
X-Google-Smtp-Source: AFSGD/W92lkMvfjQi0UE8TMQdBrYLi24in4EuD6qLw6F5Ephf0oVv06HAh3FjgmpDJyO0o4uF2p1u4IejzqAP/mtY0U=
X-Received: by 2002:a25:d4c4:: with SMTP id m187mr7844420ybf.157.1544907566011;
 Sat, 15 Dec 2018 12:59:26 -0800 (PST)
MIME-Version: 1.0
References: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
 <20181214213246.GA2182@tor.lan> <CABRG_PG+D73XPDy3RV1-5yJvSuKDV9ymjT6pp5Jt5DoVsLZT8A@mail.gmail.com>
 <20181215044345.GA19192@tor.lan>
In-Reply-To: <20181215044345.GA19192@tor.lan>
From:   "Mr&Mrs D" <the.ubik@gmail.com>
Date:   Sat, 15 Dec 2018 15:58:49 -0500
Message-ID: <CABRG_PHuRc59mp6PLO49vEn50OkPv5uwv3RyTdVZ=25MWU7dTQ@mail.gmail.com>
Subject: Re: Bug in lineendings handling that prevents resetting checking out,
 rebasing etc
To:     tboegi@web.de
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again!

Whichever path I take all the intermediate commits between the fix
commit and the one that added the gitattributes file (so marked that
file as text) will be plagued by this - checking them out on linux or
macos will show that particular file as modified. Is my understanding
correct?
It still seems to me that at least the operating system should not
matter here - I did not encounter this on windows and when I did (as
described in the SO post) `git rm -r . --cached -q && git reset
--hard` would reset the branch.

Is there a way I can add this file to local .git/info/attributes so
that I overwrite the .gitattributes (see
https://stackoverflow.com/a/33715791/281545 ) ?

I tried adding the line:

$ cat .git/info/attributes
Mopy/Docs/Bash Readme Template.html -text

but does nothing. The idea would be to add the commit fixing the line
endings on the stable branch and also instruct collaborators to edit
their .git/info/attributes files so when checking out older commits
the file does not show as changed.

Speaking of line endings fix issuing:

(dev) $ git add --renormalize .
(dev) $ git status
On branch dev
Your branch is up to date with 'origin/dev'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

modified:   Mopy/Docs/Bash Readme Template.html
modified:   Mopy/Docs/Bash Readme Template.txt
modified:   Mopy/bash/db/Oblivion_ids.pkl
modified:   Mopy/bash/db/Skyrim_ids.pkl

Untracked files:
...

adds 4 files as seen (?)

Thanks again and sorry for the late reply
On Fri, Dec 14, 2018 at 11:43 PM Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>
> On Fri, Dec 14, 2018 at 04:51:54PM -0500, Mr&Mrs D wrote:
> > Thanks for looking to it - git attributes was added in
> > 4b0863a8b834c5804fd3a568ed56ff85b27acdeb
> >
> > The file in question was added in 17ca75f0a8c25f321f2b63bc3b9c065ff91ad=
c23
> >
> > So you mean to say that because a gitattributes was added after the
> > fact this resulted in an illegal state?
> >
> > But _shouldn't git reset --hard work anyway?_ That's the buggy part.
>
> Yes and no.
> If I look at the dev branch:
> commit 02ae6f264f340137b8b41ba6953e2a4f962c222e (HEAD, origin/dev, origin=
/HEAD, dev)
>
> Now we can ask Git, why a file is modified:
>
> git ls-files --eol | grep "Mopy/Docs/Bash eadme Template.html"
> i/crlf  w/crlf  attr/text               Mopy/Docs/Bash Readme Template.ht=
ml
>
> Now we have 2 conflicting "messages" to Git:
> a) "Mopy/Docs/Bash Readme Template.html" has the attribute "text"
> b) "Mopy/Docs/Bash Readme Template.html" has been commited with CRLF.
>
> Git itself can not resolve this conflict.
> Either you normalize the repo (in this case only 1 file), other commits h=
ave 4 files
> that needs to be normalized.
> Or you change the attribute into "text=3Dauto".
>
> That decision is up to the user.
>
> >
> > As for fixing it - not sure what is the best course of action here.
> > probably issuing `git add --renormalize .` and committing that to the
> > stable (dev) branch will fix this for future checkouts/rebases but
> > IIUC won't do nothing for older commits - so checking out a commit
> > before the fix one, ghit will see this file as changed and then
> > completely refuse to go back to another branch
> >
> > This seems a bug - as illegal as the state of the file is, shouldn't
> > git reset always work?
> >
> > Thanks! (will be out for a bit but really looking forward to your repli=
es)
> > On Fri, Dec 14, 2018 at 4:32 PM Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> > >
> > > On Fri, Dec 14, 2018 at 04:04:15PM -0500, Mr&Mrs D wrote:
> > > > Hi all,
> > > >
> > > > I maintain a python project you can clone from:
> > > >
> > > > git@github.com:wrye-bash/wrye-bash.git
> > > >
> > > > For reasons unknown git sees a particular file as changed
> > > > (Mopy/Docs/Bash Readme Template.html, sometimes others too). This f=
ile
> > > > was probably committed to the svn repository this git repo was crea=
ted
> > > > from with CRLF line endings. When we moved to git we added a
> > > > gitattributes file (
> > > > https://github.com/wrye-bash/wrye-bash/blob/dev/.gitattributes ) an=
d
> > > > this file was edited to explicitly state htms are text - all to no
> > > > avail. From time to time - on windows - as in when checking out an =
old
> > > > commit - git would see that file as changed. The only workaround th=
at
> > > > worked for me was
> > > >
> > > >     git rm -r . --cached -q && git reset --hard
> > > >
> > > > For more details and discussion see this SO question I posted almos=
t
> > > > five years ago:
> > > >
> > > > https://stackoverflow.com/questions/21122094/git-line-endings-cant-=
stash-reset-and-now-cant-rebase-over-spurious-line-en
> > > >
> > > > I used to work in windows and the bug was tolerable as there was th=
at
> > > > workaround. Now I moved to mac and no workaround works anymore - we
> > > > have a special page on our wiki  with workarounds for this one btw:
> > > >
> > > > https://github.com/wrye-bash/wrye-bash/wiki/%5Bgit%5D-Issues-with-l=
ine-endings-preventing-checking,-merge,-etc
> > > >
> > > > Well after 5 years and countless hours trying to solve this I reach
> > > > out to you guys and girls - _this is a full-time bug in git line
> > > > endings handling_. When someone issues a git reset --hard this shou=
ld
> > > > work no matter what - well it does not. So this bug may be really a
> > > > can of worms.
> > > >
> > > > Please someone clone this repo on linux or mac - probably just clon=
ing
> > > > will have the files appear as changed (by the way hitting refresh o=
n
> > > > git gui I have different sets of files appear as changed). If not t=
hen
> > > >
> > > > git checkout utumno-wip
> > > Thet commit is -excuse me if that sounds too harsh- is messed up.
> > > git status says
> > > modified:   Mopy/Docs/Bash Readme Template.html
> > >
> > > And if I dig into the EOL stuff, I run
> > > git ls-files --eol | grep  Readme | less
> > >
> > > And find a contradiction here:
> > > i/crlf  w/crlf  attr/text               Mopy/Docs/Bash Readme Templat=
e.html
> > >
> > > The attributes say "text" and the file has CRLF "in the repo",
> > > (techically speaking in the index) and that is an "illegal" condition
> > > in the repo, and not a bug in Git.
> > > I didn't try the rebase as such, sice the first problem needs
> > > to be fixed, before we try to move on.
> > >
> > > So, the old commits are problematic/illegal and they are as they are.
> > > Such a commit can not be fixed, whenever somebody checks it out,
> > > there will be a problem (or two, or none, depending on the timing,
> > > the file system...)
> > >
> > > We can not fix commits like b1acc012878c9fdd8b4ad610ce7eae0dcbcbcab0.
> > > We can make new commits, and fix them.
> > >
> > > We can fix one branch, and other branches, and merge them together.
> > > But rebase seems to be problamatic, at least to me.
> > > What exactly do you want to do?
> > >
> > > Can we agree to do a merge of 2 branches?
> > > Then I can possibly help you out.
> > >
> > >
> > >
> > >
> > >
> > > > git rebase -i dev
> > > >
> > > > and then select a commit to edit should be enough to trigger this b=
ug
> > > >
> > > > Needless to say I am  well aware of things like `git add --renormal=
ize
> > > > .` - but renormalizing is not the issue. The issue is that _files s=
how
> > > > as changed and even a git reset --hard won't convince git that
> > > > nothing's changed_.
> > > >
> > > > $ git reset --hard
> > > > HEAD is now at e5c16790 Wip proper handling of ini tweaks encoding =
- TODOs:
> > > > $ git status
> > > > interactive rebase in progress; onto 02ae6f26
> > > > Last commands done (4 commands done):
> > > >    pick 3a39a0c0 Monkey patch for undecodable inis:
> > > >    pick e5c16790 Wip proper handling of ini tweaks encoding - TODOs=
:
> > > >   (see more in file .git/rebase-merge/done)
> > > > Next commands to do (19 remaining commands):
> > > >    edit a3a7b237 Amend last commit and linefixes:  =CE=95=CE=95=CE=
=95=CE=95
> > > >    edit 432fd314 fFF handle empty or malformed inis
> > > >   (use "git rebase --edit-todo" to view and edit)
> > > > You are currently editing a commit while rebasing branch 'utumno-wi=
p'
> > > > on '02ae6f26'.
> > > >   (use "git commit --amend" to amend the current commit)
> > > >   (use "git rebase --continue" once you are satisfied with your cha=
nges)
> > > >
> > > > Changes not staged for commit:
> > > >   (use "git add <file>..." to update what will be committed)
> > > >   (use "git checkout -- <file>..." to discard changes in working di=
rectory)
> > > >
> > > > modified:   Mopy/Docs/Bash Readme Template.html
> > > >
> > > > Untracked files:
> > > >   (use "git add <file>..." to include in what will be committed)
> > > >
> > > > .DS_Store
> > > > .idea.7z
> > > >
> > > > no changes added to commit (use "git add" and/or "git commit -a")
> > > > $
> > > >
> > > > I really hope someone here can debug this
> > > > Thanks!
