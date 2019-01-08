Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316F81F803
	for <e@80x24.org>; Tue,  8 Jan 2019 00:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfAHA5R (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 19:57:17 -0500
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:52048 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbfAHA5R (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Jan 2019 19:57:17 -0500
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-04v.sys.comcast.net with ESMTP
        id gZpygP7UlfZ3Sgfhkg307q; Tue, 08 Jan 2019 00:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1546909036;
        bh=4A7fSMk5CU3v6WXw45AqmQuPkvOEltFHdRyZWOaA/Us=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=hHq56OzCvRffm1qI9b/0nhfK/iCmpHDrP2XhBcXq20eSbFIptR0WFpPAuxDoZ9O9d
         EJpLKRwusSfjdeaa1t83UAQARnD/Le1hmYKo7IlktDLDWgPVt3/7y0Ntj8eFjjwxWb
         SYHZNOljCzaFkusivuMfHqlnMSRTL0pnytHNxqhu1VW0ofcCZrp7NnA248QNq66kfe
         B2D9VTTOSfKS32qPVt+c3R3QwL5a1HxdK7lntyC6IIaTr+GGQ2feIaKRyoFIxhYbsM
         tRETd9DCQQ6JLu26e200+LbdYddaqhmd+HjPrTnFkKNwhfE5jXiCJUWBLneufF79wX
         BVujCnpDUBcqw==
Received: from maqku.svl.corp.google.com ([IPv6:2620:0:100e:913:d978:5566:abe5:124c])
        by resomta-ch2-19v.sys.comcast.net with ESMTPSA
        id gfhGggOHEwFf5gfhLgfNRV; Tue, 08 Jan 2019 00:57:14 +0000
X-Xfinity-VMeta: sc=0;st=legit
Subject: Re: [PATCH v2 0/2] support for filtering trees and blobs based on
 depth
To:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
References: <20181210234030.176178-1-matvore@google.com>
 <xmqq1s6oladv.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <50eeac4e-53e5-63c7-af8a-4067d92108e0@comcast.net>
Date:   Mon, 7 Jan 2019 16:56:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq1s6oladv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2018/12/11 0:45, Junio C Hamano wrote:
> This seems to require at least two topics still not in 'master';
> I've bookmarked the topic by merging sb/more-repo-in-api and
> nd/the-index into 'master' and then queueing these two patches on
> top, to be able to merge it into 'pu' to see if there are bad
> interactions with other topics and also give others easier access to
> the topic in the integrated form.
>
> Thanks.

I'm re-reading the SubmittingPatches document and now I realize that I 
should have based this on master. Thank you for merging things so that 
my patch works. Let me know if it would be easier if I rebased this 
patch on top of master either now or on the next re-roll.


