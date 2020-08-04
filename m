Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF64C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EF722B3F
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I4jMtfPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgHDA0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:26:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61867 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgHDA0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:26:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 497EE7AA21;
        Mon,  3 Aug 2020 20:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J+WDagwGsCqu4Dyv/y1wcir+Mrg=; b=I4jMtf
        PLWteqIXEojn1TWW2AzM1B2PxtkoQzR/2mVQnN2LSW85okwmCQ7xFRpw5No1aFFi
        xpngMke9hvx9xZMffl5m9SzjJvNMHrcTWokFTNrl0XWW9wBy8ijKHrjDJPYC2ahV
        UiqItku2guZrhX1vD5UkYSsaHDuR4WUkwjpDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kaPmaFxmYdt/RGEbyuEI49+TkctceokD
        /tU86sjyTiJLNVYvT3v7GQar7nwtTyY0Bj8Thfc0ox+YQUqFzQ5BE5975jbs58JS
        gsUAQrcLxuIPNXmLR9EAG0ljVySwjcHbbpujVN1Y6BYJF5KTx+MIM56nhWxhHh1x
        i7l7Kq3mJQ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41D2D7AA1F;
        Mon,  3 Aug 2020 20:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0D857AA1E;
        Mon,  3 Aug 2020 20:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/3] List all guides in git(1)
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
        <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 17:26:13 -0700
In-Reply-To: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Tue, 04 Aug 2020 00:20:56 +0000")
Message-ID: <xmqqh7tjtfx6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A91BF7A-D5E9-11EA-9EAF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1:
>
>  * Incorporated Junio's suggestion to reduce duplication.
>
> v1: This series adds a list of the guides to git(1).
>
> The first commit adds the misssing guides 'gitcredentials' and
> 'gitremote-helpers' to command-list.txt. The only missing guide after this
> change is 'gitweb.conf', but I think this one is obscure anough, and already
> linked to in 'gitweb.txt', that it does not matter much.
>
> The second commit drops the usage of 'common' and 'useful' for guides. This
> was suggested as one of two ways forward by Duy in [1] but was not commented
> on. I'm CC'ing the people that were CC'ed on that message.
>
> The third commit tweaks 'Documentation/cmd-list.perl' so that it also
> generates a list of the guides, which gets included in 'git.txt'. I chose to
> put this list just after the end of the list of commands.
>
> [1] 
> https://lore.kernel.org/git/CACsJy8ADj-bTMYDHxRNLOMppOEdPbVwL49u3XCfNBCmoLLZo+A@mail.gmail.com/
>
> Philippe Blain (3):
>   command-list.txt: add missing 'gitcredentials' and 'gitremote-helpers'
>   help: drop usage of 'common' and 'useful' for guides
>   git.txt: add list of guides

I think the "dedup the list of cmds-$category.txt" is logically a
separate step from "we forgot to add guide category so add it", so
either (1) "add guide twice, and then refactor" or (2) "refactor
before adding guide, and then add guide only in one place" would be
more appropriate than (3) "add guide while refactoring".  IMHO, (2)
would make the most sense.

Thanks.
