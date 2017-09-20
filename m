Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C060B2047F
	for <e@80x24.org>; Wed, 20 Sep 2017 05:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdITFOR (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 01:14:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58397 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751011AbdITFOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 01:14:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E00AAB696;
        Wed, 20 Sep 2017 01:14:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LftNDzUr/1YLvbQqIe39/WuRExY=; b=n5hrxg
        m6zW7CHwjmlGg8YUsLpQExqBDDvxdgXyiXF06pLl/qGesXDsAMIshyc1Ea2JpG5N
        RrkST0QiunGtU1YX5B7l6sSErHgS5bfBMtTg38fwszCvgDMk62Lx71BBOAiv2rq7
        MAFIEdzd2MLIoBbDBU+erZXRsWsSRKvJzLaX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uayFhqm6YsfC0d7qN88aismS+nSCfqCD
        V0vCk/yshYHOv3JdQBFZKB9Dqw+9cSKQ7cxP/s2L8eb0d4iXWWTfFmyqJGuVh0od
        13PnMFAY7zLLFgDYzD30cv3BupkXoqQqKA7335NkPNzf8maw+ScA2AxA37Wgib75
        ymF4tlAPCxw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45572AB695;
        Wed, 20 Sep 2017 01:14:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98ED3AB694;
        Wed, 20 Sep 2017 01:14:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        <20170915184323.GU27425@aiede.mtv.corp.google.com>
        <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
        <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
        <xmqq4lryqhcw.fsf@gitster.mtv.corp.google.com>
        <20170920014305.GA126984@aiede.mtv.corp.google.com>
Date:   Wed, 20 Sep 2017 14:14:14 +0900
In-Reply-To: <20170920014305.GA126984@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 19 Sep 2017 18:43:05 -0700")
Message-ID: <xmqqk20une8p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C048BFE-9DC2-11E7-AFFE-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'll send a patch with a commit message saying so to try to close out
> this discussion.

Thanks.  One less thing we have to worry about ;-)
