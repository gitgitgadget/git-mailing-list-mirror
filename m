Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE3B1FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 18:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966532AbcLVScW (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 13:32:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966534AbcLVScV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 13:32:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDAB9598A1;
        Thu, 22 Dec 2016 13:32:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D8ik5xTmVyfXrBfRz40fcCIUB7k=; b=Gb+QVU
        8+TQX52wAq6rru2+RFSOCThHZFgrg8RH/8+czof1lJCGFrlvzgSAJOvVwUbELGcC
        qbm/phY/JyQ1AjQ3DOp135oYkFP6HuPgExsxwoynFCVBYXtPDegHqIo/s4MUx/Sq
        G/jSgIMhNPfMM8TSvQHWouSPHGDHyr7LunI3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Af5xVGRw2S1OOCt2A/9J3k0kM4rQ8BDe
        W6o5ovFKMm/D60Rqj4vB/29+YRPNyLotV4TkUXurhB/vu4hueRN15XV5euXp1LAe
        1j/yMlyiVqhRu7ImJRj2UgbuN2ovY8qiuikhW+EKFiO1PkKhijs9nb9U+Q2wqUur
        B4gQzWpapzk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B48E8598A0;
        Thu, 22 Dec 2016 13:32:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F2C65989F;
        Thu, 22 Dec 2016 13:32:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 0/3] Really fix the isatty() problem on Windows
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
        <cover.1482426497.git.johannes.schindelin@gmx.de>
        <xmqqd1gjhn0u.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612221852320.155951@virtualbox>
Date:   Thu, 22 Dec 2016 10:32:16 -0800
In-Reply-To: <alpine.DEB.2.20.1612221852320.155951@virtualbox> (Johannes
        Schindelin's message of "Thu, 22 Dec 2016 18:59:10 +0100 (CET)")
Message-ID: <xmqqy3z7g6hb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7D0B836-C874-11E6-9703-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Sorry, but I didn't mean to "suggest replacement".  I was just
>> testing my understanding by attempt to rephrase the gist of it.
>
> I did like your phrasing, though.

OK, then let's use these three patches as-is.  I just made sure that
they can go to maintenance track for 2.11.x; so all should be good.

Thanks.
