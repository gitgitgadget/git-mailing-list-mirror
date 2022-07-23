Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BA9C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 17:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiGWRr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWRrY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 13:47:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB437193F1
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 10:47:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04BAA145754;
        Sat, 23 Jul 2022 13:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aSuRsXqHPiEXHTRLRsI0IoPAdSQuYZ7laGYTJI
        1P8rA=; b=KzCbHfqJg+u3e6YoUL7f8vGERklorFYcVyq4Cgm6UK9XLbjq8Tanyh
        vCVGV+9fr1lOpdYLbifkRnNdJf4gPD7lz4DSecINIJqF6LAHBDo/OO+C826iK4Ky
        wHeq3pG/dwnilqANRZFKNPDyUtocOKgZHKRqv9oppidWlYA6laqe8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEA51145753;
        Sat, 23 Jul 2022 13:47:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 532CB145752;
        Sat, 23 Jul 2022 13:47:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "tenglong.tl" <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
References: <xmqqy1wkc0yw.fsf@gitster.g>
        <20220723060619.24566-1-tenglong.tl@alibaba-inc.com>
Date:   Sat, 23 Jul 2022 10:47:21 -0700
In-Reply-To: <20220723060619.24566-1-tenglong.tl@alibaba-inc.com> (tenglong
        tl's message of "Sat, 23 Jul 2022 14:06:19 +0800")
Message-ID: <xmqqilnnafh2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8152F5F6-0AAF-11ED-9B4E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"tenglong.tl" <dyroneteng@gmail.com> writes:

>> Isn't this a bit premature to do in [PATCH 1/2]?
>
> Yes, one oversight, sorry for that and will fix.

I've tweaked with "rebase -i" after queuing and before pushing the
integration result out, so if you can double check the result to
make sure I didn't screw up, there is no need to resend.

Thanks.
