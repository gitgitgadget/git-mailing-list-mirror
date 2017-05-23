Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3BB1FF30
	for <e@80x24.org>; Tue, 23 May 2017 08:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762240AbdEWIBs (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 04:01:48 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37982 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759397AbdEWIBr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 04:01:47 -0400
Received: by mail-it0-f48.google.com with SMTP id r63so14962311itc.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1GSDosIdyiGzYMu7o6rcJH4I5lXjgG+AZM64KxNgpYA=;
        b=HwUHBBELh8q9bkqLEsRY1OaP/wF3OgIW9puge50HmQp+1jh1ZVjd+NH+K4eFobdHhC
         0bzCdoak3VSgOKUGSJlR0x6vd+r3XHPlXn6lkFU+bKlC2YLq2fIenksx1GwQ96CXgcWU
         5Bqzj83viLnMow04F31K7Jv0s+3hq9SEOIG7dGbjgwewOdJUPcT29SCwxjTSaTOfifbw
         BFczrhngYk7jJQKDW+5AkCp+ANWhCsGnvLvuYqD+QNDsaNd9C28MaztNe2lBD7wvqsrN
         XY8RI9OQcXvJHD2JvLCoZl3XrII5egwWHDx4kStycbYGFYXDWyUZB6Zz6SBXOq/OIHUU
         8NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1GSDosIdyiGzYMu7o6rcJH4I5lXjgG+AZM64KxNgpYA=;
        b=MaWYxMXwSuZ4togYYU+M7796MXut7DaCSzGlVA2qyv+Pw69JcpmSybs5fJ9jp/3aEU
         Vk4uxQFKHfEwHGzIZ1CvyUDYkHXm0+I8L4VXojYHH/PUPhZ/BiueTilXNutOk5ZR1xyk
         8v6/JqEhLsLkYgO3TD1sLnUczuUgwEYftnAdGabjw6QPmFCyZ6vOvPKDweqBsp6zkHD/
         l4m1zscNmMD2Pp9v+RQ5j4KNKM3ltW2+XMxBPAR3/VGN6OkZGqJ7Z0Z8lv/lXxQV8xp5
         d2mILG8Ig0pygTXstENm4wwrJyayqmZUgLgInSyvPkc4/eTalThVVNS18GGSQAjjS8Ue
         mBIg==
X-Gm-Message-State: AODbwcAq3m9NP4zVZxrzJcTusSyGUHwE/Sp28ZMPvZvJ5RGdX58IpVMD
        rSVOftELI9dG1Flt1VVPKZnU6NvSZVetHI0=
X-Received: by 10.36.210.193 with SMTP id z184mr1450647itf.86.1495526506665;
 Tue, 23 May 2017 01:01:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Tue, 23 May 2017 01:01:06 -0700 (PDT)
In-Reply-To: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 23 May 2017 04:01:06 -0400
Message-ID: <CAJZjrdWXsuKrFzedLvyE-1mvD0RC5XYDkmvV3wRNWXjFAVt4iQ@mail.gmail.com>
Subject: Re: [Bug] cloning a repository with a default MASTER branch tries to
 check out the master branch
To:     =?UTF-8?Q?F=C3=A9lix_Saparelli?= <felix@passcod.name>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some reason the repo on GH does not have a HEAD pointer:

$ git ls-remote https://github.com/passcod/UPPERCASE-NPM.git
efc7dbfd6ca155d5d19ce67eb98603896062f35a        refs/heads/MASTER
e60ea8e6ec45ec45ff44ac8939cb4105b16477da        refs/pull/1/head
f35a73dcb151d336dc3d30c9a2c7423ecdb7bd1c        refs/pull/2/head
0d9b3a1268ff39350e04a7183af0add912b686e6        refs/tags/V1.0.0
efc7dbfd6ca155d5d19ce67eb98603896062f35a        refs/tags/V1.0.1

I'm not sure how you managed to do that, since GH rejects attempts to
delete the current branch, but I believe if you set the default branch
to MASTER it will work correctly.

On Mon, May 22, 2017 at 5:42 PM, F=C3=A9lix Saparelli <felix@passcod.name> =
wrote:
> Hi,
>
> I created a git repository that, for joke reasons, has a single branch
> called MASTER (in uppercase). Upon cloning this repo, git attempts to
> checkout the master branch (in lowercase), which does not exist.
> Checking out the MASTER branch manually afterwards works.
>
> $ git clone git@github.com:passcod/UPPERCASE-NPM.git
> Cloning into 'UPPERCASE-NPM'...
> remote: Counting objects: 14, done.
> remote: Compressing objects: 100% (11/11), done.
> remote: Total 14 (delta 3), reused 14 (delta 3), pack-reused 0
> Receiving objects: 100% (14/14), done.
> Resolving deltas: 100% (3/3), done.
> warning: remote HEAD refers to nonexistent ref, unable to checkout.
>
> $ cd UPPERCASE-NPM
> $ ls -a
> . .. .git
> $ git branch
> $ git checkout MASTER
> Branch MASTER set up to track remote branch MASTER from origin.
> Switched to a new branch 'MASTER'
> $ ls -a
> . .. .git NPM package.json README
> $ git branch
> * MASTER
>
> Some platform information:
>
> $ git version
> git version 2.12.2
>
> $ uname -a
> Linux felix-probook 4.10.13-1-ARCH #1 SMP PREEMPT Thu Apr 27 12:15:09
> CEST 2017 x86_64 GNU/Linux
>
> Git was installed from the default Arch Linux package.
>
> Thanks,
> F=C3=A9lix
>
