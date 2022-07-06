Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA55CCA473
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 05:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiGFFfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 01:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiGFFe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 01:34:59 -0400
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B220F20F55
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 22:34:57 -0700 (PDT)
Received: from bsmtp.bon.at (unknown [192.168.181.102])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4Ld7Xc0rmLz5tlW
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 07:34:56 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Ld7XW0VZyz5tlC;
        Wed,  6 Jul 2022 07:34:50 +0200 (CEST)
Message-ID: <b519375b-aa8e-1afe-cec1-2a849f7a3de5@kdbg.org>
Date:   Wed, 6 Jul 2022 07:34:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [External Mail]Re: Git fork process infinitely and never stop
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>
References: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>
 <8e1d019e-6456-ed05-7d3e-a0c4beeb35fa@gmail.com>
 <8ccd27ef3a344596b6237e98e1a5f204@xiaomi.com>
 <220706.86k08r9nmj.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <220706.86k08r9nmj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.07.22 um 00:50 schrieb Ævar Arnfjörð Bjarmason:
> The YouTube video shows that you're using various options to git-fetch,
> including filters, refspecs etc. Does a plain "git fetch" reproduce
> this, and if not what's the option (try adding them one at a time &
> experiment) that needs to be added to trigger this?
> 
> I somewhat suspect some --filter funny business, but that's just a
> hunch...

Hooks may also play a role.

-- Hannes
