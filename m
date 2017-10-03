Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8FED2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 19:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdJCTT6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 15:19:58 -0400
Received: from mout.web.de ([212.227.15.14]:54374 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdJCTT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 15:19:57 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0yvn-1dAwg03N2F-00v7ld; Tue, 03
 Oct 2017 21:19:55 +0200
Subject: Re: Line ending normalization doesn't work as expected
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
 <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
Date:   Tue, 3 Oct 2017 21:19:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:OFxaSrWfTOoEbh2K8CN2MEAKHoS7rG7oCCxrU7hYisi5c8s9YEf
 dZw+9ENPo01j63O6QPmFPvv8jl1rxlcLfuh7KJ8V5u610sjGlB304cPxQuXKMxgdjaQEKmF
 RqMMTeCthvD1KS5+Y4ymxB3X05lzBAL6MnjR5TGL5o/NRmZZhv8UrUtAtoqpZRTw+FaX6Ck
 9mYcR3mXieHkBFiv/LZZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9uuh5AqdXGU=:EmiUJSx7odiVtacDHXxDCG
 IH8htNz+EmO/EM9wSWdsPtj0FMyAtRR9vsM8/a4dF+vfw+BsH0j+gnpi+80ZPMDEjIOxeu6hF
 LpxEXG2dORcvCxhjpNpM8Y9RfwPLGW82dvtmRqvCJOeWs3FK+/k80wrIKcev6DkcaEE9LfyMt
 nleBr7I6k/jyFwqeWnXBlckXXowSzFn/AdvOnI1HhoEdlmektnis4dvSTuqK8hNKQNC5EZotV
 jqHVXJciRB5ZUW75q+57Mvxp9Dxd9H21LBDr+z2C6LFqVx/mqb/H8Usn5OsKWmfCibiHrrIg9
 dE87IPSMfBxBgdiVhMLClhE10ep6iENVqkvfRITlIdR1Z3SuLA8rYu5tOjfhFNnxsQRnmAu7l
 1IOmvEP3a1NvwlHpquPBAhr3JkXsE6ccqsEVUziekJY+xOKWWQJr5A7p0pfhYed7Fa82f0iV6
 2482uYWkOpLpH3vTtNhBx3Gqm7ZAGmSYXElq7ZMxUov2jylG+YIORdUcooP7Zpt/HzIxlM/uH
 PoEO5rZC6EmLFSMWiEXAWO0KSuAuShqdSik7zUQWwTtcrmOAm1IUzEv7h2NR1lKVoT+RLMgwL
 DQA+u0MZqi7HnP7hUReHieX+wbSiHJg8Bo5Dj0Fij1z2Nmz9hWCKnrBVkCzRz+C0hsD+8tWih
 R+O4xTb8WqV14bF4GlDznNjm2lQyAAXMDidFmKBxtBgR6TGrX1Mib6uLsoSaGn0u8/gj4kZsO
 /aGyAqz9LV5lWc96ARi15Acpu6zCZZATvvaQZQdfYwoFQCWFCAvLsj757g9CHnQap+24TKqz1
 87f+qpWW4ZpeMFfs1OQembcXvOvVkxTsFDMAmx60vhTVh+iw3E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-10-03 19:23, Robert Dailey wrote:
> On Tue, Oct 3, 2017 at 11:26 AM, Torsten Bögershausen <tboegi@web.de> wrote:
>> The short version is, that the instructions on Github are outdated.
>> This is the official procedure (since 2016, Git v2.12 or so)
>> But it should work even with older version of Git.
>>
>> $ echo "* text=auto" >.gitattributes
>> $ git read-tree --empty   # Clean index, force re-scan of working directory
>> $ git add .
>> $ git status        # Show files that will be normalized
>> $ git commit -m "Introduce end-of-line normalization"
> 
> Is the way I did it that worked also a valid solution? Or did it only
> work accidentally? Again the command I ran that worked is:
> 
> $ git rm -r --cached . && git add .

(Both should work)

To be honest, from the documentation, I can't figure out the difference between
$ git read-tree --empty
and
$ git rm -r --cached .

Does anybody remember the discussion, why we ended up with read-tree ?
