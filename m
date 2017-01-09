Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091111FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 14:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942387AbdAIOYa (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 09:24:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63504 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942379AbdAIOYA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 09:24:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D603D5B0CD;
        Mon,  9 Jan 2017 09:23:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OujY2OWllLGpdWuwEQYM+/Pehj4=; b=rkxNUt
        b0lzl/fcFDXhs6nQnHlznbslA9mK+TRn4RyainLdAnMUpwKxM0Rwzr3kmzfzT0vf
        m+mcch88FMlK3Ccjyd7mQw3Dv3Iq2YK6hp0r4oCdtlfoAhR2xJCcQmnHsEl5xOFH
        9TuUolQ5sQikHqE6QFmPvCkapMrYMt5hcMQTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ssJo7m+IjJaYpN3QsGKnAtxKf59EIcCx
        dPy6zZpT+45jWYP+XFZ1fy7x7OGhzP/ym2clCvgkUHaIC+ptTBsJF5e2bFxxTGhs
        YU31Ne+D5mKVYoWrRmj4Mz1LHPGCpYg7Ka6KOcc2MWhlxXsypjCQ+ck6iS18Uuj+
        L9v/3U9HTAs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA2C75B0CC;
        Mon,  9 Jan 2017 09:23:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20F025B0CB;
        Mon,  9 Jan 2017 09:23:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: put LIBS after LDFLAGS for imap-send
References: <20170108061238.2604-1-svnpenn@gmail.com>
        <alpine.DEB.2.20.1701081250580.3469@virtualbox>
        <CAAXzdLVXUdCAcJL6DratNwLFUSN4UAV+TmALSZe-zSSTAJcWWw@mail.gmail.com>
        <alpine.DEB.2.20.1701081953330.3469@virtualbox>
        <xmqqy3ylx75g.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701091127570.3469@virtualbox>
Date:   Mon, 09 Jan 2017 06:23:57 -0800
In-Reply-To: <alpine.DEB.2.20.1701091127570.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 9 Jan 2017 11:49:37 +0100 (CET)")
Message-ID: <xmqqbmvgwbuq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4233F310-D677-11E6-9C2A-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...
> It is a bit curious that -lws2_32 *does* only show up in $(LIBS), but I
> guess it is simply the fact that we use a newer GCC (gcc.exe (Rev2, Built
> by MSYS2 project) 6.2.0) that allows Git for Windows to be built even
> without this patch.
>
> In any case, it does not break things, and it helps Cygwin, so: ACK

Thanks, will queue on my side, too.
