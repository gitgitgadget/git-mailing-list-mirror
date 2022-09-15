Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6785DECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 20:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIOUnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIOUnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 16:43:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03012901BE
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 13:43:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A9201B2459;
        Thu, 15 Sep 2022 16:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jK2scLHAq29vPlS+7wd0FH9D46+aVvWX9Zn1LT
        YvJrA=; b=MQUlP2gBdlCDAPNBzpmUaI21NDOoOA1g51qq3Tl9/wdxouJ68P9Lwd
        aAy2QsCn85t9D+f6MyIrUjLfD5b2TesknFAYcqGUbjOBotNWtco2V06vKS1hYks6
        sIYmLaYSJORkiHJWI5swa4lKs33pyUtgBZ6coVFmYTnOLVfRFiygg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 735691B2458;
        Thu, 15 Sep 2022 16:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1082D1B244F;
        Thu, 15 Sep 2022 16:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Conners <business@elijahpepe.com>
Cc:     "hanwen" <hanwen@google.com>, "git" <git@vger.kernel.org>
Subject: Re: [PATCH v2] reftable: use a pointer for pq_entry param
References: <1833f3928cb.acf3c97d869879.7909589521159235166@elijahpepe.com>
        <xmqq1qsco6sx.fsf@gitster.g>
        <18342ce2209.d56a95ef1029282.8747052454037800255@elijahpepe.com>
Date:   Thu, 15 Sep 2022 13:42:59 -0700
In-Reply-To: <18342ce2209.d56a95ef1029282.8747052454037800255@elijahpepe.com>
        (Elijah Conners's message of "Thu, 15 Sep 2022 13:19:08 -0700")
Message-ID: <xmqqy1ukl67g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD32D14E-3536-11ED-A10E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Conners <business@elijahpepe.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>  > Hmph.  I do not know what went wrong.  Somebody between your "git
>  > format-patch" and the mailing list archive ate tabs and spitted out
>  > spaces, it seems.  I'll try to fix it up.
>
> Looks like my mail server tried to convert the spaces to tabs. If
> you could fix it, that would be great, otherwise I'll submit
> another patch in four hours.

I just pushed out the first integration result of today, which
contains this topic.

Thanks.
