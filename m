Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7845C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976C361C3B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGFWHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:07:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53014 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFWHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 18:07:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BF5B149CC2;
        Tue,  6 Jul 2021 18:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=17AUkyqVWvYmtqWzKjY6RB1M2/fHhdY1X/aa+F
        9zpGw=; b=WwN4BTSYtbTjv0soTfHrcAdTi2p3q1dDHN4OREcsBBbgqxAyC3guGE
        aX6can2AcmNB3BE571R8dFQ7p0RMVkhCYxYuEUkHERo9zrFsJa2FTupMSQNjpPw5
        Qwp3Np80m0GtdvwOPfB5qRGSFMLP6agNTDbfOfr7oAIX8FYW6RDRk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 924B0149CC0;
        Tue,  6 Jul 2021 18:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DB90149CBD;
        Tue,  6 Jul 2021 18:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.32.0(2)
References: <20210706213745.4758-1-johannes.schindelin@gmx.de>
Date:   Tue, 06 Jul 2021 15:04:28 -0700
In-Reply-To: <20210706213745.4758-1-johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 6 Jul 2021 21:37:45 +0000")
Message-ID: <xmqq7di3gkur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 232844D0-DEA6-11EB-8CFD-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.32.0(2) is available from:
>
>     https://gitforwindows.org/
>
> Changes since Git for Windows v2.32.0 (June 7th 2021)
>
> New Features
>
>   * The Windows Terminal profile is now identified by a GUID, for more
>     robust customization.
>   * Comes with GNU Privacy Guard v2.2.28.
>   * Comes with Git Credential Manager Core v2.0.475.64295.
>   * Access to remote HTTPS repositories that requires client
>     certificates can be enabled. This is now necessary because cURL no
>     longer sends client certificates by default.
>
> Bug Fixes
>
>   * The built-in file system watcher could hang in some scenarios. This
>     was fixed.
>   * Remote HTTPS repositories could not be accessed from within
>     portable Git installed into a network share. This has been fixed.
>   * When scrolling in the pager (e.g. in the output of git log), lines
>     were duplicated by mistake. This was fixed.
>   * The git subtree command was completely broken in the previous
>     release, and was fixed.
>   * A bug was fixed where remote operations appeared to hang (but were
>     waiting for user feedback on a hidden Console).
>   * A bug was fixed where the experimental built-in file system watcher
>     had a problem with worktrees whose paths had non-ASCII characters.

Nice.

Thanks.
