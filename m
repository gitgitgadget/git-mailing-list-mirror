Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28638202A2
	for <e@80x24.org>; Mon, 16 Oct 2017 22:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932627AbdJPWrG (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 18:47:06 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58911 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755486AbdJPWrF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 18:47:05 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3yGD3C1L3tz1qsDf;
        Tue, 17 Oct 2017 00:47:03 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3yGD3C10czz1qqlD;
        Tue, 17 Oct 2017 00:47:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id OpCMGyp2Mzj4; Tue, 17 Oct 2017 00:47:02 +0200 (CEST)
X-Auth-Info: nhJEcxrmr9EtmqThklyi4ICgyS6bv693ddXwNplGWjgk+36gMJjQW9gYPJB8cny+
Received: from igel.home (ppp-188-174-149-255.dynamic.mnet-online.de [188.174.149.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 17 Oct 2017 00:47:02 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 82F0B2C38D0; Tue, 17 Oct 2017 00:47:01 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeff King <peff@peff.net>
Cc:     Joris Valette <joris.valette@gmail.com>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: Consider escaping special characters like 'less' does
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
        <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
        <87zi8sxvkg.fsf@linux-m68k.org>
        <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
        <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
        <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com>
        <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net>
X-Yow:  If this was a SWEDISH MOVIE, I'd take off your GO-GO BOOTS!!
Date:   Tue, 17 Oct 2017 00:47:01 +0200
In-Reply-To: <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Oct 2017 18:13:24 -0400")
Message-ID: <87po9m3e3e.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 16 2017, Jeff King <peff@peff.net> wrote:

> I can't help but feel this is the tip of a larger iceberg, though. E.g.,
> what about characters outside of the terminal's correct encoding? Or
> broken UTF-8 characters?

Or correctly encoded UTF-8 characters that look confusing?  Or blobs
with embedded escape sequences?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
