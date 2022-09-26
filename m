Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA4C6FA8E
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIZTIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIZTIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:08:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF25EDDB
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:08:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2C0D143A3D;
        Mon, 26 Sep 2022 15:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5TbB1qdGRKha
        LBAhPlb5WKFD2YbWR4ZnBOaOLZuxjXA=; b=ktixA1D2SBiX62gChWTy0LB5ck62
        HgM31uULQbsWeFEi6CAd9eE0vP/VmvSraqi/5eEIlqWDv5D86imfpcTgLUqyiAG+
        DKsM/s5WCIdznJgVZx6EeXOPBA/Nsjdmv8xlnnSLmPnyxuJRae+F5n49V65wUYzx
        B9Xx+E7HrqbUynY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBBFC143A3C;
        Mon, 26 Sep 2022 15:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E90B143A3B;
        Mon, 26 Sep 2022 15:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] t/Makefile: remove 'test-results' on 'make clean'
References: <20220920105407.4700-1-szeder.dev@gmail.com>
        <20220920201619.40972-1-szeder.dev@gmail.com>
        <xmqqv8pg399k.fsf@gitster.g>
        <220926.86pmfi33cx.gmgdl@evledraar.gmail.com>
Date:   Mon, 26 Sep 2022 12:08:05 -0700
In-Reply-To: <220926.86pmfi33cx.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 26 Sep 2022 11:08:55 +0200")
Message-ID: <xmqqo7v2necq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E088A84-3DCE-11ED-8A1E-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> FWIW this wasn't a "while at it", it was critical to making another par=
t
> of that topic work at all.

Perhaps it was critical within the approach of the topic took, and
if a different approach was taken or the scope of topic was reduced,
you would have avoided it.  I would still consider such an unnecessary
change an unwated "whilte at it".

The moral of the story is that the topic took too big a bite to be
done without causing unnecessary mistakes like this.


