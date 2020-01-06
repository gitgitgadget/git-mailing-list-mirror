Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F2C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1394620715
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TEQXwdUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFRSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:18:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62056 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgAFRSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 12:18:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1553AD3EF;
        Mon,  6 Jan 2020 12:18:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DyCQpfoL2VHYdjN1HF7NneijJJ4=; b=TEQXwd
        UeuWXiH/c1UwRnHByfX4/wCBvmwS15coRp4HpWAL2gN7udpCraSSOQp2s6nid6BR
        MFZVWsa5MWER/Cb8UwYPUGPqLMwNMSguM7C0TfMQI5HW0jj+OdbGDmwwjnu4S6lM
        NBYNrlgXxFI4NlVNlxs/LzLSWaRjoKnNv9wCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WYkio7HNfZHMqaqRYV1Yr7Clm2kfUn86
        G/9ZDM9PAxyx8MIBmLCwijKUOpf+CiXP+vOu3NzYfnyn+T3QhFZ+BrV4iYhI2xB0
        SAZ/HRBpBlBB1sch/Me2SyfQ6aJxjI0bMTJj2W5qdea35Tzel/JJfDcl17uaZQZl
        ALqaBuO9NU4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99809AD3EE;
        Mon,  6 Jan 2020 12:18:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D362AAD3ED;
        Mon,  6 Jan 2020 12:18:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, thomas menzel <github@tomsit.de>
Subject: Re: [PATCH 1/1] doc: submodule: fix typo for command absorbgitdirs
References: <pull.688.git.git.1578322213.gitgitgadget@gmail.com>
        <b032358ca97df3bd5605ff356196f82a1f16a320.1578322213.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jan 2020 09:18:18 -0800
In-Reply-To: <b032358ca97df3bd5605ff356196f82a1f16a320.1578322213.git.gitgitgadget@gmail.com>
        (elonderin via GitGitGadget's message of "Mon, 06 Jan 2020 14:50:13
        +0000")
Message-ID: <xmqqblrga4h1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8990A788-30A8-11EA-AE7B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When anybody tries to respond to the quoted message [*1*] that came
from GGG in the way recommended for the list, the
*.noreply.github.com address gets placed on the Cc:, which is
probably not wanted.

Can GGG do something about it?  As GitHub specific service, it is
not wrong for it to know what noreply.github.com means so dropping
such an address from its Cc: line shouldn't be too difficult.

Thanks.


Reference *1* 

<b032358ca97df3bd5605ff356196f82a1f16a320.1578322213.git.gitgitgadget@gmail.com>


"elonderin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: elonderin <8225602+elonderin@users.noreply.github.com>
>
> The sentence wants to talk about the superproject's possesive, not plural form.
>
> Signed-off-by: thomas menzel dev@tomsit.de
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
