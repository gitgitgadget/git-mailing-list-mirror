Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5735C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 18:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbhLOSxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 13:53:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55929 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbhLOSxn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 13:53:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E5C3170C4A;
        Wed, 15 Dec 2021 13:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wONDBMo3zkeLXpov0L7mNHGQiqGenA8a6x4bFT
        +M5fI=; b=AiJxwEdDrL6YoIAjVCHkrHmksZunrADWAnXJ8l0R6O5sdHsF6iG6MU
        fxPDiyJw/RrmEiczU39zIe8+vycw0CEPiZmw6AZx5mVn7d/gcQdtpblWCLLOHjup
        fHhRYZT5cr/GMYFI6yM+yR1/ghTbyfxaup8PuXzfwER2YdCja5PHk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27CA3170C49;
        Wed, 15 Dec 2021 13:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 862AA170C48;
        Wed, 15 Dec 2021 13:53:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: 'Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)'
References: <xmqqilvvluoa.fsf@gitster.g>
        <20211214105941.24670-1-dyroneteng@gmail.com>
Date:   Wed, 15 Dec 2021 10:53:38 -0800
In-Reply-To: <20211214105941.24670-1-dyroneteng@gmail.com> (Teng Long's
        message of "Tue, 14 Dec 2021 18:59:41 +0800")
Message-ID: <xmqqilvp7l8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 510AE540-5DD8-11EC-BAC3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> On Fri, 10 Dec 2021 18:52:37 -0800, Junio C Hamano wrote:
>
>> * tl/ls-tree-oid-only (2021-11-22) 1 commit
>>  - ls-tree.c: support `--oid-only` option for "git-ls-tree"
>>
>>  "git ls-tree" learns "--oid-only" option, similar to "--name-only".
>>
>>  Expecting a reroll.
>>  source: <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
>
> Yes, you are right and the source is matched as Patch v3.
>
> On 8 Dec 2021 10:08:30 +0800, I sent a patch v5 in ths series: 
>
> https://public-inbox.org/git/cover.1638891420.git.dyroneteng@gmail.com/

Ah, thanks for a pointer.

It seems that it completely fell under everybody's radar.
