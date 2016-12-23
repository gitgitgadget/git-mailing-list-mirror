Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1C91FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 17:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764215AbcLWRq3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 12:46:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756025AbcLWRq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 12:46:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD41E586CA;
        Fri, 23 Dec 2016 12:46:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q8UMO2MSvtVV6sQzWj222v1CXSs=; b=dx623f
        p9OLILc6dkgLw2P0HJ+umtok0QeFF/CfVlKuUIvXHA4z+mcgVTjLdW6wYOR9+Jea
        CalWqSKuqrySXwykl+qbygNzF/qt5PgA432t3/+SUYN+ypoQLqa9bh/LzMMqmP+9
        pB6PpOfLcfZRGc8Nvz5dNPZFgPevlOMEr8nEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KxVESmZxYXqtzA448pOLujspQ83M/a0U
        0wPuVsU8Y+jTI+ChVbZd1kq2tV9R25A8H+SmaAuLMz9iCD0dpLojJ5s0TCNrpbJ2
        ER0bIDaz8CPAbktsZ7d61gri//sODg8oCyPsMAhT6nQwWkQHKxiKDMOO0haN4nu8
        VoaXzZxaaR4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5340586C9;
        Fri, 23 Dec 2016 12:46:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22C5F586C8;
        Fri, 23 Dec 2016 12:46:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2016, #07; Thu, 22)
References: <xmqqzijnehgb.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CEKj6Lbn++NHhyB7J8HBrMW4F37SHi2soCH1z=RJz4GQ@mail.gmail.com>
Date:   Fri, 23 Dec 2016 09:46:24 -0800
In-Reply-To: <CACsJy8CEKj6Lbn++NHhyB7J8HBrMW4F37SHi2soCH1z=RJz4GQ@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 23 Dec 2016 17:18:42 +0700")
Message-ID: <xmqqd1giedxr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9F469EA-C937-11E6-B5B3-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Dec 23, 2016 at 5:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Will merge to 'next'.
>>  - nd/config-misc-fixes                                         12-22          #3
>
> Hold it. You made a comment about rollback lockfile on uninitialized
> variable or something but I haven't time to really look at it yet.

The fix for it is squashed in to the version queued. Please double
check by fetching from me and comparing it with what you sent out.

Thanks.

