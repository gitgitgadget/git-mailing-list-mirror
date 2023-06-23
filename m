Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A222C0015E
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 21:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFWVnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjFWVnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 17:43:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CC81FF2
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:43:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03EE01918DF;
        Fri, 23 Jun 2023 17:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3rOwG9f42IT/Wy0NH41mdqQcEV/UjEV0ailN77
        Zub3s=; b=eJz0BL7xpZMp4qhK9FUjFOxf43ai8enAFZcRm+dI/G+Vacha5tl3kG
        NVxftQjvIrY3B++66cta403F0ifZ85TsK9Sg4BGkXwIAvihKS5RzSEsHqYRigrvu
        7cRbrTNEsqBY3E+ukRI8ab2y6Y+tjue82yjQieRVqj4tiltvykxtI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0B161918DE;
        Fri, 23 Jun 2023 17:43:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28EE61918DD;
        Fri, 23 Jun 2023 17:43:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] docs: add git hash-object -t option's possible values
References: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
        <pull.1533.v2.git.git.1687555504551.gitgitgadget@gmail.com>
Date:   Fri, 23 Jun 2023 14:43:18 -0700
In-Reply-To: <pull.1533.v2.git.git.1687555504551.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 23 Jun 2023 21:25:04 +0000")
Message-ID: <xmqq7crtam89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7D4F1B8-120E-11EE-B382-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> The verbiage under the NAME section for git hash-object could

Stil a verbiage?

> lead one to conclude that git hash-object can only be used to create
> blobs when in fact the description makes it clear that it can be used to
> create objects, not just blobs. Lets clarify this in the NAME text.

"Lets" -> "Let's".  "Let's clarify the one-line summary."
Similarly, 

    The one-line summary for 'git hash-object' can mislead hasty
    readers to think that the command can only be used to ...

or something, perhaps.

> Further, the description for the option -t does not list out other types
> that can be used. Let's make this explicit by listing out the different
> object types.
>
> Signed-off-by: John Cai <johncai86@gmail.com>

Nice.

>     docs: add git-hash-object -t option's possible values
>     
>     For newer users of Git, the possible values of -t in git-hash-object may
>     not be apparent. In fact the current verbiage under NAME could lead one
>     to conclude that git-hash-object(1) can only be used to create blobs.
>     
>     Update the verbiage to make it clear the command can be used to write
>     objects, not just blobs. Also add the possible values for -t.

What is this older version of the proposed log message?

>     Changes since v1:
>     
>      * updated verbiage of commit message
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1533%2Fjohn-cai%2Fjc%2Fhash-object-documentation-update-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1533/john-cai/jc/hash-object-documentation-update-v2
> Pull-Request: https://github.com/git/git/pull/1533
>
> Range-diff vs v1:
>
>  1:  38515c660fb ! 1:  2483375ecb8 docs: add git-hash-object -t option's possible values
>      @@ Metadata
>       Author: John Cai <johncai86@gmail.com>
>       
>        ## Commit message ##
>      -    docs: add git-hash-object -t option's possible values
>      +    docs: add git hash-object -t option's possible values
>       
>      -    For newer users of Git, the possible values of -t in git-hash-object may
>      -    not be apparent. In fact the current verbiage under NAME could
>      -    lead one to conclude that git-hash-object(1) can only be used to create
>      -    blobs.
>      +    The verbiage under the NAME section for git hash-object could
>      +    lead one to conclude that git hash-object can only be used to create
>      +    blobs when in fact the description makes it clear that it can be used to
>      +    create objects, not just blobs. Lets clarify this in the NAME text.
>       
>      -    Update the verbiage to make it clear the command can be used to write
>      -    objects, not just blobs. Also add the possible values for -t.
>      +    Further, the description for the option -t does not list out other types
>      +    that can be used. Let's make this explicit by listing out the different
>      +    object types.
>       
>           Signed-off-by: John Cai <johncai86@gmail.com>
>       
>
>
>  Documentation/git-hash-object.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
> index 472b5bb995b..404e339e170 100644
> --- a/Documentation/git-hash-object.txt
> +++ b/Documentation/git-hash-object.txt
> @@ -3,7 +3,7 @@ git-hash-object(1)
>  
>  NAME
>  ----
> -git-hash-object - Compute object ID and optionally creates a blob from a file
> +git-hash-object - Compute object ID and optionally creates an object from a file

Not a new problem, but as we are updating the one-line summary,
perhaps we should also do "creates" -> "create" to match "Compute".

>  
>  SYNOPSIS
> @@ -25,7 +25,8 @@ OPTIONS
>  -------
>  
>  -t <type>::
> -	Specify the type (default: "blob").
> +	Specify the type (default: "blob"). Possible values are `commit`,
> +	`tree`, `blob`, and `tag`.

Not a new problem, but "-t <type>" alone is clear enough that it
specifies something called "type" already.  If we are to explain
it further, we should at least say something about the significance
of that "type" thing.  Perhaps "Specify the type of the object to be
created" or something?

Thanks.
