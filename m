Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C5020193
	for <e@80x24.org>; Sat, 29 Oct 2016 09:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934269AbcJ2Jr3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 05:47:29 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37973 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbcJ2Jr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 05:47:28 -0400
Received: by mail-it0-f49.google.com with SMTP id q124so19927935itd.1
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xjrnjGhJZi2P9q6EaYzNGF97JbR/SYH2dPC8H//qMtE=;
        b=CXakHYKJ2EgNVw0IOgg5FhMPy7eEks0rLv0aDsqikjzcyCvHegwpOQiYLUkikDRNQS
         DyAPWUN3QN7tI/DyvVrd0rWTac8fMqwfdXGLAxCw48spszN+2KHB/YUkFBsa/Nndqmbu
         3WZLJw1QnxhKUv8SEAZwIolZJHIhNOTLK2aD7D6TLn9Grh1sS1GNfZ0571idyeOj/uES
         YHcgXgd2i+2g1aTdKXw0VYLyuJqxGFnscYQdPAustPGGwTZPh/ImXGFBlodn1UReYeSc
         AU9q1JiEtH0Nik2e38UaoV9CCW6Uk5Ek+W+9/M8dKnzFXrDK8YSZUkCrkmnfbmPjfpGh
         R3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xjrnjGhJZi2P9q6EaYzNGF97JbR/SYH2dPC8H//qMtE=;
        b=nBIGr31gyciKY81/abijCzGLvyrgdQVtt1XBZDWJXNVlfXCoGnqBy/Qe32wSf347dM
         Qe58BsgMD+gOCFouXOUnWyDZVIfN5rXOHjvtjhTLI8vd0pUZhvHA43AcLFlZvX/lq+wx
         Lo1URSIUUhF357oLqHuWIwnrjzDQt3DfgdtqWP8a2ll5SWScinkMvHMRlDm5EVxl449/
         nE7AvweW/A3WMx6sBfXKN1E4ATxuvkMYoQ4vgWK3jQqhtYNvDF+DAcyNvkXq6PFtsMx3
         jDlcqVTyYet0lJG8tOhEbC6ucnpgnMN1fc1Gd27fqzFIcic8BeDttz47GLL7CMxt1PtP
         LHUg==
X-Gm-Message-State: ABUngvc761XvEzrleouz6rj6x6ACeJ2tVUUVn5dO5CxObIMrU+it7NXzYtqUrE43F8WnGcjstd4pgpomAevxaA==
X-Received: by 10.107.167.82 with SMTP id q79mr14840902ioe.120.1477734446952;
 Sat, 29 Oct 2016 02:47:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.5.212 with HTTP; Sat, 29 Oct 2016 02:47:06 -0700 (PDT)
In-Reply-To: <CAJtFkWs4qYCqnbJD+zCRCAW3teczb4CdvncvYoMN_VvthJGr=w@mail.gmail.com>
References: <CAJtFkWs4qYCqnbJD+zCRCAW3teczb4CdvncvYoMN_VvthJGr=w@mail.gmail.com>
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
Date:   Sat, 29 Oct 2016 12:47:06 +0300
Message-ID: <CALhvvbYE6Tt3eByDVMB3a4t=nm3dScVZSea0Z1SsKVgwFSiQ-w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Is_the_entire_working_copy_=E2=80=9Cat_one_branch=E2=80=9D=3F?=
To:     Stefan Monov <logixoul@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Generally with git, your entire working copy will have the same
revision (set to current branch, aka HEAD). The idea behind this
is that your working copy of a repository should always be in
consistent state.

You can check out specific files or directories from another
revision (mimicking "svn update -r1234 filename"):

    $ git checkout branch-or-sha-hash -- filename

However, SVN tracks the 'revision' thing on per-file basis, while
in git this is a property of the working copy. So if you do like
above then git will be telling you that the 'filename' has been
changed (as it is certainly different from its pristine version
in HEAD):

    $ git status
    On branch master
    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)

            modified:   filename

So it's generally not recommended to do such a thing.

Another thing that you _can do_ in git to mimick SVN is the
'standard layout'. There is a feature called "git worktree" which
allows you to have SVN-like directory structure with multiple
directories linked to different working copies:

    $ mkdir my-project
    $ cd my-project
    $ git clone my-project-repository master
    $ mkdir branches
    $ cd master
    $ git worktree add -b branch-1 ../branches/branch-1
    $ git worktree add -b branch-2 ../branches/branch-2

After that you will have directory structure like this:

    $ tree my-project
    my-project
    =E2=94=9C=E2=94=80=E2=94=80 branches
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 branch-1
    =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 1
    =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 2
    =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 3
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 branch-2
    =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 1
    =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 2
    =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 banana
    =E2=94=94=E2=94=80=E2=94=80 master
        =E2=94=9C=E2=94=80=E2=94=80 1
        =E2=94=94=E2=94=80=E2=94=80 2
You can work with these working copies separately, like you
would be working with SVN. Commits in 'master' will go to the
'master' branch, commits made in 'branches/branch-1' will go
to the 'branch-1' branch.
