Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23472C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 20:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D0A2075E
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cZrDgNjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439728AbgJQULz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 16:11:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51163 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439725AbgJQULz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 16:11:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BABB105B6E;
        Sat, 17 Oct 2020 16:11:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LjU3VIrVplrcT0wjeutxkNZCKAA=; b=cZrDgN
        jG3wWWvmExu3B7x2erXARtZa0kwaFxMuvOK5uBNh4mmp9K6mkuQhqXdpuVZdochG
        e++0aYX/pH/hjDFcy8SP8gq0t7vorXDSN2Ggkj+4C/ETSAkXXEhdkhgc99g1NDyz
        IwzmjAQlcCwrmoCxV1KZsRzRzGJ1LqwJ0MGqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OVJ2VDtzZ0fYrGvGvRgGPvat4EDxKCGc
        8o5L7S9SW509n1m+6IgUPJ1yedMjtldc6K0q/XOrO1Jkn+xm1kD2Sou9FaTkgd/i
        49qk6wesBdrwaPDw5P9ax7rK2VaLru7QkPhVRsOufloIdQ9+tcPJqTP1uMMSyr8X
        2QEhazBJ0DI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44658105B6D;
        Sat, 17 Oct 2020 16:11:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D740105B6C;
        Sat, 17 Oct 2020 16:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GIT PULL] git-gui changes for v2.29
References: <20201017163411.hk7tqwzyqzvynf6c@yadavpratyush.com>
Date:   Sat, 17 Oct 2020 13:11:48 -0700
In-Reply-To: <20201017163411.hk7tqwzyqzvynf6c@yadavpratyush.com> (Pratyush
        Yadav's message of "Sat, 17 Oct 2020 22:04:11 +0530")
Message-ID: <xmqqmu0k8vej.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDF725B0-10B4-11EB-B90A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Junio,
>
> Please pull in the changes in git-gui for v2.29. 

OK, thanks.  Pulled but not pushed out (yet).

By the way, next time we might want to arrange subsystem pulls a bit
sooner than immediately before the final---what do you think?

> The following changes since commit 
> 469725c1a3d44f7e1475f1d37cd13e0824d4ea41:
>
>   Merge branch 'mt/open-worktree' (2020-06-22 20:23:28 +0530)
>
> are available in the Git repository at:
>
>   https://github.com/prati0100/git-gui.git 
>
> for you to fetch changes up to 38c2ac2e2ab00a8bcef528f24cb5b883b4413e5c:
>
>   Merge branch 'sh/blame-tooltip' (2020-10-17 15:05:27 +0530)
>
> ----------------------------------------------------------------
> Pratyush Yadav (3):
>       Merge branch 'st/spaces-tabs-cleanup' into master
>       Merge branch 'st/dark-mode' into master
>       Merge branch 'sh/blame-tooltip'
>
> Serg Tereshchenko (2):
>       git-gui: fix mixed tabs and spaces; prefer tabs
>       git-gui: improve dark mode support
>
> Stefan Haller (1):
>       git-gui: blame: prevent tool tips from sticking around after Command-Tab
>
>  git-gui.sh     | 103 ++++++++++++++++++++++++++++++---------------------------
>  lib/blame.tcl  |   1 +
>  lib/themed.tcl |  38 +++++++++++++++++++++
>  3 files changed, 93 insertions(+), 49 deletions(-)
