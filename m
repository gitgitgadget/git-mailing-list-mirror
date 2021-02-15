Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF8C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE9B64E16
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBOUDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 15:03:34 -0500
Received: from [93.83.142.38] ([93.83.142.38]:47540 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229802AbhBOUDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 15:03:33 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 7E1031B285;
        Mon, 15 Feb 2021 21:03:11 +0100 (CET)
Subject: Re: [PATCH v2 00/27] userdiff: refactor + test + doc + misc
 improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-1-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <177512df-77a1-6d3a-929f-4422665405a8@kdbg.org>
Date:   Mon, 15 Feb 2021 21:03:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
> Incorporates all the feedback on v2 and more, see the range-diff
> below.

I've read through all patches and left a few comments.

My main critique is that the new way to specify test cases is not an 
improvement because the code is hard to parse. The  desire to improve 
test precision moves the balance too far away from the simplicity to add 
new test cases, IMO.

I appreciate the new test cases for ADA and Ruby as well as the 
discovery and fixes of the many small deficiencies.

-- Hannes
