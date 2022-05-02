Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131D7C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbiEBRLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386513AbiEBRK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:10:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F75F76
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:07:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E734193040;
        Mon,  2 May 2022 13:07:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=39PE2+PVkbWQfc46REyMxcKMUdRSo8doiTEF3q
        BQip8=; b=bAZ4k1xoS8njTjDTvXJchDfxSELMtuh8q44iBm1u0xt8t3gESq0xDv
        /37x2UFcIw7buKBEGHuHV9R8NFq6VmEd47g4DFvxeHMpfjnK+cF2U+tppjOEBrzO
        yHOZi8ZlSfCnF/WhGCPSkz/QxdYCFWPsfQJh88pRilgGbzfYGomBs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 472FC19303F;
        Mon,  2 May 2022 13:07:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3C6219303E;
        Mon,  2 May 2022 13:07:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cocci: drop bogus xstrdup_or_null() rule
References: <xmqq1qxd6e4x.fsf@gitster.g>
        <4181f814-6d8e-ff2c-6fc9-a625ac189eae@github.com>
Date:   Mon, 02 May 2022 10:07:17 -0700
In-Reply-To: <4181f814-6d8e-ff2c-6fc9-a625ac189eae@github.com> (Derrick
        Stolee's message of "Mon, 2 May 2022 09:46:11 -0400")
Message-ID: <xmqq4k272796.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52D3735A-CA3A-11EC-8CCB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I think you mean if it were
> ...

Please disregard.  That one was completely bogus.

> Dropping the rule makes the most sense.

Yup.  ThHanks for a doze of sanity.
