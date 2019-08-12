Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A108B1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 18:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHLSSm (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 14:18:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58569 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLSSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 14:18:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 567DC682F7;
        Mon, 12 Aug 2019 14:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cL7YHdahMqS2MM0w1bgSAhf6kXk=; b=u4viFJ
        2DV+vXH3BmO5WS/jFdBVJi24StLNqB/WPUtXfQHXspViM4GaJAmcST9z9cAGS0fy
        3C1UZaNnpPiG1k+oSJqZ8pv3CIglNWiiqLRqMJ3l3vRD/wWX8I60sWBhvtHK8338
        zdIex+UolibkE7gZE9JsU0lfDitLuk768+3yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FvyquAY3N0z7lE0zk+BQK6aBJ6NLy2KP
        5r9BhLpPW6nKSfQNFc8eRainKMCAzubAgoO3196Y3svEe7IEvpXFm4QNXHezZlOI
        eDUMjVdd9SgKQyIryX1hMhHJuLenPHT46fQfX6aNFyuHtIe6HRAhnL6Lm2o+hdq7
        ial9ze+PqxA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E05C682F6;
        Mon, 12 Aug 2019 14:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73640682F5;
        Mon, 12 Aug 2019 14:18:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Yagnatinsky\, Mark" <mark.yagnatinsky@bofa.com>
Cc:     'Torsten =?utf-8?Q?B=C3=B6gershausen'?= <tboegi@web.de>,
        "'git\@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com>
        <20190808205631.e2647kxq74thotjb@tb-raspi4>
        <3269668c03a8482d8d854ec19dd43907@bofa.com>
        <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
        <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
        <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
        <20190811121004.guygurnopwwggvsp@tb-raspi4>
        <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
        <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
        <aae529ce1b084b7bbcca3977e6909417@bofa.com>
Date:   Mon, 12 Aug 2019 11:18:35 -0700
In-Reply-To: <aae529ce1b084b7bbcca3977e6909417@bofa.com> (Mark Yagnatinsky's
        message of "Mon, 12 Aug 2019 18:00:08 +0000")
Message-ID: <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A81B472-BD2D-11E9-90C3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com> writes:

> ...  Assuming the repo has no .gitattributes,
> is it possible to predict what line endings sample.txt will end up with in my repo?
> Or does it depend on more information than what I've just written?

Binary packagers can ship custom attributes and config that applies
globally to the installation, which may affect operations in all of
your repositories, can't they?
