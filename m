Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E138AC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiCGRXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiCGRXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:23:02 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705A90FE1
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:22:08 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8CE919098D;
        Mon,  7 Mar 2022 12:22:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8mPwCUivxRCsQmxktJFhLCHRCr5NCuK6d9Keye
        5agGQ=; b=Eo7zAWCJ2A5Ht/gASpTpElj0dBqRROcQ8FCeaSC8tGgXAGxZVsjxcv
        UjHOFSgPsUr95pRwEvpDlIJ/4Q6N001EAakfCRP4zk+mkDg+vPlIjjSZmUjYi0qd
        HuX94MpbB7y+n6BOEyaOfJrdnqKm4rFQpqnhcHQYbyMQervDZsVDg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E052819098C;
        Mon,  7 Mar 2022 12:22:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6601119098B;
        Mon,  7 Mar 2022 12:22:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
References: <Yh3rZX6cJpkHmRZc@ncase> <Yh325v3RBDMxjFnD@ncase>
        <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
        <Yh4zehdSnHLW1HuK@ncase>
        <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
        <Yh93vOkt2DkrGPh2@ncase>
        <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
        <YiCkRLFxn8Pok7Kc@ncase>
        <33deae83-1afd-1645-82f3-5af14f14094d@github.com>
        <06ea3190-32d0-c792-0ae9-c5600305f158@github.com>
        <YiXfnsbGzPXffdgV@ncase>
        <94ed6a1e-327c-3f94-b98b-db019a6f5ada@github.com>
Date:   Mon, 07 Mar 2022 09:22:04 -0800
In-Reply-To: <94ed6a1e-327c-3f94-b98b-db019a6f5ada@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 08:45:07 -0500")
Message-ID: <xmqqa6e1u18j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C28B8AE-9E3B-11EC-8552-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Thanks for following up. I agree that with 5/4 we should be safe.
>
> I'll remain available to quickly respond if anything else surprising
> comes up in this area.

Thanks.  I just picked up the "bankruptcy" step, so we should be
good to go.

