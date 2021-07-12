Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0752AC07E9A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21EA61151
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 13:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGLNFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:05:00 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:56214 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhGLNE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 09:04:59 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m2vZZ-000A2f-42; Mon, 12 Jul 2021 14:02:09 +0100
Subject: Re: [PATCH 00/19] [GSOC] cat-file: reuse ref-filter logic
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b6f661d6-d18f-9b26-da64-acad31b07188@iee.email>
Date:   Mon, 12 Jul 2021 14:02:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2021 12:46, ZheNing Hu via GitGitGadget wrote:
> This patch series make cat-file reuse ref-filter logic.
>
> Change from last version:
minor nit..
Not sure if this is a gitgitgadget feature, but would it be possible
that a version indication be included in future versions of the patch,
e.g. [PATCH vN 00/19] [GSOC] ?
--
Philip
