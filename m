Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574F11FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbcHWQaO (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:30:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60952 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932261AbcHWQaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:30:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E4CE3546B;
        Tue, 23 Aug 2016 12:30:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7i7bBBGUm4etbxjd93sPpnhh9zk=; b=F3EHyn
        b0e8oD2/YsoorMhKJtPXh7EPXUUWFVZrpd7sauc1Ymgc5cx0HF23aVHfDsudiMh9
        mVqxNDQVSGDZApb4vDkxQ1ztaW0RTK++DDlFO6px57B4MJmdslnV15QSNIK1HyCW
        pc+oSLKtUkRi8cmJUVujXyTHtLpzhGzeittkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KP6JQXVj0xbDSNe/pbU1/kdjsij1TIZi
        hIFeri+vJezeu/lgBbPZO5EMRHowAignk/Hlaw8/5xRQgn1aWc0SnIr0uBlZHlOu
        IGBdncOAuz3XoKmZqsJcCNz1MUKt279tBHMVOv42bhmLJA+6EZ+qAkLhvefdMvlJ
        f9/uUmLHOI0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56C633546A;
        Tue, 23 Aug 2016 12:30:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D870435469;
        Tue, 23 Aug 2016 12:30:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.10.0-rc1
References: <xmqq7fbcz76b.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608231538160.4924@virtualbox>
Date:   Tue, 23 Aug 2016 09:30:09 -0700
In-Reply-To: <alpine.DEB.2.20.1608231538160.4924@virtualbox> (Johannes
        Schindelin's message of "Tue, 23 Aug 2016 15:39:45 +0200 (CEST)")
Message-ID: <xmqq7fb7xxbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD169D06-694E-11E6-8D8D-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 19 Aug 2016, Junio C Hamano wrote:
>
>> [...]
>>  * A new run-command API function pipe_command() is introduced to
> ...
> You probably want a '*' in front of this paragraph, too.
>
>>  * Squelch compiler warnings for netmalloc (in compat/) library.
>
> s/netmalloc/nedmalloc/

Thanks.
