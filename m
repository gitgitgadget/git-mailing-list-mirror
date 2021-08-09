Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49940C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C2460F93
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhHIP2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 11:28:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64137 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhHIP2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 11:28:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0215815DE25;
        Mon,  9 Aug 2021 11:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pa37zT/7j2ZFjwKTtRD+XSI7nNBVyA3yZPh1uk
        VdX+8=; b=MTmW48hTfvkjxPuFlkicSXcUrgOd8Kzn4kmb4/d0gJqzAfwrwHtuMc
        +H9XOj68p7ZWKcxRwylpr4c+wN3BGEPJA47sfTh3OcZ+SoX48EzQbTHfa9V0M5Wp
        VGQtU6LWq9K8sOtGvkw8/upA69bDtbd019DD0VRE9W2ANOMOiwgp0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE43B15DE24;
        Mon,  9 Aug 2021 11:27:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E8FD15DE22;
        Mon,  9 Aug 2021 11:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2021, #03; Fri, 6)
References: <xmqqzgtuf6r0.fsf@gitster.g>
        <CABPp-BGSB5K636sgfGwpaHeFUyGGnGcVVBHLg96m-Jf=gajmSg@mail.gmail.com>
Date:   Mon, 09 Aug 2021 08:27:34 -0700
In-Reply-To: <CABPp-BGSB5K636sgfGwpaHeFUyGGnGcVVBHLg96m-Jf=gajmSg@mail.gmail.com>
        (Elijah Newren's message of "Sat, 7 Aug 2021 09:53:04 -0600")
Message-ID: <xmqqa6lqhc49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53124E80-F926-11EB-9BA8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Aug 6, 2021 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * en/merge-strategy-docs (2021-08-05) 10 commits
>>  - Update error message and code comment
>>  - merge-strategies.txt: add coverage of the `ort` merge strategy
>>  - git-rebase.txt: correct out-of-date and misleading text about renames
>>  - merge-strategies.txt: fix simple capitalization error
>>  - merge-strategies.txt: avoid giving special preference to patience algorithm
>>  - merge-strategies.txt: do not imply using copy detection is desired
>>  - merge-strategies.txt: update wording for the resolve strategy
>>  - Documentation: edit awkward references to `git merge-recursive`
>>  - directory-rename-detection.txt: small updates due to merge-ort optimizations
>>  - git-rebase.txt: correct antiquated claims about --rebase-merges
>>  (this branch is used by en/ort-becomes-the-default.)
>>
>>  Documentation updates.
>>
>>  Expecting a (hopefully final) reroll.
>
> I'm not sure what you're expecting in another reroll.  No one has
> commented on my v3 suggesting any issues and I'm not aware of any
> remaining things to fix or include.

Quite honestly, I do not know where that "expecting" came from X-<.
It would have applied to the original one, but I think v3 (which is
queued here) should be as ready as it could be.

