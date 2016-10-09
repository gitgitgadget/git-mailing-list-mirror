Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C162B20986
	for <e@80x24.org>; Sun,  9 Oct 2016 10:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753865AbcJIKpL (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 06:45:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:43912 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbcJIKpL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 06:45:11 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3ssKdx09pRz5tlC;
        Sun,  9 Oct 2016 12:45:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 61F3852D9;
        Sun,  9 Oct 2016 12:45:08 +0200 (CEST)
Subject: Re: [PATCH v2 20/25] sequencer: left-trim lines read from the script
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <cover.1473590966.git.johannes.schindelin@gmx.de>
 <09e05e7ac23164625f2076ff06d2b034101878da.1473590966.git.johannes.schindelin@gmx.de>
 <xmqqsht657ls.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609121019290.129229@virtualbox>
 <xmqqr38p3z1i.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610061459390.35196@virtualbox>
 <5ed8aaea-9fbe-11b0-49b7-1b42567d4918@kdbg.org>
 <alpine.DEB.2.20.1610091054490.35196@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5d9ab6f1-211c-37fc-9396-0742426b2c45@kdbg.org>
Date:   Sun, 9 Oct 2016 12:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1610091054490.35196@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.10.2016 um 10:57 schrieb Johannes Schindelin:
> Good point. I decided to do it at a different level, though:
> parse_insn_line() should already receive the line without trailing
> end-of-line markers (this was already the case for LF-only todo scripts).
>
> I reused your commit message and touched it up a bit, hope you don't mind!

I don't mind at all.

Thanks,
-- Hannes

