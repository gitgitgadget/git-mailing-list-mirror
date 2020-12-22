Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043FCC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 06:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9F222B2D
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 06:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgLVGtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 01:49:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64276 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVGtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 01:49:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F2D98B008;
        Tue, 22 Dec 2020 01:48:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qH9uQGb3Bj41onkvjj4Ql970pV0=; b=q3Q3xk
        n950Jbc7zHlGJVViVx8ezYeKwGCIMyeCIHWIf/R+zu4dQ+1a9zp29Rjw5eEWFklA
        phiyyGspy0smpXt4q/qb8pEbhpTiBLzErVtMOQocxf6SYY5M7Zxs5Wqnm5ZLpcHs
        f1yioP9IA5KSJFMQUAcfcxZwH3qo2NRoPBFvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YntjaLgGeRW6yvXsP58JyBIttzGGnzwi
        w2KVyDxWBEsGPD0MASZMDyZZxMZ69iUdB5Gy/X3l9XQqbenVqYLJ7Ut4WuOgyw1+
        6u5kILyPNnAlHC6NdX/58OTjWgYaJ+O3JkfHB2SkCHTzfcNR+39MryWFTAqlvfIn
        oEekXnA1j84=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 572648B007;
        Tue, 22 Dec 2020 01:48:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D24A58B006;
        Tue, 22 Dec 2020 01:48:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>
Subject: Re: [PATCH v5 0/2] negative-refspec: fix segfault on : refspec
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
        <pull.820.v5.git.1608609498.gitgitgadget@gmail.com>
Date:   Mon, 21 Dec 2020 22:48:56 -0800
In-Reply-To: <pull.820.v5.git.1608609498.gitgitgadget@gmail.com> (Nipunn
        Koorapati via GitGitGadget's message of "Tue, 22 Dec 2020 03:58:15
        +0000")
Message-ID: <xmqq1rfijpyf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C375493A-4421-11EB-BD53-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Update since Patch series V4
>
>  * Squashed in Junio's patch to handle non-master named branches
>  * Explicitly use test_unconfig
>
> Appreciate the reviews from Junio and Eric! Happy Holidays!
>
> Nipunn Koorapati (2):
>   negative-refspec: fix segfault on : refspec
>   negative-refspec: improve comment on query_matches_negative_refspec

Thanks, will replace.  Happy holidays to you, too.
