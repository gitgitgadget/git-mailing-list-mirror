Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B682C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiHLSgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiHLSgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 14:36:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E3B3B19
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 11:36:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DEE213BE83;
        Fri, 12 Aug 2022 14:36:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cvUphvszzpAyx8SROSZsNwi0pa7q/oLMO+6dU6
        5vGMo=; b=byQB54Yo7NEIO+IHTNm5pSNLVVnrQCDE8P4eTbM/vFdgD0Z8izT34B
        22UaiJIQcPvXduMMSN70SBz9ajRXSa5aVlZvS8zSKF/recLJYHLGQM2S/bbLH6mq
        KZEq7dLparSsjTd/S0VQhULVi2XP5ZnhmdPv3UaSYitGsal8og4RM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 458A113BE80;
        Fri, 12 Aug 2022 14:36:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB77C13BE7F;
        Fri, 12 Aug 2022 14:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH v2 0/4] rm: integrate with sparse-index
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
        <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
        <8a76428d-e236-88bc-ec67-356b4c6f67fa@github.com>
Date:   Fri, 12 Aug 2022 11:36:44 -0700
In-Reply-To: <8a76428d-e236-88bc-ec67-356b4c6f67fa@github.com> (Victoria Dye's
        message of "Tue, 9 Aug 2022 17:27:35 -0700")
Message-ID: <xmqqczd5b96r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7E2FE5E-1A6D-11ED-976D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Other than a completely optional recommendation on commit ordering
> [1], I didn't have any comments on any individual patches. This
> series looks good to me!

Thanks, all, for working on and reviewing these patches.

Let's merge it down to 'next' soonish.

