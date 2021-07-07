Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5470C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F4D61C77
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhGGTkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:40:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53614 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhGGTkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 15:40:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B2FCC1F8C6;
        Wed,  7 Jul 2021 19:38:14 +0000 (UTC)
Date:   Wed, 7 Jul 2021 19:38:14 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #01; Tue, 6)
Message-ID: <20210707193814.GA28947@dcvr>
References: <xmqqim1mgbty.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqim1mgbty.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> * ew/many-alternate-optim (2021-06-29) 5 commits
>  - oidtree: a crit-bit tree for odb_loose_cache
>  - oidcpy_with_padding: constify `src' arg
>  - make object_directory.loose_objects_subdir_seen a bitmap
>  - avoid strlen via strbuf_addstr in link_alt_odb_entry
>  - speed up alt_odb_usable() with many alternates
> 
>  Optimization for repositories with many alternate object store.
> 
>  Will merge to 'next'.

I've started working on a reroll to address feedback from René and Ævar;
but I got myself stuck on a 2-character typo bug :x

> * ew/mmap-failures (2021-06-29) 1 commit
>  - xmmap: inform Linux users of tuning knobs on ENOMEM
> 
>  Error message update.
> 
>  Will merge to 'next'.

Seems fine.
