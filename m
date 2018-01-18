Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E341FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933439AbeARQTQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 11:19:16 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:39089 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbeARQTN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 11:19:13 -0500
Received: by mail-lf0-f46.google.com with SMTP id m8so27391673lfc.6
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 08:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=4pS3L0WvmNSxYhaaKg11h7DhNUqG3SNUogyZLW8VMyg=;
        b=kdIrb7rF0Mp//ZNRHj8satLSXyEhz9wB7of31lMjZt2QAgKZ5/u7wVMA3OW6w99sT0
         OmnNUiVb6Dru8uGSaHjtIPBE7UgOTkDY6ASDUQtg4j9u3ftrEj7SBAYd+HUee/Y/hVc5
         JdLwPX76BxWcydxGSTcpKwduYUx58JgUipnUdd44Eto+OL8fXlwgsXf7VqG9Th2T+nG2
         XBwYdi059mI5/Ni7w0gmEJDn7vXfwD+QzXsz6qhyD1WWmVEbwHxaeoKiLXak8weOjtiA
         5uts+sqQSBQtLAKwp+FQltQQMSKG8t9UwIGe9d2yKzkM+TmHMFrsFR4fgC6oxY1p4oro
         TEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=4pS3L0WvmNSxYhaaKg11h7DhNUqG3SNUogyZLW8VMyg=;
        b=h/MHuua4kxU70GsR1gksfJdto2GdSr44mCPAJw5SstpdvJgJ6ej5rBAKUUM4HUb+HU
         /JU97wBJyN8fRm0frVLqdJIrtxveeuAOUPJoED5UFNM3sdeLe1jIlxp95n/buwIcKW3m
         FSSi76nikQgnV5QG7MJn/XDkJw1LwVme2ZiYLuyOFypIN67K/QzwZV6bE/9nEpzrM0rm
         v7lCQocLzdc60ziqB083FKawuk1mgKVbTTMdN1KmaCHAWIIYQcNiOJGIZvbzXJk5G7Tp
         /XlQKTabuCEN1WynGJRValx0eqOq3jmeZCeeYGrtJBEViYnkrfr5+HgNei9mO/EMlDkK
         QFaw==
X-Gm-Message-State: AKwxytdlvLrn8AgMD7kYURu6FRHDD9na5ZmxSBQTBzreNVtw55Ck07/3
        o47+DAIhF8nhZNiXIAarksRULvcnasxpOJqMd2azvjnt
X-Google-Smtp-Source: ACJfBoswwQwESGKQVTPjoul77tSBbhSTXxi/4u0ciajmYGZ1UTWzwrGS5hwSdeyAsXZXBtfXWuaBf9WWB860FG2cBJw=
X-Received: by 10.25.171.10 with SMTP id u10mr23127781lfe.12.1516292351202;
 Thu, 18 Jan 2018 08:19:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.41.65 with HTTP; Thu, 18 Jan 2018 08:19:10 -0800 (PST)
In-Reply-To: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Thu, 18 Jan 2018 11:19:10 -0500
Message-ID: <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, just following up on this bug report. I have not heard back. Is
there additional information that's needed? Is there a better place to
file bug reports?

Thanks

On Sat, Jan 6, 2018 at 5:45 PM, Stephen R Guglielmo
<srguglielmo@gmail.com> wrote:
> Hi all,
>
> I've noticed an issue regarding the use of `git subtree add` and `git
> subtree pull` when the subtree repository's commit (either HEAD or
> whatever commit specified by the subtree command) is signed with GPG.
> It seems to work properly if the commit is not signed but previous
> commits are.
>
> The gist of the issue is that `git subtree add` does not add the
> subree properly and a "fatal: Not a valid object name" error is
> thrown. Running `git subtree pull` does not pull any upstream changes
> after that ("'subtree' was never added").
>
> I have not done extensive testing, however, below are instructions to
> reproduce the issue. This was tested using git version 2.15.1
> installed via Homebrew on MacOS. I did not test with the built-in
> version of git on MacOS.
>
> Thanks,
> Steve
>
> # Create a new repository
> mkdir repoA && cd repoA
> git init
> echo "Test File in Repo A" > FileA
> git add -A && git commit -m 'Initial commit in repo A'
>
> # Create a second repository
> cd .. && mkdir repoB && cd repoB
> git init
> echo "Test File in Repo B" > FileB
> git add -A && git commit -m 'Initial commit in repo B'
>
> # Create a signed commit in repo B
> echo "Signed Commit" >> FileB
> git commit -a -S  -m 'Signed commit in repo B'
>
> # Now, add repoB as a subtree of RepoA
> cd ../repoA
> git subtree add --prefix repoB_subtree/ ../repoB/ master --squash
> # Output:
> git fetch ../repoB/ master
> warning: no common commits
> remote: Counting objects: 6, done.
> remote: Compressing objects: 100% (2/2), done.
> remote: Total 6 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (6/6), done.
> From ../repoB
>  * branch            master     -> FETCH_HEAD
> fatal: Not a valid object name gpg: Signature made Sat Jan  6 17:38:31 2018 EST
> gpg:                using RSA key 6900E9CFDD39B6A741D601F50999759F2DCF3E7C
> gpg: Good signature from "Stephen Robert Guglielmo (Temple University
> Computer Services) <srg@temple.edu>" [ultimate]
> Primary key fingerprint: 6900 E9CF DD39 B6A7 41D6  01F5 0999 759F 2DCF 3E7C
> 4b700b1a4ebb9e2c1011aafd6b0f720b38f059a4
> # Note, git exits with status 128 at this point.
>
> # FileB was in fact added and staged to repoA, despite the "fatal"
> above. Commit it:
> git commit -m 'Add repoB subtree'
>
> # Ok, let's make another commit in repoB and try a `subtree pull`
> instead of `subtree add`
> cd ../repoB
> echo "Another Line" >> FileB
> git commit -a -S -m 'Another signed commit'
> cd ../repoA
> git subtree pull --prefix repoB_subtree/ ../repoB master --squash
> # Output:
> warning: no common commits
> remote: Counting objects: 9, done.
> remote: Compressing objects: 100% (3/3), done.
> remote: Total 9 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (9/9), done.
> From ../repoB
>  * branch            master     -> FETCH_HEAD
> Can't squash-merge: 'repoB_subtree' was never added.
> # Note, git exits with status 1 at this point.
>
> # RepoB's third commit ('Another signed commit') is not pulled into
> the subree in repo A.
> # This can be verified by running a diff:
> diff -qr --exclude ".git" repoB_subtree ../repoB
> # Output:
> Files repoB_subtree/FileB and ../repoB/FileB differ
