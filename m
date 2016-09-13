Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08FC20984
	for <e@80x24.org>; Tue, 13 Sep 2016 14:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbcIMOoj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 10:44:39 -0400
Received: from mout.web.de ([217.72.192.78]:58874 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbcIMOoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 10:44:39 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LnS4I-1b5oAU2G5u-00hcSN; Tue, 13 Sep 2016 16:44:20
 +0200
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
 <20160908182132.50788-11-larsxschneider@gmail.com>
 <20160910062919.GB11001@tb-raspi>
 <10020380-76ED-4371-A0BA-59D07AF33CE0@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        gitster@pobox.com, sbeller@google.com, Johannes.Schindelin@gmx.de,
        jnareb@gmail.com, mlbright@gmail.com, jacob.keller@gmail.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <96554f6d-988d-e0b8-7936-8d0f29a7564f@web.de>
Date:   Tue, 13 Sep 2016 16:44:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <10020380-76ED-4371-A0BA-59D07AF33CE0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:fgxpH7XNvkhiHhoL9f47WlfbUC0Yb9tTKKESdUKTlwW290uy/GX
 g742xhp/s/H37VPZU1zqA+ZGFAp6jSEmwrusBQ+fsf1Anu7jnSFFzYMPaOiZIELbPqZKAwg
 oaLJ/zGeEqnKLTJR0TUi48HCs6lTJEPS+0mLsmwrsFnVDb+0MT0H1HVInk1Qj9yNs+BqlV0
 1eUSSfPEdaZEDtKAqZDzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xb6mVWQmuh0=:lwnsOq6DXkr8/8TEnF+0f+
 up7C4bewSrqaynFneGxf1FF5g/nQIYBAP0IO6MZz9IOLAnzRFBJE3voCKRMqdTwI6uL9+DyO0
 0LWK6eCzC8MOAC8xHGfyBOSDFMbLwH1L72Wjliu2BnraNjPCZcK3I29Ny4bq4/B3TVGxoQBYs
 gZBB6puqZMMpwwv9Jrg3snjOPPHVMGv6egVMcU5hQioWJaNrWpYzjvRtmrLU9Tv9jwNO8Xotd
 t2eiZmm+p/xvMTv8DBkMZ5kjgU2ShWuy3kDI7vFeg+8bqCShi4QeSiI1cvId1YM2na6vvUpPG
 SH5EWJxCxYpFIKlYZY7bLzHDD+6s8PzmC7fu6KsZ59lfOhLCbt4egEcdqNbmOhDNPUK8KLBA8
 0AIFz3r+n69vElQGDFjsppGODSK8dn8hrEyDX8bdg83WvFbAmG6XhCfjzxZGJZ8FnRVGX2QFb
 wpSqqILx5nXJDgm1jh64mrLTdNXEMlP+rEUaodawFSFuFFMPDm3Jn+RX+dzouOLTtkV5/Pm6s
 frRDw6fS4IIIsI6GShRvCbb0gvAiTAa3OY6mOZVyy8q4SZB7pj2MVWlfcU5VMJqQwzb7Sw1vT
 0E8o4UGXKm7Tn+lq9+HQA0hC/zkJ7mTb8O5UKzzewO4hct9D4/aVdUx/p4Rhi9h8gLocbC7N1
 mDmW6Z90jGUY/cWXt6dqE3EjbH+Rx9ym/fFv5nD5AYTFQCUFkbu+ad1cc9zZG+2Cp9jwJHw98
 VibV3SHPRqhFjel66jo4u67nCNAkEeh2zAL1aDjVqD/SQRgXnFEmW1eXCFHN2KWnr1b5bA2zs
 Phciz0o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.09.16 11:49, Lars Schneider wrote:

>> How do we send pathnames the have '\n' ?
>> Not really recommended, but allowed.
>> And here I am a little bit lost, is each of the lines packed into
>> a pkt-line ?
>> command=smudge is packet as pkt-line and pathname= is packed into
>> another one ? (The we don't need the '\n' at all)
> 
> Every line is a dedicated packet. That's why '\n' in a path name would
> not be a problem as the receiver is expected to read the entire packet
> when parsing the value (and the receiver knows the packet length, too).
> 
> The '\n' at the end is required by the pkt-line format:
> "A non-binary line SHOULD BE terminated by an LF..."
> (see protocol-common.txt)

That is only the half part of the story:
A non-binary line SHOULD BE terminated by an LF, which if present
MUST be included in the total length. Receivers MUST treat pkt-lines
with non-binary data the same whether or not they contain the trailing
LF (stripping the LF if present, and not complaining when it is
missing).


How do we treat pathnames ?
They can have each byte value except '\0'.
What should a receiver do, which reads a string like "ABC\n\n" ?
Is it "ABC\n" or "ABC\n\n" ?

I would really consider to treat pathnames as binary, and not add a trailing '\n',
are there other opinions ?
 





