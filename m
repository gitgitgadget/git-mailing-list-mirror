Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1396B20958
	for <e@80x24.org>; Tue, 21 Mar 2017 03:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756169AbdCUDH3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 23:07:29 -0400
Received: from mx1.constrainttec.com ([59.167.34.41]:10429 "EHLO
        mx1.constrainttec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755307AbdCUDH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 23:07:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mx1.constrainttec.com (Postfix) with ESMTP id 428D0149C40B;
        Tue, 21 Mar 2017 03:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at maat.constrainttec.com
Received: from mx1.constrainttec.com ([127.0.0.1])
        by localhost (maat.contecint.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0U6c-rhSfZcj; Tue, 21 Mar 2017 14:07:16 +1100 (AEDT)
Received: from [10.224.200.149] (dhcp-149.contecint.com.au [10.224.200.149])
        by mx1.constrainttec.com (Postfix) with ESMTP id 7C423149C408;
        Tue, 21 Mar 2017 14:07:16 +1100 (AEDT)
Subject: Re: Use base32?
To:     Jacob Keller <jacob.keller@gmail.com>
References: <alpine.DEB.2.20.1703081638010.3767@virtualbox>
 <27077870-76d9-b45a-5727-c339a3d0ffc8@bu.edu>
 <1c213acb-1deb-8959-b1f8-28f99974640f@constrainttec.com>
 <CA+P7+xoCsO=LFw1aSQugmvZz+kjhNXT+Ffwa3DjDUPOdpobzAg@mail.gmail.com>
Cc:     Jason Hennessey <henn@bu.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Michael Steuer <Michael.Steuer@constrainttec.com>
Message-ID: <f573b82c-591f-22f0-84fb-204c23d1de81@constrainttec.com>
Date:   Tue, 21 Mar 2017 14:07:16 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xoCsO=LFw1aSQugmvZz+kjhNXT+Ffwa3DjDUPOdpobzAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 20/03/2017 19:05, Jacob Keller wrote:
> On Sun, Mar 19, 2017 at 10:58 PM, Michael Steuer
> <Michael.Steuer@constrainttec.com> wrote:
>> [..]
>> If base32 is being considered, I'd suggest the "base32hex" variant, which
>> uses the same amount of space.
> I don't see the benefit of adding characters like 0 and 1 which
> conflict with some of the letters? Since there's no need for a human
> to decode the base32 output, it's easier to use the one that's less
> likely to get screwed up when typing if that ever happens. It's not
> like we actually need to know what value each character represents.
> (sure the program does, but the human does not).
>
> Thanks,
> Jake

Fair enough and good point. We definitely wouldn't want 0 and O and 1 
and I mixed together.

Cheers,
Mike.
