Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625211FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 03:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756971AbdJRDlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 23:41:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56384 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755279AbdJRDlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 23:41:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73994A145D;
        Tue, 17 Oct 2017 23:41:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SDt9q4E66x5bT/kpksK5M/iDvUM=; b=EWB3Y6
        PcUORHiEe6GLgq5aDEvZ5VzDkMKZfqC63GphVLNWAIi4vMgHUNoVZgDfQWx4bslu
        psvH8TCS7wFErScqOS0At9+sCHnj85eSRW9scXef78XykxYI12UTs8l5Xk9jimXJ
        UdMpcuDc7sk3rsci3Outf9jygDEKZewQjiIIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vlchU8T65UTrdxHJrl2cdHwm2BT0nbos
        eeXzIJsKfUek428d1gfA6JRLk3JBeCVx4l5jnfqL0nunN3ye3UWsMbq9hIex+ece
        5R0RveePNXIKvpwDih9KF5MHnUZ6/iBcHQ2ZlQJyZBsY734aVop4bOQO0noMdDEx
        QVPBZoP+U2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B413A145A;
        Tue, 17 Oct 2017 23:41:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCBF0A1459;
        Tue, 17 Oct 2017 23:41:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Minor man page weirdness?
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
        <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net>
        <87zi8psli3.fsf@linux-m68k.org>
        <xmqq1sm1o5k5.fsf@gitster.mtv.corp.google.com>
        <xmqqfuahkwug.fsf@gitster.mtv.corp.google.com>
        <20171018032103.p6bz7wciiedokiyy@sigill.intra.peff.net>
Date:   Wed, 18 Oct 2017 12:41:03 +0900
In-Reply-To: <20171018032103.p6bz7wciiedokiyy@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 17 Oct 2017 23:21:04 -0400")
Message-ID: <xmqqbml5ktrk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B40C06C-B3B6-11E7-9FF3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It does make me wonder if there are other instances of the missing-space
> problem lurking. Grepping for backtick followed by single-quote shows
> only one more case in user-manual.txt. I have no idea if that one hits
> the same problem on older docbook versions.

I had an impression that this is only for roff, but we do not
produce user-manual.[0-9], do we?

> Or if it's a problem for any
> other punctuation combinations. I'm happy to punt on it until somebody
> with an affected docbook produces more bug reports. :)

Yup, we cannot _fix_ what we do not know are broken ;-)

Thanks.
