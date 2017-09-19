Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC4A2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 02:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdISCc2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 22:32:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51193 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750882AbdISCc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 22:32:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64E5DAA019;
        Mon, 18 Sep 2017 22:32:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TKTDmVx9hhRvZ7cBx5RT3X9gfgo=; b=O+8Zdz
        luh19qH5SrXxaeWZDsJZH674hN0D41zs0c46JsdxM1Ah83UK/cH8YBVFmh36CgHj
        3U9Ilt41JCT53hWvm1rgUkyqadH299YAGKhNq3T6U0kS7N3pp3aHYWrW7brAvLQV
        Yz5OvaG1JHlDuIafvkI14lePFqHC9sOHjqDcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dYDzZDb6FZ0RR5ktB76IjL+3kAlZa4+x
        NyRndGIHczMEIa5LKvwv3cfeaPQwWBtM9voz+iQ40Ocdo7PyhG54T8zOcJlNkDVv
        wbtWG2pRVQAhXQ2RQ7TsEplJGTtSdQETiEzwqJRQkiECXpQTZUE6TL+2Fj+L1pL2
        39YTwbwVAsU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59D89AA017;
        Mon, 18 Sep 2017 22:32:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B52BEAA015;
        Mon, 18 Sep 2017 22:32:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
        <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com>
        <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709151816390.219280@virtualbox>
        <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709152214100.219280@virtualbox>
        <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709181637420.219280@virtualbox>
Date:   Tue, 19 Sep 2017 11:32:25 +0900
In-Reply-To: <alpine.DEB.2.21.1.1709181637420.219280@virtualbox> (Johannes
        Schindelin's message of "Mon, 18 Sep 2017 16:41:39 +0200 (CEST)")
Message-ID: <xmqqbmm7s9ja.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6A87756-9CE2-11E7-BFA9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Do you have a concrete suggestion to make these individual entries more
>> helpful for people who may want go back to the original thread in doing
>> so?  In-reply-to: or References: fields of the "What's cooking" report
>> would not help.  I often have the message IDs that made/helped me make
>> these individual comments in the description; they alone would not react
>> to mouse clicks, though.
>
> Oh gawd, not even more stuff piled onto the mail format. Please stop.
> ...
> It probably tries to serve too many purposes at the same time, and thereby
> none.

Well, this was started as my attempt to give a public service that
shows a summary of what is happening in the entire integration tree,
as there was nothing like that before (and going to github.com and
looking at 'pu' branch would not give you an easy overview).  As
many people contribute many topics to the project, complaining that
it talks about too many topics would not get you anywhere.

If you find "What's cooking" report not serving your needs, and if
no one finds it not serving his or her needs, then I can stop
sending these out, of course, but I am not getting the impression
that we are at that point, at least not yet.
