Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BC1C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 10:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiEKKLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 06:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbiEKKLc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 06:11:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE0F1EECD
        for <git@vger.kernel.org>; Wed, 11 May 2022 03:11:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C77218DC16;
        Wed, 11 May 2022 06:11:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=fMJlZpr5cqyHKxUDxfnPVVIU7Pz8xV1xeNOl9869KX0=; b=F8Uc
        60iDgT0zZuMSK5O74uAf2jUp5ZGC5GRGSnmVtzj9CU+9yAiwvdVME4PSnmGaj/wY
        FvD4bolG0SXYhXloC1oKE+swHFzePrqk6nR52GamnTSZ8FJPkTthMNg7ATKMib6r
        evlwdVgRWGtHrsKw9W2gXctyzjNBPaZuIuYW0nQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 753BC18DC15;
        Wed, 11 May 2022 06:11:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2308D18DC14;
        Wed, 11 May 2022 06:11:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/5] Improve MyFirstContribution's GitGitGadget section
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
        <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
Date:   Wed, 11 May 2022 03:11:24 -0700
Message-ID: <xmqq4k1wnzub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B79A8484-D112-11EC-9A2D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Thanks a lot for the reviews! Here is an updated version.

Thanks a lot for the patches.  I made a small comment or two, but
other than those, everything looked good.

Will queue.
