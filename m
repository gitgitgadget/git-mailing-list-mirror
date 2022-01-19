Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FAC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350540AbiASAxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:53:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53732 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiASAxH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:53:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8787A17F9EF;
        Tue, 18 Jan 2022 19:53:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rJwyLPxaAbeXFjS0aTBaCZXKW14adMHfGjYcj5XQK7s=; b=pid9
        mnFXFBr6xXJ0huaL+Hk8EaM3xWZsX+02BFll8os9YnUs+8Sm7szGSFIxe0uOpr0w
        dteM9dXbKa+gLa7IwMXB+4FrorEGI7zlQYdzqaeJyRKOnKW7UlC9mYA9dzFpUqhL
        ue6oLbf3ntIL329eVhAYjfdc4rULrL3pbbMNev4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8008A17F9EE;
        Tue, 18 Jan 2022 19:53:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED4F217F9ED;
        Tue, 18 Jan 2022 19:53:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: ar/submodule-update (was Re: What's cooking in git.git (Jan
 2022, #04; Fri, 14))
References: <xmqqy23h4nss.fsf@gitster.g>
        <kl6llezcy2yr.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 18 Jan 2022 16:53:03 -0800
Message-ID: <xmqqczkopmvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29154256-78C2-11EC-882C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ar/submodule-update (2021-10-13) 9 commits
>>  . submodule--helper: rename helper functions
>>  . submodule--helper: remove unused helpers
>>  . submodule: move core cmd_update() logic to C
>>  . submodule--helper: run update using child process struct
>>  . submodule--helper: allow setting superprefix for init_submodule()
>>  . submodule--helper: refactor get_submodule_displaypath()
>>  . submodule--helper: rename helpers for update-clone
>>  . submodule--helper: get remote names from any repository
>>  . submodule--helper: split up ensure_core_worktree()
>>
>>  Rewrite of "git submodule update" in C.
>>
>>  Expecting a reroll?
>>  cf. <YWiXL+plA7GHfuVv@google.com>
>>  source: <20211013051805.45662-10-raykar.ath@gmail.com>
>
> How close are we to getting this into 'next'? Last I checked, it seemed
> like the only remaining piece is to rebase this onto
> es/superproject-aware-submodules.

Unless we have a new version of, a new review or a new ack on any
topic since we tagged -rc0, there should be anything to make them
any closer to 'next'.

In any case, a rebased version would not come from me, so I think
the message I am responding to has To: and Cc: addresses mixed up.

