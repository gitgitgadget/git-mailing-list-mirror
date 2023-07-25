Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A96AEB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGYV4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGYV4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:56:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9492129
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:56:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D942A190C90;
        Tue, 25 Jul 2023 17:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DyEtMljGM5tPp/SjGcaLuJSwgK54rvWync6X5e
        3zeIE=; b=A53C5aLleDajRrM6VprsCMc3d5V+1jRKg/SH5mbd3wU1SYKodbW6rs
        psVaAopfoKozrGh8iepewiPcpMwd4oHYZPRKDMzlTb+Kh3bIoI72UYZ2ew487tCX
        1ca5QdFgfYnDiUaIcMA3+prsA35Zwil0/FybGItdQIDgxKlhG5fns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1E38190C8F;
        Tue, 25 Jul 2023 17:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A8CE190C8E;
        Tue, 25 Jul 2023 17:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pvutov@imap.cc
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5] doc: highlight that .gitmodules does not support
 !command
References: <xmqq8rb3n9du.fsf@gitster.g>
        <20230725212218.711116-1-pvutov@imap.cc>
Date:   Tue, 25 Jul 2023 14:56:13 -0700
In-Reply-To: <20230725212218.711116-1-pvutov@imap.cc> (pvutov@imap.cc's
        message of "Tue, 25 Jul 2023 23:22:18 +0200")
Message-ID: <xmqqv8e7hczm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1310DCD6-2B36-11EE-BD1F-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pvutov@imap.cc writes:

> From: Petar Vutov <pvutov@imap.cc>
>
> Bugfix for fc01a5d2 (submodule update documentation: don't repeat
> ourselves, 2016-12-27).
>
> The `custom command` and `none` options are described as sharing the
> same limitations, but one is allowed in .gitmodules and the other is
> not.
>
> Rewrite the description for custom commands to be more precise,
> and make it easier for readers to notice that custom commands cannot
> be used in the .gitmodules file.
>
> Signed-off-by: Petar Vutov <pvutov@imap.cc>
> ---
> Combines the custom command description rewrite by Junio C Hamano and
> my proposed changes into a single patch.

Thanks.  Willl queue.  Let's move it forward.
