Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D922DC433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9968464E4E
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 20:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhB0Ur7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 15:47:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51069 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhB0Ur6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 15:47:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E218312C013;
        Sat, 27 Feb 2021 15:47:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wlh5j+a76KR7N5yILFJNRqwom2Y=; b=XkTKTE
        74Ye9PQpfGFOOSuD6KjFaoyDLPzkalLLOVFD7uAIIgi+FvQ2C7+fIDdQXW+mG8gw
        fIpH89TgUg6eWCfw00Nu6Q+Y+HVlpdnS1Xz43k8h19NZWTONYIx2NkIHfysVg4Hv
        vNxPoy9VV3TSgGwmy4iwwTRIJ/xubZFYPx3Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=azUnAGYdhnjhchBLCskKHZSprBRL+nkz
        apFmSs0sDcS0+mzJRjPnqdlqip60fCfosm0pcz/3eydxbhRK/O2+GHjQK6MWqAkk
        BS5oDCraWLPDwp5CfUF8oT0RVKKO58y/M+V5Wicbow5855iUUyfkxmZUEbsEjiOZ
        d9/dEyQFelU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB1C012C012;
        Sat, 27 Feb 2021 15:47:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49E9012C011;
        Sat, 27 Feb 2021 15:47:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: [GIT PULL] git-gui pull request
References: <20210226161001.x3j2pligndqnzlbu@yadavpratyush.com>
Date:   Sat, 27 Feb 2021 12:47:12 -0800
In-Reply-To: <20210226161001.x3j2pligndqnzlbu@yadavpratyush.com> (Pratyush
        Yadav's message of "Fri, 26 Feb 2021 21:40:01 +0530")
Message-ID: <xmqq5z2ds0fj.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F82636E4-793C-11EB-89EC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Hi Junio,
>
> Please pull the changes in git-gui for v2.31.
>
> ---
> The following changes since commit 
> 7b0cfe156e1f1fbb77ab35d55d48eef41625944d:
>
>   Merge branch 'sh/inactive-background' (2020-12-19 01:02:34 +0530)
>
> are available in the Git repository at:
>
>   https://github.com/prati0100/git-gui.git 
>
> for you to fetch changes up to b1056f60b63f1bc8226d01881bc829e171fc78bf:
>
>   Merge branch 'py/commit-comments' (2021-02-22 20:19:53 +0530)

Thanks, will do so when I come back to my main development
environment.

>
> ----------------------------------------------------------------
> Mikhail Klyushin (1):
>       git-gui: fix typo in russian locale
>
> Pratyush Yadav (3):
>       Merge branch 'mk/russian-translation'
>       git-gui: remove lines starting with the comment character
>       Merge branch 'py/commit-comments'
>
>  git-gui.sh     |  5 +++++
>  lib/commit.tcl | 18 ++++++++++++++++--
>  po/ru.po       |  2 +-
>  3 files changed, 22 insertions(+), 3 deletions(-)
