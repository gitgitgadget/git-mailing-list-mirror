Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27272C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 20:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiGMUcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMUce (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 16:32:34 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BC72B25E
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:32:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9458313C970;
        Wed, 13 Jul 2022 16:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E3hl7tQTx/6C7B5cg3jopxqb0I7uzZhDu6iikx
        k+qd0=; b=O/Psqr3RFWv8Ocmoi+i0wATnhwwexlDueKNk9fp63mLovke263meB2
        XWGmF/anmRvZ26C/ARoDgzBNZOxbdLcNKsGsVzcE9eza8QhBSPt9qQ/g8+k7jbRi
        3DfGuYwWcoIqi+2aP4Z7TNT5DS5E5juUsYh80cXI7CZVfhMb5VZ7s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AF2F13C96F;
        Wed, 13 Jul 2022 16:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D96C113C96E;
        Wed, 13 Jul 2022 16:32:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
        <xmqqk08hdm05.fsf@gitster.g>
        <647a4cf7-ef1f-284b-37e2-4dceb3cfae1d@github.com>
Date:   Wed, 13 Jul 2022 13:32:30 -0700
In-Reply-To: <647a4cf7-ef1f-284b-37e2-4dceb3cfae1d@github.com> (Derrick
        Stolee's message of "Wed, 13 Jul 2022 14:33:05 -0400")
Message-ID: <xmqqfsj4bvoh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBBF07F8-02EA-11ED-B93D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I like how you start by saying you are playing devil's advocate,
> but then go on to add more reasons to support the work. It's good
> feedback to make the case stronger.

I may have offered alternatives, but I am not "adding more" reasons.
