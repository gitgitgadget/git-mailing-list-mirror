Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFFFC433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D3B60EBB
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJaStP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 14:49:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61626 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJaStO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 14:49:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BBC0F1145;
        Sun, 31 Oct 2021 14:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WsJuCyrwEOLR1BdAyPBhs7jRT6H2EWAYIjZSbR
        MqqlI=; b=kQ8RBT4ghqdkX5Esv3QKzOPgdL0w+bH1D1ZiD3Z/Th1UkJjs26aKRK
        hgyPKqNtlsc0uzsKrIxf5gyc5WycM9Y4WqRNQ8kXoiZbm4FI34QmVId5BVNQcPH6
        JQmVeFojnadTdFe9J1JTcijpDdYTcxd4bKhcWyGLdwiAtTA6HUvO0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12CE4F1144;
        Sun, 31 Oct 2021 14:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 793C8F1143;
        Sun, 31 Oct 2021 14:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dongsheng Song <dongsheng.song@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: timezone related bug of git
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
        <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
        <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
Date:   Sun, 31 Oct 2021 11:46:40 -0700
In-Reply-To: <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
        (Dongsheng Song's message of "Sun, 31 Oct 2021 21:18:27 +0800")
Message-ID: <xmqqcznldobz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E346BBF4-3A7A-11EC-B223-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dongsheng Song <dongsheng.song@gmail.com> writes:

> Thank you for the clarification, it's really a disappointing answer.

The situation may be disappointing, but I found the answer eminently
clear and helpful.

> Perhaps the manual needs to be clearer about this limitation.

Sounds like we have a volunteer ;-)?

Thanks for a report and discussion.
