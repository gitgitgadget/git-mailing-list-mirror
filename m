Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2508C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiCNVq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiCNVq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 17:46:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D539802
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 14:45:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BB1B1893E0;
        Mon, 14 Mar 2022 17:45:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yjWuIRCyUEUfNMuKUiWZAhzGsoqEj/Zdi5hG57
        VYNIw=; b=HFBGEFVJRGsgwkVxsNMUg3D643btbq0CH/9GNTWigrwnoLm9OympG8
        z7VdR+OPtq7h3h2DsF7fqauAkTrYKK2k3xzRHS5S8nqsQFt/RfQ3KFf3ZQV6vutO
        Lqt2VyU8QUAOW2jVacZUkAq/xGqkNNFkDT3QH/RqKosifbUuW7QdM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7492B1893DF;
        Mon, 14 Mar 2022 17:45:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 016601893DD;
        Mon, 14 Mar 2022 17:45:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] attr.h: remove duplicate struct definition
References: <20220314002327.243915-1-gitter.spiros@gmail.com>
        <xmqqh781t7ks.fsf@gitster.g>
        <CA+EOSBkJtcvKJ1D1hMuWB0EkrGEfP7Dua6gP8MDHehto1r+E3A@mail.gmail.com>
Date:   Mon, 14 Mar 2022 21:45:11 +0000
In-Reply-To: <CA+EOSBkJtcvKJ1D1hMuWB0EkrGEfP7Dua6gP8MDHehto1r+E3A@mail.gmail.com>
        (Elia Pinto's message of "Mon, 14 Mar 2022 11:39:31 +0100")
Message-ID: <xmqqo828nr88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 072FEAA8-A3E0-11EC-B104-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Il giorno lun 14 mar 2022 alle ore 06:40 Junio C Hamano
> <gitster@pobox.com> ha scritto:
>>
>> Elia Pinto <gitter.spiros@gmail.com> writes:
>>
>> > Subject: Re: [PATCH 6/6] attr.h: remove duplicate struct definition
>>
>> I do not see other 5 from 1/6 thru 5/6 on the list.
> I'm sorry. It was my mistake in producing the patch. There are no
> other cases like this.
>
> Thanks for your patience

No need to say sorry!  I just wanted to make sure I have all pieces
necessary.

Thanks.
