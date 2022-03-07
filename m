Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC90C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 22:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiCGWMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 17:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiCGWMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 17:12:50 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5928B6F9
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 14:11:54 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CF9C192D20;
        Mon,  7 Mar 2022 17:11:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z6UiTZZZmYLRxPyRoHKADAA17fjjgb77kepDMf
        XlKwY=; b=sE+uS56K7j55G+7g6usAEsiIRIzomNCurvUjIgmK4kMLkg5kTM8J1+
        n8/3pmFWL7fiPcERss0bPXhArOY0hzEzAA5xnYO+XKqzUrqkM1ctz7INZs4keRVV
        +zYryMEh1gn7DlP1npM5FRfjSjwH+TNgHBxCZTFFABkdJtIg5lgV4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35130192D1F;
        Mon,  7 Mar 2022 17:11:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A217C192D1E;
        Mon,  7 Mar 2022 17:11:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/12] Partial bundles
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 14:11:50 -0800
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 07 Mar 2022 21:50:28
        +0000")
Message-ID: <xmqqh789quop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 972BAEB2-9E63-11EC-A5C1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> While discussing bundle-URIs [1], it came to my attention that bundles have
> no way to specify an object filter, so bundles cannot be used with partial
> clones.

Looking good.  Will replace and queue.

Thanks.
