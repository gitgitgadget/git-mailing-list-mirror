Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45259C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 18:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1279120692
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 18:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eEvc8y9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLHSog (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:44:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:56417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfLHSof (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 13:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575830673;
        bh=u6oPQwWudmg9DBpJ7i/qbX0CIJqC+GUU8OL++G07tOM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=eEvc8y9zy0vV1hdxjMaDm4+FHhIi8Y4FWnsySSxlJVdYNTi5kMU6YesvuCyR90qYX
         0NLaiWG3KBxwoJoPJAEcNxXmYqZJhqFIgnzgkTFVQm2c2WrF4iFfKr8JOY57fihyCY
         KXVknZyOn9rRA3pSODtthAFReVarFN50mGeKr2Og=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.32] ([87.180.190.85]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V4J-1hbVuA0l95-013xTN; Sun, 08
 Dec 2019 19:44:33 +0100
Subject: Re: Git as data archive
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
References: <21fcdc5f-955a-e027-0d71-15f476f6162c@gmx.de>
 <60945f9c-d79c-7806-0c5e-3e2affcea001@iee.email>
 <1c81112d-5a1b-a791-b43f-d6a67d5b2e04@virtuell-zuhause.de>
From:   Andreas Kalz <andreas-kalz@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Message-ID: <76f7d2f5-45fe-a43f-2121-954e1a497b4f@gmx.de>
Date:   Sun, 8 Dec 2019 19:44:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1c81112d-5a1b-a791-b43f-d6a67d5b2e04@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VlHstonrP4VpYhy2NLKioy5g23P5CAi2Pi4pch9ikLl4PDSCKHR
 hVNgqqUYZTVo1OemSmuiiKI6mBc8sAY0uBLG86rb76N1PI854lsL3PKhs9ARQ2bJeH2ZH9e
 F9XcQlnAh29Y3VL+IivyxdvEblZ6AXPNNX/VRoXujv+lpWUBndhxZ4qI9/28dr7ShDbgyHY
 /DBz5L508lp5BImyQIsTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ksTPouF8cKU=:dOgV3hpd9xsuL1wiNHAUat
 WueP8nGDleCtJl2fO+Q3TpVrc8sfQiPgka7KCPF8A5TV8wunIDun67XA5sXwMWemRuTNKtBaU
 XGjz4Tylw3p3c1d6WWfihbwybcRJnRfq/3XQlL8mcEdKSrdj0o7XEKWnroYQuwChw2BHn+EYl
 +dVHe3JotN1wK1B5FyZJ1Wed4U9VF0t88hBmEtNOZHh8QsxQAc9BKhPjJGfkzuU2cjZgEDS4w
 n8jdxbg+75P+fY8U55lXmk8R6fMnqsUKvsotsLsA7e5bD/av/6SJ9iag7/HrjObOvvEznMPtt
 8cDe1yCCn3xEAn7SRei6CLGpWibNAixUbyWpSeoyma2K86QeRRQKe6RJpcQsdSOCFNCRe0QV+
 28K7wZdwYoCGiK/1cLPRhO+FvdQUOZ22UYV8eJx5ywJxRnBKOg75xBTe413RadiTjQHs8IW5s
 NP+X+sFVupr7KV2XyCrfwXR2fEoBof9ByLqwW3ESl90H3G2lvrgbOwKYF2thqL6lcyaOzNqW+
 MKs+lzzYeKVmK4ApwiuWdEaN76zG8wCCdtmK6TAVVPqnMuWfP2z70pC7U+xKgu+TjJDWO4QsO
 JZmBN2hFX61yQ2PHh1YAHBihMAj79tCR7fiLGBWIRMwHiVMk6/TsCbhFqPmmPpONKAcmC99Sw
 ko4d7s8ETsEzh0UFJLSzEpVaGyROR2yVLzKAtrtm6Hx7Cx9GsFrZoWdNrg3okELr5hl3Q2alu
 8Zx/sJ8eufdJVYgcM6nQH7GggFWfTwD1Clh3LmrPXYA7utw+4OZ0C+D1XJq34pRs0aHPnFI4r
 +MNynW35ZZeZCHsXwdq9r82bCmPjPJrpBkZ8oR1zzHw+bkyPc3DhkDe3oLDOcHGqmboSdkPop
 gqOZPndEuaLkHXpJLKl+j2CFn208nnoAjuvjYtpYd34ZqB0gbKg3PW2mnrvkfVw8aKvrwYnU2
 V5H6D6bva3i0ciwk08cM9ZmG6MyUlrUdBn9uPJrKgvGVgB/ZbC7T81xnRE1aRUcXEiabujX8y
 bPcMy5xlcS6sKE0tpd3Jzxu2+fSBguhgCuz3ShtdAIFWdzO2CMbIIvO2i00Q1FAAw7X1fZOw3
 vry5PxbSISQ4H1mAr+JaEumEsNSFn6ftBS2VX5IN288NY7tZtzEYadf7bUQj8AXqGdomzTiyd
 MLN2pupuyOBRQywim98+8gvuR4qE5Yz3jl3AY7VpXLKTjtzFrYIJroFrPnQc/d9hCuu+tTES6
 gZyyWK4OIO2qAmFprXSJvRKMd88YFUFrT+bce3XSQ/r/UIkFqGqd3hPfEDB4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

thanks to you both.

@Thomas: are you Thomas Braun who studied at FH Regensburg?

Well, currently the .git repository is 715GB and the maximum file size
is 9.5GB, but I did not get error messages due to that even if the
performance is quite low. The biggest pack* file is 24GB. There are some
files which are modified, but most are not modified.

My question came up as I did not find a documentation about limits of
git, only a lot of entries about github and forum users who are
discussing about old bugs of git. I read about git-lfs and also that it
is not working very stable, due to that I did not use it yet.

How can the delta compression settings and/or the big filethreshold
limits be modified?
Thanks in advance.

All the best,
Andreas


Am 07.12.2019 um 19:04 schrieb Thomas Braun:
> On 07.12.2019 17:54, Philip Oakley wrote:
>> Hi Andreas,
>>
>> On 06/12/2019 18:54, Andreas Kalz wrote:
>>> Hello,
>>> I am using git as archive and versioning also for photos. Apart from
>>> performance issues, I wanted to ask if there are hard limits and
>>> configurable limits (how to configure?) for maximum single file size a=
nd
>>> maximum .git archive size (Windows 64 Bit system)?
>>> Thanks in advance for your answer.
>>> All the best,
>>> Andreas
>> On Git the file size is currently limited to size of `long`, rather tha=
n
>> `size_t`. Hence on Git-for Windows the size limit is 32bit ~4GiB
>>
>> Any change will be a big change as it ripples through many places in th=
e
>> code base and, for some, will feel 'wrong'. I did some work [1-4] on to=
p
>> of those of many others that was almost there, but...
> Adding to what Philip said. On Windows the size of exported archives
> (git archive) is currently also limited to 4GB. The reason being also
> the long vs size_t issue (which is not present on linux though).
>
> So if you can switch to Linux or even MacOSX these issues are gone.
>
> The number of files in .git, only the number packfiles would be of
> interest here I guess, do not have the long vs size_t issue. So
> packfiles can be larger than 4GB on 64bit Windows (with 64bit git of
> course).
>
> But depending on how large the biggest files are, it might be worth
> tweaking some of the settings, so that the created packfiles are
> readable on all platforms. I once created a repo on linux which could
> not be checked on windows, and that is a bit annoying.
>
> So the questions are how large is each file? And what repository size do
> you expect? Are we talking about 20MB files and 10GB repository? Or a
> factor 100 more? And are you just adding files or are you modifying the
> added files? Depending on the file sizes it might then also be
> beneficial to tweak the delta compression settings and/or the big file
> threshold limits.
>
> Thomas
>
>> The alternative is git-lfs, which I don't personally use (see [4]).
>>
>> Philip
>>
>> [1] https://github.com/git-for-windows/git/pull/2179
>> [2] https://github.com/gitgitgadget/git/pull/115
>> [3] https://github.com/git-for-windows/git/issues/1063
>> [4] https://github.com/git-lfs/git-lfs/issues/2434
>>
>>

