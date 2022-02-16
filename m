Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF3C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiBPBAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:00:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245223AbiBPBAm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 20:00:42 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4799CE98D0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 17:00:31 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95725129771;
        Tue, 15 Feb 2022 20:00:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xPDbndLfjFAdeSYx+aO4UUYbNdUXHU5UmVMek1
        FpG8I=; b=EDFQ6m4yFytez1nwThkIsJYVq+CpOy4C33dgUKXoNpmy41rYG4Rehr
        TGNYcDpNMgdy9ZMHya0AYGEztOxdeKysg8mx3LgFJ38ZuhTSEnxUcST6Hxpqb43v
        nF1HfZx5ZgM0trU60EVYbH6oS1YI7GUjblNJhXE7PJa9EESLJp1NU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DA13129770;
        Tue, 15 Feb 2022 20:00:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC32212976F;
        Tue, 15 Feb 2022 20:00:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/23] Builtin FSMonitor Part 3
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 17:00:28 -0800
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com> (Jeff Hostetler
        via GitGitGadget's message of "Tue, 15 Feb 2022 15:59:10 +0000")
Message-ID: <xmqqv8xfy6ab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5E37B44-8EC3-11EC-9237-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is part 3 of my builtin FSMonitor series.
>
> Part 3 builds upon part 2 (jh/builtin-fsmonitor-part2) which is currently in
> "seen", so this series should be considered a preview until part 2 moves to
> "next". (And part 2 should not graduate to "master" without this part.)
>
> Part 2 established the client code (used by commands like git status) and an
> MVP implementation of the FSMonitor daemon. This was sufficient to test the
> concepts and basic functionality.

Sounds like part 2 is sufficiently done to be eligible for being in
'master', waiting for an improved daemon, no?  

Have people been reviewing the patches in part 2?  I haven't had a
chance to take a deeper look myself.

Thanks.

