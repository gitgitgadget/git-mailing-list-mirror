Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68BC1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 14:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeBHOXC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 09:23:02 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:39625 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHOXC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 09:23:02 -0500
Received: by mail-lf0-f44.google.com with SMTP id x20so4686817lff.6
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 06:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IcWjy8Abh/x6t3kXiZMxHpYP7amE3Ysi17W0dgJ+CXQ=;
        b=lsrO5X2UpNeZEEBs0VzQxntx563PsjLoq09OIsQTCAVmRpPASbG1FLBRMfpv2p+g7+
         8kPy0KWjRpqZpoJUbFtHQDfTEqOhMnKq7l4yBmHDNgv0n/uIOJGWUZqHN8gJn8cl4Tj0
         UzdPKAYW8cjEjnJWDl6U46dujOdYM5pKAdlsky8N5SSgNzuU1y8Mkj6ipUPoCDud0BRh
         Uu0KwxgRUB3DId9PBecMLkUyfdQMguT682m4nwwjq3LJgiFLN5s8bJf3D+sVzHhyJDKj
         kHoBpBJF/zCExYsqmMjSzD1np0Rt77qeU2thMA7XfSLhQYlX307iu5/8K0KZQae9Y3do
         v/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IcWjy8Abh/x6t3kXiZMxHpYP7amE3Ysi17W0dgJ+CXQ=;
        b=lHalWeDVI5b+wQ4diGjUhOluwEzxjg87gxKYkwsSu1Q5c/BIFzI3wsB82pelRW5sOg
         gN5W9OshEEoa8sQpjUWjqyp4Kwpwje7U1uYnasXUmXDnvIQoRQKu57hKkzBpvhQmYyN2
         IqnjWBcwSyj7BWVUtbvGCDAmZsCHRN6IZIFbWMyKyOq9FWnqAzLoGlQ0fLZi/Twb9kZ4
         C017ERF9yWbSz/2Cqoie+izbPgKh7/zKKgrqvswj0VznI9BgK7PSHrFCNZ5zJo+MNhH4
         3SmjPURLAyGpHydUdUTkKcZ6nuJMtTf5TMaS5d07AhMiKZ5sMJsDlxAaRoWGNfccsH7x
         Qggw==
X-Gm-Message-State: APf1xPADi9g9QJGiwW3vwwhaV5nORaMUXJYvN0797gure2pSiNIqmrBW
        g1P4QKNxQ+bvRH9NsguFNKkfRYndGVsDn/roK9A=
X-Google-Smtp-Source: AH8x225zLQSS+RASEiz5ysU72HUvPOp7RYY15YO1XuiWbP/NOWTxWw7IhehzRr8/4D/UvtnGmjUgvPz8Vz6CNJTUcYE=
X-Received: by 10.25.213.19 with SMTP id m19mr683266lfg.4.1518099780451; Thu,
 08 Feb 2018 06:23:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.125.26 with HTTP; Thu, 8 Feb 2018 06:22:59 -0800 (PST)
In-Reply-To: <131f3b0f-0002-2823-d64b-ffd16fff8dfa@wp.pl>
References: <29b0272d-7854-592d-5e1c-3a4f0d347bd1@wp.pl> <131f3b0f-0002-2823-d64b-ffd16fff8dfa@wp.pl>
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Thu, 8 Feb 2018 09:22:59 -0500
Message-ID: <CADfK3RWXJyFWPUds1Q2qQS-w-Kwh8jKmO9VWCAgueo434LSYcg@mail.gmail.com>
Subject: Re: Automatic parameters completion
To:     Andrzej <borucki_andrzej@wp.pl>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 9:03 AM, Andrzej <borucki_andrzej@wp.pl> wrote:
> I have Linux Mint and its terminal besides usual completion (add file name
> when type first letter and press tab) also can complete git parameters. How
> is doing this? Bash knows git or bash has special interface to completion
> and git uses it?
> I want in my Linux program apply this mechanism.

Various shells include support for completion of git parameters. These
completion functions may be enabled by default in your distribution.
For example, zsh has vcs_info[1]. There are also scripts included in
git (contrib/completion) [2] to do this.

[1] http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
[2] https://github.com/git/git/tree/master/contrib/completion
