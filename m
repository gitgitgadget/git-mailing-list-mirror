Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D3EC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 04:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbiHOEWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 00:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiHOEWR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 00:22:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227BE140FC
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 21:22:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4C9814DA14;
        Mon, 15 Aug 2022 00:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ozJ2GyMHiYiDFB2THWN1fFqUvi/nenaV9xraFaxMio8=; b=a5jd
        kGVbZ24pNCoiFfnjVFK7o0IyLrGxVfF19W9Pr6b8QQHIYj55p3tU5fS/sy4PXGtP
        E6BAzIJ9Olk9a1fntya0+jUY2HQABTR31cgtP3ItbL1fXuL910xt7NLIKrA8U4ZK
        qmsB2piVMjNgcRNyhVWhCLKCOR/5wJnJWyPs1UE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC16814DA13;
        Mon, 15 Aug 2022 00:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE92814DA11;
        Mon, 15 Aug 2022 00:22:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Justin Donnelly <justinrdonnelly@gmail.com>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        newren@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] git-prompt: show presence of unresolved conflicts at
 command prompt
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
        <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
        <CAGTqyRw-SYDbQy9aktq5s3ZhoDhUOCf-pEopjH9m7v5+PH7Qqg@mail.gmail.com>
Date:   Sun, 14 Aug 2022 21:22:12 -0700
Message-ID: <xmqqy1vq3zm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6CB66F4-1C51-11ED-A7C9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Justin Donnelly <justinrdonnelly@gmail.com> writes:

> I hope this is against protocol/etiquette, but after some initial
> feedback from Junio, I haven't gotten any more. I wasn't sure if
> nobody had seen the patch, or if there just wasn't any interest.

It probably is a bit of both.  I personally did not see much point
in adding the long "conflicts" marker to the shell prompt (I did
worry about possible complaints by end users triggered by seeing
them suddenly without asking, which was why I commented on the
patch) and I was waiting for interested folks to speak out.

I do not know about other folks if they did see and did not find it
interesting, they are not looking at others' work, or your second
round came on a particularly bad day (busy with other topics, or
weekend just before the list was swamped with many new topics at the
beginning of a new week, or something).  Pinging on the thread like
you did would be the right thing to do to "kick" those, who did see
and who were in favor but who kept silent, into action ;-)



