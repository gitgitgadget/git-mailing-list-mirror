Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8781F209FD
	for <e@80x24.org>; Thu, 25 May 2017 12:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765794AbdEYM64 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 08:58:56 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33209 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765780AbdEYM6y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 08:58:54 -0400
Received: by mail-oi0-f47.google.com with SMTP id w10so279311463oif.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rf/U/BVLhKdmVOicYP2KE5GzrZHob/oeXY8tQFl3KWA=;
        b=l+zLVLtR/0PG7buy3HkLtLWStG9VOLb6ER/bYAz0DhA1Ntxmw73H9jqQza3gEPuSsR
         fB2b2USfubcQDsqnTxHe01X7ZJJYfFO0c9XhB791vMnwVy/ZB5RxNU6otWPT7q5hMZ0i
         p86mZfR8q+oL6M916KWSdgLHcUTApbkvF5cPgxtZk9jauddzxrVHcHq1F7wh1cDgslJG
         KDqXDhadB4SSEiadvyVQv2z9PCyhnS4/U0Cfah8k0waxkVJjeDPN4P+igNymNKwmctLJ
         4lt1JS2FG1m8NRILxnsTt0+ZsYeyE/+NJeiStNfeqCpgu7PYzgXiO3CT4ZpUG0Js5bMH
         vAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rf/U/BVLhKdmVOicYP2KE5GzrZHob/oeXY8tQFl3KWA=;
        b=DHyt8Nfb/XDAqr32tTF7jzV/JXV5j8UWUI7LMHAVGlWT/V1LsZbgSjZBneWPrOG7r4
         B5UPTi6Ns1Qmo9csUMiBabYIzcA2CRixW/SUUAV2lp+Pa+kyQgbrgFSIkXAZNaqHeEKH
         8nkd7+HeZEvaod5IEcwGYzu0vdT8HfxOvZWuUSOqpCmC1van3DXtkZ8DEdOo6W2OvbOX
         BgZsPn9trQehD3OAhZgTL/UQ850/vV2f9bLcHMSgYuzo79RsGDloNCuL+IwgZJiYtQzs
         uSGaxdyh4eAkEeVPbHq86Ks0ReT97ikQLWVf/fYs8LFlEwSlRG23m8sY5828VPYd7J0Y
         Yw1A==
X-Gm-Message-State: AODbwcAt50be9XkSo1p1PsCrGQ4H5zcooZRgJpozwzwb5TySIpNtpyMw
        MQ0gLERLs0i5tUd8jy2Ue/uMP0TMrahf
X-Received: by 10.157.23.47 with SMTP id i47mr6975642ota.179.1495717134023;
 Thu, 25 May 2017 05:58:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Thu, 25 May 2017 05:58:23 -0700 (PDT)
In-Reply-To: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
References: <xmqqo9ulo1yn.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 May 2017 19:58:23 +0700
Message-ID: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #06; Mon, 22)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/fopen-errors (2017-05-09) 23 commits
>  - t1308: add a test case on open a config directory
>  - config.c: handle error on failing to fopen()
>  - xdiff-interface.c: report errno on failure to stat() or fopen()
>  - wt-status.c: report error on failure to fopen()
>  - server-info: report error on failure to fopen()
>  - sequencer.c: report error on failure to fopen()
>  - rerere.c: report correct errno
>  - rerere.c: report error on failure to fopen()
>  - remote.c: report error on failure to fopen()
>  - commit.c: report error on failure to fopen() the graft file
>  - log: fix memory leak in open_next_file()
>  - log: report errno on failure to fopen() a file
>  - blame: report error on open if graft_file is a directory
>  - bisect: report on fopen() error
>  - ident.c: use fopen_or_warn()
>  - attr.c: use fopen_or_warn()
>  - wrapper.c: add fopen_or_warn()
>  - wrapper.c: add warn_on_fopen_errors()
>  - config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
>  - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
>  - clone: use xfopen() instead of fopen()
>  - Use xfopen() in more places
>  - git_fopen: fix a sparse 'not declared' warning
>
>  We often try to open a file for reading whose existence is
>  optional, and silently ignore errors from open/fopen; report such
>  errors if they are not due to missing files.

If anyone wants to continue this, I've cleaned up the series based on
Johannes comments here [1]. It does not have the Darwin change though.
There was the last question about the '*' test change in ref path and
what exact code change causes that, which I can't answer because I
don't have Windows, or the time to simulate and pinpoint the fault on
Linux.

[1] https://github.com/pclouds/git/commits/fopen-or-warn
-- 
Duy
