Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA20C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352208AbiHSVI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350874AbiHSVIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:08:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBBC42AF6
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:08:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 974AC19ECFB;
        Fri, 19 Aug 2022 17:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Eyul1AgOIWFP
        M1VbX9B606+wtCQZJ/Zjdb1ul3dqZFM=; b=wALdfHPeR5aRjNfEpeH/KqPpqYFo
        GRbKk03n/KVBlVxqQGRiH3CZCMEuvg+7eqUMXMChgyn9nc6xQJbpQpB84/YS6aap
        gJP9HzZONxFSG/TtIG8O/zvpzy/eRoSjczIUSMEKHbZ5dDOnguquBOWaq9/MT/so
        zCLh5+TrFKYHHo8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F8D119ECF9;
        Fri, 19 Aug 2022 17:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65CC419ECF8;
        Fri, 19 Aug 2022 17:08:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/3] Allow --ancestry-path to take an argument
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
        <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
        <7b7918f8-d997-89e8-2ba0-7bb31beb9335@github.com>
Date:   Fri, 19 Aug 2022 14:08:15 -0700
In-Reply-To: <7b7918f8-d997-89e8-2ba0-7bb31beb9335@github.com> (Derrick
        Stolee's message of "Fri, 19 Aug 2022 08:53:55 -0400")
Message-ID: <xmqqtu68j60w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0BDC1F14-2003-11ED-ADAF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 8/19/2022 12:28 AM, Elijah Newren via GitGitGadget wrote:
>> Changes since v2:
>>=20
>>  * Incorporated Stolee's suggested patch as a preliminary cleanup of t=
6019.
>>    Slightly modified his patch by:
>>    * fixing the "repetitive" typo pointed out by Eric
>>    * removed the unnecessary "return 1" pointed out by =C3=86var
>>    * switched "rev-list" to "log" since we are using --format anyway, =
in
>>      order to remove the need to call "sed" afterward
>
> Thanks! I appreciate you fixing all of my mistakes and
> incorporating all of the existing feedback. It also looks
> nicer as your patch 2 than as a third on top.
>
> This version looks good to me.

Yup, it looks good to me, too.  Thanks, both.

Let's mark it for 'next' and merge it down soonish.
