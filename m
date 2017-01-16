Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38BEC20756
	for <e@80x24.org>; Mon, 16 Jan 2017 06:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbdAPG4r (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 01:56:47 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:4989 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750845AbdAPG4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 01:56:46 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3v23th3YXqz5tlN;
        Mon, 16 Jan 2017 07:56:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9A4A9123;
        Mon, 16 Jan 2017 07:56:43 +0100 (CET)
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
Date:   Mon, 16 Jan 2017 07:56:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.01.2017 um 02:51 schrieb Junio C Hamano:
> * jk/vreport-sanitize (2017-01-11) 2 commits
>  - vreport: sanitize ASCII control chars
>  - Revert "vreportf: avoid intermediate buffer"
>
>  An error message with an ASCII control character like '\r' in it
>  can alter the message to hide its early part, which is problematic
>  when a remote side gives such an error message that the local side
>  will relay with a "remote: " prefix.
>
>  Will merge to 'next'.

Please be not too hasty with advancing this topic to master. I could 
imagine that there is some unwanted fallout on systems where the 
end-of-line marker CRLF is common. Though, I haven't tested the topic 
myself, yet, nor do I expect regressions in *my* typical workflow.

-- Hannes

