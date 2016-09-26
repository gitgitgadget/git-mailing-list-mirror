Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3DFC209AB
	for <e@80x24.org>; Mon, 26 Sep 2016 18:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422783AbcIZSVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:21:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1422739AbcIZSVR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:21:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6127E418C0;
        Mon, 26 Sep 2016 14:21:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rLwRAWq7nThm+5i+PEEFtmWBAhc=; b=oFk7L4
        XOoTxW7l6aZIKdFvXMTQo2Nla2KvSq+q2+/hu7UjXmaG11yVJEgCp2MdDHZnszDK
        FRFbb1utiRWEkyDDxrJQS/TNhELiYpDntK80QFxH97sFvx6clnLltGpaLlNWfq9Q
        KNTUPfDSXAi9ufiFK/dJ8+jkuOePDzs8f3ChI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nTp7ka43QGwvxEYvrBNVY347G70WX0io
        J7n896wEYsNY2iZgpCCffL51njPON3VKwZDEo2IP+R5d53iSRj09udpeB6E5G+JN
        9q9Cysy8vuqHyoe3BKLgPTq/z93c7OwG0FxPR+izrkQIkCq5e4hxpkyELb4WZ7qP
        k7vOddPNQCU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59D35418BF;
        Mon, 26 Sep 2016 14:21:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7A0C418BE;
        Mon, 26 Sep 2016 14:21:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 04/11] i18n: add--interactive: mark plural strings
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-5-git-send-email-vascomalmeida@sapo.pt>
        <1474913721.1035.9.camel@sapo.pt>
Date:   Mon, 26 Sep 2016 11:21:13 -0700
In-Reply-To: <1474913721.1035.9.camel@sapo.pt> (Vasco Almeida's message of
        "Mon, 26 Sep 2016 18:15:21 +0000")
Message-ID: <xmqqlgyesesm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 032F58F2-8416-11E6-8D36-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>> > +	} elsif ($did eq 'reversed') {
>> > +		printf(Q__("reversed one path\n", "reversed %d paths\n",
>
> This should be 'reverted' not 'reversed'.

I'll mark v2 of this topic "not to be merged yet"; please send in a
corrected version 3 after you collect feedbacks from others and
adjusted the patches for them.

Thanks.
