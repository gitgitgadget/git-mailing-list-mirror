Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955F8C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 10:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJEKQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJEKQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 06:16:34 -0400
X-Greylist: delayed 2235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Oct 2022 03:16:33 PDT
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B8192B3
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 03:16:32 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1og0ry-0007K3-2g; Wed, 05 Oct 2022 11:39:14 +0200
Message-ID: <c8d43514-6f78-387c-b5aa-0657c75d5b4e@virtuell-zuhause.de>
Date:   Wed, 5 Oct 2022 11:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [ANNOUNCE] Git v2.38.0
Content-Language: en-US
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqqmtacu8bw.fsf@gitster.g>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
In-Reply-To: <xmqqmtacu8bw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1664964993;bf246380;
X-HE-SMSGID: 1og0ry-0007K3-2g
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.10.2022 19:26, Junio C Hamano wrote:

Hi Junio and Ævar,

the last git release has

> submodule--helper: remove unused "list" helper

in the shortlog which is 31955475 (submodule--helper: remove unused 
"list" helper, 2022-09-01).

Now the inevitable "I'm using this in production since 5 years and now 
it's broken" has happened.

Just for the record "git submodule status" is a good replacement for my 
case. I happen to need it on Windows using a CMD shell.

Is there a general rule that commands which have "--helper" in them 
should not be relied on?

Thomas

