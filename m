Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F0EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 20:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiBWUYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiBWUYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 15:24:40 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0FC4D266
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 12:24:11 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96FE711ED67;
        Wed, 23 Feb 2022 15:24:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=toFUwpt3U708DSxlY7IoqpuVX0IYHNHXB6OlYL
        rD7sU=; b=lLwBuen8BvXs5S6RuihCR1bbeNdn/pvi+vqnQlH5dMaXz94L/xj7e0
        zyKvY8RHPkuB8KBGc5JWOEXBBMpko2co9yqt9sZ79iLqOKl2whPAWj637QAzJjZb
        yy1AgVHuDlxgINe71OiPesRj7QZ7R3VduhzQ4DKyuYnisuDlFt7vI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B58011ED66;
        Wed, 23 Feb 2022 15:24:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF57E11ED65;
        Wed, 23 Feb 2022 15:24:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com, newren@gmail.com,
        jn.avila@free.fr, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/11] Updates to worktree code and docs
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <YhU+iI3RmwauYnsI@nand.local>
Date:   Wed, 23 Feb 2022 12:24:08 -0800
In-Reply-To: <YhU+iI3RmwauYnsI@nand.local> (Taylor Blau's message of "Tue, 22
        Feb 2022 14:50:32 -0500")
Message-ID: <xmqqzgmhtjpz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EA4BE2C-94E6-11EC-B27B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Feb 22, 2022 at 12:17:49AM +0000, Derrick Stolee via GitGitGadget wrote:
>> Updates in v2
>> =============
>>
>> Based on Junio and Taylor's review, I updated some language in the docs:
>>
>>  * Some uses of "worktree" should have stayed as "working tree"
>>  * Some adjacent wording was improved.
>
> Thanks; these updates (in addition to the handful of fixups that Junio
> provided on top) look good to me. I'll leave it to the two of you to
> figure out if you want to send another reroll, or if Junio already
> caught the minor changes when applying.

I thought I'd locally fix the three but I see Derrick has a reroll
already on the list, so I'll try that one first ;-)

Thanks, all.
