Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE17C1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 17:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfFYRIM (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 13:08:12 -0400
Received: from avasout01.plus.net ([84.93.230.227]:56127 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfFYRIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 13:08:11 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id fovKhqaKOGPEvfovLhR9L1; Tue, 25 Jun 2019 18:08:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1561482490; bh=Xt0IgDWL4s2TYoaN5Yb5ZQJSruBGz90y2pdraiMuyEA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VMwwRG8J8Ss58IpFAIH/Ep+2sSg5mSQXxHnOiNGe15iLnDoUYgrIu0TSksV1Ij0Nr
         f1HV47Zt2KPMCzSG9PzDtSFCkdqRAz4pQMl7LDF7ZRf2Fj3Di+N3TiNvuKzr7hbps2
         PuaKpkfqWhmna3ckD91K/cbUvDcT5dFebH2bwPzCezBjZdDF2Tu2OwubCb2nf61bBz
         ma59q5i45GmE4cVxwIursBEOM68E1/cZ3VKeIVQzbigjHKgCHmUv6D8IgKF62OJifr
         7NAMZUmG5h8P1eei3DGNC+/i2gXdVWROl2ZV9aYa/nPVNTcAyTMakiqgjdpkK+Csut
         9XkaVjUfxmQDw==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=VJ+jYOHX c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Lj8eiQVQ7Me0eSzdBeQA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index in
 json
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet>
 <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1906251311280.44@tvgsbejvaqbjf.bet>
 <CACsJy8B9vd9YaP_FHN-EDEPc_OHgD=MtFu8WymM66PURWX=25Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1906251601240.44@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <27211d51-c77f-84f8-49c0-4bc104baa266@ramsayjones.plus.com>
Date:   Tue, 25 Jun 2019 18:08:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906251601240.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJk6u0aRSrQJavInIo5NxUDMqZ60Qo96wKR6g1wShsPuRTqiwdvXZ7h8QpYfA4UwP0rNtthUVxC0QXJBvmh4vHrLsYHBrZ/ah5N660QPOxsQKPd4FjX3
 rnxAnkzzFG4mmWsXtXZHa0ZOMqz6P3RGfBuS6IZSU4s6Milj385DYAcSdNcRnm0wrlD8eUzJavM2Ew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/06/2019 15:10, Johannes Schindelin wrote:
> Hi Duy,
[snip]

>> Again our experiences differ. Mine is mostly about extensions,
>> probably because I had to work on them more often. For normal entries
>> "ls-files --debug" gives you 99% what's in the index file already.
> 
> Like the device. And the ctime. And the file size. And the uid/gid. Is
> that what you mean?

Hmm, well I think so:

  $ git ls-files --debug git.c git-compat-util.h 
  git-compat-util.h
    ctime: 1561457278:502638001
    mtime: 1561457278:502638001
    dev: 2049	ino: 262663
    uid: 1000	gid: 1000
    size: 35440	flags: 0
  git.c
    ctime: 1561457278:518646000
    mtime: 1561457278:518646000
    dev: 2049	ino: 263083
    uid: 1000	gid: 1000
    size: 26837	flags: 0
  $ 

I have occasionally added stuff to the '--debug' output
while debugging something, but the above is usually
sufficient for my uses. (Having said that, I have not
had the need to debug extensions [yet!]).

ATB,
Ramsay Jones
