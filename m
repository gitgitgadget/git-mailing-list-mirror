Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E8FC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6D9610CC
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 17:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGVQUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 12:20:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:16363 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234575AbhGVQTX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 12:19:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1B5C93F410A;
        Thu, 22 Jul 2021 12:59:56 -0400 (EDT)
Received: from SME-RED-HCI8.sme.test.net (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C67583F4103;
        Thu, 22 Jul 2021 12:59:55 -0400 (EDT)
Subject: Re: [PATCH v6 0/2] tr2: log parent process name
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20210722012707.205776-1-emilyshaffer@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b69a9434-a5c0-d7f2-75f0-c4af518229bf@jeffhostetler.com>
Date:   Thu, 22 Jul 2021 12:59:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210722012707.205776-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/21/21 9:27 PM, Emily Shaffer wrote:
> Since v5, I reshuffled some of the platform-specific compilation recipe
> around per Jeff H's comments on v5. I think these are at odds with
> Ævar's comments, though, so I guess let's take a look and see how
> strongly we feel? :)
> 
> Otherwise I also made the logic inversion Junio suggested to make the
> logic easier to follow in procinfo.c:trace2_collect_process_info.
> 
> Thanks,
>   - Emily
...

LGTM

Thanks,
Jeff

