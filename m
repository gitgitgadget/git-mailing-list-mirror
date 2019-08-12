Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5366B1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 00:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfHLAkq (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 20:40:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63570 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLAkp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 20:40:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5621171777;
        Sun, 11 Aug 2019 20:40:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DJycKoK/+Oe2RS7SWm/RUfq2Jyo=; b=cId50M
        j8agPdb6z9nxQgFPhIhKW7GFvV3pqc6jHaFlgt/sl0EtMaWkMTjzClCnoRE8iXIX
        k6IcQ239KvMqHdfoJITQiclE8R7ahIpqnvbl1NLPsBweiPrDP5PEPPKB6uBoZcyx
        mVLbZnjC3igLz3G0bIfC9tD8bRX1YK8nsVckY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wWD60ymTGqG6HLNsZ610l5NGScl1XohU
        LPZYaKpaJAytgYCcun/932PsqEG7O8FvGhI2TxZeUWIsEf2/y3q6IxGFlhvz8E4t
        Fqj5Q0yPPgasCH/q1qq0Mzr5lJx7uoOrRXIcOsNExF0igDHuOKKzm4BHyasI3X6/
        SW5zeCnIAWg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D140171776;
        Sun, 11 Aug 2019 20:40:43 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05C5D171775;
        Sun, 11 Aug 2019 20:40:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Mark Rushakoff via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mark Rushakoff <mark.rushakoff@gmail.com>
Subject: Re: [PATCH 1/1] doc: fix repeated words
References: <pull.309.git.gitgitgadget@gmail.com>
        <76831150995dd3e7847825192b22114a6d4906d1.1565416752.git.gitgitgadget@gmail.com>
        <20190810060351.GA25876@sigill.intra.peff.net>
Date:   Sun, 11 Aug 2019 17:40:42 -0700
In-Reply-To: <20190810060351.GA25876@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 10 Aug 2019 02:03:51 -0400")
Message-ID: <xmqqsgq7b4hh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0C9434A-BC99-11E9-AD40-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> There were many false positives by this grep command, including
>> deliberate repeated words like "really really" or valid uses of "that
>> that" which I left alone, of course.
>> 
>> I also did not correct any of the legitimate, accidentally repeated
>> words in old RelNotes.
>
> Thanks. I read over each of these, and they are all obviously the right
> thing to do.

Thanks, both.
