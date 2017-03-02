Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21291F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 15:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdCBP31 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 10:29:27 -0500
Received: from avasout04.plus.net ([212.159.14.19]:34412 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdCBP3X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 10:29:23 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id r3Hh1u00722aPyA013HiKk; Thu, 02 Mar 2017 15:17:42 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=N659UExz7-8A:10 a=KLh6X47LKmqaKNZ5Wc8A:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
 <20170302105157.59791-1-larsxschneider@gmail.com>
 <alpine.DEB.2.20.1703021210170.3767@virtualbox>
Cc:     git@vger.kernel.org, gitster@pobox.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4a27f62d-5576-df9d-257f-60ff327547e6@ramsayjones.plus.com>
Date:   Thu, 2 Mar 2017 15:17:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703021210170.3767@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/03/17 11:24, Johannes Schindelin wrote:
> Hi Lars,
> 
> On Thu, 2 Mar 2017, Lars Schneider wrote:
> 
[snip]
>> One thing that still bugs me: In the Linux32 environment prove adds the
>> CPU times to every test run: ( 0.02 usr  0.00 sys +  0.00 cusr  0.00
>> csys ...  Has anyone an idea why that happens and how we can disable it?
> 
> I have no idea.

I have no idea either, but it is not unique to this 32bit Linux, but
rather the version of prove. For example, I am seeing this on Linux
Mint 18.1 (64bit _and_ 32bit), whereas Linux Mint 17.x did not do
this. (They used different Ubuntu LTS releases).

[Mint 18.1 'prove --version' says: TAP::Harness v3.35 and Perl v5.22.1]

ATB,
Ramsay Jones

