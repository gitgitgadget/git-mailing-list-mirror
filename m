Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28358C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 16:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiFGQE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbiFGQEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 12:04:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBCFC4FE
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 09:04:54 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 805531A698E;
        Tue,  7 Jun 2022 12:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xMhiF/Hzir+TilTAzV0Poda1BUfjwEkff+dBEJ
        Hmxzk=; b=FH55Itq3SIX4vUBMv3ggnTfKajc5fAC1C8V1pkph57tnVh7HXA4Syv
        5PUMOU5nPCizuZ1TxqdrinPB7/CgLDk4b1XEw6vswkQvJlniaCemWNb6IZgUKHC7
        xExBsTz286/GtW9hJFYRZElYz0T2EBR2x8thrbuuhdfQPP3hi5IlI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7854E1A698D;
        Tue,  7 Jun 2022 12:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC13F1A698B;
        Tue,  7 Jun 2022 12:04:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Joakim Petersen <joak-pet@online.no>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v5] git-prompt: make colourization consistent
References: <20220604161333.54627-1-joak-pet@online.no>
        <20220604192606.176023-1-joak-pet@online.no>
        <466ec54a-825b-c3e6-e9f2-a7007af71b6d@gmail.com>
Date:   Tue, 07 Jun 2022 09:04:48 -0700
In-Reply-To: <466ec54a-825b-c3e6-e9f2-a7007af71b6d@gmail.com> (Bagas Sanjaya's
        message of "Mon, 6 Jun 2022 14:23:11 +0700")
Message-ID: <xmqq4k0w1mu7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F382496-E67B-11EC-9B48-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 6/5/22 02:26, Joakim Petersen wrote:
>> If the user is in a sparse checkout, the sparsity state indicator
>> follows a similar pattern to the short upstream state indicator.
>> However, clearing colour of the colourized indicators changes how the
>> sparsity state indicator is colourized , as it currently inherits (and
>> before the change referenced also inherited) the colour of the last
>> short state indicator before it. Reading the commit message of the
>> change that introduced the sparsity state indicator, afda36dbf3b
>> (git-prompt: include sparsity state as well, 2020-06-21), it appears
>> this colourization also was unintended, so clearing the colour for said
>> indicator further increases consistency.
>> 
>
> colourization? I have never heared that. Did you mean "colorization" (en-US)
> or "colourisation" (en-UK)? I assumed the former.

;-)  

Either way, that word is a mouthful.  Using verb "to color" and
"coloring" might be easier to read, perhaps?
