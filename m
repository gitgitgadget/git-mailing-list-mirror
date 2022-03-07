Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33544C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbiCGQu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiCGQu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:50:26 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C74665B
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:49:31 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32E6A190590;
        Mon,  7 Mar 2022 11:49:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mTwUoffexw7XJ6JhnUGNkoTOlZJaXbE2bWuLOQ
        V/qyM=; b=ZEX0KIps2K35bMFRldV/STPovpWOY20PqyCRVTrXB1kFH3mk0lCpAX
        jCc4r3yVy86KxIHIUi7gqRKm/vsSLHKu5y7r1V/uIv8FyPzW2s7i7J1RrDxSLSHu
        edUyFInk+/NyEfxAYsQtBrEL+L+wYetibcLPt9t5Zw99Skqhi8kCM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B3B919058F;
        Mon,  7 Mar 2022 11:49:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A410819058E;
        Mon,  7 Mar 2022 11:49:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
Subject: Re: [PATCH 10/11] bundle: create filtered bundles
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <5393e74708dfd38e5596d9e877a491e6ed8dda24.1645638911.git.gitgitgadget@gmail.com>
        <xmqq5yotxpdo.fsf@gitster.g>
        <edb5897a-30f0-e5a6-1166-d03f5bdaeb47@github.com>
Date:   Mon, 07 Mar 2022 08:49:27 -0800
In-Reply-To: <edb5897a-30f0-e5a6-1166-d03f5bdaeb47@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 09:14:09 -0500")
Message-ID: <xmqq35jtvhbc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DD942D4-9E36-11EC-9D91-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Perhaps I was thinking about having one line per "reason", which might
> be extended in the future.

Makes sense.  It wasn't a serious objection but mostly a curiousity
question anyway.
