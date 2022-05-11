Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940CC433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 15:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiEKPIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245474AbiEKPIq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 11:08:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0116AA44
        for <git@vger.kernel.org>; Wed, 11 May 2022 08:08:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6DE418F73C;
        Wed, 11 May 2022 11:08:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q3Vnyx/LOeLxAAN5DoVk5TKMinScazOrMSAK1V
        eEG5A=; b=mGUZ8xFhURrdoOcx5BE/gWuwh1Cggz9BJn6wdRAQ7rrj8Dpo43o4fI
        wBmYTyfbLo14cjlGJhYLhZ9tmDlfXWKvUP41LRxWFxWrSP8syhc6JLdTzXcQ0bPk
        MAnZyxfIcLKHZYDdHV19EaNiHnC+h2k6zHsRzTBPWHRUMyUsSNP7M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF2E218F73B;
        Wed, 11 May 2022 11:08:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6876018F73A;
        Wed, 11 May 2022 11:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Halil SEN <halilsen@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Christian =?utf-8?Q?Gr=C3=BCn?= <christian.gruen@gmail.com>,
        git@vger.kernel.org,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Resizing panels in the gitk window
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
        <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com>
        <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
        <xmqqzgjuocjk.fsf@gitster.g>
        <CAOeUTuufDgsyp7FgJj4T+h=JOMaWYVBkMx8S6fNRQ3cdVo6tOw@mail.gmail.com>
        <xmqqtu9yd42d.fsf@gitster.g> <Yntx33Q9pNLJ+QqS@cleo>
Date:   Wed, 11 May 2022 08:08:40 -0700
In-Reply-To: <Yntx33Q9pNLJ+QqS@cleo> (Paul Mackerras's message of "Wed, 11 May
        2022 18:20:47 +1000")
Message-ID: <xmqqpmkkm7if.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E427090-D13C-11EC-AF84-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> The ozlabs.org infrastructure changes every so often, and while the
> plain ozlabs.org works now and is not expected to stop working,
> git.ozlabs.org would be a little more future-proof.

Will do.  Thanks.
