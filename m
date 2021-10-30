Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01684C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81BD60EB8
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 19:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhJ3Tbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 15:31:50 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13721 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhJ3Tbt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 15:31:49 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mgu2X-000AT1-9K; Sat, 30 Oct 2021 20:29:18 +0100
Message-ID: <d42213c8-c07c-eedf-6011-bc5d9996a419@iee.email>
Date:   Sat, 30 Oct 2021 20:29:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 0/8] Allow clean/smudge filters to handle huge files in
 the LLP64 data model
Content-Language: en-GB
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Johannes Schindelin <johannes.schindelin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
 <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <xmqqk0hvllxp.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2110292239170.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110292311200.56@tvgsbejvaqbjf.bet>
 <ae900419-39ca-10f6-8ff2-d278f1b8e2e0@iee.email>
 <20211030173547.fse5iuq7omvfalke@tb-raspi4>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20211030173547.fse5iuq7omvfalke@tb-raspi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,
On 30/10/2021 18:35, Torsten Bögershausen wrote:
> On Sat, Oct 30, 2021 at 04:16:31PM +0100, Philip Oakley wrote:
>> On 29/10/2021 22:12, Johannes Schindelin wrote:
>>> I am not aware of any other popular platform using the LLP64 data model,
>>> therefore I do not even think that these patches have to be fast-tracked
>>> into Git v2.34.0, next cycle would be good enough. Unless you are aware of
>>> other such platforms that do not rely on the Git for Windows fork, but on
>>> Git built from your repository?
>> I was under the impression that the original Raspberry Pi also used the
>> LLP64 model, or similar, and that had started of Torsten (tboegi) on the
>> extensive early work on this. I was just looking at the zlib parts
>> following the Git Merge.
>>
>> Torsten was compiling for Rasbian (gcc (Raspbian 6.3.0-18+rpi1+deb9u1)
>> 6.3.0 20170516)
>>
>> Philip
> The raspi does not use LLP64.
> However, the gcc from above did warn about a long - size_t mixup.
> Even if both are 32 bit.
Thanks for the clarification. Looks like I'd misinterpreted what you'd
said at the time.
--
Philip
