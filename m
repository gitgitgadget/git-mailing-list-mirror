Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59687C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 15:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbiEKPZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbiEKPZn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 11:25:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA56309
        for <git@vger.kernel.org>; Wed, 11 May 2022 08:25:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF11910D5ED;
        Wed, 11 May 2022 11:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hglS6roXL1iN8cqv12g6KtsfsZ0PA9XtarfomR
        kQ1ZI=; b=miVJi8wtyeJbKkxhOiE9kgdpH57AXkHWHEFZhg1AV5wBcGcm8BTW10
        XLhcHcNSQvv4i5qdD51ifaemBnoLqW6tjh84nEv+M6S5MaQci3dxBR5IecXivPRM
        GbyxHIplafonNMMBaatiG1hOtmvnDem9Yp9R+FHgzDQhxg0iIXxMg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E619210D5EC;
        Wed, 11 May 2022 11:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5818110D5EB;
        Wed, 11 May 2022 11:25:40 -0400 (EDT)
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
        <xmqqtu9yd42d.fsf@gitster.g>
        <CAOeUTusOW1=cDKNhrBCzdzfbVLmY_qb7yg114ukRfy904S34uA@mail.gmail.com>
        <YntyF+dHp2WEpI8v@cleo>
Date:   Wed, 11 May 2022 08:25:39 -0700
In-Reply-To: <YntyF+dHp2WEpI8v@cleo> (Paul Mackerras's message of "Wed, 11 May
        2022 18:21:43 +1000")
Message-ID: <xmqqlev8m6q4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D98247A-D13E-11EC-AF3E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> Junio, could you do a pull from my repository to get them?

Thanks, done.
