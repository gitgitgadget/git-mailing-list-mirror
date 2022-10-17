Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ABDC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 22:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJQWWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQWWG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 18:22:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B215A16F
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 15:22:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FF791B431D;
        Mon, 17 Oct 2022 18:22:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=D9Fk8J24mb+HJJ98d30b13blT8on+wIX+/07WNc8MZc=; b=TRK6
        iLFf8bbTzWLQmnV/2af026bEB/3ZgACEI/sWCXa7cH9EUqZ7xKYlqLN9H0YwA47N
        oNEmqKYja6dnAmiRwgHa7HN0aofMvQey3F92rL6pC6gYx6yqyjfzYh5O58AG+aHg
        xG9PM7ruu/3N9SMlxxbsmPeOn4V0t1nSPPmN2bk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97C771B431C;
        Mon, 17 Oct 2022 18:22:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBFEA1B4318;
        Mon, 17 Oct 2022 18:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric DeCosta <edecosta@mathworks.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <xmqqwn9256cw.fsf@gitster.g>
        <BL0PR05MB557123F87157E0E091A43494D9299@BL0PR05MB5571.namprd05.prod.outlook.com>
Date:   Mon, 17 Oct 2022 15:22:00 -0700
Message-ID: <xmqqk04yxf93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F640048-4E6A-11ED-BE67-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric DeCosta <edecosta@mathworks.com> writes:

>> I understand that it might not be easy/possible (e.g. perhaps it is a limitation
>> of GGG?), but I really prefer not to see them re-posted as part of this series,
>> as I have to apply them and make sure there are no changes from the last
>> one before discarding them.
>> 
>> Anyway, thanks for an update.  Will requeue.
>
> I looks like I can use GGG with the next branch, but I will have
> to open a new PR (and close the existing one).

Please don't.

The macOS topic (thanks for working on it, by the way) is about to
graduate to 'master', and the situation would probably "improve"
anyway when it happens, I hope.

Thanks.
