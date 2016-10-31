Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C35020229
	for <e@80x24.org>; Mon, 31 Oct 2016 10:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbcJaKl6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 06:41:58 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33857 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765798AbcJaKl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 06:41:57 -0400
Received: by mail-vk0-f47.google.com with SMTP id x186so42363561vkd.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=52aoRyJKJuPBZRkpYLEeqA02urnc/6xJVkBxE46LgRY=;
        b=yoXpNzrZqRThfUzJxs2lKuJMfNEqzYEc6FcnYLeZomexxJb9G4GhDvT1bUm/HJBA4O
         kAIQpVp63WCDKKJUT+V08YZ2TX7cmzR/7ah00AL+ffZ4xuCd4XWdqlGTZi1/tZKL6GWm
         6k8hdoIIkMLKX2cUhHbxdaa1xtnB8vEOwUTgMoMAkuIpCwnhVCrEYcV9iZeConbSRL6t
         yqXYBdvXimDBH/2cBnwXpYtFXW0Af8n4I+rt7PDVfZ0urFUF0PwWVkaLljFc7I1i+1Ji
         7J+OCvOBdC1V9FUfEmicEYrQbtmumAP1RQ/XKiZFX+/07KsjWPXwylYb3rAIO5hzpBRF
         PBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=52aoRyJKJuPBZRkpYLEeqA02urnc/6xJVkBxE46LgRY=;
        b=cfyoduN4w9ovwMQgFK9MJBn47JPcrTIS/O0OQfiTeLyoRFuJabiCj6Rm8RSwBbpnPb
         +rPW62owJNQPiOFqo3zSsIpQ8TImJcCd12xA2X4wjX1OC+MQwobllJK16uVsJ2ZYgV3q
         dU8zdjb3pUvyTSvw0QtodpcQPjrUzGyXaw+I4QdoqCRvBJdOtaYy3XcVTyqfsBr3qefJ
         s/Imed0dpKNFetqcjdNMHRSF5rU9NRyTHJpYqm4Hjp0sTLJW3pS0pJ/yltkRMTXM2Gd+
         Lx5JWuELKH+R7UiP03Tsk5cROAAQkZadp959bfpRpRDITe0g4WAM01DGDdIBS/Wrr4yG
         r4yg==
X-Gm-Message-State: ABUngvfDegGLEnZd/vaU+vHRkIlOY44iNjTjrN5k/oHNm5v3+t1FCaw0CW09paYkmgEQzCrXE1raFPMqCgSiPQ==
X-Received: by 10.31.85.4 with SMTP id j4mr22622351vkb.8.1477910516716; Mon,
 31 Oct 2016 03:41:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.133 with HTTP; Mon, 31 Oct 2016 03:41:36 -0700 (PDT)
In-Reply-To: <CALhvvbYE6Tt3eByDVMB3a4t=nm3dScVZSea0Z1SsKVgwFSiQ-w@mail.gmail.com>
References: <CAJtFkWs4qYCqnbJD+zCRCAW3teczb4CdvncvYoMN_VvthJGr=w@mail.gmail.com>
 <CALhvvbYE6Tt3eByDVMB3a4t=nm3dScVZSea0Z1SsKVgwFSiQ-w@mail.gmail.com>
From:   Stefan Monov <logixoul@gmail.com>
Date:   Mon, 31 Oct 2016 12:41:36 +0200
Message-ID: <CAJtFkWtsG9zRuL+BSTG-Wgjo+DZJpxobCXK94y-grgN7UTzULA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Is_the_entire_working_copy_=E2=80=9Cat_one_branch=E2=80=9D=3F?=
To:     Alexei Lozovsky <a.lozovsky@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Alexei!

On Sat, Oct 29, 2016 at 12:47 PM, Alexei Lozovsky <a.lozovsky@gmail.com> wr=
ote:
> Hi Stefan,
>
> Generally with git, your entire working copy will have the same
> revision (set to current branch, aka HEAD). The idea behind this
> is that your working copy of a repository should always be in
> consistent state.
>
> You can check out specific files or directories from another
> revision (mimicking "svn update -r1234 filename"):
>
>     $ git checkout branch-or-sha-hash -- filename
>
> However, SVN tracks the 'revision' thing on per-file basis, while
> in git this is a property of the working copy. So if you do like
> above then git will be telling you that the 'filename' has been
> changed (as it is certainly different from its pristine version
> in HEAD):
>
>     $ git status
>     On branch master
>     Changes to be committed:
>       (use "git reset HEAD <file>..." to unstage)
>
>             modified:   filename
>
> So it's generally not recommended to do such a thing.
>
> Another thing that you _can do_ in git to mimick SVN is the
> 'standard layout'. There is a feature called "git worktree" which
> allows you to have SVN-like directory structure with multiple
> directories linked to different working copies:
>
>     $ mkdir my-project
>     $ cd my-project
>     $ git clone my-project-repository master
>     $ mkdir branches
>     $ cd master
>     $ git worktree add -b branch-1 ../branches/branch-1
>     $ git worktree add -b branch-2 ../branches/branch-2
>
> After that you will have directory structure like this:
>
>     $ tree my-project
>     my-project
>     =E2=94=9C=E2=94=80=E2=94=80 branches
>     =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 branch-1
>     =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 1
>     =E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 2
>     =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 3
>     =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 branch-2
>     =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 1
>     =E2=94=82       =E2=94=9C=E2=94=80=E2=94=80 2
>     =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 banana
>     =E2=94=94=E2=94=80=E2=94=80 master
>         =E2=94=9C=E2=94=80=E2=94=80 1
>         =E2=94=94=E2=94=80=E2=94=80 2
> You can work with these working copies separately, like you
> would be working with SVN. Commits in 'master' will go to the
> 'master' branch, commits made in 'branches/branch-1' will go
> to the 'branch-1' branch.
