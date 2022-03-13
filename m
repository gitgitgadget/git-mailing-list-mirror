Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA443C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiCMSl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiCMSlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 14:41:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303BF76E23
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 11:40:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B44AC11D881;
        Sun, 13 Mar 2022 14:40:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m3xR1SP+P/KdQvvWjW6lc9pxyCrmky2MYTX8S/
        ilCxQ=; b=H9URDWzKdv6ofOgnsFcDK5PaP8dargsq7+HdEvPP4kY9ves73ZPRQW
        eVJmyXcskmGHZSuyM+2bLR+Jh+dLAEa4dpTumLAUbZF5RevkTwzpBWPEJ6EsaNjx
        jHx4nW08QAOhv/KkaLJhcjgWReUEjo0+QNN0HUAWiLI3DKWI2t4nA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB6CC11D87E;
        Sun, 13 Mar 2022 14:40:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D06611D87D;
        Sun, 13 Mar 2022 14:40:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4] name-rev: use generation numbers if available
References: <20220312000015.3643427-1-jacob.e.keller@intel.com>
Date:   Sun, 13 Mar 2022 18:40:13 +0000
In-Reply-To: <20220312000015.3643427-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 11 Mar 2022 16:00:15 -0800")
Message-ID: <xmqqy21dvgqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05E11C82-A2FD-11EC-9494-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> Add several test cases including a test that covers the new commitGraph
> behavior, as well as tests for --all and --annotate-stdin with and
> without commitGraphs.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Changes since v3
> * Fix the commit graph test as pointed out by Junio

This round looks good.  Let's merge it down.

Thanks.
