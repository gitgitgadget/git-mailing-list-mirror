Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02630C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99D66113E
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhIJFbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 01:31:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62968 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhIJFbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 01:31:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BEE614416A;
        Fri, 10 Sep 2021 01:30:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qNfWXO7On62NZnnAHndkCIuZSMi+Heg8F2yL/A
        OLUGQ=; b=Dy8vgnNEljnilAeiJ+7WRmCUmKeOM0NtujYi0uR9TlgRL42Dl2O68J
        22U3J6eazfO3fMDipRxsSfhSI/ScBChgArnww3c9EedQlsHToi6GA9L0hPrDYhjs
        fInsQj55Jb0ya9l68YiIOIjDZvE3KCiWD0IkeJNbdKt30jHJAPwnY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8466D144169;
        Fri, 10 Sep 2021 01:30:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BA363144162;
        Fri, 10 Sep 2021 01:30:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: ar/submodule-add-more, was Re: What's cooking in git.git (Sep
 2021, #02; Wed, 8)
References: <xmqqsfyf5b74.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2109091314350.59@tvgsbejvaqbjf.bet>
Date:   Thu, 09 Sep 2021 22:30:01 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109091314350.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 9 Sep 2021 13:15:15 +0200 (CEST)")
Message-ID: <xmqqmtoluheu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2689D64A-11F8-11EC-88D8-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 8 Sep 2021, Junio C Hamano wrote:
>
>> * ar/submodule-add-more (2021-08-10) 10 commits
>>  - submodule--helper: rename compute_submodule_clone_url()
>>  - submodule--helper: remove resolve-relative-url subcommand
>>  - submodule--helper: remove add-config subcommand
>>  - submodule--helper: remove add-clone subcommand
>>  - submodule--helper: convert the bulk of cmd_add() to C
>>  - dir: libify and export helper functions from clone.c
>>  - submodule--helper: remove repeated code in sync_submodule()
>>  - submodule--helper: refactor resolve_relative_url() helper
>>  - submodule--helper: add options for compute_submodule_clone_url()
>>  - Merge branch 'ar/submodule-add-config' into ar/submodule-add
>>  (this branch uses ar/submodule-add-config.)
>>
>>  More parts of "git submoudle add" has been rewritten in C.
>>
>>  Will merge to 'next'.
>
> If you use the description in the release notes, please
> `s/submoudle/submodule/` first.

Thank you.
