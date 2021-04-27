Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E31BC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554AB613AA
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhD0Hku (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 03:40:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65376 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhD0Hkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 03:40:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0329513389B;
        Tue, 27 Apr 2021 03:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PFzffK9Pbka69CejSoaNxHG6ZamS330aorkb1X
        Mruv8=; b=xo2OC3Jmgtw4aK24nS9yY6kgacLJ6wwy8IXr3AfXa7895mMeLJxSqZ
        WDYTaEm06BHdt2I7mcvwQFYoP7LCnk6GmDKMDDHJjsrLzw46QTBN1tOxT8SrV2JM
        Vslk+Bt6Bs15vIqrIOoSGZwXf8zyFx19WJDCZ5wzJOhxiTwML2Qu8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F12B213389A;
        Tue, 27 Apr 2021 03:40:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 198A3133898;
        Tue, 27 Apr 2021 03:40:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Peter Oliver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: Re: [PATCH] doc: point to diff attribute in patch format docs
References: <pull.940.git.1619463549689.gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 16:40:00 +0900
In-Reply-To: <pull.940.git.1619463549689.gitgitgadget@gmail.com> (Peter Oliver
        via GitGitGadget's message of "Mon, 26 Apr 2021 18:59:09 +0000")
Message-ID: <xmqqh7jsdvlb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C68839A8-A72B-11EB-82B9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Peter Oliver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -11,7 +11,7 @@ linkgit:git-diff-files[1]
>  with the `-p` option produces patch text.
>  You can customize the creation of patch text via the
>  `GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables
> -(see linkgit:git[1]).
> +(see linkgit:git[1]), and the `diff` attribute (see linkgit:gitattributes[5]).
>  
>  What the -p option produces is slightly different from the traditional
>  diff format:
> @@ -74,6 +74,10 @@ separate lines indicate the old and the new mode.
>        rename from b
>        rename to a
>  
> +5.  Hunk headers mention the name of the function to which the hunk
> +    applies.  See linkgit:gitattributes[5] for details of how to tailor
> +    to this to specific languages.

Shouldn't this part be as helpful as the change you made to the
earlier part by mentioning that the user wants to look at a specific
part of the document, instead of reading the entire gitattributes(5)
manpage?  Perhaps "Defining a custom hunk header" section is what
they want to refer to.


>  Combined diff format
>  --------------------
>
> base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
