Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71751F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 10:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeCTK2i (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 06:28:38 -0400
Received: from mail.progesoft.com ([104.236.42.59]:49144 "EHLO
        mail.progesoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbeCTK2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 06:28:37 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Mar 2018 06:28:37 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.progesoft.com (Postfix) with ESMTP id 4C5FF1A0CC2
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 11:22:05 +0100 (CET)
Received: from [192.168.1.11] (151-0-155-178.ip281.fastwebnet.it [151.0.155.178])
        by mail.progesoft.com (Postfix) with ESMTPSA id D41891A0CDC;
        Tue, 20 Mar 2018 11:21:58 +0100 (CET)
Subject: Re: [PATCH] filter-branch: use printf instead of echo -e
To:     Ian Campbell <ijc@hellion.org.uk>, Jeff King <peff@peff.net>,
        CB Bailey <charles@hashpling.org>
Cc:     git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <20180319144905.11564-1-michele@locati.it>
 <20180319153945.kchupu43cpcbg25n@hashpling.org>
 <20180320042245.GA13302@sigill.intra.peff.net>
 <1521539621.2474.60.camel@hellion.org.uk>
From:   Michele Locati <michele@locati.it>
Message-ID: <d2bf28a9-ae79-9046-22f4-ceac502882f6@locati.it>
Date:   Tue, 20 Mar 2018 11:21:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521539621.2474.60.camel@hellion.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il 20/03/2018 10:53, Ian Campbell ha scritto:
> On Tue, 2018-03-20 at 00:22 -0400, Jeff King wrote:
>> Author cc'd in case there's something more interesting going on.
> 
> That code was written years ago, if I had a good reason at the time
> I've forgotten what it was and I can't think of a fresh one now.
> Switching to printf seems like a reasonable thing to do.
> 
> Perhaps switch the remaining `/bin/echo` (there are two without `-e`)
> uses to just `echo` for consistency with the rest of the file?
> 
> Ian.
> 

Thanks for reply, Ian.
Charles already suggested to replace /bin/echo with echo, and I already 
updated the patch accordingly: see
https://marc.info/?l=git&m=152147479517707&w=2
Junio already queued that PATCH-v2.

--
Michele
