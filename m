Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACBEC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 20:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbiEZURn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 16:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348383AbiEZURj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 16:17:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9135C9ED2
        for <git@vger.kernel.org>; Thu, 26 May 2022 13:17:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32664193606;
        Thu, 26 May 2022 16:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=anp2WdnKkWmhyQignUTGFYh75ESw1f0fSLy0RC
        yeqTg=; b=NcW5yKG0MTZQE081qTtPUsG+QaW0EalBKbqv3Omm6IrNF7iDjGciEy
        kgtCcpQDw2zwOpBcQx7kIHtb5ms9f7qyUqDwKATvUjNrzrs6O5CI5fw+H2ICf4HU
        +V4f5YxiShoc2u2oGDEmsXJscStcQppABxBdJfpPOn4HzMGQzR3dU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AF0D193605;
        Thu, 26 May 2022 16:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BE8E2193604;
        Thu, 26 May 2022 16:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2022, #07; Wed, 25)
References: <xmqqzgj41ya2.fsf@gitster.g> <Yo/CeyqsOe7CPY0v@nand.local>
Date:   Thu, 26 May 2022 13:17:31 -0700
In-Reply-To: <Yo/CeyqsOe7CPY0v@nand.local> (Taylor Blau's message of "Thu, 26
        May 2022 14:10:03 -0400")
Message-ID: <xmqqbkvkxd44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E000672A-DD30-11EC-9D28-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, May 26, 2022 at 01:41:25AM -0700, Junio C Hamano wrote:
>> * tb/geom-repack-with-keep-and-max (2022-05-20) 3 commits
>>  - builtin/repack.c: ensure that `names` is sorted
>>  - t7703: demonstrate object corruption with pack.packSizeLimit
>>  - repack: respect --keep-pack with geometric repack
>>
>>  source: <cover.1653073280.git.me@ttaylorr.com>
>
> Stolee took a look at this and left a positive review. Victoria and I
> wrote these patches together, so I assume/hope she's on board, too ;).

Yup, I did find these patches are OK, too.

Thanks.
