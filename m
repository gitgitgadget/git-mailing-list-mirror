Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52716C0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 20:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjGZUjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 16:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjGZUji (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 16:39:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3C2D47
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 13:39:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45BDE1988F;
        Wed, 26 Jul 2023 16:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TJlfPt74LvhiGmf8yjSKtGFq/e2ffpefMSmibl
        vBgS0=; b=m8HHIFAp+dd3IFh/Qnsr/cSF/rX/bocj0ExeqInllLlIcJRrqyzI7b
        cGjuU9qWAocjTbweaEYeujMeOyAss5icgQTnhluzRIQ1HFoP2KOaEXitlQlG5BX4
        NP5qj9HEF5eT//rz1qruoqwAGCgJtSN1KLmsRYrIHq1bG39G3yrLM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D05A1988E;
        Wed, 26 Jul 2023 16:39:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C0A431988D;
        Wed, 26 Jul 2023 16:39:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1689889382.git.jonathantanmy@google.com>
Date:   Wed, 26 Jul 2023 13:39:14 -0700
In-Reply-To: <cover.1689889382.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 20 Jul 2023 14:46:33 -0700")
Message-ID: <xmqq8rb2csr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CA1CF84-2BF4-11EE-BD82-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Jonathan Tan (4):
>   gitformat-commit-graph: describe version 2 of BDAT
>   t4216: test changed path filters with high bit paths
>   repo-settings: introduce commitgraph.changedPathsVersion
>   commit-graph: new filter ver. that fixes murmur3
>
> Taylor Blau (3):
>   t/helper/test-read-graph.c: extract `dump_graph_info()`
>   bloom.h: make `load_bloom_filter_from_graph()` public
>   t/helper/test-read-graph: implement `bloom-filters` mode

After a week, nobody seems to have found anything worth saying about
these patches.  Does the design, especially the migration story, now
look sensible to everybody?  I was contemplating to mark the topic
for 'next' after reading them myself once more.

Thanks.
