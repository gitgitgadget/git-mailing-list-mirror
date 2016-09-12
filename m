Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EC66207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932538AbcILTfY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:35:24 -0400
Received: from mout.web.de ([212.227.15.4]:61708 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbcILTfT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:35:19 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LiFT1-1bE5va0zJb-00nQeH; Mon, 12 Sep 2016 21:35:17
 +0200
Subject: Re: Gitattributes file is not respected when switching between
 branches
To:     =?UTF-8?B?0JLQuNGC0LDQu9C40Lkg0JjRidC10L3QutC+?= <betalb@gmail.com>,
        git@vger.kernel.org
References: <CANYoZJng0GNZWU=eUEnXgVQ_NKQQOKM+mhJ9bsXMEJxxEhwQMw@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <8df2883f-ec3c-3446-2e06-207c93452332@web.de>
Date:   Mon, 12 Sep 2016 21:35:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CANYoZJng0GNZWU=eUEnXgVQ_NKQQOKM+mhJ9bsXMEJxxEhwQMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:a5IfSzqlXJ/uaRzU+sUFGvsmcMJUHD+AakmGg+2zmKSSjWoUHK7
 XscMcagQ6lCfWbavRyBApAGY6D035SwtnT8rIoPjNSnPpRzLd2Lr/bObYJEIINdA8MDsZjM
 OzGFHug5Zp5zaGTWWb7FO4AXaAnJ89JCgEWy+IJsEpaV7HeSDQWyTGBLyY1a1ySAbexAs5N
 iw+ke38Inqgt9niwKLspQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zxZ19rIAEcs=:PeUlaI0b5hrFHV8Lk990ca
 wO7WN4Thf58Ai49D3q/zvd+PRitEEq3iVOjf/1zPb0PsPqTSegY6C3y8rznK+o9y9nsDB79oI
 4UiOm9M91EH3iPhGWbvYlMCzBpV2BdxnsihZe/Fdl6gR72SJGx61DEsGlyqJOv+ObpINoct3D
 ThFyBzlQHgzWL8/CTqOTrBXde1T024J9NHamfIyWGln4g5gILVCcHgz7a5A7ZyokRP0UPg/Wl
 p94oW9XSfmCUlYKPmGX4pt2VhWSoF/yoWMNFzwiCm82biUS4/bBSPsg8cVD+VnUN4ExiiepIK
 BGkkI8Hnj4yJVICIU3ZMVfQnaYmN6NpDSzTcD1DNRCd1hl+NA+dsC9uhZ5k44bduzHuFfirPi
 RwSH3OIDasUsugzp1GwWUuI8g/jwcnc3NMg0TpYZDOwiFa3pyE0fw9b7/o0MmGn6CaGhZsPGa
 z6AhctctKSEFrjdBIzCFUh0K0qzOjkHjErxio5pG7qfRMEHQVI6MeMx6EyHTG+EedF8bWito3
 xvSOK2cb5fDS+ZMKGWDm4UEKfY2b85pq1y33W36WYTrKBgLkReB2+LaUJiboQ6ZgCTZEuq2og
 fb3Gt7PYjekruAGRhbN50pOJKGu8hOt55OQO0hTmeMI5+M5VHeFsvzzd+rnmw3M2CaQ04II41
 UH493wotsmYT3Qr4AHDzP7W9CYOsBwpLnwB7QX2TVQw4feIRwvW9c+rSkN2FRODMadxSekCc0
 jY7KeCSTLEQZNdNJEjP/AxWczD27Q/FFuwaLLFfTE7kMI7S37DQW6N1SYq2418dV7FeQmCpIm
 5CosWLR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.09.16 14:55, Виталий Ищенко wrote:
> Good day
>
> I faced following issue with gitattributes file (at least eol setting)
> when was trying to force `lf` mode on windows.
>
> We have 2 branches: master & dev. With master set as HEAD in repository
>
> I've added `.gitattributes` with following content to `dev` branch
>
> ```
> * text eol=lf
> ```
>
> Now when you clone this repo on other machine and checkout dev branch,
> eol setting is not respected.
> As a workaround you can rm all files except .git folder and do hard reset.
>
> Issue is reproducible on windows & unix versions. Test repo can be
> found on github
> https://github.com/betalb/gitattributes-issue
>
> master branch - one file without gitattributes
> feature-branch - .gitattributes added with eol=lf
> unix-feature-branch - .gitattributes added with eol=crlf
>
> Thanks,
> Vitalii
Some more information may be needed, to help to debug.

Which version of Git are you using ?
What does

git ls-files --eol

say ?


