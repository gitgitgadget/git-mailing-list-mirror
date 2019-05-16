Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F4F1F461
	for <e@80x24.org>; Thu, 16 May 2019 23:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfEPXeH (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:34:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52663 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfEPXeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:34:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2031471D36;
        Thu, 16 May 2019 19:34:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L6Op9/91vcjo6b9S6HP5biua8PI=; b=HI2Qs7
        1Aj0L9yR3CjL23Vx1LLgp8ahRXM0IWTWRkqkebe8iYyk4VB6nlAVnawnXaDkdp2U
        Yk+KnGYNwTQcWgPO7E7LfJb7xZuQdPw/49g6UFbpGJbkQWMM7l2ETwLzqzGO1UBh
        cnMdXRyiqxrKJOW6aG497fvQf0yyPXvbGdPhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uuJMOQdfZMh/D05ijl50leKu9aNWWrdl
        RMi19m1hwtFME8JkIN60fBVmY34d8eRt5jiKGeWFMJfVcUJaNVHy4gVehXGnuD29
        mfGK2SY4aSkpbMgCNmvCivoYuzb8dUwoTxPJq92eixjJy6ASbVOg9qmn26b1b3eW
        adY4dOi8diA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1836971D35;
        Thu, 16 May 2019 19:34:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D209871D33;
        Thu, 16 May 2019 19:34:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "LI\, BO XUAN" <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        philipoakley@iee.org
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
        <20190511041331.51642-1-liboxuan@connect.hku.hk>
        <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
        <CALM0=-n_=8K4RWE9MvwPFT26UwN-rAA09ryqdTfEF4GJ57YBjg@mail.gmail.com>
        <a2455214-9ce5-71e3-74bc-114af6fcfca7@kdbg.org>
        <xmqqlfz64uzw.fsf@gitster-ct.c.googlers.com>
        <262eb1d4-a898-c6d0-8e04-ce6c58eaa4e6@kdbg.org>
Date:   Fri, 17 May 2019 08:33:59 +0900
In-Reply-To: <262eb1d4-a898-c6d0-8e04-ce6c58eaa4e6@kdbg.org> (Johannes Sixt's
        message of "Thu, 16 May 2019 21:20:57 +0200")
Message-ID: <xmqq8sv63rfc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15F80D94-7833-11E9-B425-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> I'd prefer to keep this list at the minimum necessary as long as it is
> hard-coded in C.

Yeah, I know that feeling.

> I would take a different stance if this were some
> configuration file that we ship.

Hmm, now you reminded me of my ancient wish.

Perhaps it is not too bad to ship $(sharedir)/git-core/userdiff that
can be read using git_config_from_file() interface, using a very
narrow callback function that understands only diff.*.xfuncname and
diff.*.wordregex and discards everything else, without even
following the include/includeIf stuff?  As long as that can be done
safely and without too much overhead, we could get rid of the
hardcoded patterns in userdiff.c::builtin_drivers[] and that would
be wonderful ;-)

