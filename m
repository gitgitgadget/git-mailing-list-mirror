Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C314C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE54206BE
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dp1A5yKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgETRqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:46:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52339 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:46:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4BC0DAA93;
        Wed, 20 May 2020 13:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rjrG+FfMup5wNQ4N9YHWwshhjaU=; b=Dp1A5y
        KecBjYRuktOlIY01G7fzL0gzqG/2EqgyRLOr1reuQH0JrLrpReraG8Sn1RT/6JgU
        /FZdC03Clhy9ivf7HG+YJIfpj8CK3wn5F9gin0kqRHdvZbhJbhboZd3nbPeIjVEj
        dMey8UEkj7qoeoTeLdmrqWJHCozgsYjk5Cnns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SQSEkaAH14808r/6aMHMS4CGry8F76oX
        rCDFmA0Bnk9wQJANJN/dFdkAHmP3+Te/4tfcLDghxFel7MaMjuHpSF5X3JIwJtwY
        U8j2vShLdQYfTeGth5NfLoIXZp6znn7mHkgLaNt32wE3dnUo5oXNrMJK2xkiC86C
        w6kBkI5UhUM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB70FDAA92;
        Wed, 20 May 2020 13:46:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B9F3DAA91;
        Wed, 20 May 2020 13:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/6] Refs cleanup
References: <pull.638.git.1589996173.gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 10:46:40 -0700
In-Reply-To: <pull.638.git.1589996173.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Wed, 20 May 2020 17:36:06
        +0000")
Message-ID: <xmqq5zcqwlbz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD50D720-9AC1-11EA-8BA1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series contains preliminary cleanups for adding reftable support
> to git-core

I'll rebase hn/reftable on top of these patches, and hopefully we
can merge this topic early to 'next' to start cooking it early
before the rest, unless there is no other major issues identified by
others.

Thanks for a quick turnaround.

