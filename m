Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DE4CCA473
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 15:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbiFFPh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240897AbiFFPhV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 11:37:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBA1C12A
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 08:37:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 150BD19DC6D;
        Mon,  6 Jun 2022 11:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SE/oy8nynaO3LwZqgjsILc6186rN24S9dZs90d
        ZFAhY=; b=SULJdIAoCnrXbTx5AEJrU99PgvCLecR46cOCYnMpkvK3lb0AF2xSj8
        lL+lS72DfluVR7WOq7wSHoeC4zwYu9iJYYo8YY0U+8Pk/LLP/kelgwAvpq/CFciB
        74HcRbJfe4VNWye8vnAswnZp6ehdJW+xyUGcMvo0jdo5r7KwIUecw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C1A819DC6C;
        Mon,  6 Jun 2022 11:37:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8112D19DC6A;
        Mon,  6 Jun 2022 11:37:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
Subject: Re: [PATCH v4] remote: create fetch.credentialsInUrl config
References: <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
        <pull.1237.v4.git.1654190434908.gitgitgadget@gmail.com>
        <xmqq35gmkbic.fsf@gitster.g>
        <c414de1f-b742-0880-09e6-446f1212e3bd@github.com>
Date:   Mon, 06 Jun 2022 08:37:12 -0700
In-Reply-To: <c414de1f-b742-0880-09e6-446f1212e3bd@github.com> (Derrick
        Stolee's message of "Fri, 3 Jun 2022 08:54:47 -0400")
Message-ID: <xmqqa6apdcrb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 897E85AE-E5AE-11EC-A0C0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/2/2022 5:20 PM, Junio C Hamano wrote:
> ...
>> Taking all together, I'll queue the following on top as a separate
>> fix-up patch, but I may well be giving (some) bad pieces of advice,
>> so I will wait for others to comment.
>
> I cut all of your commentary because it was universally good and
> the fixup you provided does a great job of solving those issues.
>
> Please give yourself co-authorship on the squashed commit.

Heh, that's at most helped-by; a small bugfix in the logic (zero-length)
and all others are minor clean-ups.

Thanks.
