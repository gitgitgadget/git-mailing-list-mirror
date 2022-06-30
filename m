Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF9C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiF3RTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiF3RTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:19:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAC1C13C
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:19:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A78E1A793B;
        Thu, 30 Jun 2022 13:19:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KXIdz5KQna035vEyfISnlZZjvElicB4pkfjhvH
        NQJR4=; b=hQ4PufQ5LUU66GEpOBGNZS+fxoKo2nqaTveeWgpaWcT/OxJv0ltSOI
        U4CwuHve1mTFiqeFeOEOhElf3a3jCvVHB+tSOgki1lGreqGRLnLMvcqQl6HEOzr2
        2Kieku2R3u2jjaj3vIkv5WTBOmzUVMLtW9wGu2dJcWOQjZ6TeGyCY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 125BA1A793A;
        Thu, 30 Jun 2022 13:19:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DD291A7938;
        Thu, 30 Jun 2022 13:18:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] git-rebase.txt: use back-ticks consistently
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
        <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
        <xmqqwnd0h30t.fsf@gitster.g>
        <6f229f4d-8ce8-beb5-e27c-2ea244a634a7@gmail.com>
Date:   Thu, 30 Jun 2022 10:18:55 -0700
In-Reply-To: <6f229f4d-8ce8-beb5-e27c-2ea244a634a7@gmail.com> (Phillip Wood's
        message of "Wed, 29 Jun 2022 10:31:22 +0100")
Message-ID: <xmqqa69uf4sg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9254BB0-F898-11EC-8090-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 28/06/2022 22:49, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> @@ -537,7 +539,7 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>>>   -x <cmd>::
>>>   --exec <cmd>::
>>>   	Append "exec <cmd>" after each line creating a commit in the
>> I thought `exec <cmd>` was an improvement, just like ...
>
> I'm not so sure, I thought we normally reserved backticks for command
> line options and this is talking about what gets added to the
> todo-list. I could see "exec `<cmd>`" being an improvement
> though. There are several other mentions of todo list commands in the
> documentation and I think they are all double quoted like this one.

OK.  Thanks for correcting me.

