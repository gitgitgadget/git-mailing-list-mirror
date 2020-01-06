Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A6C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2184206DB
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vl8Put8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAFRN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:13:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56500 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgAFRN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 12:13:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47A77223D0;
        Mon,  6 Jan 2020 12:13:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=woM7kcU6dWU4zi+RjX2kif5JKYY=; b=vl8Put
        8nDOWQ8xLWRMzqRIBXgNNoqYyKYWE8oi7xiwiWRIcrA/4k/E6o0shJgtZ1GpVSaT
        oCzqh2Whr5jIEbGyz1fFXGvyC3JMDfez89FjJ/mqfxo0ZzgmLP2sRrKFSB6WHrhO
        sjXStF35PxqimiLqa3VjQEmx6jwyJOWymQhGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T6OXjRmdbFAKeiknCw2k3QRCM03iWSAA
        k1JZ9G1x6QzhLQ4C4P3+RJmX1ZbIH/pULEQ4VSNfOwuoIo5vKN1BtlicEvfp1JwY
        qnLmomUFLPnTNa+B3d+WE7r8bLq7A8KDat3L5/mD5WbFZZUJ2kYkwjMGqH0a8OU2
        +JnS0xlxo60=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F179223CF;
        Mon,  6 Jan 2020 12:13:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97139223CE;
        Mon,  6 Jan 2020 12:13:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "elonderin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, thomas menzel <github@tomsit.de>
Subject: Re: [PATCH 1/1] doc: submodule: fix typo for command absorbgitdirs
References: <pull.688.git.git.1578322213.gitgitgadget@gmail.com>
        <b032358ca97df3bd5605ff356196f82a1f16a320.1578322213.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jan 2020 09:13:53 -0800
In-Reply-To: <b032358ca97df3bd5605ff356196f82a1f16a320.1578322213.git.gitgitgadget@gmail.com>
        (elonderin via GitGitGadget's message of "Mon, 06 Jan 2020 14:50:13
        +0000")
Message-ID: <xmqqlfqka4oe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EADEDF42-30A7-11EA-80F3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"elonderin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: elonderin <8225602+elonderin@users.noreply.github.com>
>
> The sentence wants to talk about the superproject's possesive, not plural form.
>
> Signed-off-by: thomas menzel dev@tomsit.de

The author of the patch must sign-off, so the above three lines
should look more like so:

	From: Thomas Menzel <dev@tomsit.de>

	The sentence wants to talk about the superproject's
	possesive, not plural form.

	From: Thomas Menzel <dev@tomsit.de>

The content of the patch obviously is correct.

Thanks.

> ---
>  Documentation/git-submodule.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 22425cbc76..5232407f68 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -248,7 +248,7 @@ registered submodules, and sync any nested submodules within.
>  
>  absorbgitdirs::
>  	If a git directory of a submodule is inside the submodule,
> -	move the git directory of the submodule into its superprojects
> +	move the git directory of the submodule into its superproject's
>  	`$GIT_DIR/modules` path and then connect the git directory and
>  	its working directory by setting the `core.worktree` and adding
>  	a .git file pointing to the git directory embedded in the
