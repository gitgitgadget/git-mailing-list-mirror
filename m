Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE481C433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 12:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9743961166
	for <git@archiver.kernel.org>; Sun, 16 May 2021 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhEPM7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 08:59:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58001 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhEPM7X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 08:59:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89847CBCBB;
        Sun, 16 May 2021 08:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xTT3Qx8w0m7Q
        SXOjGY9fp3fmwaajHESJ1iMQgx4EaZQ=; b=uQjgzNjVTZRO/sGSLwlRMy9dMQfM
        i2N8NqF3AXGhpYSL2xKOdhrspYefv1qOBjE7PeeiJ5gyJqLK3suipbR43Bq8zvAo
        J52IAiXW/wTkYnkAnTqLIv84S90OeFDthbZ+8PXV5Ueor8aC4q5KVZ4CXIT1bb83
        q8GdxwhsShx6g0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A1D5CBCBA;
        Sun, 16 May 2021 08:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FA14CBCB9;
        Sun, 16 May 2021 08:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders =?utf-8?Q?H=C3=B6ckersten?= <anders@hockersten.se>
Cc:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Anders =?utf-8?Q?H=C3=B6ckers?= =?utf-8?Q?ten?= via
         GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] describe-doc: clarify default length of abbreviation
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
        <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com>
        <8cad4c4b-a923-43f2-9bb7-6ce418cfb0fc@www.fastmail.com>
Date:   Sun, 16 May 2021 21:58:03 +0900
In-Reply-To: <8cad4c4b-a923-43f2-9bb7-6ce418cfb0fc@www.fastmail.com>
 ("Anders
        =?utf-8?Q?H=C3=B6ckersten=22's?= message of "Sun, 16 May 2021 14:47:49
 +0200")
Message-ID: <xmqqo8da6dk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B71DDE8-B646-11EB-9904-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders H=C3=B6ckersten <anders@hockersten.se> writes:

> The explanation was mostly copied from the 2.11.0 release notes,
> but mentioning the birtday paradox is unnecessary. I suggest
> changing this sentence to: "The length of the abbreviation scales
> as the repository grows using the approximate number of objects in
> the repository, and by default the minimum length is 7."

Heh.  In my priate review, I said that I very much liked the way the
new description was phrased with "a bit of math around the birthday
paradox".  Now I know why I liked that phrasing---it turns out to be
my own ;-)

I don't mind with or without mention of the birthday math.  Thanks
for working on this.

