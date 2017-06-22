Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB0720802
	for <e@80x24.org>; Thu, 22 Jun 2017 23:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbdFVXKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 19:10:03 -0400
Received: from avasout07.plus.net ([84.93.230.235]:33813 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdFVXKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 19:10:02 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id bz9z1v00A1keHif01zA0Ln; Fri, 23 Jun 2017 00:10:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=F8YDbKMSAFdSzxIyTmAA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/3] t1301: move movebits() to test-lib-functions.sh
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
 <20170622190158.13265-2-chriscool@tuxfamily.org>
 <xmqq4lv7kdfa.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <455cbce5-97eb-2fdc-6e38-b4feb4daaa6e@ramsayjones.plus.com>
Date:   Fri, 23 Jun 2017 00:09:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqq4lv7kdfa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/06/17 20:52, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> As the movebits() function can be useful outside t1301,
>> let's move it into test-lib-functions.sh, and while at
>> it let's rename it test_movebits().
> 
> Good thinking, especially on the renaming.

Err, except for the commit message! :-D

Both the commit message subject and the commit message body
refer to _move_bits() rather than _mode_bits() etc.
(So, three instances of s/move/mode/).

ATB,
Ramsay Jones


