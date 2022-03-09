Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060CBC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 17:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiCIRPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiCIROw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 12:14:52 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E546C926
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 09:10:21 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4FBD17E9A5;
        Wed,  9 Mar 2022 12:10:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jiRAQoD13P417VSyX+yqX39lto9b6nmsn8umC/
        26110=; b=uC1GexVf/qMtWywPdLkDNMsgq8QvXm6SCqCjUif0sClJNX4n4GDLmK
        XXxS8c3/tvie+PVlMipKdOs5En35VzZqMiye6Jd0qrvzsBOU0z+7/R/sjCtmcuE2
        NhKnsfWP7/u1R4c3WVeaoYpKUv/Fup3cDxC7ls37i9uuBWtQY4kCQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE09517E9A4;
        Wed,  9 Mar 2022 12:10:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6214317E99F;
        Wed,  9 Mar 2022 12:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: jc/stash-drop (was Re: What's cooking in git.git (Mar 2022,
 #02; Mon, 7))
References: <xmqqilspp5yg.fsf@gitster.g>
        <da1a464e-0beb-6a44-ed05-35868fd12bed@gmail.com>
Date:   Wed, 09 Mar 2022 09:10:17 -0800
In-Reply-To: <da1a464e-0beb-6a44-ed05-35868fd12bed@gmail.com> (Phillip Wood's
        message of "Wed, 9 Mar 2022 16:12:38 +0000")
Message-ID: <xmqqzglzm4qu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB91DF28-9FCB-11EC-A5B8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> * jc/stash-drop (2022-03-02) 3 commits
>>   - stash: call reflog_delete() in reflog.c
>>   - reflog: libify delete reflog function and helpers
>>   - stash: add tests to ensure reflog --rewrite --updatref behavior
>>   "git stash drop" is reimplemented as an internal call to
>>   reflog_delete() function, instead of invoking "git reflog delete"
>>   via run_command() API.
>>   Will merge to 'next'.
>>   source: <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
>
> I think John is planning to re-roll with an improved commit message
> c.f. <A8BDCB7C-5F16-4EDE-B8B7-0B73C93B68D2@gmail.com>

Thanks, but I think it already happened 24 hours ago.

