Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97097207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 16:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbcJCQYN (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 12:24:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64036 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751830AbcJCQYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 12:24:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFC5742968;
        Mon,  3 Oct 2016 12:24:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OynzzfXPcYMKST6+L3B4eklqKLk=; b=mPSlhO
        1+DMNbkZ7LUhvuTWBYM1x+zOxA4wFliwCunDqUPIrckSpqMT3TAmgaB7Lk2yfGBV
        85SG5ttn16l6YrnbET4rNG/exMI2zrMKVzeqhfYEvECMtq848ccNEMWBM0E299bt
        MHhJOz1xhoEtbJEGlRiLhGhbsjhVJPNN1hoLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IR3dnPpZl2Bq7SqJ2mzIjbwvH4iRpEh1
        uGzQUiNJylWSTc0oNytD2bw06v6JYtviSSjABfLqFxbiDEKMWsanD620E8eHqJJA
        ouXBZx+srmj70z0SrPMvrxVE5NWJKId6k7WhujeKsK3bfXd7+FZaONlAg+7LfXQC
        jRcm3rJ41ho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8BA342967;
        Mon,  3 Oct 2016 12:24:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7455442965;
        Mon,  3 Oct 2016 12:24:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [Q] would it be bad to make /etc/gitconfig runtime configurable?
References: <xmqqoa39p926.fsf@gitster.mtv.corp.google.com>
        <20160927192539.ybooc34iodnzs2ab@sigill.intra.peff.net>
        <alpine.DEB.2.20.1610031303000.35196@virtualbox>
        <20161003112654.3vca4zmctslcudfz@sigill.intra.peff.net>
Date:   Mon, 03 Oct 2016 09:24:08 -0700
In-Reply-To: <20161003112654.3vca4zmctslcudfz@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 07:26:54 -0400")
Message-ID: <xmqq1szx8kpj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D09C1AF4-8985-11E6-8A3A-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I admit both of those are uses for git _developers_, though, not git
> _users_.

Yes, this is meant for developers and not users.

The initial question probably should have stated more explicitly,
e.g. "I am wondering if it would be helpful to developers if we add
this thing; does anybody think of a reason why exposing it to end
users is a bad idea?"
