Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5629B20229
	for <e@80x24.org>; Wed,  9 Nov 2016 06:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbcKIG3M (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 01:29:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52276 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750803AbcKIG3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 01:29:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B23D471F9;
        Wed,  9 Nov 2016 01:29:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rw7g5og/2BVSnnb/wULlXUwfI+w=; b=OQXLln
        eMVNfTrxGkK1AxtrSeJh4aJiPIPUV8eWWNIvl437DbMkvmC3CxnWyXFpd4IXmKLA
        Dlx9Z671/lZW8YayVRYSXZhFuz7q1BePRIGBGAvGnSUtsiLPYKtb/jUu2MjPFPzl
        fRKtXcaXyD3YuxZ1vnNAfwzmjzbcIOndzptAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KXHpDYNMHfPLMyHM3BIoa+NbQze4k1CI
        V9GmHbllVqkXUArjJPg7qb/HJPsha2XRwLjU8vr5u1q3x4I0lozu5WIp4IZJbDQI
        EMXZOz6KQF8l7DV++9ZEr0QK9ZdtUDSddLdb2s7kzSnTuoD6oog1dYJPfksOwWD4
        MQ0qgO0+s4I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11BDF471F8;
        Wed,  9 Nov 2016 01:29:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E374471F7;
        Wed,  9 Nov 2016 01:29:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
        <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net>
        <65a1bb6d-e924-21aa-70d3-303ebdc499f1@kdbg.org>
        <20161108214825.yo37kvoqkeucuqgg@sigill.intra.peff.net>
Date:   Tue, 08 Nov 2016 22:29:07 -0800
In-Reply-To: <20161108214825.yo37kvoqkeucuqgg@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 8 Nov 2016 16:48:25 -0500")
Message-ID: <xmqqoa1p9nf0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1E7C8EA-A645-11E6-A7E2-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm collecting v2.11-rc1 topics in the "refs/heads/for-junio/" section
> of git://github.com/peff/git.git.
>
> I've also got proposed merges for "master" there, though note that none
> of the topics has actually cooked at all in next (the fixes are trivial
> enough that it may be OK, though).

I am not quite back up at full steam yet, but I expect I'd be more
or less functioning tomorrow, so I'll fetch them from your tree and
continue.

Thanks.


