Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D204FC433E0
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66F620663
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 17:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgGMRJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:09:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:29466 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgGMRJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 13:09:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4B599k4jK0z5tlF;
        Mon, 13 Jul 2020 19:09:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D09B2149;
        Mon, 13 Jul 2020 19:09:29 +0200 (CEST)
Subject: Re: FETCH_HEAD files and mirrored repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
Date:   Mon, 13 Jul 2020 19:09:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.07.20 um 22:52 schrieb Junio C Hamano:
> We could teach "git fetch" a new "--write-fetch-head" option and
> teach "git pull" to pass it when calling "git fetch".  It is very
> plausible that some folks rely on "git fetch" to leave FETCH_HEAD
> without being told, so the option must default to on for a few
> development cycles before we flip the default to off,

Nah, really??? It's one of the benefits of git-fetch that it writes
FETCH_HEAD and the primary reason in many cases where I use the command!
So, either I don't care that FETCH_HEAD is written, or I do use it. IMO,
not wanting to write FETCH_HEAD is the odd case and would need a
configuration tweak, not the other way round.

-- Hannes
