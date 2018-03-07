Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BD61F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933922AbeCGWan (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:30:43 -0500
Received: from mail.netzguerilla.net ([217.11.57.120]:45175 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGWam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:30:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 3A08D100019;
        Wed,  7 Mar 2018 23:30:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netzguerilla.net
Received: from mail.netzguerilla.net ([IPv6:2a00:1828:2000:612::25])
        by localhost (sal.netzguerilla.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id XYztjyZZ0630; Wed,  7 Mar 2018 23:30:40 +0100 (CET)
Received: from [IPv6:2003:dd:ff29:a301:1c94:69ca:ad13:165a] (p200300DDFF29A3011C9469CAAD13165A.dip0.t-ipconnect.de [IPv6:2003:dd:ff29:a301:1c94:69ca:ad13:165a])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id DBBE5100012;
        Wed,  7 Mar 2018 23:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=projektwerkstatt.de;
        s=fckp; t=1520461839;
        bh=lnqhMDKJdTOn3uGqhSvQdsiT/URVt0MB2vFi5j/aLPo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gmRPWU145YeyTY+Q8fA9vsK8PPcrd2Vzkqk18ULT3kSIYWNYSQE8v/27QrKyr6xxf
         +pH7qSHIs3exve6PBsLKzv3HLBrlnTEA2O8A6YRw2KXGeTcdIUZksLg/xDAAO3btFL
         ezHtJ1lceTCpeTOad6jNwvPZERevRlnBNXMOk27/gbh1kArzbduxjYf1XMjhKc00jw
         UEvK6kR9gAQPiMgfeLT0v0m0ngJugCcFK5siWBHUn7LDfCbUVO7kVchiILHMkxijmy
         qZu4L51WrezxNSB1yN/O6IfPrrL12fVdZTFqlGw+lKCZbW+xyJRSC6ca80e6al3kBI
         9j+TtGXDSft4w==
Subject: Re: git help clone: questions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <6ea2b41f-37c3-8540-4763-7688f56fe202@projektwerkstatt.de>
 <xmqqinaa6l3b.fsf@gitster-ct.c.googlers.com>
From:   kalle <kalle@projektwerkstatt.de>
Message-ID: <81c78c4f-b690-d06c-bb7d-9c65e33777b5@projektwerkstatt.de>
Date:   Wed, 7 Mar 2018 23:30:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqinaa6l3b.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote this, because when it is written about 'reference repository', I
consider it not totally clear, which repository is meant, as the option
'--reference <repository>' only names one as <repository>.
For reasons of clearness, I now propose writing "reference repository
<repository>".

kalle

Am 06.03.2018 um 02:36 schrieb Junio C Hamano:
> kalle <kalle@projektwerkstatt.de> writes:
> 
>> -In the explanation of the option --reference: shouldn't there be
>> written '<repository>' instead of  'reference repository'?
> 
> "Shouldn't X be Y?" is not an effective way to communicate; it
> solicits a "no, the current one is fine." without any explanation.
> 
> If you think X should be Y for some reason, please say "I think X
> should be Y BECAUSE Z" instead.  Without stating why you think
> differently from what those who wrote the current text, it is hard
> for people to respond either with "Yeah, you're right---I agree
> with Z" or with "No, Z does not hold because..."
> 
