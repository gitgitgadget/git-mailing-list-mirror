Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF0A1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 17:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGPRYP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 13:24:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59585 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPRYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 13:24:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 738E16E0D4;
        Tue, 16 Jul 2019 13:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x5JHmZeLC4bfDDpFJCc4RMlwUfg=; b=KHQXsD
        wX9vZEfp13e319aX0rKiZ6F69xb99ro8By9wH+zfgrPu5P9FNIEhvBBwrvlAqP/+
        WQOu9RbzOZs95Su3kfsZxYphv/I5tSbVU8s1vKrBEI50fJVMJkl+xyrPAb0lspuD
        wvkNdxvr7dT9efXb44LWyqm+sp4r2lyBXlvlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I1HZ5wVcH1BwTvQ8TEQp/2aINuJFskPA
        c1rRaqL158QsyeCBuLsJA5fnstkLfbxLJEdCHtdpQTih29M6IcD5lPaOqRioTSAB
        HRLdynpvXDcfn0s9L4GgZ7SqO8F82aplaenkyJrXG/hxODvic1D8mYxXRlrht0QP
        mUbzyTpZt/M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BCF46E0D3;
        Tue, 16 Jul 2019 13:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 500E16E0D2;
        Tue, 16 Jul 2019 13:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] documentation: add tutorial for revision walking
References: <20190607010708.46654-1-emilyshaffer@google.com>
        <xmqqef41mbmd.fsf@gitster-ct.c.googlers.com>
        <20190617235053.GD100487@google.com>
        <xmqq4l4lr4dy.fsf@gitster-ct.c.googlers.com>
        <20190620210649.GA87385@google.com>
        <20190713003948.GA43313@google.com>
        <20190716000628.GF113966@google.com>
Date:   Tue, 16 Jul 2019 10:24:08 -0700
In-Reply-To: <20190716000628.GF113966@google.com> (Emily Shaffer's message of
        "Mon, 15 Jul 2019 17:06:28 -0700")
Message-ID: <xmqqwogh3nbb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85FBAEDA-A7EE-11E9-B17A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I have been in a position of reviewing diff-of-.patch in a past life,
> albeit via Gerrit, and it's not the worst when the code is simple (as we
> should always hope this example tutorial code would be).

I personally think a directory full of patch files is OK.  I am not
sure if they (together with this rev walk tutorial) belong to the
main part of the project, though.
