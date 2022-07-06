Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197ACC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 22:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiGFWQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 18:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGFWQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 18:16:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6D2AE23
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 15:16:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E70A1B27BA;
        Wed,  6 Jul 2022 18:16:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fus1fmaeGH1vPViaAz0hi/+z2HkU0Ip4zYye6w
        /oeUk=; b=mZx9TK09evObZyNFG/ezJwFlMJ8HzbVKwCMgoXILpFu3F35tN+GA8l
        IEKbg8bARQyCpCX8CU7Nujfkqj4o1nrYHCzQrN1k6iodn1PTE325sqBmfZTBh9ZW
        wlfgqMVTMh16wipuogrfxmJ9C/QosYeuHPvGdBolrpj7e1Y+bvtvE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 672201B27B9;
        Wed,  6 Jul 2022 18:16:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D4011B27B8;
        Wed,  6 Jul 2022 18:15:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: gc/bare-repo-discovery (was Re: What's cooking in git.git (Jul
 2022, #01; Fri, 1))
References: <xmqqo7y85t44.fsf@gitster.g>
        <kl6lh73urup7.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 06 Jul 2022 15:15:55 -0700
In-Reply-To: <kl6lh73urup7.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 06 Jul 2022 10:56:36 -0700")
Message-ID: <xmqq1quxhopw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 356A75A8-FD79-11EC-8C62-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * gc/bare-repo-discovery (2022-06-30) 5 commits
>>  - setup.c: create `discovery.bare`
>>  - safe.directory: use git_protected_config()
>>  - config: learn `git_protected_config()`
>>  - Documentation: define protected configuration
>>  - Documentation/git-config.txt: add SCOPES section
>>
>>  Introduce a discovery.barerepository configuration variable that
>>  allows users to forbid discovery of bare repositories.
>>
>>  Will merge to 'next'?
>>  source: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
>
> I'll send a reroll soon. Taylor Blau left a bunch of great
> comments/suggestions that I intend to address (though I don't think any
> of them were meant to be blocking?)

OK.  I too found Taylor's comments very helpful.

Thanks for a status update.
