Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2DB1F51C
	for <e@80x24.org>; Fri, 18 May 2018 15:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeERPEA (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 11:04:00 -0400
Received: from mout.web.de ([217.72.192.78]:47501 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbeERPD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 11:03:59 -0400
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LeLKb-1eU6t60ag1-00qCkc; Fri, 18
 May 2018 17:03:57 +0200
Subject: Re: git diff: meaning of ^M at line ends ?
To:     =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>,
        git@vger.kernel.org
References: <6c23ed9e-4a14-12e4-20ca-3ac6f80cf9ec@googlemail.com>
 <8d7e4807-9a79-e357-8265-95f22ab716e0@web.de>
 <ec5c536a-708a-1fd2-6ee2-98271b90b0fb@googlemail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <a6b95cc0-0676-930e-9a42-325688d24675@web.de>
Date:   Fri, 18 May 2018 17:03:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ec5c536a-708a-1fd2-6ee2-98271b90b0fb@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sZP7IB5QrNMVVLEXgBfqq0tNEfZz5vH3CsV1czl2cRg+O6wV/Mc
 cZhsTX0g4ZIhvl/lQfsvb0/p8q7p46xk0/HkcMd8Tw5EuigF517ty5f6YEiYfXaBRkp5zXo
 DssJLJzVkYitsnwvmsxZdBHLarlKiYk3sgVAtzOchdySMsVUj7CQxa8uLezXWTduhhM0I2y
 4JCgHHIUwa6M5mT42DcCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tFXFs36XwvY=:ycSJXtw/du785A/Egg5wfC
 JoC5JA8eBJ/KGFNjYUG3Fs0txjl0zMvYlFB6wzlretw56Qo8R0v7YZmFliuPzdI0iDnAikvlk
 Ohicc1cJbPyFDktAo9P76FwT48ayXqk1JS3ZDyS5KYcbRLB/U7iPW1dWiPEURUCM/7I43ZuFI
 Nj65PWuIX4GPiSe9TXfDsQ4Mx9KZy93D9rtHzc++AR2WUWqfnmA2uga0LErfuRRe3OdrV394V
 Xmerc98I9UoXcIDUZ0qeMJ8dJcxfB6Bz/FLfilbx33PxELdVRvnSbXtEULL91s/PyuUcUUmJR
 xQ35ZGC2Jg9stWSSPDxAYvR0S96OAzTZ8waJ7jODCC8HyySLqX5KbHd74Yk27OyqmpoXR9I2y
 PSFCPJkmlhWPuz4pOJoG3ihaplHe2Rqm5EWMnRYwV/EePcDKyJAeMvtpn8P+wvNkrABCprMwt
 QRJdUvPfpCqvQobPQ1ui6T4Yx0EZQuA4nxefufquK2Fp6LAWaV5ql2eg3NiUXG/G+PMHWZwy5
 sF7Lg+30kbeX3dYeGTCs+ASkTMg82vaaBw9npKpRTXftQA+MWDlA0QROK3wFuFf3IvDnWZzwd
 gDfmEgRv4qdrgaTdNYWoLmNFfMgPTJkFVwKY6LvQkmzAZb9tPMX7IjVYLCOct2+t1ZW7WGK6W
 2JADuf74BsD40AyQ50QL6eE3Sfm3AcJEbyW5VJ4hR9vIT3yzXBLqfyYKMMET91AnDxdg42wNF
 cIADXsRHunxu7sjgd722riK1C6QBYZ763Y5P6VU5f9BGI/cxH9qiQQK/LkVMythSeATjVH9b3
 INx5q8G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.05.18 20:04, Frank Schäfer wrote:
> Am 14.05.2018 um 20:13 schrieb Torsten Bögershausen:
>> ^M is the representation of a "Carriage Return" or CR.
>> Under Linux/Unix/Mac OS X a line is terminated with a single
>> "line feed", LF.
>>
>> Windows typically uses CRLF at the end of the line.
>> "git diff" uses the LF to detect the end of line,
>> leaving the CR alone.
>>
>> Nothing to worry about.
> Thanks, I already suspected something like that.
> Has this behavior been changed/added recently ?

That is a good question.
There is, to my knowledge, no intentional change.

> I didn't observe it before, although the project I'm currently looking
> into has always been using CR+LF...

Do you mean that older versions did behave differently ?
Do you have a version number for the "old" handling ?

> 
> Why does the ^M only show up in '+' lines ?
> When changing the line end from CR+LF to LF, the diff looks like this:

> 
> -blahblah
> +blahblah
> 
> But I would expect it to be
> 
> -blahblah^M
> +blahblah

May be this helps (I haven't tested it) ?
git config  core.whitespace cr-at-eol

