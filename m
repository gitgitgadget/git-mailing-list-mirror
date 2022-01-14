Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE430C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 20:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiANUyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 15:54:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56924 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiANUyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 15:54:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96E1C112DA6;
        Fri, 14 Jan 2022 15:54:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ihO68GxOnduWGIrtP0IRwCd/lpPofM/Mxf6YRz
        fOmYA=; b=E0CRn3etNGDjT8W3cgRav2dHZvFcKey51DYmiv+fx1rFjnBfpqZc/Y
        fT/Y0qsEW+sEwYS58WPHLptHJMXogQG0bkgjCF4A3jh+n8lInVkF+RZvEDllOTRI
        Q2yq3xGvqPKI5uYJwK1Mx4V4WfwlNferdZ6JRnCW0XrmYuazrhmmo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E92D112DA5;
        Fri, 14 Jan 2022 15:54:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 045BC112DA4;
        Fri, 14 Jan 2022 15:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH] README.md: add CodingGuidelines and a link for Translators
References: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
Date:   Fri, 14 Jan 2022 12:54:12 -0800
In-Reply-To: <pull.1115.git.1642182615339.gitgitgadget@gmail.com> (Philip
        Oakley via GitGitGadget's message of "Fri, 14 Jan 2022 17:50:15
        +0000")
Message-ID: <xmqq7db2avij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21847F32-757C-11EC-8DEB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philip Oakley <philipoakley@iee.email>
>
> Also space out the list joining instructions and clarify the subscription

the instructions to join the list?

>  requests, comments and patches to git@vger.kernel.org (read
> -[Documentation/SubmittingPatches][] for instructions on patch submission).
> +[Documentation/SubmittingPatches][] for instructions on patch submission
> +and [Documentation/CodingGuidelines]() ).

Remind me the significance of using [] and () after [File Reference]?

> +Those wishing to help with error message translation (localization L10)
> +should see [po/README.md]()

Same here.

https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links

seems to indicate () is to enclose URL the text goes to, and if
there is no URL to go to, perhaps it does the right thing, but the
current page (which has "[Documentation/SubmittingPatches][]" and
all other reference into in-tree files with that format) seems to
render correctly with links that work, so...

> +(a `po` file is a portable object file for the translations).
> +
>  To subscribe to the list, send an email with just "subscribe git" in
> -the body to majordomo@vger.kernel.org. The mailing list archives are
> -available at <https://lore.kernel.org/git/>,
> +the body to majordomo@vger.kernel.org (not the list). The mailing list
> +archives are available at <https://lore.kernel.org/git/>,
>  <http://marc.info/?l=git> and other archival sites.
>  
>  Issues which are security relevant should be disclosed privately to
>
> base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
