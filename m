Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1362C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 20:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiGRUYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiGRUYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 16:24:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181AF26AD8
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:24:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F50414DB7C;
        Mon, 18 Jul 2022 16:24:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=93oWFLNdHpI6HRgUKkxyqW+5h5mD6PxwHHvA+QarrMk=; b=Vq7p
        2WJF+r2L25Wmz7BvVyDVS4pQQs+yEXY1zpbs8gtwDI9cPqQPaPR+imDypBJVEDX3
        Tgxace2ib47UqiGN3LDczxKirLYCj3ArbMfFXfUfroPawL3VJOynxbH9i5md889V
        HUhCrN+CiHIMJK5aZ7I1dLDORUkKDNe6tY4dXeA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 054AF14DB7B;
        Mon, 18 Jul 2022 16:24:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4091614DB7A;
        Mon, 18 Jul 2022 16:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <jch@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2022, #05; Sun, 17)
References: <xmqq7d4bt8n4.fsf@gitster.g>
        <07097797-40d7-022d-a41b-1d219183b4a5@github.com>
Date:   Mon, 18 Jul 2022 13:24:08 -0700
Message-ID: <xmqqr12idv9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94D277AE-06D7-11ED-B673-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I have a topic (formerly RFC, now a two-patch doc update) [1] that's had
> some review, but isn't tracked here yet

Thanks for pinging ...

> [1] https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/

... especially with a pointer.

