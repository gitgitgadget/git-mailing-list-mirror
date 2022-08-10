Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74929C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 19:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiHJThl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiHJThj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 15:37:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCBA79A74
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 12:37:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A820C19E487;
        Wed, 10 Aug 2022 15:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=64wmZ+D5yr9w0+eu9oQBCEIpT5/TU3q6K5bwFy
        bHyrE=; b=vqffV1y9dtpIwZ2Gf/0+7Yqterpn7xTa8N/eVVVYw6KssbgTQYw83J
        nZ3GOguaUrMOC7L2Vz9hUhRuMA5lNtNNpP/ACnwn/ALK842yWRflMwXpxOv/J7gl
        6m4+SDiMoKiu9J0W7GNhVWyJZ7qhyvydc9MYTiSXNu0yxQJ0pIE+A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A18E519E486;
        Wed, 10 Aug 2022 15:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4DD7B19E484;
        Wed, 10 Aug 2022 15:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 0/7] mergetools: vimdiff: regression fixes and
 improvements
References: <20220810154618.307275-1-felipe.contreras@gmail.com>
        <YvP81vtZd7DlvQDa@zacax395.localdomain>
Date:   Wed, 10 Aug 2022 12:37:33 -0700
In-Reply-To: <YvP81vtZd7DlvQDa@zacax395.localdomain> (Fernando Ramos's message
        of "Wed, 10 Aug 2022 20:45:42 +0200")
Message-ID: <xmqqlervlwjm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1CD999E-18E3-11ED-BCD5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> On 22/08/10 10:46AM, Felipe Contreras wrote:
>> Hello,
>> 
>> These patches make vimdiff3 actually work, along with many single window
>> cases.
>> 
>
> Thanks Felipe. In this new v4 the code is even cleaner.
>
> I also manually re-tested all the cases (with and without .vimrc) and verified
> they work as expected.
>
> Reviewed-by: Fernando Ramos <greenfoo@u92.eu>
>
>
> PS to Junio: Is it OK to reply with "Reviewed-by" to the cover letter or (for
> the next time) should I had individually replied to each of the patches in the
> series? Thanks!

You did just fine.  I'll queue with your reviewed-by.

Thanks, both.

