Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4AC1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 09:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeKUUMG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 15:12:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64768 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUUMG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 15:12:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A006310CCF6;
        Wed, 21 Nov 2018 04:38:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IL+noFL7mmp0TDqSmpih8kG8hUs=; b=B1gcMJ
        lltead7EjMbYoQD2aux5Nwf1h5l6UMYySpiyvRNMLtLcfV+Y9XEWYitU3dCHoxkk
        2B5rrSck9b508X8VULGu7dns8U/imL4mORlv9zH5A1UAo0+y41H2nkISHlMhRc88
        Z1kCL/2pBT9z8AHaR9Um4PX7u8oAOgHRBqEXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BpjekhhFElwwG31Tz0nQaiKmhsWhhN9g
        uIOOwJnvTlVeCZEE3AUKOUSXCvXDhA9c1Y/ipbvpWnz5t5C3GnVKaX8dku/mtiif
        VwAECpWc8l0Uck2WJBe4eKhxxQERJxF0GtCYHHAD1uclaJIyx5R5McQE/nAsCJXJ
        HBks9eeazK0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 998F410CCF4;
        Wed, 21 Nov 2018 04:38:21 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B95710CCF3;
        Wed, 21 Nov 2018 04:38:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/2] Fix scissors bug during merge conflict
References: <cover.1542496915.git.liu.denton@gmail.com>
        <cover.1542768902.git.liu.denton@gmail.com>
Date:   Wed, 21 Nov 2018 18:38:20 +0900
In-Reply-To: <cover.1542768902.git.liu.denton@gmail.com> (Denton Liu's message
        of "Tue, 20 Nov 2018 22:13:07 -0500")
Message-ID: <xmqqefbe7otv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F0CF0C6-ED71-11E8-8108-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Changes since V3:
> 	* Add patch to cleanup 'merge --squash c3 with c7' test in t7600
> 	* Use test_i18ncmp instead of test_cmp to pass GETTEXT_POISON tests

Queued. Thanks, both.
