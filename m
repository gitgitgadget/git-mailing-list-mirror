Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBFBC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 05:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353679AbiCPFxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 01:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiCPFxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 01:53:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B767060053
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 22:52:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F333611919F;
        Wed, 16 Mar 2022 01:51:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:message-id:references:date:mime-version
        :content-type; s=sasl; bh=r5qBnsCvVmiZpzP6NWgJ8b7lT9r8YOo2+LaGtA
        1lwDE=; b=PO/rlwgx5dcR4jbnc+Umj29a0ERy6iIEW/akT6DnZ0+kIUMxKGodmo
        ucW+WlHKFyWgY040IqdqByssH/MBOJu8iYsg+TBVQfi557vP2g8Kpek/98jG33nk
        A0gslhWVTpDa1xR4EsV6kWmdwWRrg6gtn7SC+etls8DLEDaoZDWcc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB19D11919E;
        Wed, 16 Mar 2022 01:51:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6007711919D;
        Wed, 16 Mar 2022 01:51:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] maintenance: fix synopsis in documentation
In-Reply-To: <pull.1178.git.1647366104967.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 15 Mar 2022 17:41:44
        +0000")
Message-ID: <xmqqmthrdrp8.fsf@gitster.g>
References: <pull.1178.git.1647366104967.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Tue, 15 Mar 2022 22:51:58 -0700
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31F7A7CC-A4ED-11EC-A740-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20220316055158.wbhq_haMau8etLPFUIzHhGR8JB3EraqHMCTjQvWQ7a0@z>

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The synopsis for 'git maintenance' did not include the commands other
> than the 'run' command. Update this to include the others. The 'start'
> command is the only one of these that parses additional options, and
> then only the --scheduler option.
>
> Also move the 'register' command down after 'stop' and before
> 'unregister' for a logical grouping of the commands instead of an
> alphabetical one. The diff makes it look as three other commands are
> moved up.

Will queue.  Thanks.
