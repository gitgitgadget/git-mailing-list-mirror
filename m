Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A83C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 16:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGZQeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGZQeP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 12:34:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20952121
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 09:34:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D02226228;
        Wed, 26 Jul 2023 12:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=49VSVvNxXIwANWFeiDr8M8vGEhMV2n6RugUkwu
        zXsUo=; b=EHfwn2vL2vQ5iU9MMFOmNWapVwfioxQw6TCbUMDFjoVsZv05QN8pH/
        SsZkQY91gagCvxKTAUaameG43Rny13ZCBFUJey7Htp4jsWmtm/6bSITBkhEuO6UB
        cCeHK5XmXEC8TxLDc0lHEBAmM1g+6MRWE3MVFTWMBmS6VbKDuDrQA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9611426227;
        Wed, 26 Jul 2023 12:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FC3D26226;
        Wed, 26 Jul 2023 12:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #05; Tue, 25)
References: <xmqqedkvk8u4.fsf@gitster.g>
        <9d2f119d-7da7-003d-d011-5c3aa7f94ae7@gmail.com>
Date:   Wed, 26 Jul 2023 09:34:09 -0700
In-Reply-To: <9d2f119d-7da7-003d-d011-5c3aa7f94ae7@gmail.com> (Phillip Wood's
        message of "Wed, 26 Jul 2023 14:11:45 +0100")
Message-ID: <xmqqpm4eeiny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FEEB8E4-2BD2-11EE-99FC-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 25/07/2023 21:57, Junio C Hamano wrote:
>> * pw/rebase-i-after-failure (2023-04-21) 6 commits
>>   - rebase -i: fix adding failed command to the todo list
>>   - rebase: fix rewritten list for failed pick
>>   - rebase --continue: refuse to commit after failed command
>>   - sequencer: factor out part of pick_commits()
>>   - rebase -i: remove patch file after conflict resolution
>>   - rebase -i: move unlink() calls
>>   Various fixes to the behaviour of "rebase -i" when the command got
>>   interrupted by conflicting changes.
>>   Will discard.
>>   Have been expecting a reroll for too long.
>
> I am slowly working on a new version, but it probably makes sense to
> drop it in the meantime as it has been so long that the new version
> probably wants to be rebased onto master anyway.

Yeah, I think that is a good next step.  Unfortunately, folks who
have seen this round would likely have already forgotten and the
updated round would need fresh reviews anyway.

Thanks.
