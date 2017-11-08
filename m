Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280111F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756561AbdKHARi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:17:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52089 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752437AbdKHARf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:17:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 625AEB74D8;
        Tue,  7 Nov 2017 19:17:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mx0FFLl/rfohdUvwKvn9eRFtjgA=; b=V+sLCJ
        Ob4VHMktL1VR1vepLwozj/4JSuH82FKJhstxmFo919Ln7jO2yzz1N+4hnJjb7ABK
        ycIhycaUQ9uAdDAVQN8LOFTeJ4HNk2EID5bgP77oqmVBH/A3srworqNtfF2joVKe
        XniSBRpbJmBT/90+4ngiO4a6jw8bVU+RQRkAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mcLjdd2fqf2d5o0fCNv8XysQCQEeA/fw
        l3dbJUmNhePcPF4ctUIKq0tswose0pdQJLd7wiy4bkdYBH7jpdEzq+crDQbnY8xq
        QYr5zr7wzdiv1msuK+GFePMyE5ayIt0YwlvwNaAmN/iytkD/szlBL9RUMzreslJO
        sjwCjUef2ko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A4BDB74D7;
        Tue,  7 Nov 2017 19:17:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7CC4B74D5;
        Tue,  7 Nov 2017 19:17:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: bp/read-index-from-skip-verification, was Re: What's cooking in git.git (Nov 2017, #02; Mon, 6)
References: <xmqqfu9rizwc.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711071319430.6482@virtualbox>
Date:   Wed, 08 Nov 2017 09:17:32 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711071319430.6482@virtualbox> (Johannes
        Schindelin's message of "Tue, 7 Nov 2017 13:20:30 +0100 (CET)")
Message-ID: <xmqq7ev1pqsj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 378DA276-C41A-11E7-9ABB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 6 Nov 2017, Junio C Hamano wrote:
>
>> * bp/read-index-from-skip-verification (2017-11-01) 1 commit
>>  - read_index_from(): speed index loading by skiping verification of the entry order
>> 
>>  Drop (perhaps overly cautious) sanity check before using the index
>>  read from the filesystem at runtime.
>> 
>>  Will merge to 'next'.
>
> Maybe s/skiping/skipping/ before merging it into `next`?

Will do; thanks for being a careful reader.
