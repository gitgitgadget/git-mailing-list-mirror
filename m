Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DABFC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 22:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiADWsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:48:50 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63795 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiADWst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 17:48:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65EB81763AD;
        Tue,  4 Jan 2022 17:48:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8QgX3O8DFYT5Cd/AI0KYslmetK2mT7NMznLRsn
        F/B6I=; b=FReb7Aa+WSBUTjhNXtrGIbctjOeurBFwn03vsE9jsJBlFZ4JohOeB+
        4kKZJpZ76I4qpsQJCFY+jcUy/IIjjwFQ3yterCv2G955R6wqn8uu72DfIkvCZHp8
        XPY8PmvaRJzCV6dvcCBPJ0OkToSwXxgrJUCDqSTzUFDygA4fnzT/Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E2471763AB;
        Tue,  4 Jan 2022 17:48:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE35F1763AA;
        Tue,  4 Jan 2022 17:48:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v2 RESEND 0/5] git-p4: fix RCS keyword processing
 encoding errors
References: <20220104124913.2894-1-jholdsworth@nvidia.com>
        <xmqqh7ajb2bi.fsf@gitster.g>
        <BL0PR12MB4849438B1245FC1FCEE7ED0CC84A9@BL0PR12MB4849.namprd12.prod.outlook.com>
Date:   Tue, 04 Jan 2022 14:48:44 -0800
In-Reply-To: <BL0PR12MB4849438B1245FC1FCEE7ED0CC84A9@BL0PR12MB4849.namprd12.prod.outlook.com>
        (Joel Holdsworth's message of "Tue, 4 Jan 2022 21:59:24 +0000")
Message-ID: <xmqq7dbf9kxf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 793BDD70-6DB0-11EC-9DD3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

>> I do not see any difference between this version and what has been merged
>> to 'next' at 650cb248 (2021-12-27).  Sent a wrong version?
>
> Ah ok. I didn't realise that's how things are done around here. If
> the patches are accepted then this patch-set is unchanged and can
> be ignored.

I try to respond with "Thanks, will queue" to patches, but sometimes
I forget.  Periodical "What's cooking" reports meant to tell where
each topic stands to the developers.

