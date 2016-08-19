Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9A31F859
	for <e@80x24.org>; Fri, 19 Aug 2016 16:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbcHSQHA (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 12:07:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754083AbcHSQG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 12:06:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8948535846;
        Fri, 19 Aug 2016 12:06:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xm+b0xm+SqWWKNXIDcvTJodiq4Q=; b=ncFqKJ
        Ve9sxdB9NgRt+VLaxy9FgAujum1v51QSg1ZIHdXnNNEHkIbBOJnj7YhVRqq5cxF8
        E97C0u707ItP464hS8JMSSUebpBcdfvHy4LbzvgPYAbl0laVL6UNs2vf+pzJxOgr
        T1BDrOWODQiu3qnf8AZJeoEsH6x5wcIQcUUrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FuT7rCqNXqMUaY1civs7b192chbGpRqg
        1ScQ9G+MyY4tDYiPHcgtZDm2A2l8aVDXAEl0nIs+PawWKKk7vSWAeMfMYLzSmMt8
        c7STeDTwCD7BjelJnKLLU5Ui4n9lC9hZNI9bqJtWUtq+KpYML9uADlwZUF6zfP0G
        VRm6h6kffBI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81E8735845;
        Fri, 19 Aug 2016 12:06:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D59735844;
        Fri, 19 Aug 2016 12:06:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de>
        <20160819085700.GA23254@tb-raspi>
        <alpine.DEB.2.20.1608191656080.4924@virtualbox>
Date:   Fri, 19 Aug 2016 09:06:56 -0700
In-Reply-To: <alpine.DEB.2.20.1608191656080.4924@virtualbox> (Johannes
        Schindelin's message of "Fri, 19 Aug 2016 17:00:20 +0200 (CEST)")
Message-ID: <xmqq37m04uan.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4A597B8-6626-11E6-B883-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Does it make sense to be more specific here:
>> The order of conversion is
>> - ident
>> - CRLF
>> - smudge
>
> I do not think it makes sense to complexify the documentation in that
> manner.

Right.
