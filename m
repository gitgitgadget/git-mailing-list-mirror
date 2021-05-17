Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E2C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0FC60FF3
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhEQTxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 15:53:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59902 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhEQTxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 15:53:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27BA41335C5;
        Mon, 17 May 2021 15:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AYvd1mFWTl2CIA6QE/Qh4bC49R05CxcCxIuI8h
        yEk8A=; b=nqEouMv5M4PGe55Ml3dOp+qoHg9LcQ94LfEQdTMnqViWcAlgmbMq/e
        CooJ0Yop2G/SZPKYmzCqTJr5kIiX/cUPm7YuHIiXIvZN/qvYETgN9ljadcaAGHel
        bbkjlVOKN93ZjNVZiOwaqTGcOCiPIvG3SS4AWRXHmmSuCz3Pzam8w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F9041335C3;
        Mon, 17 May 2021 15:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E13EB1335C2;
        Mon, 17 May 2021 15:51:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/9] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
Date:   Tue, 18 May 2021 04:51:39 +0900
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 17 May 2021 18:58:09 +0300")
Message-ID: <xmqq1ra56svo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C87EE0E-B749-11EB-BC42-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Fix long standing inconsistency between -c/--cc that do imply -p, on
> one side, and -m that did not imply -p, on the other side.
> ...
> Exact historical semantics of -m is still provided by
> --diff-merges=separate.
>
> Updates in v1:

OK, so this is [v2] not v1 ;-)

Will replace.  Thanks.
