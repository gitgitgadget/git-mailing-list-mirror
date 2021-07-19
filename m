Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA5C64980
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB9661166
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441811AbhGSW0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:26:31 -0400
Received: from siwi.pair.com ([209.68.5.199]:43742 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1391830AbhGSWE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 18:04:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 392A13F413A;
        Mon, 19 Jul 2021 18:35:34 -0400 (EDT)
Received: from SME-RED-HCI8.sme.test.net (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D57293F4104;
        Mon, 19 Jul 2021 18:35:33 -0400 (EDT)
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
To:     Eric Wong <e@80x24.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
 <87k0m9bpmv.fsf@evledraar.gmail.com>
 <b19f3f2a-049f-acf2-f59e-de705dc54307@jeffhostetler.com>
 <87mtqq2i3r.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161754180.59@tvgsbejvaqbjf.bet>
 <874kcuxkz8.fsf@evledraar.gmail.com> <20210717124535.GB16801@dcvr>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d2936252-50d7-7b3f-4707-7c07b17a09f3@jeffhostetler.com>
Date:   Mon, 19 Jul 2021 18:35:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210717124535.GB16801@dcvr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/17/21 8:45 AM, Eric Wong wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> On Fri, Jul 16 2021, Johannes Schindelin wrote:
>>> Hi Ævar,
>>>
>>> On Tue, 13 Jul 2021, Ævar Arnfjörð Bjarmason wrote:
>>>
>>>>
>>>> On Tue, Jul 13 2021, Jeff Hostetler wrote:
>>>>
>>>>> On 7/1/21 7:02 PM, Ævar Arnfjörð Bjarmason wrote:
>>>>>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>>>>>
>>>>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>>>>
...

Eric, welcome to the conversation and thanks for sharing your concerns.


For my upcoming V4 I've shortened the filenames of the various backends,
renamed the -macos one to -darwin, and shortened the names of the
fsm-listener API, and the names of those static functions associated
with starting the daemon in the background.

I think this covers all of the issues raised across several
patches in the series.

Jeff
