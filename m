Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE956C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 22:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8DA6137D
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 22:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhDPWpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:45:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60331 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbhDPWpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 18:45:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B29D12D004;
        Fri, 16 Apr 2021 18:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=RaIh8rVKgF5NHhJmVBtOBoTNtWg=; b=oFuP7nMSJjpgxzeLoYo0
        tpubXMWJvOJbzK8m91mCXfiWaJYhSTckJ+bMdV/LHujFvi42KGGOjd0w8itCcSkg
        x1cJWQESp6dVQaiNvRbSLbndHYOqUXo5M4cAX3GK23uC9F83Er983s9QQcLK3L28
        FA3bFnSljoGObaHQl8FN02c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=kRYnTJuw230w7Z5jeJdCJYayGb2BdlvghZXCvTiNgBL8qu
        WQnfMyPc7FT9PDCyYKPDVqrVSebjgFMUgXvuBqOjhmcHgTgYvRt5xWnHR5thOC9Y
        krtV64CJBRV6SLGIfR3cTTscd6YcAtWNU1y4R8F95/y+IDIl3oo4xJyPtJLOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8634912D003;
        Fri, 16 Apr 2021 18:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC2D012D001;
        Fri, 16 Apr 2021 18:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/23] [RFC] Builtin FSMonitor Feature
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 15:44:37 -0700
Message-ID: <xmqq8s5hkfxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53FFEA08-9F05-11EB-A2F9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series adds a builtin FSMonitor daemon to Git.

This hasn't seen much (if any) activity for a few weeks.

Does that mean nobody (other than obviously the author and whoever
wanted to have this feature) is interested?

What does it need to get this topic unstuck?

> Finally, having a builtin daemon eliminates the need for user to download
> and install a third-party tool. This makes enterprise deployments simpler
> since there are fewer parts to install, maintain, and updates to track.
>
> This RFC version includes support for Windows and MacOS file system events.
> A Linux version will be submitted in a later patch series.

