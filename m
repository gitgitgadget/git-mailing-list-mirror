Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D651FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 20:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756303AbcKVUka (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 15:40:30 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:46347 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755780AbcKVUk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 15:40:29 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tNcm52RzNz5tlF;
        Tue, 22 Nov 2016 21:40:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BD5481D04;
        Tue, 22 Nov 2016 21:40:03 +0100 (CET)
Subject: Re: [PATCH] git-gui: pass the branch name to git merge
To:     Junio C Hamano <gitster@pobox.com>
References: <6a6dd0b9-436d-327f-c33d-e5cce078b3a0@kdbg.org>
 <xmqqvavfpbph.fsf@gitster.mtv.corp.google.com>
Cc:     Pat Thoyts <patthoyts@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1dc28731-9000-c3bf-fbed-0cb17c230d8b@kdbg.org>
Date:   Tue, 22 Nov 2016 21:40:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqvavfpbph.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.11.2016 um 20:16 schrieb Junio C Hamano:
> Can't this be handled on the "git merge FETCH_HEAD" codepath
> instead?

Absolutely. Any takers? ;)

-- Hannes

