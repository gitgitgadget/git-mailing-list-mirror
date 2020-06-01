Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD4C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 21:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2572073B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 21:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EsPNodCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFAVFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:05:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56126 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgFAVFL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 17:05:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 606E7DD550;
        Mon,  1 Jun 2020 17:05:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iGNK3hYWkO1j6aonCCkNflyNtqs=; b=EsPNod
        CtRfBj1lSOaIeHbonmCX3MABpr/h9xIJAsrwDccVor7glPQqT3JgeMc78wRceAmO
        P7ZZie1gBPoD/mKnpek14PmyR3DW2YwkQLRL5wh/Z9R9doAKssTSV6zblfGcBcib
        5rw9OjHk3LgpdlurxhuK96X6tJQMSRQ4yNrkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IOs9UTOZIkqhcSjemFBEN4CCrAlh9jv+
        /uvLab745IHo1qyvwlcIG+E9T8cuDOGVKMZaEzMKpqcmCkqWxcKEo8iSzP7RAasp
        TJrRmU09VTeJ64MDjHB/pr4hEWmOq9/3xKPpwhocYucgu3VjxJqFgJlii308qLSa
        vz5IWjIsIkc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57DC4DD54F;
        Mon,  1 Jun 2020 17:05:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 738B5DD54A;
        Mon,  1 Jun 2020 17:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE] Git for Windows 2.27.0-rc2
References: <20200526204539.6181-1-johannes.schindelin@gmx.de>
        <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet>
Date:   Mon, 01 Jun 2020 14:05:03 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 28 May 2020 23:35:24 +0200 (CEST)")
Message-ID: <xmqqv9kats3k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91442F6A-A44B-11EA-B1BE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Git for Windows v2.27.0 will be out on Tuesday (or even on Monday if Git
> v2.27.0 is released early enough).

Thanks for a reminder that Europe is ahead of me by about a bit less
than half a day ;-)
