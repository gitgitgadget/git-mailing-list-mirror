Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B69E7C4E2
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 16:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbjJDQ4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjJDQ4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 12:56:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119CD9B
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 09:56:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E088334F4;
        Wed,  4 Oct 2023 12:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=z+EXuGAYQXBe+b6Qiezn4+RbyU4qpgnmxcZHTQ
        TRyoM=; b=oiP8Rl6DPibmiCSPWgpVUECxVe2LJlzOsKbR3peWV3Bl4lXB85TAGA
        OP6m+DmlIyQTLSlkxCvojsfCjiO6EiBrQGzTWGC3hcDrOs5a+wINYjZS0ecyGO4d
        EfY5lFQx1Deg+cWjESPIZg02tXkSPlCDPdeqvsoDZWU9vSkWF8ekU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37158334F3;
        Wed,  4 Oct 2023 12:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B263D334EF;
        Wed,  4 Oct 2023 12:56:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "cousteau via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Javier Mora <cousteaulecommandant@gmail.com>
Subject: Re: [PATCH v3] git-status.txt: fix minor asciidoc format issue
In-Reply-To: <pull.1591.v3.git.1696386165616.gitgitgadget@gmail.com> (cousteau
        via GitGitGadget's message of "Wed, 04 Oct 2023 02:22:45 +0000")
References: <pull.1591.v2.git.1696350802820.gitgitgadget@gmail.com>
        <pull.1591.v3.git.1696386165616.gitgitgadget@gmail.com>
Date:   Wed, 04 Oct 2023 09:56:08 -0700
Message-ID: <xmqqa5syqqc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAD57A32-62D6-11EE-BEAE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"cousteau via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Javier Mora <cousteaulecommandant@gmail.com>
>
> The list of additional XY values for submodules in short format
> isn't formatted consistently with the rest of the document.
> Format as list for consistency.
>
> Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
> ---
> ...
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index b27d127b5e2..48f46eb2047 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -246,10 +246,9 @@ U           U    unmerged, both modified
>  
>  Submodules have more state and instead report
>  
> -		M    the submodule has a different HEAD than
> -		     recorded in the index
> -		m    the submodule has modified content
> -		?    the submodule has untracked files
> +* 'M' = the submodule has a different HEAD than recorded in the index
> +* 'm' = the submodule has modified content
> +* '?' = the submodule has untracked files
>  
>  since modified content or untracked files in a submodule cannot be added
>  via `git add` in the superproject to prepare a commit.
>
> base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415

Perfect.  Thanks.
