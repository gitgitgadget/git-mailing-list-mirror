Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4819FC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiHPSor (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbiHPSon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:44:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DBA6C12D
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:44:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A918715D295;
        Tue, 16 Aug 2022 14:44:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=71CNeqrXX0VoMkhdO8A4ViGqaODaYuNROLFXJb
        pvd50=; b=ny5hRs6EeKnM3AAeHtvpFDyZ8gKZBc3K730g5sQ7XR37i/e2wLazYE
        24Kytk6M/LXtCv11DpB8wdCxMJIBhLLEhqr1Y6VpwWRQScSq95BiVOhZx3s6V1/b
        uvh5ngqXw0lSU7fBjTuPXo1GgEts3K9lwxc/Gv2X/24XhqLZD4fts=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A04ED15D294;
        Tue, 16 Aug 2022 14:44:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10A7115D293;
        Tue, 16 Aug 2022 14:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com
Subject: Re: [PATCH 0/3] scalar: enable built-in FSMonitor
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <xmqqzgg4uk0q.fsf@gitster.g>
        <5fb1a4b3-a4d8-25de-ac47-7e47bc604f97@github.com>
Date:   Tue, 16 Aug 2022 11:44:37 -0700
In-Reply-To: <5fb1a4b3-a4d8-25de-ac47-7e47bc604f97@github.com> (Victoria Dye's
        message of "Tue, 16 Aug 2022 11:42:07 -0700")
Message-ID: <xmqqa684uiy2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B16DC4C-1D93-11ED-AEA4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> On the off chance that some major blocking review to
> 'vd/scalar-generalize-diagnose' comes in, I didn't want to base this series
> on that one. But, if it *is* merged to 'next' before this one, I'll make
> sure to rebase this series on top in subsequent versions to avoid the merge
> conflict. 

All sensible.  I actually am running out of topics to merge to
'next' ;-) and that was the primary reason why I asked.

