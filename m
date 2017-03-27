Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E38D1FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 20:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbdC0UaW (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 16:30:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50212 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751677AbdC0UaV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 16:30:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85CE68289E;
        Mon, 27 Mar 2017 16:30:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GKadtw69HEOKywEpcHge3J4xX0Q=; b=ZP1r5m
        zN8nvQxiK3VpkcVNZANr2Ib0dSuUTU+BT4IlJsTJe5XI6GY3x2JU7rHqhN/PXVJK
        FfzfVYcVSOWzEtcrRa/INoTCgOdNk92woZiu1o/OOyKb0gi6CL9hi/PLLqugEUKR
        NFTJUDN/ZSvevIXwkPJzTAiy+XRezI8i6T088=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M/HHJwDRcUwdHAhgcnQghDKdQlxTgSG9
        q4j+FOAquMcq7Zq5AZPo1pCLeMWztSMRhCleoH2gKZwEnYfBqDWligp9StGGXZTv
        lpCwx6ERSQ0TM+aHJs5N+5mLCpLRbBOJ4LtLtaLEDSHcYBgL7zGTVTzKQJdrG3lo
        W6/lxVopsH4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EE6E8289D;
        Mon, 27 Mar 2017 16:30:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E91F38289C;
        Mon, 27 Mar 2017 16:30:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-p4: Add failing test case for name-rev vs symbolic-ref
References: <20170326091537.2707-1-luke@diamand.org>
        <xmqqefxj4ofm.fsf@gitster.mtv.corp.google.com>
        <CAE5ih78jhR3GwMBdPyi5oOHByC2fVxefExStc9pCNMTu-1Os7w@mail.gmail.com>
Date:   Mon, 27 Mar 2017 13:30:17 -0700
In-Reply-To: <CAE5ih78jhR3GwMBdPyi5oOHByC2fVxefExStc9pCNMTu-1Os7w@mail.gmail.com>
        (Luke Diamand's message of "Mon, 27 Mar 2017 07:57:47 +0100")
Message-ID: <xmqq8tnq1mzq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31989A8C-132C-11E7-B0AC-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> Yes. The test passes with your change.
>>
>> IOW, can we have a follow up to this patch that fixes a known
>> breakage the patch documents ;-)?
>
> Yes.

Thanks.
