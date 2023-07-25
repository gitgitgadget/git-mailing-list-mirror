Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D62EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 23:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGYX7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjGYX7K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 19:59:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8474726A1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:59:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11BAC3397D;
        Tue, 25 Jul 2023 19:59:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R7zR8zuFzCnFydXXaLDxO3nxsU7RImshptGunb
        8h/QI=; b=NRW5tM0qVGFRO7ZeGPBQqulH1yKKsFVBXSBHmJ5iDSQ749QGUcBJ4C
        iOpjJVLzdD2YWhZ68v3oc4cP/oyXi6leJm7GApJZBcJjQLYLCrcVuJFNTqinADsp
        EBX0YkFKr4LmzpoHvPfVUy1ZjtpSoPKMt6uOT85I1Xd6lOD9AUqz0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B0173397C;
        Tue, 25 Jul 2023 19:59:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A31E13397B;
        Tue, 25 Jul 2023 19:59:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
References: <xmqqedkvk8u4.fsf@gitster.g> <ZMBPHTIacaWjy99D@nand.local>
Date:   Tue, 25 Jul 2023 16:59:04 -0700
In-Reply-To: <ZMBPHTIacaWjy99D@nand.local> (Taylor Blau's message of "Tue, 25
        Jul 2023 18:39:25 -0400")
Message-ID: <xmqq8rb3h7av.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CBE25AA-2B47-11EE-BE31-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jul 25, 2023 at 01:57:39PM -0700, Junio C Hamano wrote:
>> * cc/repack-sift-filtered-objects-to-separate-pack (2023-07-24) 8 commits
>> ...
>>  Will merge to 'next'.
>>  source: <20230724085909.3831831-1-christian.couder@gmail.com>
>
> This may be a little soon to merge into 'next'. I looked at version 1
> and had some concerns, but haven't had a chance to look at version 2.
>
> Now that we have a third round, I'll take a look at it now. Sorry for
> the hold up.

Thanks.
