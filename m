Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D7BC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 18:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiDFSEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiDFSEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 14:04:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF6188548
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 09:38:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 867B6174604;
        Wed,  6 Apr 2022 12:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rtuOF0i0CGh1quRIlFqK74awXSMzNmEUjbRnEH
        MXrkM=; b=NW14ZniPfX7Hk3PBznXpvjsUFvgr47o/bLkDpDnq4LXtmtmSH0O+xK
        oLIiWj6WN+LUAd4D9hMBT5ITuWLgfzgxMfVgS7ZJkLQ9hovZz3KHy9ZfEGdno/d0
        iOmjQluRle9MnN4v7ryIn5MDva4tEdiYvw0Nnb/evZ2OICbBxyInI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EB65174603;
        Wed,  6 Apr 2022 12:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AFE0A1745FE;
        Wed,  6 Apr 2022 12:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes
 to a ref
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220329214941.2018609-1-sandals@crustytoothpaste.net>
        <20220329214941.2018609-4-sandals@crustytoothpaste.net>
        <220331.86pmm2swm9.gmgdl@evledraar.gmail.com>
        <YkwgGjj0JIcOhlMH@camp.crustytoothpaste.net>
Date:   Wed, 06 Apr 2022 09:38:55 -0700
In-Reply-To: <YkwgGjj0JIcOhlMH@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 5 Apr 2022 10:55:22 +0000")
Message-ID: <xmqqk0c2yxnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D90DEA8-B5C8-11EC-A6EA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> >  	probably not the command you want to use; see "push" above.
>> >  
>> > +export ( --print | --to-ref <ref> ) [<stash>...]::
>> > +
>> 
>> I think this extra \n here isn't needed.
>
> All the rest of the entries have it that way.  Junio likes it, you
> don't, but it's consistent with the rest of the file and I'm just
> following along.

I do not have preference either way.  The only reason why I think
this patch is better with the blank line is because other existing
entries are with a blank line between the header and the body.

Thanks.
