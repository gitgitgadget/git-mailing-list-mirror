Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EBBC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352053AbiHSVG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350874AbiHSVGy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:06:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C53B5A7D
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:06:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 696E01477CB;
        Fri, 19 Aug 2022 17:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NQlJG+hHwtZJGuodauPtdVilC6czoyQU7aRVBH
        +6ngM=; b=Hiz43TPogXoS6+tQL1VaqNJeZi+W0+AYjXPSABeqjIfPKQCPr6FyIQ
        fJofEaSa5eXvv5VuDXq1WGXl6zH+r1NtuW+LvARAvt8mX/XyieUvIbVTHN0AEsgu
        2pT/Z4X6FzI9xqMn3rvbzS2zu+hCemM6GDARyPmKOQ9B7qMPF/5YY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60FDE1477C9;
        Fri, 19 Aug 2022 17:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCB3D1477C8;
        Fri, 19 Aug 2022 17:06:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        mjcheetham@outlook.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 0/8] scalar: enable built-in FSMonitor
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
        <6b1e154d-e90f-aed9-64c4-6e6845abe25c@github.com>
Date:   Fri, 19 Aug 2022 14:06:50 -0700
In-Reply-To: <6b1e154d-e90f-aed9-64c4-6e6845abe25c@github.com> (Derrick
        Stolee's message of "Fri, 19 Aug 2022 14:45:40 -0400")
Message-ID: <xmqqy1vkj639.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8DA219C-2002-11ED-BBCF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 8/18/2022 5:40 PM, Victoria Dye via GitGitGadget wrote:
>> This series enables the built-in FSMonitor [1] on 'scalar'-registered
>> repository enlistments. To avoid errors when unregistering an enlistment,
>> the FSMonitor daemon is explicitly stopped during 'scalar unregister'.
>> ...
> I wrote a couple "thinking out loud" replies, but the series looks
> good to me without any changes.

Thanks, both.  Queued.

Let's mark it for 'next' and merge it down soonish.
