Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D73209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 21:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933168AbcLMVxk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:53:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58681 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932767AbcLMVxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:53:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01F7455048;
        Tue, 13 Dec 2016 16:52:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BocgR5cJD2MC4qDnA+Uqz2Dcmjk=; b=NewEM0
        L/dhxfKaeNTB93VFa1W95AjPrKPqToE4jHL6b+IIuruRbBgO45OX/z7YjTDcpDjs
        JAfEq6YFytX4+HnAlZB8t71JfD3Jv8/eo44SwTgUQEhu2sTwAYYl7HFY92VaiCj+
        WYPdTHTqqyShTDMzuGVpKFGizt+maaEGRMXoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q6003N5GVilsBd6KHIQUW/IzEyo/338U
        fNxCMHgRIXRdifkeVc6RHmjk08cJkhIDpHxQRVslEQQ4bu9/m/DmQqJZxUbvCw2j
        CV0XOCTeTvHhZ63qbzXYWYOrjLa4//1xv4vyhd6Ctpp5+zTbNmFtVQAl5gnbLAMi
        6KIWcTZJSdo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDAA755047;
        Tue, 13 Dec 2016 16:52:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D89D55046;
        Tue, 13 Dec 2016 16:52:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 06/34] sequencer (rebase -i): write the 'done' file
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <4a1229e9f2d3715607935519f359b5d7986c2290.1481642927.git.johannes.schindelin@gmx.de>
Date:   Tue, 13 Dec 2016 13:52:57 -0800
In-Reply-To: <4a1229e9f2d3715607935519f359b5d7986c2290.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:29:56 +0100
        (CET)")
Message-ID: <xmqqy3zjzebq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82B9BDC4-C17E-11E6-8EBC-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In the interactive rebase, commands that were successfully processed are
> not simply discarded, but appended to the 'done' file instead. This is
> used e.g. to display the current state to the user in the output of
> `git status` or the progress.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Looks good.

I'd stop at this point for now, and start working on other things
for the rest of the day.  I might find time to come back to it later
tonight.

So far, looking mostly good.
