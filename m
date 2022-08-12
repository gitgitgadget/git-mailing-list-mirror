Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9790C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 18:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiHLSXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLSXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 14:23:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26669B2DA6
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 11:23:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 354651B0D13;
        Fri, 12 Aug 2022 14:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=63GiuzLWKzla0nhgKGrZgqUyC8NdlHzgIdwhKo
        QXpmo=; b=EsWQENkM6oA95pE+T2aA35VOMs++idZhdjsbBrBBblcV8tZVy0NAzt
        yboxXFRINVmbrtsI78Ia64r9P/AT6lH3/B7lyuAMqOCsdfEfUhz/1SI5xmJlfL4F
        dMi59Rp9V8cjBqhVQ4Oi/uXaSfOalAqhDfYR1/5VO8B8tIU04A5D4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D7B01B0D12;
        Fri, 12 Aug 2022 14:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B7411B0D11;
        Fri, 12 Aug 2022 14:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com>
        <pull.1317.v4.git.1660262231357.gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 11:23:28 -0700
In-Reply-To: <pull.1317.v4.git.1660262231357.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Thu, 11 Aug 2022 23:57:11
        +0000")
Message-ID: <xmqqh72hb9sv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD500116-1A6B-11ED-A1CA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Though perhaps not common, there are uses cases where users have large,

"uses cases" -> "use cases", probably.

> network-mounted repos. Having the ability to run fsmonitor against
> network paths would benefit those users.
>
> Most modern Samba-based filers have the necessary support to enable
> fsmonitor on network-mounted repos. As a first step towards enabling
> fsmonitor to work against network-mounted repos, introduce a
> configuration option, 'fsmonitor.allowRemote'. Setting this option to
> true will override the default behavior (erroring-out) when a
> network-mounted repo is detected by fsmonitor.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---

Will make the above typofix while queuing.

Thanks.
