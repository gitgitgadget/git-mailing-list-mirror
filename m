Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F2FC4321E
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCF061BE5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbhKOV2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbhKOVWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 16:22:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D6EC035443
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:05:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so33248783wru.13
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 13:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:in-reply-to:message-id:references:user-agent
         :mime-version;
        bh=9Tu9sSmKCf3vc1PuhqX9EeRG6NilkInwzsWT0/NKOVM=;
        b=cGTtP0BLa384bMWL4ySHjRlbIkqM4ojKuAlJVhqPu0e+aCVG/tuQXckSQRkPJ/binK
         dawudjZ+gTNdjv7FFcGlRwJ3ZVCl2x3nkye28z+2rXVQGyFAufpziyfYW+CbOwlWVeVq
         8owxtXsKXYfT4mIex+AS6CGmTNt4C6leqMIS7sU9IUxAq14e590fG+QZcvmiKekEXr/I
         A04ne5DRM5gHDGKcdTv0CdeaZUA9rhPaBStUaORWXzH5kxiJCoP5+yS0BhiSa8dcVfiz
         lbBXS2wvtr+GtjGYctVz1tehh0gpAq1ZG+gnlbjOi3rXonZ9SupiAx0qWYS5BUJSJgfN
         apHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9Tu9sSmKCf3vc1PuhqX9EeRG6NilkInwzsWT0/NKOVM=;
        b=58CFz2Rm0aKasFFUnkY3+oojqvZOHQUw17XA3ARGwFi1tfn7JZSOyFatQsNMZDt2vX
         9eeF8+4tL24Vz3WC8a/nu/e0l1g5RQRSVIn3GKHT6b+0DjyLzA1UpwjNV8m/xxHc8qIR
         DBK5knlacWaEuiEvut5KTQkedec5WkXut0DpZuEfL4S0akptNKgho9+0sHeWjOZ/H0Ko
         EowugUsCLIWaDTucVNEolfPzyATuaGIFkkWcvgdrw9lQMSIw9gRgK6LpI894FHj9N3U1
         yDhc5dzw1+7sLcG0dp8GNX0j7OMA8OFVQn7TEkAEMB2+jqiFW9NBe9CxyVaXEbQlAIVW
         URhA==
X-Gm-Message-State: AOAM533g/BY1oi6fkJY/0gzFgYLtlXonStK+RdVVUw5EDIjpQCn0VUUi
        Wq6RByzyVs26COA7PScAynUtuLJn6ds=
X-Google-Smtp-Source: ABdhPJwlOTDLurj9oxi+gg+nuSuFwYUbV6VDMCJELKqZkIkuecYX84gUnBVaPMpQ2XmauqODSshk4w==
X-Received: by 2002:a5d:4143:: with SMTP id c3mr2694616wrq.254.1637010347151;
        Mon, 15 Nov 2021 13:05:47 -0800 (PST)
Received: from [172.27.166.205] (cgn-89-1-213-220.nc.de. [89.1.213.220])
        by smtp.gmail.com with ESMTPSA id c16sm14976401wrx.96.2021.11.15.13.05.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 13:05:46 -0800 (PST)
Date:   Mon, 15 Nov 2021 22:05:32 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmail.com>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: Resend: [ANNOUNCE] Git for Windows 2.34.0
In-Reply-To: <20211115195335.5290-1-johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.2111152204530.21127@tvgsbejvaqbjf.bet>
References: <20211115195335.5290-1-johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

re-sending because vger once again ate my mail.

On Mon, 15 Nov 2021, Johannes Schindelin wrote:

> Dear Git users,
> 
> I hereby announce that Git for Windows 2.34.0 is available from:
> 
>     https://gitforwindows.org/
> 
> Changes since Git for Windows v2.33.1 (October 13th 2021)
> 
> New Features
> 
>   * Comes with Git v2.34.0.
>   * Config settings referring to paths relative to where Git is
>     installed now have to be marked via %(prefix)/ instead of the
>     now-deprecated leading slash.
>   * Comes with Git LFS v3.0.2.
>   * Contains new, experimental support for core.fsyncObjectFiles=batch.
> 
> Bug Fixes
> 
>   * Configuring a system-wide VS Code as Git's editor was broken, which
>     has been fixed.
>   * It is now possible to clone files larger than 4GB as long as they
>     are transferred via Git LFS.
>   * Git now works around an issue with vi and incorrect line breaks in
>     the Windows Terminal.
> 
> Git-2.34.0-64-bit.exe | 2a833d15f97539e845b3883e375a8a152e8199b63ac345282d80f834f7d6a9b6
> Git-2.34.0-32-bit.exe | e665d6d2e454bfe2a9172e326becf00a8d82d0de080cebdae4218d1727b1897e
> PortableGit-2.34.0-64-bit.7z.exe | 12f6aed40fdf2d409dc61d5d1626eed97b0e818549d92626bfffdd7bc580855c
> PortableGit-2.34.0-32-bit.7z.exe | 46643dde0f40bee6e7963b9d67ec2f78ffc6882d452b866940e5fe5724dbdba3
> MinGit-2.34.0-64-bit.zip | e53818f68308a8f7988f37e2b56f4e8da2aa93b279b6a70c87a21972c7c4ab93
> MinGit-2.34.0-32-bit.zip | a8b68a86e999e5c6caf0bf79a92a20631c6b3d9c90404db49f27ed2244d3cb11
> MinGit-2.34.0-busybox-64-bit.zip | 5812ef40a0f03f917128f3b4866a7d463932b7f0b2744ac901f00c6434eedce2
> MinGit-2.34.0-busybox-32-bit.zip | bfbd5c5dc95d094616f40bd3d27833434b5c3d5dc8a5f3285236b50f6eee93d7
> Git-2.34.0-64-bit.tar.bz2 | dcbfd2b24c321973bbd7e27ef841be07749668a0a75c3fad1ddec933154d85d6
> Git-2.34.0-32-bit.tar.bz2 | 1b1961c9875edf35aca188e5182b80b1b6d0adae50c01f99f314b83c0062fdc5
> 
> Ciao,
> Johannes
> 
