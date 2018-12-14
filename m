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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4137F20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbeLNVcu (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:32:50 -0500
Received: from mout.web.de ([212.227.15.4]:49011 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730887AbeLNVcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1544823167;
        bh=BDNEkWpSUtaGMt/RHLIr1X+VzNr9rXrtzT/7Bs5zQSU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aOal+uLtszTAWN8ThSXjgOOrHkmVLMjNwIuPMQ8BZZ97DPuiTFNRqolzw7C38wWpg
         DAlktdEbvtrVRLiS9myv+Q02rNkmOIAi1SM+vLbcCEGN80gl5MnK5TYMoXK++cDbq5
         N+1geYl/NW5vWcvANjw+1td8vAGvb99aq4Q2UCuk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPp0k-1gU5aH0Kuo-0052mA; Fri, 14
 Dec 2018 22:32:47 +0100
Date:   Fri, 14 Dec 2018 22:32:46 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Mr&Mrs D <the.ubik@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Bug in lineendings handling that prevents resetting checking
 out, rebasing etc
Message-ID: <20181214213246.GA2182@tor.lan>
References: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:bvQseMHPtNvZisHgHXdsdHcpDsNJfF/tYioKQhng1nxIM76L4EF
 apkw4/tHKA1/rC9pLgVBSKUCaewoKv+FJiwT58M4TzVmIzeJYkvT7/0oq1kbCfeujb11PJA
 8iPSSImRhjfu1vwS9H0pNFIbDQ67UGF3wEWeOmwhR/HXa2Lc1F+I8vjq7m6WYijKJ+xWZ6N
 QDGsezidw3kklFKxYUxMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EfLSDFcC6nA=:/0rZTxCzzPkGBzpNTp7LtL
 MHdqTUGwh96KQop0n/zlS5HDZrUb+AgAXoWIWcqsoOkz9PGw90ZGjdeN/AigF3Agp3c4vEBcV
 afCePEXLGUGo/6bBXGbmikx1MltePw9i0cx93P9OWyRpbx8qklkcv3p2N+JR5g8ypAnx9j4pW
 76WUe+aEAot8YxKdK+P4wyyI9J91+ktoUiSgYAp0aoJW3RyZhiR3Lp/V5e/AoJpBjGzAFmGql
 NVo82qh1/Pxm6ssuM0K5hifBUDbkxjYmqbGsSaNQeg7L4umrj25dGU6VffE0YB2/XwN01m5fR
 yxVwDs3tLCbgvxX5a5PlMyXuvsM6tkavL8SgS8OSzmcXil3U9U0ahK5fYIF0G5zCbcMd3ZNoL
 9o5zn+Rm3dGhvNPuUEBPvHnENyuwAaelA0hZz6xRa9a261YCYMiVqs+1L5G1ZB3LmiHLgFKbf
 rq5eOsK4FOuWQ6AbxhUugxv8mx2kmOMkkB8OodyUNWXNP5tqBsApi30NyXAYmOs2N91JvpFS8
 HW2Ks8BeuTbAQljPzxgrnM1IF4EmZrWyJQ9Wc58IBS6JchgI2bOSudnQAGO5sL1kz5NH8OXHs
 +dvL/0q5B3tU2KNdJsWxtIvkkGiDxQNLSla15vshTDh2n7f5/Cq15BSmTAwRhUiAAGx7UXdB6
 +rguPYzs/GOSSRpu63KLvJ+FUjaayjo/hvitltkebfg3KdEJMPEDTlt0BHuq4d59mziaPDlRq
 m1BiqFsUN00wpfWbLPE9kO0NkAk7lgBLm3UIdMko95F1++hnxkgLgchtBgppZUjlI2cgHoCaV
 YYM3uu9Rmc87fY5MFbVJbI0A5URa9hm+OT6rLNRae0FJakdI4LvYKpUKkIKk+lqOl34ens/JO
 qjgDMKJH3qkK7zlbgfmKyBRjHiMX8VLrGMFHzkXkQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 04:04:15PM -0500, Mr&Mrs D wrote:
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
> https://stackoverflow.com/questions/21122094/git-line-endings-cant-stash-reset-and-now-cant-rebase-over-spurious-line-en
> 
> I used to work in windows and the bug was tolerable as there was that
> workaround. Now I moved to mac and no workaround works anymore - we
> have a special page on our wiki  with workarounds for this one btw:
> 
> https://github.com/wrye-bash/wrye-bash/wiki/%5Bgit%5D-Issues-with-line-endings-preventing-checking,-merge,-etc
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
Thet commit is -excuse me if that sounds too harsh- is messed up.
git status says
modified:   Mopy/Docs/Bash Readme Template.html

And if I dig into the EOL stuff, I run
git ls-files --eol | grep  Readme | less

And find a contradiction here:
i/crlf  w/crlf  attr/text               Mopy/Docs/Bash Readme Template.html

The attributes say "text" and the file has CRLF "in the repo",
(techically speaking in the index) and that is an "illegal" condition
in the repo, and not a bug in Git.
I didn't try the rebase as such, sice the first problem needs
to be fixed, before we try to move on.

So, the old commits are problematic/illegal and they are as they are.
Such a commit can not be fixed, whenever somebody checks it out,
there will be a problem (or two, or none, depending on the timing,
the file system...)

We can not fix commits like b1acc012878c9fdd8b4ad610ce7eae0dcbcbcab0.
We can make new commits, and fix them.

We can fix one branch, and other branches, and merge them together.
But rebase seems to be problamatic, at least to me.
What exactly do you want to do?

Can we agree to do a merge of 2 branches?
Then I can possibly help you out.





> git rebase -i dev
> 
> and then select a commit to edit should be enough to trigger this bug
> 
> Needless to say I am  well aware of things like `git add --renormalize
> .` - but renormalizing is not the issue. The issue is that _files show
> as changed and even a git reset --hard won't convince git that
> nothing's changed_.
> 
> $ git reset --hard
> HEAD is now at e5c16790 Wip proper handling of ini tweaks encoding - TODOs:
> $ git status
> interactive rebase in progress; onto 02ae6f26
> Last commands done (4 commands done):
>    pick 3a39a0c0 Monkey patch for undecodable inis:
>    pick e5c16790 Wip proper handling of ini tweaks encoding - TODOs:
>   (see more in file .git/rebase-merge/done)
> Next commands to do (19 remaining commands):
>    edit a3a7b237 Amend last commit and linefixes:  ΕΕΕΕ
>    edit 432fd314 fFF handle empty or malformed inis
>   (use "git rebase --edit-todo" to view and edit)
> You are currently editing a commit while rebasing branch 'utumno-wip'
> on '02ae6f26'.
>   (use "git commit --amend" to amend the current commit)
>   (use "git rebase --continue" once you are satisfied with your changes)
> 
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
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
