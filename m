Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D9AC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 06:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351839AbiFVG4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 02:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351904AbiFVG4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 02:56:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECFD369FD
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 23:56:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DD7F13FC0F;
        Wed, 22 Jun 2022 02:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x3P7oHR8KSF5eur8d2nMTB5amW1FlQKgXKfLYd
        2f28w=; b=MtXmPkcWARxP/zfkedDasqQOPNhaFHW8fOZ32av1JCLWOFt2+Q5U0V
        bhJlUSK+nRRhz38syBLgiApGaJ9cfxQVGx6hHcNIyScnXji+oPn0oaGvfEX0yAwt
        GkcRWtOTcWS71ndchgBS/8MoTvRsL5WEtPgRc0N/15lorBt3q++sM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 265DF13FC0D;
        Wed, 22 Jun 2022 02:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6DAC913FC0C;
        Wed, 22 Jun 2022 02:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carlos L." <00xc@protonmail.com>
Cc:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Martin_=C3=85gren_=5B_=5D?= <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>
Subject: Re: [PATCH v2] grep: add --max-count command line option
References: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com>
        <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
        <xmqq5ykuhthp.fsf@gitster.g>
        <XWF-gaPGsSObqE_fNBKYQ-577E-oM5mMtmnDeGE-oCRmjjTSnByfmgGwesPecoAAVN9B2Gk1mA-Hu-KVyGyPiwzUxgC4Yc1HUetOvYoC2YU=@protonmail.com>
Date:   Tue, 21 Jun 2022 23:56:26 -0700
In-Reply-To: <XWF-gaPGsSObqE_fNBKYQ-577E-oM5mMtmnDeGE-oCRmjjTSnByfmgGwesPecoAAVN9B2Gk1mA-Hu-KVyGyPiwzUxgC4Yc1HUetOvYoC2YU=@protonmail.com>
        (Carlos L.'s message of "Wed, 22 Jun 2022 06:41:49 +0000")
Message-ID: <xmqqo7yl6vad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FFDA550-F1F8-11EC-82C7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlos L." <00xc@protonmail.com> writes:

>> Tests?
>
> Right. Is it OK if I include my test(s) in t/t7810-grep.sh, or
> should it be a different/new file?

It is preferrable to add new tests to existing scripts, rather than
adding a new (and short) one.

Thanks.
