Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC5CC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCC42072E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgAFXcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:32:04 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:42102 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbgAFXcE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2020 18:32:04 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1iobqr-0002pS-TA; Tue, 07 Jan 2020 00:32:01 +0100
Subject: Re: Testsuite failures on ppc64, sparc64 and s390x (64-bit BE)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        git@vger.kernel.org
References: <34ed7497-643e-5a38-d68c-7c075b647bcd@physik.fu-berlin.de>
 <20200104205803.GE6570@camp.crustytoothpaste.net>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <2ce6a111-73ac-d8ac-e3a9-25286423535f@virtuell-zuhause.de>
Date:   Tue, 7 Jan 2020 00:31:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200104205803.GE6570@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1578353523;9138fafa;
X-HE-SMSGID: 1iobqr-0002pS-TA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.01.2020 21:58, brian m. carlson wrote:

> I got rid of my UltraSPARC hardware when I last moved, so I won't be
> looking into this further, but it seems unlikely to me that the problem
> is in Git when the only non-Windows C change between the two versions is
> a one-line file name change.
> 

Just in case someone is interested. Last year I've created a QEMU image
using MIPS big-endian hardware [1]. It is still on debian stretch and
like **slow** but does not require additional hardware.

[1]: https://github.com/t-b/debian-mips-qemu
