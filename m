Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C25C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiCJTTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiCJTTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:19:42 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A9442489
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:18:41 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B395C1062AC;
        Thu, 10 Mar 2022 14:18:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8pRZANSQ+wu++szRO6S16Qy4T1Oja6tpjjuy9X
        jYIlQ=; b=SxXwS/zQ7WpqTeRthxpbpZSZtkVgxQxW/foHsS9ASoy6w4VC+xFiCn
        5zMW+IXprW9VX5YJr3B2puXIqh9uU1LV5g57NdIY6ibbXowhRh1FlfkZ7KZJpX8E
        dDIJiofXXFs9q068443RON/fw/KgkardOeFbhcICBd0Z5E3KimGDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AACD21062AB;
        Thu, 10 Mar 2022 14:18:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16DC31062AA;
        Thu, 10 Mar 2022 14:18:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3] block-sha1: remove use of obsolete x86 assembly
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
        <20220310174750.4166514-1-sandals@crustytoothpaste.net>
Date:   Thu, 10 Mar 2022 11:18:39 -0800
In-Reply-To: <20220310174750.4166514-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Mar 2022 17:47:50 +0000")
Message-ID: <xmqqy21hd3ao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E48D698A-A0A6-11EC-9709-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Changes from v2:
> * Improve subject

Will queue.  Let's merge it down to 'next'.
