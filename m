Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811BFC25B08
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiHDUmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiHDUmC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:42:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B87E5FAE7
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:42:01 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F9C315486E;
        Thu,  4 Aug 2022 16:42:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YblpAcOdJfVYykENTgQDadFHnWFqGKR01yrWJP
        Tucp0=; b=eFT1TE9Nvy72+5Zn0xzxr/PecEVFWzZbXfNpVzHyE6kiiINOSpFX0J
        Au+9eW0RoR1QPdjaszdUSeTmOJNYieE4PUHlFhCZqXecZlbbTVjZRLMsOAmEEGrI
        4JZ1JweTd4+93GC1j3HWZwqVU1bXpeA4Voo/OxnZ8wB2fPSjDoiKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61E3A15486D;
        Thu,  4 Aug 2022 16:42:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A301415486C;
        Thu,  4 Aug 2022 16:41:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] tests: cache glibc version check
References: <pull.1311.git.1659620305757.gitgitgadget@gmail.com>
        <xmqq4jyr6fuz.fsf@gitster.g>
        <53cffc06-ebb1-ac97-ceb4-4c242a82c68a@gmail.com>
Date:   Thu, 04 Aug 2022 13:41:58 -0700
In-Reply-To: <53cffc06-ebb1-ac97-ceb4-4c242a82c68a@gmail.com> (Phillip Wood's
        message of "Thu, 4 Aug 2022 20:16:12 +0100")
Message-ID: <xmqqczdf4u7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3411452-1435-11ED-827A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> As for the variable name I don't mind particularly either way, I chose
> this name as the variable is checking whether we should use the glibc
> tunables mechanism or not.

Yup, but that becomes awkward when we decide to use the tunabules
mechanism for something other than malloc debugging, and that is
where my "is this the right name?" comes from.

Thanks.
