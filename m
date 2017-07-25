Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102141F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 19:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754293AbdGYTaz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 15:30:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61017 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754239AbdGYTax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 15:30:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3B0CA184B;
        Tue, 25 Jul 2017 15:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NtUjPbOdM14M3NRNDOW8ERJe2Lw=; b=cVYr9p
        /UQw/Wb++VlIzl0ZXlXkgp8E/PpX4oir3lGqwKcmMOnj/shjTfC9DV93jryttBtV
        9FlDnN/dbKpfZeLOlCGW6IalAHm/TraZJRD0YlvIKwiJCUTUF19zj8jMjoCV7kG6
        fnGJPIvHpxFdgKzEBICvEHvvLX/mudhxVW/xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ywcgkrp2XAXubp4ohNY+yJRmTm6gGSrA
        CEaJ6ObCpZiuN8O+GR4mB+pWy956yxm5eLggddvzsnYKop9IWk2aSQQhFcnDTbOf
        YnaRVdvTc3iIOCqPoQnAgy1gm9RKFoEM3jkiNg29ryUU4uxdp3UVZ1Tuapedv69p
        MiIlNzHUAbw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC103A184A;
        Tue, 25 Jul 2017 15:30:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41F4DA1849;
        Tue, 25 Jul 2017 15:30:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #07; Mon, 24)
References: <xmqqinihbgci.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707252046190.4271@virtualbox>
Date:   Tue, 25 Jul 2017 12:30:51 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707252046190.4271@virtualbox> (Johannes
        Schindelin's message of "Tue, 25 Jul 2017 21:22:19 +0200 (CEST)")
Message-ID: <xmqqy3rcuxec.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C541D7FC-716F-11E7-83DC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 24 Jul 2017, Junio C Hamano wrote:
>
>> * js/blame-lib (2017-07-24) 1 commit
>>  - blame: fix memory corruption scrambling revision name in error message
>> 
>>  A hotfix to a topic already in 'master'.
>> 
>>  Will merge to 'next'.
>
> This sounds more critical than `next`, in particular since you said that
> you do not want to move anything from `next` to `master` before 2.14
> final.

That is why it is not "Will merge to and cook in 'next'" which is a
norm for new things during -rc.

>>  The final batch to "git rebase -i" updates to move more code from
>>  the shell script to C.
>> 
>>  Expecting a reroll.
>
> Since you said yourself that you won't pick up v6...

Read the message again and realize that I said won't during -rc
but may hold onto it.  I am intending to queue it on 2.14 final
to merge to 'pu' until the topic is rerolled again.

