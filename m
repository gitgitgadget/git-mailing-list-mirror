Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FBEC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B205264F5D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 06:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhBCGYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 01:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhBCGYV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 01:24:21 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE22C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 22:23:41 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a31so7947086uae.11
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PDtqcgKY4duYhCrD5JZVMN00p0m8HYb04Mg8T/y6Dx0=;
        b=obw9Nz2H6I07FKqPsPsg0viz3haYxZ+vVhMK07MC+dnzTJNexR7F3Mlgdam86/+FEV
         7gmldRAKqrtN4MYxId/AgjTCLrv3OwOJCQtmi9fRH7p4qMwSQ9lEZZ0qZ5sudtkhprPK
         SITlMJ+4tVSUIALdgbdhQ+hPBtxGc1P4g4JfmIsAmXTjr7OjmCYEZl9jLIM+edWWpJlH
         6DfbiEbLOWAq9Qmtx8/mCGwjGRy25DXhiPnj9uWLzOeVhcxQp37L0+8vKMUQMiSWzZeX
         UWUGxR7iVoHpALGazHLpLAZPDlaB9wcw/m9fRlggKF6ad4Sa92ofaPkDn6CFfzQeitmm
         AX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PDtqcgKY4duYhCrD5JZVMN00p0m8HYb04Mg8T/y6Dx0=;
        b=lF8IG6LsL8zwk4JoWVukUGlvCu+G5Zto9IC2ZhB6yb1sTrbmCYx33Nw2xuZ64sWw6g
         6LhsAPyeH/4sXJDO4keEVrJbTElr/Aw+TSrRYbyeUoojN5S+Fx9ydcxyS+8W4obKaB7C
         3VvyVmsRMF7041z2SifGsyp3oARCCPSE9Ezsyp+Sb3Uyyzp6c2uMh5H7cyDdyPFnUhhF
         gPqSsbpNMqDK87OoHU+mk/kBnb8nT2r7N68+d4ThBizIiyntfhfL6SLsu/5Qr1mUEMhN
         Uu8yKEcRh+BOLE24zJj0UUl3DBu7hsLjhkQf+NLVPnXT16kep821+/TjaIDBH9kAd6+J
         qD7w==
X-Gm-Message-State: AOAM533Qhwu1NbuisjCXFr2vmlRBYpJ97besymAL5TXdC8OVtaL3DF2z
        CvF2iD5+NhM5mP+5HefKkQ8uugStzkQe5hY6A3cyLyeeofgRNQ==
X-Google-Smtp-Source: ABdhPJy/B2NzwjVwN6XO0bTov86J1go50ZtoOhFwtaYhb17P9HiZ7g3yHXTjUl9U7LdOGCN9cyXn4jFuSz1FbB5EW1A=
X-Received: by 2002:ab0:310a:: with SMTP id e10mr952171ual.126.1612333420297;
 Tue, 02 Feb 2021 22:23:40 -0800 (PST)
MIME-Version: 1.0
From:   Murtaza Gandhi <murtaza.i.gandhi@gmail.com>
Date:   Wed, 3 Feb 2021 11:53:30 +0530
Message-ID: <CAC9ZHmfj2tii729jixAQUuM1EZ3GD08Ei5XxxuL17aWzRXT2pQ@mail.gmail.com>
Subject: GIT , Visual Studio
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have newly joined a team.

I will be working on repository at dev.azure.com

I want sequence of commands

How to use git with Visual Studio 2019

Do I have to add remote repository
or
I should clone remote repository

I want to create new branch and commit my changes on remote repository

Can I get all the command sequence , right from creating a local folder
and connecting with remote repository? If possible using Visual Studio 2019

I want to know about

push pull sync checkout and other commands

Thanks,
Regards.
