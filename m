Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C224C1F405
	for <e@80x24.org>; Sat, 15 Dec 2018 04:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeLOEnt (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 23:43:49 -0500
Received: from mout.web.de ([212.227.15.3]:54003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbeLOEnt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 23:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1544849025;
        bh=E2SinddUoiARt4iRdsaUj1hu5SVhac19H+fWOjf1bKw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cqOtj5iEwC8G5bug37KcHBphMl8p/O9y6Zusw5JmV94Pv/MWCqjOn8Xf9zKOEHupo
         F1WUCYE4pnt0ecIs095+i6KthO+0SW9b4z18EQph7VT/BI/1NkMK+vd8bvopMhiom9
         uAUHFbBkEnFYiQ8i7fd36bB0sIzai50ZoYyUWUEI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAjet-1gjtVq2Hb1-00BqeJ; Sat, 15
 Dec 2018 05:43:45 +0100
Date:   Sat, 15 Dec 2018 05:43:45 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Mr&Mrs D <the.ubik@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Bug in lineendings handling that prevents resetting checking
 out, rebasing etc
Message-ID: <20181215044345.GA19192@tor.lan>
References: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
 <20181214213246.GA2182@tor.lan>
 <CABRG_PG+D73XPDy3RV1-5yJvSuKDV9ymjT6pp5Jt5DoVsLZT8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABRG_PG+D73XPDy3RV1-5yJvSuKDV9ymjT6pp5Jt5DoVsLZT8A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:EYGGdSPQ5c8/G7mZvVqVEWR57v4RJHPSARAGgJ+04YkLOt7vz0p
 p5a88lSprSh6GbEeKFtgcZr1SaV2iKTz9je8yOqadQyP1UzG5NyiB9rl/nnB9jo3eDD/O54
 xgFiWZ7n6JpTiqPpUOlMFP40UX35ime1aNrSsENG62+NDXyAc2TI4XAYeIb+Wg363AZhp3j
 ExTXfSAnkBpzK48Cd5FDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZPoPf1+xTn8=:n9vn535y6AgtAIbKUGVK97
 lARC0bIwYLwK78doCQSl0T+IZ/9Z79tX95jHq7Dej1fgH45vQP6buDlu6E8b2nsmbrxgS04bA
 DGg/CRY+F3eaTSza7CwgclwGw8koZ6q5SDyIdHkGpDfUWMwj1tPayKlOLKMpE7Gtpp7XlChzy
 Kpa3dNVET3m6SwQqin/wfMpDJp1L1WmLQOS2COZKC3mjCJO6hOIvIKitNRUvYz9V2Ohp+EaSd
 FuvaWhBNgKt2BN/CeMj56YQ+uw/Viqjs1QxdDHO6u1lVlyndfBcC2fH+2NpKquA9Z650eBzjl
 RhUbwjVYTrvbNDCUfPDvx6VqEK4kJ5kx7tcnunfXetHFRoMiJ2lug4FtrAFBFTkmSdxqCEi9e
 zHxkeDTl2f98cqajZjtdr9okC1seUVefj8kfgfr+9pVDCJSa1xvXJV0JIIEG+lkHhpJw0zfkD
 a/3ygeq19JPaUw0r1PRB8Ui4w2nsGYkeB0ZJG6tFMWLzY4H1b6KnD/GorafmuUOG+oEMrHyr6
 OQIdkLl1YczrU+IU2OpoChbRy8nA6zXr1/ugColJW8qsUb2OKcTxyTQhdBNFolkSuiLBmbEKj
 Xg8XcmPU1t5WrOsIpK2Cf9pgLNSZ/IlUn9BEvyMLeTQ2bvd+OiDliKxFMBaFXyY+kKoAmUQ4X
 +4TXpX89r2q45Jfmyohnj7vt3zNxo5iBSfnqfHYWvhW17XJxfp7Z4dZDf/YeSZ38JHO4v+/SA
 Zv4zk0invNXtX/hzIdvI9Ey/KrZhgguIi89w9oZo4hscCvBwUl7BRwOOUQ0oWOx+IlILJ4C4z
 bhJ/IXbWdE3dMNsyERoDRyhMuS1IxD4xEezH0OUQaEPjrSWHyfsXQK8w4Hyr7sKchpXB9PQqO
 yNnpTdUO6oHucFWdfGMxH0CuGE6WT3y7Wy2YWaERM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 04:51:54PM -0500, Mr&Mrs D wrote:
> Thanks for looking to it - git attributes was added in
> 4b0863a8b834c5804fd3a568ed56ff85b27acdeb
> 
> The file in question was added in 17ca75f0a8c25f321f2b63bc3b9c065ff91adc23
> 
> So you mean to say that because a gitattributes was added after the
> fact this resulted in an illegal state?
> 
> But _shouldn't git reset --hard work anyway?_ That's the buggy part.

Yes and no.
If I look at the dev branch:
commit 02ae6f264f340137b8b41ba6953e2a4f962c222e (HEAD, origin/dev, origin/HEAD, dev)

Now we can ask Git, why a file is modified:

git ls-files --eol | grep "Mopy/Docs/Bash eadme Template.html"
i/crlf  w/crlf  attr/text               Mopy/Docs/Bash Readme Template.html

Now we have 2 conflicting "messages" to Git:
a) "Mopy/Docs/Bash Readme Template.html" has the attribute "text"
b) "Mopy/Docs/Bash Readme Template.html" has been commited with CRLF.

Git itself can not resolve this conflict.
Either you normalize the repo (in this case only 1 file), other commits have 4 files
that needs to be normalized.
Or you change the attribute into "text=auto".

That decision is up to the user.

