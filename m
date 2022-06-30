Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024A0C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 16:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiF3Qog (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiF3Qoc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 12:44:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48933E0EF
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:44:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AA121A7604;
        Thu, 30 Jun 2022 12:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2zyzMinrU6DoH3Smo3bUuL9m72uNp21TFGDOPB
        yFU3M=; b=bGQZXOcT1aGMDQPvdtUytPiv2JhxVW6HiXIiM38xEg0psObkTTN71s
        6m+fAv86SO59vJLOTQ01/sgLStJ0bnnDT4MTTvneTu980jqXRmvMOxH3xBVl49Dr
        Zqg0eGaiQjqE3QFRRwC4gmANhu2OBllIEXWwqx8tCMxV+fEq+e+q8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 029C21A7603;
        Thu, 30 Jun 2022 12:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 959871A7602;
        Thu, 30 Jun 2022 12:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/8] t2407: test branches currently using apply backend
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <fbaedc7f1f02efec251cb4df665fd3cb71f1d3b3.1656422759.git.gitgitgadget@gmail.com>
        <xmqqtu84iklu.fsf@gitster.g>
        <4016eee6-0759-dece-cd7b-0ed8454faf63@github.com>
Date:   Thu, 30 Jun 2022 09:44:26 -0700
In-Reply-To: <4016eee6-0759-dece-cd7b-0ed8454faf63@github.com> (Derrick
        Stolee's message of "Wed, 29 Jun 2022 08:54:56 -0400")
Message-ID: <xmqqwncyf6dx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7E83BD8-F893-11EC-A07F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I can either re-roll that series or create a new forward-fix that
> includes the functionality of this test. Both are the same amount of
> work for me, so let me know which you prefer.

Either is fine by me.  Other than this small glitch in the test, the
remainder of the "should we allow this branch to be touched?" topic
looked really cleanly done and ready to be unleashed to the public.

Thanks.
