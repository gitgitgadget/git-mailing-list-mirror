Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387C6202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 10:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbdIHKGa (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 06:06:30 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53406 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751894AbdIHKG3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 06:06:29 -0400
X-AuditID: 12074412-1e5ff7000000748d-e8-59b26ba40415
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id DE.94.29837.4AB62B95; Fri,  8 Sep 2017 06:06:28 -0400 (EDT)
Received: from [192.168.69.190] (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88A6Pud024610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 06:06:26 -0400
Subject: Re: [PATCH 07/10] t1404: demonstrate two problems with reference
 transactions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <caaa44126f18869158872e5473e53478db780ba9.1503993268.git.mhagger@alum.mit.edu>
 <xmqqshfxztn5.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c5ff9b3d-6526-44d5-f539-39cac3b05657@alum.mit.edu>
Date:   Fri, 8 Sep 2017 12:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqshfxztn5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqLske1OkwavDchZrn91hsni+/gS7
        RdeVbiaLht4rzBbdU94yWvxo6WG22Ly5ncWB3WPnrLvsHgs2lXo8693D6HHxkrLH501yAaxR
        XDYpqTmZZalF+nYJXBlLNk1iLHjIXLF5yz/mBsafTF2MnBwSAiYSE85MY+li5OIQEtjBJLF0
        8jxmCOc8k8TeDRdYQaqEBSIkGnuvsIDYIgJqEhPbDoHZzAKLmCROXg6HaNjJKPFs0X92kASb
        gK7Eop5msBW8AvYSf2YcBmtgEVCRmHr3BRuILQo0tO/tZXaIGkGJkzOfgNVwClhL/Fy7gAli
        gbrEn3mXmCFscYlbT+ZDxeUltr+dwzyBUWAWkvZZSFpmIWmZhaRlASPLKka5xJzSXN3cxMyc
        4tRk3eLkxLy81CJdM73czBK91JTSTYyQeBDawbj+pNwhRgEORiUe3hXemyKFWBPLiitzDzFK
        cjApifI2zNgYKcSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE96IfUDlvSmJlVWpRPkxKmoNFSZz3
        52J1PyGB9MSS1OzU1ILUIpisDAeHkgTvhCygRsGi1PTUirTMnBKENBMHJ8hwHqDhCiA1vMUF
        ibnFmekQ+VOMuhw3Hl7/wyTEkpeflyolzlsGUiQAUpRRmgc3B5bGXjGKA70lzNsPUsUDTIFw
        k14BLWECWlLyfAPIkpJEhJRUA2N7qVxonuBtnqbZyr+3aU7gifKy/MFgNGP53E4J1+LH2btq
        TskFu67sS/5dLvLnqr5aSnX8fjb2o6LTFv41u10mFrDe5+KvaVY9tgnGGW1hyve3OOrcPdQ3
        xeBC7e4rYjp6T3dm/Hq54d/thwJMcYuNxJ+2cz+dvMouSXdT1A2BC8kxNXs371ViKc5INNRi
        LipOBAD8P2v2PgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2017 06:44 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> +	git for-each-ref $prefix >actual &&
>> +	grep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&
> 
> I added a squash for doing s/grep/test_i18n&/ here

Thanks for the fix. I always forget that gotcha.

> are there other
> issues in the series, or is the series more or less ready to be
> polished in 'next'?

I'm working on v2 right now.

Michael
