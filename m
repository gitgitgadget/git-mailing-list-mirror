Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8271ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 19:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIUTQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 15:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIUTQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 15:16:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC677F24A
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 12:16:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E76F14108F;
        Wed, 21 Sep 2022 15:16:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Bssn7r2ylCeOsD2Sg+UN5aNDYD5TwqAA3LeLObg7CXQ=; b=RJNq
        NGVdRMy6KndIe6kXRElQwz+OMtL5lDoHieBoI6FY2nP1uwalXiBmJFj/7DP9e59m
        +b283ObTjxXSeKLwjwc7WnWWdYzHETq9Px6tBt5cybichIDoyk0eDGbeEGf0SCKJ
        a7GP6ZSVSZ1pyMZwoBZ8nWVNvcsXLwQMNGqEHQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0577414108E;
        Wed, 21 Sep 2022 15:16:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66C7E14108D;
        Wed, 21 Sep 2022 15:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jacob Stopak <jacob@initialcommit.io>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix various typos in regular and technical docs
References: <20220920024557.22889-1-jacob@initialcommit.io>
        <CAPig+cSMDef1qLM9t6_7pP5svcgYz37pp_o5idERGpAOX_0yXQ@mail.gmail.com>
Date:   Wed, 21 Sep 2022 12:16:24 -0700
Message-ID: <xmqqv8pg1qt3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2D481DA-39E1-11ED-B169-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Sep 19, 2022 at 11:04 PM Jacob Stopak <jacob@initialcommit.io> wrote:
>> Used GNU "aspell check <filename>" to review various documentation
>> files with the default aspell dictionary. Ignored false-positives
>> between american and british english.
>>
>> Jacob Stopak (2):
>>   Documentation: clean up a few misspelled word typos
>>   Documentation: clean up various typos in technical docs
>
> The fixes in these two patches all look sensible. Consider this
> Reviewed-by: <me> if my read-through is worth anything.

Thanks, both.
