Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34680C64E96
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 20:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354842AbjHQUie (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354891AbjHQUiM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 16:38:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF61FF3
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 13:38:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 305AB1A7476;
        Thu, 17 Aug 2023 16:38:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aGCCacNpaE+LJ7ol1JVcVNtbn54IIVunm0yqSH
        fd9/U=; b=QIMhFmMo4nwjm221SMoB8ma5pT0SX3YiAjknSIujJPmZwBRFqG1Tlm
        oCcHkUIHukpqMr/ciwunVXJB8E1mTOKZUqEEl5umBBEau9D1K1gZszht9bisdySk
        lKSbDzgl5dMW0JlelFxQP089A/F7xcKceOY0PX447BveDP3TpbQ/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25D261A7475;
        Thu, 17 Aug 2023 16:38:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E0911A7474;
        Thu, 17 Aug 2023 16:38:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        phillip.wood123@gmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 0/3] Add unit test framework and project plan
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        <cover.1692297001.git.steadmon@google.com>
Date:   Thu, 17 Aug 2023 13:38:08 -0700
In-Reply-To: <cover.1692297001.git.steadmon@google.com> (Josh Steadmon's
        message of "Thu, 17 Aug 2023 11:37:20 -0700")
Message-ID: <xmqqo7j5be1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA24A1E8-3D3D-11EE-9B26-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Changes in v7:
> - Fix corrupt diff in patch #2, sorry for the noise.

Thanks for resending.  Will queue.
