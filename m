Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28693C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 23:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiANXco (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 18:32:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61477 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiANXco (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 18:32:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DEB110C853;
        Fri, 14 Jan 2022 18:32:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=siT79qsVqchlXHVimetyxYLOUOv0wiT6SSyEmS
        z1TTg=; b=jnThW3SV9Y1ht75GkrC02dq3isxIB2ncJSaCkcRGuiVzQjb2BOMY79
        LbkTwkcQLkDnsYn/aczHIvhZCJvPf8vVTd1MFjXgobEQHS5Gajkdq3frexm6Vtch
        +kMNrKWDzJrSQwh9hzInPQB+VP8mn5iDxa4iJ9g8xORt0rQW0H/AA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48AFA10C852;
        Fri, 14 Jan 2022 18:32:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEAEF10C851;
        Fri, 14 Jan 2022 18:32:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: Mistakes in the stalled category?
References: <xmqq35lrf8g4.fsf@gitster.g>
        <CABPp-BFj8NyXG6cQPJeDE46eicbfnP=TgEirRZVcnMM+YNG7OQ@mail.gmail.com>
Date:   Fri, 14 Jan 2022 15:32:41 -0800
In-Reply-To: <CABPp-BFj8NyXG6cQPJeDE46eicbfnP=TgEirRZVcnMM+YNG7OQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 14 Jan 2022 07:44:36 -0800")
Message-ID: <xmqqr19999ly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45254D84-7592-11EC-857A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Are there some errors with the stalled category this time around?  In
> particular...

Yeah, I agree that the more recent ones would not belong there.
