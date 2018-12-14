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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1BF20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbeLNVwd (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:52:33 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41118 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:52:32 -0500
Received: by mail-yb1-f196.google.com with SMTP id e124so2863417ybb.8
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4qT9CRd9S/eqzX3c7/a0dlwu8hGntt0QCJH1ODutRA=;
        b=RpZ0MMEIMUYoMJPYvnTPFP9zbI7VMznP9APfEmoIxQif9tB/2/+2OExilUChJHyIoe
         EilkZh6jfHJW6g+iKhqwnVg8Y/VMjvxNf4KiGdNWh8D2G4NvqEcxqDb1tQFuZjHI/XBX
         bb3d3sGhoqwe82CDhv1LoB1/cKfyDBduJwujpYBseqXTL8tr8fB5PCG3FzJcF5oHiYfY
         GC5I2RLcZicFpPhdap7EsK+R1uQzkWsIBTMd0CWiIhsULiuie17l9o3PcO2Or39ia5Ai
         BgI93kI4bQWlwEq1oZFWot1cYt7hPVKyxlCufOJO/DI+xgcpQ6Zef550bJn1bTHgtPR3
         eTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4qT9CRd9S/eqzX3c7/a0dlwu8hGntt0QCJH1ODutRA=;
        b=XN+OyBs2wDQcdWWY3Wl0gfjcT1P8AGXyYIUitWyUVNxYzsLCnu/FoIk2daNodHDnAk
         bn7/tTV6iM7cLidSpO4eGs7tkF2VkB5Iz0feg4/W6i5CQk+6O1UeynE0lUqDndRXyxWK
         XyJocrk0kXqSMtRSmz9haNx6wkkWT/rR7euh6rQZBnMU2UlabxU544kZVCd3aBDuWYoJ
         QpdN5KE/bf6lykeUsgqtCd4oyp3Pky+GhxTYNcmPZ2VaEg7JFwCCEWGxVWgfYVGu/E5p
         ALH8piRBk76QD8v+2aph3JJXy9AFmocSEnrA9UdWlKsS907twUWaJPDywgPL3Uj4+6rN
         VpXA==
X-Gm-Message-State: AA+aEWbMo58QjoHE1AjG5SUxxOIxTGBz4YDpLGj681VnKkfAcZ8YTbhD
        s2qfr6RrBjOYW1K81w0t+Kw5g8YSeunKsR6ylBo=
X-Google-Smtp-Source: AFSGD/WvWIhAgbu3LwAlDq06bLyoqnIP2P/jw+irmSvwB4Whnrr2P+V7xmAXJY71TTiSkCTzgVmMSNo3VH5njeRxnLM=
X-Received: by 2002:a25:d4c4:: with SMTP id m187mr4733886ybf.157.1544824351160;
 Fri, 14 Dec 2018 13:52:31 -0800 (PST)
MIME-Version: 1.0
References: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
 <20181214213246.GA2182@tor.lan>
In-Reply-To: <20181214213246.GA2182@tor.lan>
From:   "Mr&Mrs D" <the.ubik@gmail.com>
Date:   Fri, 14 Dec 2018 16:51:54 -0500
Message-ID: <CABRG_PG+D73XPDy3RV1-5yJvSuKDV9ymjT6pp5Jt5DoVsLZT8A@mail.gmail.com>
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

Thanks for looking to it - git attributes was added in
4b0863a8b834c5804fd3a568ed56ff85b27acdeb

The file in question was added in 17ca75f0a8c25f321f2b63bc3b9c065ff91adc23

So you mean to say that because a gitattributes was added after the
fact this resulted in an illegal state?

But _shouldn't git reset --hard work anyway?_ That's the buggy part.

As for fixing it - not sure what is the best course of action here.
probably issuing `git add --renormalize .` and committing that to the
stable (dev) branch will fix this for future checkouts/rebases but
IIUC won't do nothing for older commits - so checking out a commit
before the fix one, ghit will see this file as changed and then
completely refuse to go back to another branch

This seems a bug - as illegal as the state of the file is, shouldn't
git reset always work?

Thanks! (will be out for a bit but really looking forward to your replies)
On Fri, Dec 14, 2018 at 4:32 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Fri, Dec 14, 2018 at 04:04:15PM -0500, Mr&Mrs D wrote:
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
> Thet commit is -excuse me if that sounds too harsh- is messed up.
> git status says
> modified:   Mopy/Docs/Bash Readme Template.html
>
> And if I dig into the EOL stuff, I run
> git ls-files --eol | grep  Readme | less
>
> And find a contradiction here:
> i/crlf  w/crlf  attr/text               Mopy/Docs/Bash Readme Template.ht=
ml
>
> The attributes say "text" and the file has CRLF "in the repo",
> (techically speaking in the index) and that is an "illegal" condition
> in the repo, and not a bug in Git.
> I didn't try the rebase as such, sice the first problem needs
> to be fixed, before we try to move on.
>
> So, the old commits are problematic/illegal and they are as they are.
> Such a commit can not be fixed, whenever somebody checks it out,
> there will be a problem (or two, or none, depending on the timing,
> the file system...)
>
> We can not fix commits like b1acc012878c9fdd8b4ad610ce7eae0dcbcbcab0.
> We can make new commits, and fix them.
>
> We can fix one branch, and other branches, and merge them together.
> But rebase seems to be problamatic, at least to me.
> What exactly do you want to do?
>
> Can we agree to do a merge of 2 branches?
> Then I can possibly help you out.
>
>
>
>
>
> > git rebase -i dev
> >
> > and then select a commit to edit should be enough to trigger this bug
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
