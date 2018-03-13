Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1331FAE3
	for <e@80x24.org>; Tue, 13 Mar 2018 16:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932736AbeCMQvJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:51:09 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44446 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeCMQvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:51:07 -0400
Received: by mail-ua0-f196.google.com with SMTP id s92so174616uas.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DlIFZDzFFyzyLbG8bpAOK6EO4aSJC75PNv14bSXqJ2c=;
        b=lRCsdOqDooXJzFd0Iqh0HQIbo98mQoZYLpSO7xrpuZcCihx6eLMob3l0FKLqNMMht5
         mP4Fma5dVM3MenDHxNkhbV09CjEEsYDHyb/YeLVUfNbMjS6KVoRUTdKy3Yp9Lumt9pOT
         /owhQdrTBmZbePlx2zDToyecvPDI2EEZHEwUFbfbIk4Dhq0wMH9i+aOPm++/26FRM2ey
         CCr292oAinHbFQ5GZPs+gAKNAIXEAEDZpJE5ddsJm+LIHmrTohwWRH5Rv6IMVmTycOeb
         FtbJXaUkFDYHWdiWFU5xuZffnhFrtJKhjcNQBE6sU8wcevjQpER92yOar0J0n72CmaSB
         xeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DlIFZDzFFyzyLbG8bpAOK6EO4aSJC75PNv14bSXqJ2c=;
        b=hZxImQYu527wph7rz5FsetqU/UXhx7qMHOY4uwh0T4Qj4Lq+ZQwez2C9TL/nR5oQd/
         iH3p+Oku91tsMPJ+P3JvzD6Yf+0SM/of9gsdLGuN1gE5IyJ1VVBlTznKTset599Zkosj
         XfjvPXPoerCKBN3w6sDJA7rbsx8WjXafCT1BMHy1jLk8nt/cLMCHWam0r8FKco3jpcCs
         6UH1fXLx31q5MPjSoS/cuoS/XxCZ2ms0DKqpy7JJY4oO38259eSrQpdlOvTAAUOZDCfX
         UUycTK3zNN7CoJBoCICDaVYpkn9qAPYo58pQGOLBdUN/Kg94VOmknhy1IiDVcCnQdANP
         6itg==
X-Gm-Message-State: AElRT7FdpjW6QAyyMlKhmCEhlTV6GEXtCCVTTfGfXZBWdJeEdasTdcBP
        QmrqsPVOs/hMJs2ANSdUENjdO5g3IeJW6qEul/w=
X-Google-Smtp-Source: AG47ELvrlvpsl/lMP7itNQ6sXk9LshaVJ2L491GkadEKdePiFO5IgJ/hDBg2eU93w6KLDQX3A53+NXeZPVveVvYahuc=
X-Received: by 10.159.63.11 with SMTP id h11mr1111332uaj.94.1520959866222;
 Tue, 13 Mar 2018 09:51:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.3.241 with HTTP; Tue, 13 Mar 2018 09:51:05 -0700 (PDT)
