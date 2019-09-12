Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071DF1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 18:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfILSGT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 14:06:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51889 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfILSGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 14:06:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3401A24EEA;
        Thu, 12 Sep 2019 14:06:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5+RiO1qgqpzQ2S2SPehMpWRVAgM=; b=doDmvM
        22Up7Rlzu1mHyTYlmkFBSuRbUeh4B2KpiQhz8HUtyng5rxx+C0ij4g5gslTasL16
        ooRqngCdOzCFNiAKX6PBcaoE076flJpA49AYGBMNp7iPf3MIbWDZq3gRjx25kVIE
        FGEB9q9isyOpWKd31ogoPnkeUGIF2kwo+RSB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EtxzAhF62Us9IBqvT6GZ2+H76TNcztps
        zCJA00eNgHbV4hI/CraFGAdcMg/H92J7Uo2Ldy4O0OTWC9Pv6vbXr23LBpd4oivy
        OWDOByxFySSRNz/Kmwsin7EuWA8MzNAGNtoriWKLDSY6fCjxFSsUiqKRzZIYoxwt
        9HjNm7TsfWw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AD7624EE9;
        Thu, 12 Sep 2019 14:06:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 797FF24EE8;
        Thu, 12 Sep 2019 14:06:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Cameron Steffen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Cameron Steffen <cam.steffen94@gmail.com>
Subject: Re: [PATCH v2 1/1] doc: minor formatting fix
References: <pull.330.git.gitgitgadget@gmail.com>
        <pull.330.v2.git.gitgitgadget@gmail.com>
        <8e6400745275e0af317552e73384101e5745a667.1568213570.git.gitgitgadget@gmail.com>
Date:   Thu, 12 Sep 2019 11:06:15 -0700
In-Reply-To: <8e6400745275e0af317552e73384101e5745a667.1568213570.git.gitgitgadget@gmail.com>
        (Cameron Steffen via GitGitGadget's message of "Wed, 11 Sep 2019
        07:52:51 -0700 (PDT)")
Message-ID: <xmqq4l1hgzjc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03A8C464-D588-11E9-BECA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Cameron Steffen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Cameron Steffen <cam.steffen94@gmail.com>
>
> Move a closing backtick that was placed one character too soon.
>
> Signed-off-by: Cameron Steffen <cam.steffen94@gmail.com>
> ---
>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for spotting and fixing.  Will apply.

>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 079598307a..b87e2e83e6 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -208,7 +208,7 @@ endif::git-rev-list[]
>  '%GP':: show the fingerprint of the primary key whose subkey was used
>  	to sign a signed commit
>  '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
> -	minutes ago`}; the format follows the rules described for the
> +	minutes ago}`; the format follows the rules described for the
>  	`-g` option. The portion before the `@` is the refname as
>  	given on the command line (so `git log -g refs/heads/master`
>  	would yield `refs/heads/master@{0}`).
