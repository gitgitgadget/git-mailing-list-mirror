Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB641F461
	for <e@80x24.org>; Wed, 10 Jul 2019 19:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfGJTIv (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 15:08:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61755 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGJTIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 15:08:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA8C415D016;
        Wed, 10 Jul 2019 15:08:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TAmrER5R5H6KxzFA8g6md229saM=; b=V3axtP
        Gyx2xN/6F8cxd6WY1gi4JsKXVMnJ+CtZwjt3YClxeo8Tym6c6fnsuUvoGkZnoxae
        tkpWYMLHekuU2UJuOx+YiYWciOjICNRPuvPZG0UJoCaJ+qmlb2x53cHw6eRIIrJx
        mdzkqiO+bvaP3j+aLxDQf5Yl20GVHdYTKn5Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NkkqSZotbo+FS5FOyOUUdP9eNW5W8yXh
        VEKD+3ossaD497KJczzvQPPti5jFT33QH1k8G6BnutO8zs5nqYJt/oJ1CeyOdszL
        sOBfRg9x4Z+E6R0Qs8uAKyD+wuyq/Wyy8biCY9CGW3Na1WhVCEGRk2qnX13+Ht+d
        bV60HgaxJrM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD3FF15D015;
        Wed, 10 Jul 2019 15:08:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E206F15D014;
        Wed, 10 Jul 2019 15:08:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: jl/status-reduce-vertical-blank, was Re: What's cooking in git.git (Jul 2019, #02; Tue, 9)
References: <xmqq36jeva9e.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907102058360.46@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Jul 2019 12:08:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907102058360.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 10 Jul 2019 20:59:21 +0200 (CEST)")
Message-ID: <xmqq1ryxu2pv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 240E3A50-A346-11E9-8891-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * jl/status-reduce-vertical-blank (2019-06-21) 1 commit
>>  - status: remove the empty line after hints
>>
>>  Extra blank lines in "git status" output have been reduced.
>>
>>  Needs to wait on nd/switch-and-restore to stabilize.
>
> Didn't that latter branch hit `master` already, i.e. it did stabilize?

Hopefully ;-) 

I haven't used it very extensively myself (I am too used to typing
"git checkout"), so I wouldn't be surprised if people find glitches
in the updated experience after it hit 'master', though.

In any case, now we can decide whether we want to keep it and move
it forward, or it is a bad idea to be discarded.  My tentative vote
is to move it forward, fwiw.

Thanks.

