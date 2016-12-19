Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C9B1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbcLSVDu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 16:03:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752040AbcLSVDs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 16:03:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B629859B53;
        Mon, 19 Dec 2016 16:03:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GPLu/avH4dhzop5zXfFHkvY1+JY=; b=s+htfB
        +QCo5Xv/tAoBnzeHPiKT1XwNyoVNVr6AZ+hefC9s4Xcs83DMBqWmfeXeoA0990LY
        JkKI78K4LJ8ncPCjIyzY2yvXJUnXGKbp5yxPbYntFOKjReuOxbtpVKMf4X6mQuMu
        v/w42f8vWbOehu01lnDcsMVK3dPOxmd5a2Ya4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EP+YofmaGkoefsmW+4jpf/h5NMwO/7PF
        4GsTYUz7ITkTnUbViNBTJgTZMdgG8Mh6tfK0e+lAoLXo7Pt8td4YWSn+ktMNgjua
        7HNjuurbJil+3V2/lAYQ9V7Uwl6jw4/LHn9Q26gYAnHBv0F8YK8j6DikpghUunVP
        KINUXAIYcM8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE20659B52;
        Mon, 19 Dec 2016 16:03:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34F9D59B51;
        Mon, 19 Dec 2016 16:03:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 00/21] Add configuration options for split-index
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
        <20161219120246.GE24125@ash>
Date:   Mon, 19 Dec 2016 13:03:45 -0800
In-Reply-To: <20161219120246.GE24125@ash> (Duy Nguyen's message of "Mon, 19
        Dec 2016 19:02:46 +0700")
Message-ID: <xmqq7f6voclq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A222AE82-C62E-11E6-8480-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I've read through the series (*) and I think it looks good, just a few
> minor comments here and there.
>
> (*) guiltily admit that I only skimmed through tests, not giving them
>     as much attention as I should have

OK.  I'd still want to see them get reviewed, though.  Perhaps I'll
do so myself once I run out of things to do, but hopefully somebody
else gets there first ;-)

Thanks.
