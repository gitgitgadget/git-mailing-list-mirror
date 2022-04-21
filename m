Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5451C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390112AbiDUVuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349020AbiDUVuK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:50:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE62409B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:47:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6620196477;
        Thu, 21 Apr 2022 17:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8uJCsGq1pkSx
        KJhy5+3PKTnt1RrNVzBRDegIFTvERAg=; b=mIHvhXlwn+gTRJe9J3/EF1R//pzI
        u0lScsuC+YUd3ipFyPV/8tx2K4r4B4YxxWImiSAokw2t8PYpgnVtKfZ7lxP+6kPu
        i33laTieFwEhtZtEL0AP2MVB8QdR9i4befri2zT9MbNQ5qbnEw4sLsIDBAMcKIrv
        r5wJjJqCpRliay4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF71F196476;
        Thu, 21 Apr 2022 17:47:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 150BA196475;
        Thu, 21 Apr 2022 17:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Alyssa Ross <hi@alyssa.is>, git@vger.kernel.org
Subject: Re: Should sendemail.confirm default to always?
References: <20220421194832.lshqkl3bogy2f2hy@eve>
        <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Apr 2022 14:47:13 -0700
In-Reply-To: <220421.86tuam5hoi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Apr 2022 21:58:06 +0200")
Message-ID: <xmqqwnfids7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9BA629C8-C1BC-11EC-89FD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> .... As always the real work is updating docs, running the tests
> etc., digging up ML discussions to see if there's been any past
> arguments for/against it etc.

I agree with this part.  The code change itself may be easy, but it
takes a lot of work and moderate amount of help from a long timer or
two.

