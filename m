Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8206EC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 08:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370E961968
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 08:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhC1I4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 04:56:44 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:26294 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhC1I4j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 04:56:39 -0400
X-Greylist: delayed 33023 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Mar 2021 04:56:39 EDT
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4F7V1j0sgGz5tlB;
        Sun, 28 Mar 2021 10:56:24 +0200 (CEST)
Subject: Re: [PATCH 4/5] fsck: improve the error on invalid object types
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
 <patch-4.6-d23fb5cd039-20210328T025618Z-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <20ba35a4-6510-1a48-2ce6-5022e96926bd@kdbg.org>
Date:   Sun, 28 Mar 2021 10:56:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <patch-4.6-d23fb5cd039-20210328T025618Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A note on the subject line: we are all pretty sure that you want to
improve the code, not disimprove it. Therefore, the word "improve"
carries not meaning and only takes away space that could be used better.
Perhaps

   fsck: report invalid types recorded in objects

or something. Ditto for 5/5.

-- Hannes
