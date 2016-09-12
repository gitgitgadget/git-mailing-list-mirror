Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7F9207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbcILTmO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:42:14 -0400
Received: from mout.web.de ([212.227.15.3]:49925 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755129AbcILTmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:42:13 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MPJya-1bf9Ob2M7M-004VLM; Mon, 12 Sep 2016 21:42:09
 +0200
Subject: Re: Gitattributes file is not respected when switching between
 branches
To:     =?UTF-8?B?0JLQuNGC0LDQu9C40Lkg0JjRidC10L3QutC+?= <betalb@gmail.com>,
        git@vger.kernel.org
References: <CANYoZJng0GNZWU=eUEnXgVQ_NKQQOKM+mhJ9bsXMEJxxEhwQMw@mail.gmail.com>
 <8df2883f-ec3c-3446-2e06-207c93452332@web.de>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7c14756e-29f9-b475-f5f5-597acb8cea98@web.de>
Date:   Mon, 12 Sep 2016 21:42:08 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8df2883f-ec3c-3446-2e06-207c93452332@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SaYoZI1dE9zzBOJJxOPVbF+oJIaTGo5Ps9EsruLUPsGr3muyozI
 AElhgYnbZy6IiETpwhKEIKn3r42fG8eGqywBrkQu9WVe4ZDdVPtwGtPSwBczQZitqZgXvLF
 p0DqMzwyTbcgEjYgc0SMA7oHosFhUgpRT31HK9xvOUxI2/rW/v88NvcBsjRQ4PsOJEphv2U
 y0y8cfxmeQ6Vn5mHqD5VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ydmFffXvEWw=:y4bkMd31NJeJCuhFnKKJI6
 EY5Fnpa/UtG9sDIJz8XaiP8RnWMboKON0A/VKwqvsePU2zMBjLziyLcGgjksjEzYecNPOeOew
 YsEyATumi8shnUDwdLV07yxCpwSCUYMEyNnhzSD53iAaunAPJvmgEEUaNXOjO+bl/HbKzcI3b
 XkZviDxkkJphHVK7yV8RW/dnVyT22cVdc/IOT06oEEaafJgxyLsgMsjeMES8Kk8UWKOJ9u0Vt
 D2a4ofy2Ei1IQQimR++OiIcLu7cTLaMnxfBtiO1nN4WdTjZ8ZUOLw2iNpgbQsgyh2depeURCf
 MnCXyfoJidKvvyDwOQkk54N0nrpfpGEtxavM2PP+ugzXETUQ0mqvycybd4BKeCJXuAeu8rn1F
 O0xcQi5cdG99WwIx1jCfOseNZF2i70262+kpovKB5DqV293qOU3D8gs4nPfWANq6zD4XxcPoU
 swIllpXtId84EPZDH1nU2K97EQLtYZZakKnQfJKvK8RT9aXzAuDlMDx32fePNUPsaRORxI7pu
 Ua+6YPpjChDA8/n/VrNfmaHY1fvTVD7NynZzHZ9YglVRN8dV+81hkZKy9cI8UNkcyWw49BHIf
 982ZAx7wb0qjTLNZfaaVWKZM2Bqwhyz96EX+KWFc20jIQVufBikuXhzUnItiG65cJy8uhGUV3
 8DLWG4FwFyI/0eGaW2MUN0TP+f4wmtx0yw4DupJU5N/YpH6bzlLql1zynBHjLdffIyxauylLU
 6Xc2cE9uiYwo2OzTEwNxuutnyEka6g+siN0PuT5XToex1yBGEEKH/su9eG0fkPPf7GjD6PyiJ
 +4WgJfFVPICgKQHB0MFMlsPvtjvoT9WGTMn5s40TKIu1psQnwEQubTNEKkKJjNzJuZufCjgoe
 CwzYVcd8klnH/CzeICvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.09.16 21:35, Torsten Bögershausen wrote:
> On 12.09.16 14:55, Виталий Ищенко wrote:
>> Good day
>>
>> I faced following issue with gitattributes file (at least eol setting)
>> when was trying to force `lf` mode on windows.
>>
>> We have 2 branches: master & dev. With master set as HEAD in repository
>>
>> I've added `.gitattributes` with following content to `dev` branch
>>
>> ```
>> * text eol=lf
>> ```
>>
>> Now when you clone this repo on other machine and checkout dev branch,
>> eol setting is not respected.
>> As a workaround you can rm all files except .git folder and do hard reset.
>>
>> Issue is reproducible on windows & unix versions. Test repo can be
>> found on github
>> https://github.com/betalb/gitattributes-issue
>>
>> master branch - one file without gitattributes
>> feature-branch - .gitattributes added with eol=lf
>> unix-feature-branch - .gitattributes added with eol=crlf
>>
>> Thanks,
>> Vitalii
> Some more information may be needed, to help to debug.
>
> Which version of Git are you using ?
> What does
>
> git ls-files --eol
>
> say ?
Obs, All information was in the email.

tb@xxx:/tmp/gitattributes-issue> git ls-files --eol
i/lf    w/lf    attr/                   testfile-crlf.txt
tb@xxx:/tmp/gitattributes-issue> ls -al
total 8
drwxr-xr-x   4 tb    wheel  136 Sep 12 21:38 .
drwxrwxrwt  19 root  wheel  646 Sep 12 21:38 ..
drwxr-xr-x  13 tb    wheel  442 Sep 12 21:38 .git
-rw-r--r--   1 tb    wheel   60 Sep 12 21:38 testfile-crlf.txt
tb@xxx:/tmp/gitattributes-issue>

Could it be that you didn't commit the file ".gitattributes" ?
This could help:
git add .gitattributes && git commit -m "Add .gitattributes"







