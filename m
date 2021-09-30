Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBBC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 10:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E866101B
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 10:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350227AbhI3K6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:58:35 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:51916 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350206AbhI3K6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 06:58:35 -0400
Received: from [192.168.1.37] ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id Vtjrm0Y4JpJ6gVtjrmOiGc; Thu, 30 Sep 2021 11:56:32 +0100
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=PpntkDE3 c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=NEAV23lmAAAA:8
 a=kRrvSXaudNH05TikWGgA:9 a=QEXdDO2ut3YA:10
Subject: Re: Draft of Git Rev News edition 79
From:   Philip Oakley <philipoakley@iee.email>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAP8UFD1necFT_wSzuu3Ua+d7zxeBuurys=ubp0ocbNR+4H0Q6w@mail.gmail.com>
 <5973e00d-251f-101a-b3c6-34bc29e015e8@iee.email>
 <2882D89C-7CFF-4CCC-800A-B9A3E7533496@gmail.com>
 <617f428d-2453-36f3-6abd-dbc7859e2a0c@iee.email>
Message-ID: <598d6e48-f458-f135-7e3c-98f18aeb9705@iee.email>
Date:   Thu, 30 Sep 2021 11:56:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <617f428d-2453-36f3-6abd-dbc7859e2a0c@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFmagw8bjNbuady/TY2EiWyO6WxWIzm5NP/j1fmrqgXeyOwm4Z3XezjU6Z9hjgiQJTxjY97X0drPMbhRLumabx6H4V+KYgjrxonsMddUoSMvpRFf+tsf
 qT1OFqjlbiL94AmjFBjJ/9HGBtn5V60Gdh0gHXkDXUmSB+fou4m6FWb3WXDxyX0trId2q0dR2D7IODMQ8P97V6AxoZWF/0aqA6YsVrHwS1dL6tSuYo86rCr0
 IAgWGUwfHU5g6VSb2rb1HC4uCrvs9pRq8vy8vRRGmZtobJ/qKKasJwOcJAHh2Ow8B/9zfShoWqJhaMjAt2+GbLPms1k4BgoS/B213m0JX/hoRj+GqP4QbnCk
 TZN7jzSuW/wC8awcG9IsbTf0BDYi+fE66yH9RVrDmRMuz+mumcVBPdXxd5kTD5sCt6GZaLm+sxi8vWa47pBCMNJv8e6PtXhdB6AAUkLJqgE7DcK3HsQkCb/Y
 DO8Uz6lNke9OqYi0dKmq+Efw8H+5A5sx5GKwQgzH6/Ta3OLoF3eJ1jtfRc7oztBGfwLObudHYnU840J1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Took me three times around the dumb interface that didn't send the PR it
said..

I found that it had created a `Patch-N` branch in a fork of the repo in
my account (It appears I had one from a previous contribution).

Having found that Patch branch I have (again) asked for a PR which it
says is https://github.com/git/git.github.io/pull/523

Hopefully it works this time ;-)

P.

On 30/09/2021 11:43, Philip Oakley wrote:
> Maybe it's the Github interface :-(
>
> I edited the page on github, which said I didn't have direct edit
> permission, but would create sone intermediary (can't remember what
> exactly), and at the end it asked if I wanted to create a PR and I said
> yes (clicked the green button).
>
> Looks like it was a black hole of confusions.
>
> I'll have a quick look (via my account) to see if I can see what happened.
>
> Philip
>
> On 30/09/2021 10:37, Kaartic Sivaraam wrote:
>> Hi Philip,
>>
>>
>> On 29 September 2021 6:01:12 pm IST, Philip Oakley <philipoakley@iee.email> wrote:
>>> Added a couple of video links to the light reading. PR sent.
>>>
>> I'm trying to locate your PR at the following link but couldn't find it. Anything I missed? 
>>  https://github.com/git/git.github.io/pulls?q=is%3Apr
>>

