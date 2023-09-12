Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42885CA0ED2
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjILROY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjILROV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:14:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BE210D9
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:14:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81D8319AC30;
        Tue, 12 Sep 2023 13:14:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=XE54N0xTEKhD0SAufGSCaIdLq1MilPLBT/10Gj
        9qSeg=; b=Tam0GicwvlPyVqULMv2MaF8Dy2wpi6Al2feZEJZXfB9f791qRDUNFx
        CrCJfh6FL2MPuozaL4UV2O59b69DCGaH4zFVfOiEf5dPkX+Ck8vdj71knxi50jE5
        O42CncL9L7nATIHWPzv0XaeSKDuxYy/Ek1+GWeaAO51ODY1n6VSEY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A66919AC2F;
        Tue, 12 Sep 2023 13:14:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D742719AC2E;
        Tue, 12 Sep 2023 13:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] update-index doc: v4 is OK with JGit and libgit2
In-Reply-To: <owlyfs3kkmzd.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Mon, 11 Sep 2023 21:57:10 -0700")
References: <20230818233729.2766281-1-gitster@pobox.com>
        <20230818233729.2766281-2-gitster@pobox.com>
        <owlyfs3kkmzd.fsf@fine.c.googlers.com>
Date:   Tue, 12 Sep 2023 10:14:13 -0700
Message-ID: <xmqq7covpb4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC8C50D0-518F-11EE-A693-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> +Older editions of this manual page called it "relatively young", but
>
> Nit: s/editions/versions because typically "edition" means a version of
> physically published text (such as books).

This text belonging to the manual, that was exactly the reason why I
used that word, but ...

> Also I don't think we use the
> word "edition" anywhere else in our codebase.

... I think "version" is just fine.  Will fix.

Thanks.
