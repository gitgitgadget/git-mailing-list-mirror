Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C687EC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiHPSVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiHPSV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:21:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E88672E
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:21:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F891132E34;
        Tue, 16 Aug 2022 14:21:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6P7kYYD9dHT7fpGtTOvsL99YSvAxnqRVpyFXOe
        hT0BY=; b=S2Y5InGRR84iyCyh6M3eOg5CiRSk48LoyHuvQLi7Kr3Oo3jXfzXuqK
        UZx0a2+ZSnw0YAGTVXBludGNWqqO7NlrfX+AMj6O8z1QgzmZ0d35in7pYWr1SkA3
        MN3wS6j654QofsH6g5tnxoBrstoZNtUeUdfeb/TblnUpx+NPNvHZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 277B7132E33;
        Tue, 16 Aug 2022 14:21:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87C96132E32;
        Tue, 16 Aug 2022 14:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/3] scalar: enable built-in FSMonitor
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 11:21:25 -0700
In-Reply-To: <pull.1324.git.1660673269.gitgitgadget@gmail.com> (Victoria Dye
        via GitGitGadget's message of "Tue, 16 Aug 2022 18:07:46 +0000")
Message-ID: <xmqqzgg4uk0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DAEE910-1D90-11ED-9245-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series enables the built-in FSMonitor [1] on 'scalar'-registered
> repository enlistments. To avoid errors when unregistering an enlistment,
> the FSMonitor daemon is explicitly stopped during 'scalar unregister'.
>
> Maintainer's note: this series has a minor conflict with
> 'vd/scalar-generalize-diagnose'. Please let me know if there's anything else
> I can provide (in addition to [2]) that would make resolution easier.

Thanks.  What's the doneness of the other series?  It has cooked for
quite a while and I was wondering if it is ready for 'next' already,
by the way.

