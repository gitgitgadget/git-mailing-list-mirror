Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C7AC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE9E6135E
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbhI1STR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:19:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbhI1STQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 14:19:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7889CE03C2;
        Tue, 28 Sep 2021 14:17:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9m39pswkczT1k87Lx/9PHqrbc6crxXCRQ9rAIK
        0kUXo=; b=X4+9x2Yz4Nh8AKv0hHu6HXTsKRmh8yPQ6hX0x2xbpcOCgHtQer3Or1
        cH5vv9ir5sErF7w7oFO7JpSKiM5kIUC9xVm3GwYreSBrxh4g/2qVJE1FNfI2mcJE
        eK95N2BBKt7OSFtl2Fcdq2O53otVdgWHy2dDe2JPI0agY8GdTehc8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B07DE03C0;
        Tue, 28 Sep 2021 14:17:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA450E03BF;
        Tue, 28 Sep 2021 14:17:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 00/19] Adds reftable library code from
 https://github.com/hanwen/reftable.
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 11:17:34 -0700
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 28 Sep 2021 15:09:57
        +0000")
Message-ID: <xmqqtui4k1j5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B2549B8-2088-11EC-B99D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The reftable format is described in Documentation/technical/reftable.txt.
>
> This is a fully reentrant implementation of reading and writing the reftable
> file format, and should be suitable for embedding in libgit2 too. It does
> not hook the code up to git to function as a ref storage backend yet.

Elsewhere you solicited comments on the "RFC - add LICENSE" step.

As long as the copyright holders of this library are happy with BSD,
I do not see a problem with your plan in which the project borrows
this code under the license and then owns it, giving access to
others under the same license.

If somebody sees problems with it, please raise your hands ;-)

Thanks.
