Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2488202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 14:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdKTOxh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 09:53:37 -0500
Received: from cp-27.webhostbox.net ([208.91.198.76]:46009 "EHLO
        cp-27.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdKTOxg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 09:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unimetic.com; s=default; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dM8ifpoadrFp8IuKeWIk0QQNtgKSaFwL/HfUUsUOgJ4=; b=L/+LXv2CtSgxgjCUL/bUT3E7Xb
        jiYY/bsFLZhjPkhCBACniu7FQyztr4d7ad8G0FDtaRAc1fYZMgdgXFd0aUNq2Qa6hS7DaiTEcRyAt
        oTzrPQfLW8ufZLidap9w8wpiZFmXu2kTfGjdSYBE4C0+6ASQ8gA/1O0bWZ3je4IALUIm35DdYKdvk
        gwg6bbwxoumvi2wqsP/jFci2k9dc/1vZALsxA51aJRsjoo13WgWal6oza0LvGSo3w0fqE17+6qaWG
        FKnW3lnCyJndN56u24uZwguxBxYo8qFQyks8taDQyPZBogleBegPLAvoIKhhIpMqu/CXc9roYOW2t
        Ai8eZJeg==;
Received: from [127.0.0.1] (port=54738 helo=208.91.198.76)
        by cp-27.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <hsed@unimetic.com>)
        id 1eGnS4-004ETF-1d; Mon, 20 Nov 2017 14:53:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Nov 2017 14:53:35 +0000
From:   hsed@unimetic.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH V4] config: add --expiry-date
In-Reply-To: <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
 <20171118022727.30179-1-hsed@unimetic.com>
 <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com>
Message-ID: <dfa89c0016cc857bee6d9c380c2b2679@unimetic.com>
X-Sender: hsed@unimetic.com
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated_sender: hsed@unimetic.com
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-27.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unimetic.com
X-Get-Message-Sender-Via: cp-27.webhostbox.net: authenticated_id: hsed@unimetic.com
X-Authenticated-Sender: cp-27.webhostbox.net: hsed@unimetic.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-18 03:37, Junio C Hamano wrote:
> 
> I think this is more correct even within the context of this
> function than dying, which suggests the need for a slightly related
> (which is not within the scope of this change) clean-up within this
> file as a #leftoverbits task.  I think dying in these value parsers
> goes against the point of having die_on_error bit in the
> config-source structure; Heiko and Peff CC'ed for b2dc0945 ("do not
> die when error in config parsing of buf occurs", 2013-07-12).
> 
> Thanks; will queue.

Thanks a lot for all your help and I hope to do more patches in future!

Kind Regards,
Haaris
