Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA8C433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 00:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiEEAKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiEEAKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 20:10:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF45798F
        for <git@vger.kernel.org>; Wed,  4 May 2022 17:03:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C28F1A8A00;
        Wed,  4 May 2022 20:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U0nohlAho3vp
        Lln74KFClI+6yyvbkQmZRHZJuQfEX4s=; b=qM67OBTVl5s38YhhmvFr/0tm8ctM
        9xO/rAECJ4+7pmb1DuRLfIzGu8BcLRCuPNnY+XxV27ylQyarFeGpjGZY1youL5Gq
        +PG5eRvaEBdLM9rxJ3FIXFMbak4sIk5CKDMb9DMoQ6y4kwwuoXklL3e24QmOWHFq
        U7XP2eeG0/0qUlA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8402C1A89FF;
        Wed,  4 May 2022 20:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15D021A89FE;
        Wed,  4 May 2022 20:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
References: <xmqqilqnvacd.fsf@gitster.g>
        <YnL2d4Vr9Vr7W4Hj@camp.crustytoothpaste.net>
Date:   Wed, 04 May 2022 17:03:33 -0700
In-Reply-To: <YnL2d4Vr9Vr7W4Hj@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 4 May 2022 21:56:07 +0000")
Message-ID: <xmqqa6bwluay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEAE6200-CC06-11EC-9266-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-05-02 at 22:27:46, Junio C Hamano wrote:
>> * bc/stash-export (2022-04-08) 4 commits
>>  - builtin/stash: provide a way to import stashes from a ref
>>  - builtin/stash: provide a way to export stashes to a ref
>>  - builtin/stash: factor out revision parsing into a function
>>  - object-name: make get_oid quietly return an error
>>=20
>>  A mechanism to export and import stash entries to and from a normal
>>  commit to transfer it across repositories has been introduced.
>>=20
>>  Will merge to 'next'?
>>  source: <20220407215352.3491567-1-sandals@crustytoothpaste.net>
>
> I think =C3=86var had some requests for a v5, so I'll try to get to one
> relatively soon.

Thanks.