> 
> As for fixing it - not sure what is the best course of action here.
> probably issuing `git add --renormalize .` and committing that to the
> stable (dev) branch will fix this for future checkouts/rebases but
> IIUC won't do nothing for older commits - so checking out a commit
> before the fix one, ghit will see this file as changed and then
> completely refuse to go back to another branch
> 
> This seems a bug - as illegal as the state of the file is, shouldn't
> git reset always work?
> 
> Thanks! (will be out for a bit but really looking forward to your replies)
> On Fri, Dec 14, 2018 at 4:32 PM Torsten Bögershausen <tboegi@web.de> wrote:
> >
> > On Fri, Dec 14, 2018 at 04:04:15PM -0500, Mr&Mrs D wrote:
> > > Hi all,
> > >
> > > I maintain a python project you can clone from:
> > >
> > > git@github.com:wrye-bash/wrye-bash.git
> > >
> > > For reasons unknown git sees a particular file as changed
> > > (Mopy/Docs/Bash Readme Template.html, sometimes others too). This file
> > > was probably committed to the svn repository this git repo was created
> > > from with CRLF line endings. When we moved to git we added a
> > > gitattributes file (
> > > https://github.com/wrye-bash/wrye-bash/blob/dev/.gitattributes ) and
> > > this file was edited to explicitly state htms are text - all to no
> > > avail. From time to time - on windows - as in when checking out an old
> > > commit - git would see that file as changed. The only workaround that
> > > worked for me was
> > >
> > >     git rm -r . --cached -q && git reset --hard
> > >
> > > For more details and discussion see this SO question I posted almost
> > > five years ago:
> > >
> > > https://stackoverflow.com/questions/21122094/git-line-endings-cant-stash-reset-and-now-cant-rebase-over-spurious-line-en
> > >
> > > I used to work in windows and the bug was tolerable as there was that
> > > workaround. Now I moved to mac and no workaround works anymore - we
> > > have a special page on our wiki  with workarounds for this one btw:
> > >
> > > https://github.com/wrye-bash/wrye-bash/wiki/%5Bgit%5D-Issues-with-line-endings-preventing-checking,-merge,-etc
> > >
> > > Well after 5 years and countless hours trying to solve this I reach
> > > out to you guys and girls - _this is a full-time bug in git line
> > > endings handling_. When someone issues a git reset --hard this should
> > > work no matter what - well it does not. So this bug may be really a
> > > can of worms.
> > >
> > > Please someone clone this repo on linux or mac - probably just cloning
> > > will have the files appear as changed (by the way hitting refresh on
> > > git gui I have different sets of files appear as changed). If not then
> > >
> > > git checkout utumno-wip
> > Thet commit is -excuse me if that sounds too harsh- is messed up.
> > git status says
> > modified:   Mopy/Docs/Bash Readme Template.html
> >
> > And if I dig into the EOL stuff, I run
> > git ls-files --eol | grep  Readme | less
> >
> > And find a contradiction here:
> > i/crlf  w/crlf  attr/text               Mopy/Docs/Bash Readme Template.html
> >
> > The attributes say "text" and the file has CRLF "in the repo",
> > (techically speaking in the index) and that is an "illegal" condition
> > in the repo, and not a bug in Git.
> > I didn't try the rebase as such, sice the first problem needs
> > to be fixed, before we try to move on.
> >
> > So, the old commits are problematic/illegal and they are as they are.
> > Such a commit can not be fixed, whenever somebody checks it out,
> > there will be a problem (or two, or none, depending on the timing,
> > the file system...)
> >
> > We can not fix commits like b1acc012878c9fdd8b4ad610ce7eae0dcbcbcab0.
> > We can make new commits, and fix them.
> >
> > We can fix one branch, and other branches, and merge them together.
> > But rebase seems to be problamatic, at least to me.
> > What exactly do you want to do?
> >
> > Can we agree to do a merge of 2 branches?
> > Then I can possibly help you out.
> >
> >
> >
> >
> >
> > > git rebase -i dev
> > >
> > > and then select a commit to edit should be enough to trigger this bug
> > >
> > > Needless to say I am  well aware of things like `git add --renormalize
> > > .` - but renormalizing is not the issue. The issue is that _files show
> > > as changed and even a git reset --hard won't convince git that
> > > nothing's changed_.
> > >
> > > $ git reset --hard
> > > HEAD is now at e5c16790 Wip proper handling of ini tweaks encoding - TODOs:
> > > $ git status
> > > interactive rebase in progress; onto 02ae6f26
> > > Last commands done (4 commands done):
> > >    pick 3a39a0c0 Monkey patch for undecodable inis:
> > >    pick e5c16790 Wip proper handling of ini tweaks encoding - TODOs:
> > >   (see more in file .git/rebase-merge/done)
> > > Next commands to do (19 remaining commands):
> > >    edit a3a7b237 Amend last commit and linefixes:  ΕΕΕΕ
> > >    edit 432fd314 fFF handle empty or malformed inis
> > >   (use "git rebase --edit-todo" to view and edit)
> > > You are currently editing a commit while rebasing branch 'utumno-wip'
> > > on '02ae6f26'.
> > >   (use "git commit --amend" to amend the current commit)
> > >   (use "git rebase --continue" once you are satisfied with your changes)
> > >
> > > Changes not staged for commit:
> > >   (use "git add <file>..." to update what will be committed)
> > >   (use "git checkout -- <file>..." to discard changes in working directory)
> > >
> > > modified:   Mopy/Docs/Bash Readme Template.html
> > >
> > > Untracked files:
> > >   (use "git add <file>..." to include in what will be committed)
> > >
> > > .DS_Store
> > > .idea.7z
> > >
> > > no changes added to commit (use "git add" and/or "git commit -a")
> > > $
> > >
> > > I really hope someone here can debug this
> > > Thanks!
