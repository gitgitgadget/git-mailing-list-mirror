Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4130C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B5620828
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cO4e7UDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLZUqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:46:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65358 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZUqE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:46:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73108A8A91;
        Thu, 26 Dec 2019 15:46:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cu1fxJyJx4xhJDEYxCH9cNQYGfI=; b=cO4e7U
        DfKJIdsudgs5C8Fm8asvhBvdHQejsrPkC3EtJ7Sng9/7knR9T4sZ7mu/kdUycegJ
        62t81f0RqOja9Ax+0AJNlB2fUAyvcaiomBbJ5gUMQsjY1QP+DnJoWNm95RxGK7mn
        M5yTfW4FQSJ/nN+6Gp0NL+YhOtcQQVcyNpXoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k/C33EirC+glH0kQAoGZM0nr7KPbHXAR
        cbIjHiyrw0D0+B3nTG4z21I5NDwz2F6jwRdwY9e5R3CdU35Q4V2pK8vePo64ZlsX
        OZly5RQdAUK0pZhDxYdZwODwBgSZhJBR/elMYU1D1PNSvcBFF3r98CRZZL3z385z
        E9ZcjxGb+V0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F208A8A90;
        Thu, 26 Dec 2019 15:46:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49E81A8A8B;
        Thu, 26 Dec 2019 15:46:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/9] built-in add -p: add support for the same config settings as the Perl version
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 12:45:58 -0800
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 25 Dec 2019 11:56:51
        +0000")
Message-ID: <xmqqsgl6ke7t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B96C6E46-2820-11EA-9104-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  * Fixed the commit message where a copy/paste fail made it talk about
>    another GIT_TEST_* variable than the GIT_TEST_ADD_I_USE_BUILTIN one.

This matches what is queued (with a hand-fix while queuing), so
I'll keep it, together with the older author dates.

Thanks.
