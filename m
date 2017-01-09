Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258711FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 14:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbdAIO3J (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 09:29:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63102 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932991AbdAIO15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 09:27:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6EC65D183;
        Mon,  9 Jan 2017 09:27:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VF8X9mkHmHbAySebTqaG2Wvqh4U=; b=qtDn0E
        cyx/IF8OGbu0wmEKrVQiSVt/jxoimUj6HLbqn9t7xgNn/6SIpOJ7clvWY6WqedDV
        KkoenM9O8sX+X6o5Ht+0mWZ853DSiEeQUspH66oxnl6O9yP/03bx3VQ5VDed6Iha
        gsXlQ5ParqUbCnFmXZd47zVT9BWyL6FkKgcsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=diisTnv7WwAbk9ltolNtPbU5tVlNiuCl
        Nv+EoXUedkNB5jTcF7fCRT+j3AU7qD/K6xbDwm5rLrHZJNTDCtNSB296lTTV3g8f
        X9AeQuMUP55SRHi+bdnjZb97CSwMhWziE6RHlJd7e9BvKnnRUJ7EKDY+4OLujo/e
        5YnDfBMN7vs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBC8C5D181;
        Mon,  9 Jan 2017 09:27:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2992F5D180;
        Mon,  9 Jan 2017 09:27:56 -0500 (EST)
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
Date:   Mon, 09 Jan 2017 06:27:54 -0800
In-Reply-To: <alpine.DEB.2.20.1701091127570.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 9 Jan 2017 11:49:37 +0100 (CET)")
Message-ID: <xmqq4m18wbo5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D015A002-D677-11E6-AF12-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In any case, it does not break things, and it helps Cygwin, so: ACK
>
> Ciao,
> Dscho
>
> P.S.: I pushed this to Git for Windows' `master`, too:
> https://github.com/git-for-windows/git/commit/f05a26948b

Hmm, I peeked it hoping that you corrected the log message along the
lines of your <alpine.DEB.2.20.1701081953330.3469@virtualbox>, but
it appears that what you queued does not have any extra mention of
cygwin or specifics of the buildchain on top of what Steven posted?

