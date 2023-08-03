Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C29C001DB
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 19:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHCT4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjHCT4b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 15:56:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001241706
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 12:56:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D6971AA10F;
        Thu,  3 Aug 2023 15:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1Xey6oSFeZQH
        019BjT1GEg9/8LUXLoFl0GFuhhsXo/4=; b=QlQs53LABnf/4mpbXpxNoKHFbS8i
        lioHlw43gi80y1A1gHZEY3kTYowidCHMkhWJvjILdFxK68L3G+Gnnvz0mAAjMzH0
        pn8c7K9206Ovm6zE0V59XVoyOM70goi/3tOA6D/ZvlpW4/YWtN/cANB7Kt3wpgZt
        /xEs6SBRJO+3i/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14F621AA10E;
        Thu,  3 Aug 2023 15:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FDC21AA10D;
        Thu,  3 Aug 2023 15:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc:     Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH 0/3] git bisect visualize: find gitk on Windows again
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <xmqqo7jo5d5a.fsf@gitster.g> <xmqqy1is3qqn.fsf@gitster.g>
        <DB9P250MB0692B33DE1EBFC26865D78C9A508A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Date:   Thu, 03 Aug 2023 12:56:28 -0700
In-Reply-To: <DB9P250MB0692B33DE1EBFC26865D78C9A508A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Thu, 3 Aug 2023
 21:03:36 +0200
        (CEST)")
Message-ID: <xmqqtttf528j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D652C210-3237-11EE-A503-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

>> And the answer was in [2/3], if I am reading the proposed log
>> messages correctly.  When the "bisect visualize" was ported to C, we
>> broke it.
>
> Yes, that's correct.
>
>>
>> Thanks.  Will try to queue based on 'maint'.
>>
>
> Please wait a moment, I'm currently preparing a V2 based on your feedba=
ck.

OK.  Thanks.
