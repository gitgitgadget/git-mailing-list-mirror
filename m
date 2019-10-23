Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E551F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 02:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbfJWCG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 22:06:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58890 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731549AbfJWCG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 22:06:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4F3D36045;
        Tue, 22 Oct 2019 22:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P5G8DrY/EvP0rz5B/gD/9wHsUWU=; b=cd1Pjg
        K8dl8ddphxDtV3MucJWroS5KXvesI1s3PwEbcrlHLaeIBPdnfkgv/UAMLItZeHNs
        wcEyeqpsLMkUVm+cYixznaaupe02MZqDBwkkTxK+sgFSC4J8SDE4rG+XD4nvOJU3
        vXInyrXDfRxT/xd+Zqja06VzFAYeKa30XSg0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wzy7W1NdgBLG9eBrMScHlPbqaNHFisX9
        It8khOjuxcIhv7DVsq22BNUE5ZiRKbozZg+FkctaTVgph77XK2V1Gdj03cbiyAL7
        SbKI9UI/EiWR909lva21+5Ve3Weu8XJB0E8Xd0zCibMYuWVUqW/d3sfSIO1B/azP
        NBeS9PjEZnI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD34A36044;
        Tue, 22 Oct 2019 22:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 339E636043;
        Tue, 22 Oct 2019 22:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Fix the speed of the CI (Visual Studio) tests
References: <pull.410.git.1571603970.gitgitgadget@gmail.com>
        <pull.410.v2.git.1571687999.gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 11:06:25 +0900
In-Reply-To: <pull.410.v2.git.1571687999.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 21 Oct 2019 19:59:56
        +0000")
Message-ID: <xmqqlftcjjvi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B81B7B50-F539-11E9-9816-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v1:
>
>  * Fixed typo "nore" -> "nor" in the commit message.
>
> Johannes Schindelin (2):
>   ci(visual-studio): use strict compile flags, and optimization
>   ci(visual-studio): actually run the tests in parallel
>
>  azure-pipelines.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks.

I will take the change to 'master' directly, as cooking in 'next'
won't give it any extra exposure when the topic touches only this
file and the patch comes from those who do exercise azure CI build
before sending it out to the list ;-)
