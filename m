Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C61EC433FE
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbiEXTGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241075AbiEXTGh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:06:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1082DE012
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:06:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F334E180410;
        Tue, 24 May 2022 15:06:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L+WBcFAMBWNNBI8ZODVanwIfOhl6tX6ilU7dSO
        nvqgM=; b=fvQHYyL5zL8fTJ9I8werg2I6d1MRo6BDVRecS/eDegGMW6OLyRP3NO
        wyfYX5zHQGcx80DKXiCUWgWkYVDnln2JAF2JwZVt0Ii/EV8bafj1s+oePmek+J7G
        eYn6rmIM6taTG/4jAF0xTGnardNkPfDtG9Yugo68bw52WyeeiWGBo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB24F18040F;
        Tue, 24 May 2022 15:06:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A3178180409;
        Tue, 24 May 2022 15:06:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 0/5] Improve MyFirstContribution's GitGitGadget section
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
        <xmqqpmk9kxa8.fsf@gitster.g>
        <f47761e0-bbaa-e4a5-b74e-e9c211bd8d85@gmail.com>
        <xmqqy1yubb8j.fsf@gitster.g>
        <0a2ab37e-58c0-378e-bc43-a935c8ebecec@gmail.com>
Date:   Tue, 24 May 2022 12:06:30 -0700
In-Reply-To: <0a2ab37e-58c0-378e-bc43-a935c8ebecec@gmail.com> (Philippe
        Blain's message of "Tue, 24 May 2022 08:29:51 -0400")
Message-ID: <xmqq5yluiwcp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F5B4C3C-DB94-11EC-8CFF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I can't really send an incremental fix because the final content
> as it is in 'next' already is OK; it's just that some content which was added
> in patch 2/5 should have been added in 1/5 instead.
>
> It's that too big of a deal, I just wanted to let you know.

Ah, I mis-read you then.

Such a misdivision may technically break bisectability, but
hopefully nobody bisects the documentation changes and I do not
think we should be worried too much about it.

Thanks.
