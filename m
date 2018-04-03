Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3701F424
	for <e@80x24.org>; Tue,  3 Apr 2018 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755343AbeDCIvd (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 04:51:33 -0400
Received: from mailhost.frm2.tum.de ([129.187.179.12]:55673 "EHLO
        mailhost.frm2.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbeDCIvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 04:51:31 -0400
Received: from mailhost.frm2.tum.de (localhost [127.0.0.1])
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTP id w338pSxi053712;
        Tue, 3 Apr 2018 10:51:28 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
X-Virus-Scanned: at mailhost.frm2.tum.de
Received: from taco61.taco.frm2 (taco61.ictrl.frm2 [172.25.2.61])
        (authenticated bits=0)
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTPSA id w338p4jI053704
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Apr 2018 10:51:05 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
X-Authentication-Warning: mailhost.frm2.tum.de: Host taco61.ictrl.frm2 [172.25.2.61] claimed to be taco61.taco.frm2
Subject: Re: Test t2028 failes
To:     Eric Sunshine <sunshine@sunshineco.us>
Cc:     Git List <git@vger.kernel.org>
References: <dfb01281-2ffb-a0ac-a44d-74ccd304a7ea@frm2.tum.de>
 <CAPig+cRTf+WHaSJsLhbPuG0fwd6zkTP_zhwLhB14GdC81xiHRQ@mail.gmail.com>
 <cdec466c-ecc9-b1d7-c637-04e63552c759@frm2.tum.de>
 <CAPig+cSsTPKoLfcxrgD4+NhXa5AeWynxumo8Zed_PH-q3U163w@mail.gmail.com>
 <6d28dbb1-0c4c-6fca-555c-afb6c1c9e781@frm2.tum.de>
 <CAPig+cQ8BsaxaWzSHvytx3aHbFbWjs1V=35PKtQCpwKOWBsstg@mail.gmail.com>
From:   =?UTF-8?Q?Jens_Kr=c3=bcger?= <Jens.Krueger@frm2.tum.de>
Message-ID: <26a00c2b-c588-68d5-7085-22310c20e6df@frm2.tum.de>
Date:   Tue, 3 Apr 2018 10:51:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ8BsaxaWzSHvytx3aHbFbWjs1V=35PKtQCpwKOWBsstg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE-1901
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mailhost.frm2.tum.de [129.187.179.12]); Tue, 03 Apr 2018 10:51:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.04.2018 um 10:47 schrieb Eric Sunshine:
> On Tue, Apr 3, 2018 at 4:42 AM, Jens Krüger <Jens.Krueger@frm2.tum.de> wrote:
>> Maybe, the attached patch may help. On my machine(s) it helped.
>>    git worktree list --porcelain >out &&
>>    grep "^worktree.*/destination" out &&
>> - ! grep "^worktree.*/source" out &&
>> + ! grep "^worktree.*/source$" out &&
> 
> Our emails crossed. I suggested the same in my response (although I'd
> add the '$' anchor to both grep's, not just the one).
> 
I think so, that both of grep commands needs the '$' anchor.

Thanks, for your help.
