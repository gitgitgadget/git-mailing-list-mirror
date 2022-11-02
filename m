Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E4C43217
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 17:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiKBRa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiKBRab (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 13:30:31 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829032C655
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 10:30:29 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oqHZL-0006LA-EE;
        Wed, 02 Nov 2022 17:30:27 +0000
Message-ID: <83d3c28b-9b33-fa17-c0ca-85e790e52dad@iee.email>
Date:   Wed, 2 Nov 2022 17:30:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] Mention that password could be a personal access
 token.
Content-Language: en-GB
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
 <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com>
 <CAPig+cQ2Tqt8rzvXsRjCsPFTkbq7B06gq2pourKXi5dKNx8oAA@mail.gmail.com>
 <CAPc5daXmnkGpScihLpTPDXEFOAQF0vm-aWOpeym90X=tktLC2w@mail.gmail.com>
 <CAPig+cRy66HNfTnNQC4PcAaMR-m-DwUbdETsy0zBX4saG7F4Ng@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAPig+cRy66HNfTnNQC4PcAaMR-m-DwUbdETsy0zBX4saG7F4Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/11/2022 15:51, Eric Sunshine wrote:
> On Wed, Nov 2, 2022 at 11:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>> On Wed, Nov 2, 2022 at 3:55 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> How about a different approach, calling it a "secret" first, and then
>>> defining "secret" as different names for "password".
>> Or more directly, say "password" and parenthetically add that some hosting
>> sites may call it with different names like "personal tokens"?
> I tried the parenthetical approach first but the sentence structure
> became too complex and more difficult to understand. Having a separate
> sentence helped simplify. That said, perhap something like this?
>
>     Git will sometimes need credentials from the user in order to
>     perform operations; for example, it may need to ask for a username
>     and password in order to access a remote repository over HTTP.  In

Perhaps s/password/secret 'password'/ here 9above0, and then talk about
the names for that "secret" in the follow up sentence below.
>     place of a password, some sites may instead provide a passcode,
>     personal access token, OAuth access token, etc.  This manual...
--
Philip