In-Reply-To: <CAHd499Axo7HFviUJavigTZ6BGZCkj9iOSeNVndu1oPivkPv+5Q@mail.gmail.com>
References: <CAHd499Axo7HFviUJavigTZ6BGZCkj9iOSeNVndu1oPivkPv+5Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Mar 2018 09:51:05 -0700
Message-ID: <CABPp-BEC48EoTc5eyLrcaLLtUexgbShQsB7zbQJB0QE6AA19kA@mail.gmail.com>
Subject: Re: Rename of file is causing changes to be lost
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 8:01 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I'm on Windows and core.ignorecase is set to 'true' when I clone/init
> a repository. I've got a branch where I started making changes to a
> file AND renamed it only to change its case. The changes I've made
> were significant enough that git no longer detects a rename, instead
> the files show up as "D" and "A" in git status (deleted then added).
> To correct this, I do an interactive rebase to add an additional
> commit before the first one to rename the file without changing it,
> and *then* allow the second commit to change the file. The goal is
> that rebase should detect the rename and automatically move the
> changes in the (now) second commit to the newly named file. Here's a
> MCVE (treat this as a script):
>
> #/bin/bash
> git init testgitrepo
> cd testgitrepo/
> git config core.ignorecase true # This is set by Windows for me, but
> hopefully will allow this to repro on linux. Didn't test linux though.
> echo "first change" > foo.txt
> git add . && git commit -m 'first change'
> git checkout -b topic
> echo "second change" > foo.txt
> git mv foo.txt FOO.txt
> git add . && git commit -m 'second change'
> git rebase -i master # Move line 1 to line 2, and put "x false" in line 1
> git mv foo.txt FOO.txt && git commit -m 'rename foo'
> git rebase --continue
> git mergetool
>
> After the rebase continue, you will get a conflict like so:
>
> error: could not apply 527d208... second change
>
> When you have resolved this problem, run "git rebase --continue".
> If you prefer to skip this patch, run "git rebase --skip" instead.
> To check out the original branch and stop rebasing, run "git rebase --abort".
>
> Could not apply 527d208... second change
> CONFLICT (rename/delete): foo.txt deleted in 527d208... second change
> and renamed to FOO.txt in HEAD. Version HEAD of FOO.txt left in tree.
>
> The last command, `git mergetool` runs, giving you the option to pick
> the Created (left) or Deleted (right) version of the file:
>
> Left: The file is created, but selecting this erases the changes from
> the "added" version on the remote (which is topic). Basically the
> rename of only case confused git, and we lost the changes on the
> remote version of the file
> Right: File is deleted. Changes are still lost.
>
> The ideal outcome is that the changes from the "added" version of the
> file in the 2nd commit get carried over to the "renamed" version of
> the file, which when you compare the two are named exactly the same
> after the 1st commit is introduced. How can I solve this issue?

Cool, thanks for the testcase.  I don't have a good workaround for
you, but this is clearly a bug in the merge-recursive logic in git.  I
guess it's what might be called a rename/add/delete conflict, which
git just doesn't handle.  Your testcase triggers the bug just fine on
linux, though you can trigger the exact same bug without case
sensitivity using a slightly different setup (and no need for an
interactive rebase):

------
git init foobar
cd foobar
echo "original file" >foo
git add foo
git commit -m "original"
git branch L
git branch R

git checkout L
git rm foo
echo "different file" >bar
git add bar
git commit -m "Remove foo, add bar"

git checkout R
git mv foo bar
git commit -m "rename foo to bar"

git merge L
-------

git has code to handle rename/delete conflicts and rename/add
conflicts, but since one side of history BOTH deleted foo and added an
unrelated bar, that means both types of changes are relevant to the
same path (bar) -- essentially, a rename/delete/add conflict.  Sadly,
git only goes down a codepath that handles one of those two (the
rename/delete), and incorrectly throws away the separate add:

-----
$ git ls-files -s
100644 78fa0f415ae2bdb5c0182c067eacaaf843699b39 2    bar

$ git ls-tree -r master
100644 blob 78fa0f415ae2bdb5c0182c067eacaaf843699b39    foo
$ git ls-tree -r L
100644 blob f286e5cdd97ac6895438ea4548638bb98ac9bd6b    bar
$ git ls-tree -r R
100644 blob 78fa0f415ae2bdb5c0182c067eacaaf843699b39    bar
-----

But the problem is actually a bit bigger than shown here; there are
higher order corner cases here too.  I realized in the past that e.g.
rename/rename(1to2) could also have rename/add conflicts for each
rename (thus making a rename/rename/add/add conflict possible), but I
also felt there were probably some other bad interactions out there.
I figured they were likely theoretical only, so I didn't bother
investigating.  But, combining your example with that other one, we
should also be able to come up with a
rename/rename/add/add/delete/delete conflict.  I wonder if there are
others...

Anyway, I recorded this at
https://bugs.chromium.org/p/git/issues/detail?id=11.  Sorry I don't
have a workaround, but I'll try to eventually get back to this and fix
it.
