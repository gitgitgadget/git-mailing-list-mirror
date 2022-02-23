Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4E9C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbiBWVgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242277AbiBWVgL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:36:11 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67C04F9D6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:35:42 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99C01178FFC;
        Wed, 23 Feb 2022 16:35:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=0GnTdAc3C/e36Ho89uGfYcLIExypKDkvEeJxZhxg0xg=; b=Gur6
        q0GyJ4GFFqRPG5NJhZG2if4dcYPKDk4U/AJnr0grhaiCfxXPtAm+fzgCVpzClSus
        btSuYX+EADGHe4iAYoRNz46fAhsd8A2wmPVLxepXvEXLFpIA4kphVBU2WyFJf/PP
        rX2MYsdEeeti62OlzFNkJf/l8WxPcM61QqCCTa4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 923D8178FFB;
        Wed, 23 Feb 2022 16:35:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D9FCE178FF8;
        Wed, 23 Feb 2022 16:35:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/14] Finish converting git bisect into a built-in
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 13:35:37 -0800
Message-ID: <xmqqo82xs1ue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B242166-94F0-11EC-A8DD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> After three GSoC/Outreachy students spent an incredible effort on this, it
> is finally time to put a neat little bow on it.

Thanks for tying the loose ends.  I've read the previous one and
also this round, and except for the parse-options bit I am not sure
about (read: I do not have a strong objection, but I do have to
wonder if there is a better way to achieve the goal), everything
else looks good.

Will queue.

