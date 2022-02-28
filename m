Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89157C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiB1SKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241693AbiB1SKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:10:15 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4485ABD2D9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:50:27 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4D75D3F47EF;
        Mon, 28 Feb 2022 12:49:59 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EC56E3F4162;
        Mon, 28 Feb 2022 12:49:58 -0500 (EST)
Subject: Re: [PATCH v5 23/30] t/helper/test-chmtime: skip directories on
 Windows
To:     Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <6cba1d950b013410ecc6ffc15bfcba02c51d6de2.1644612979.git.gitgitgadget@gmail.com>
 <CAPMMpogycjDdoFR2kzLypb48LSQW_vU=yaeaMKdM1Thd+J3DUg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <73a47838-2f9e-dccb-9aaf-6eb143906d36@jeffhostetler.com>
Date:   Mon, 28 Feb 2022 12:49:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPMMpogycjDdoFR2kzLypb48LSQW_vU=yaeaMKdM1Thd+J3DUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/28/22 4:43 AM, Tao Klerks wrote:
> Random follow-up on this: in message/patch
> 76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com
> I propose a fix to this issue. If accepted, that fix (and related
> changes to rely
> more heavily on chmtime in t7063) will cause *this* change to cause test
> failures.
> 
> If that patch is accepted, this commit will simply need to be dropped
> as far as I understand.
> 

Thanks for the note.  Yes, with your change we should be able to
drop or revert this commit.

Thanks
Jeff

