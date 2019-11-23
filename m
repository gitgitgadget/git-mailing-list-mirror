Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF8C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 01:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E3F2070E
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 01:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nPdtOEH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKWBVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 20:21:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53363 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWBVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 20:21:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8AAF5990BD;
        Fri, 22 Nov 2019 20:21:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0XZrgjuDKvM2KU7+SGrs86L7E6A=; b=nPdtOE
        H7VC9850Hbhd4APXHbae5Ews+Hzan2xv3K7gV0Zj0ZRM3cD82msapGJkPlJIhTNg
        4h5B/AYyNB3i4kaXHG0cpWIbcxFEqZ7ZHU4b/eqMlVIbKdgQh4bub4rhV69n4Jz3
        odBINt3RuUvLqsP0bLt0OP815xHSBLgPdCtNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=unk3aU6TpbqWc+T0tSUYSMy1kCn78LfI
        P77C56+3uGhpOWd3BQi9gaGQP03g/3DwZiQ8/I+aNDGamRnYlOstOozb81PFA8pK
        htHYqKcizWV1xKHVg46hg7+T/XztmNemt1BuMZJL3SUHehhZ5TQZDtgStOsuKopV
        P8VU288OMBI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83AD9990BC;
        Fri, 22 Nov 2019 20:21:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4428990B3;
        Fri, 22 Nov 2019 20:21:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Manish Goregaokar <manishsmail@gmail.com>
Subject: Re: [PATCH 1/1] Documentation: Correct man page for the SHAs reported by 'submodule status'
References: <pull.470.git.1574464285.gitgitgadget@gmail.com>
        <0eabb27ba0c7a07bbf24f13f1766c0ff63995348.1574464285.git.gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 10:21:44 +0900
In-Reply-To: <0eabb27ba0c7a07bbf24f13f1766c0ff63995348.1574464285.git.gitgitgadget@gmail.com>
        (Manish Goregaokar via GitGitGadget's message of "Fri, 22 Nov 2019
        23:11:25 +0000")
Message-ID: <xmqqo8x32xqv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DC87FAA-0D8F-11EA-BF12-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Manish Goregaokar <manishsmail@gmail.com>
>
> 'git submodule status' reports the SHAs expected by the parent project,
> not the SHAs that are actually checked out in the submodule. Checking
> out a new SHA in a submodule will not change the output of 'git
> submodule status' until you 'git add' the submodule.
>
> Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
> ---
>  Documentation/git-submodule.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 0ed5c24dc1..31e089454a 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -72,8 +72,8 @@ git-submodule will correctly locate the submodule using the relative
>  URL in `.gitmodules`.
>  
>  status [--cached] [--recursive] [--] [<path>...]::
> -	Show the status of the submodules. This will print the SHA-1 of the
> -	currently checked out commit for each submodule, along with the
> +	Show the status of the submodules. This will print the SHA-1
> +	recorded in the superproject for each submodule, along with the
>  	submodule path and the output of 'git describe' for the

Am I mistaken to say that neither the old or the new description is
correct, depending on the use (or non-use) of the --cached option?

	... print the object name of the commit that is currently
	checked out, or the commit that is recorded in the
	superproject if `--cached` option is given, for each
	submodule, ...

perhaps?
