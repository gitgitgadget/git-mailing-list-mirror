Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473BC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CF8611F2
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhKDQLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:11:35 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:46405 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhKDQLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 12:11:35 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mibnE-0001Sk-67; Thu, 04 Nov 2021 12:24:33 +0000
Message-ID: <36140d50-be1f-669f-999b-4ee2314200bf@iee.email>
Date:   Thu, 4 Nov 2021 12:24:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 5/8] odb: teach read_blob_entry to use size_t
Content-Language: en-GB
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Matt Cooper <vtbassmatt@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
 <308a8f2a3ade63ef21feb945e45866f2a83ae101.1635867971.git.gitgitgadget@gmail.com>
 <20211102204040.nnndsqrzu7ozpva7@tb-raspi4>
 <nycvar.QRO.7.76.6.2111040102560.56@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <nycvar.QRO.7.76.6.2111040102560.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11/2021 00:09, Johannes Schindelin wrote:
> I would say that in the context of talking about a signature, "expect" is
> a better verb than "use".
>
> But then, just like you I am not a native speaker, so I think we should
> maybe stop telling a native speaker like Matt how to use his native
> tongue...
>
>> (I am not a native English speaker, would "changing" be better than "altering" ?)
>>  By changing the signature of read_blob_entry to use size_t,
> As I said, I am not a native English speaker, either. So I believe that
> Matt knows better than the two of us together how to phrase things in
> English.
Being a native speaker can be a bit of a Catch 22, especially in
English, as we can use unusual idioms and find them normal, and often
weren't taught 'grammar'.

It is important that the text is understandable to those for whom
English isn't their first language. At least we don't have to use
simplified English [e.g. 1,2]

Philip

[1] https://en.wikipedia.org/wiki/Simplified_Technical_English
[2]
https://www.boeing.com/company/key-orgs/licensing/simplified-english-checker.page
(not actually used;-)


