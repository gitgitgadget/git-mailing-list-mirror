Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44654C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 16:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDNQHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNQH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 12:07:29 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F949D7
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1681488445; i=l.s.r@web.de;
        bh=vcY2eHZcKiaURAFUgYYgCuH5JhOm97g86dHrxlhHoXc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
        b=krLVRyKbn9sBQQCGm3HkAxLG2bgQi6WB+6XPj9HGuTMM8XWpmEDVSxHHZ3C8qdrXl
         G9sXzy0uOTqQ/HyrXYiuaEqndu5DKtDsaRdx/O3+/8YZYQXPOUUGOYeOQnJUOyD7ua
         RHwCIgchhvfEFQHND51u6t429mHrPWp5MuseeyTLkb6kwnvXkE9Kkr+2/pCELJsCEa
         HlFnVXVAtY0Y+WpDwYyRK/uEg2Is5cmnG7M3yVJ5aRJlO0W2QmK2MxyjSr9ySUd/pP
         0m6MjjJoDT0jj+5X4cCgueBZz8PCnTslI/ditaI//RWSQd2guOXeCwFN34u4huugXv
         AiAvOYus+h7/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MALeR-1pcaJC06Ch-00Bk2T; Fri, 14
 Apr 2023 18:07:25 +0200
Message-ID: <43997e66-4afb-562d-c06f-ec3d038f1988@web.de>
Date:   Fri, 14 Apr 2023 18:07:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Git bug
Content-Language: en-US
To:     Gabriel Furstenheim Milerud <furstenheim@gmail.com>
References: <CAJN3DWriXWYKyf+hJL+wZDCgwOZZsWRah=E8_HnKEWh1wcy4Ww@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
In-Reply-To: <CAJN3DWriXWYKyf+hJL+wZDCgwOZZsWRah=E8_HnKEWh1wcy4Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kMuasqrtZohTcqDLVfKzCdt20N9egRlJ9Q52FbzEw9N1qCwjuLm
 mZTMZePInSlbEt6ytiYWFr66K0TLCpxHdTOFYVwVB8Giq1PAvm5gxX93LomNMG2rL4J4eSD
 9H6HP5zxJrabM1O75BzEkuz8jRo7hn2JdobNwfnvZ9NESLJ/WVWgEK/XHS/4+trXK2s4Z6X
 2AGY/CRlY0Xr5/iIpPlXQ==
UI-OutboundReport: notjunk:1;M01:P0:5KtUHHHMaf4=;Tt6mppcz7kuwckndJFK3pEyKor5
 wg7QZtvcX/nJYemqNKnsE99s46h2cS0zCFXfktZUIdP/fRM0m6FU9gb1PLsnthA5U5OZLYbTP
 aGJ9W+DvsdezqARdtP/rD2tesw/3C80+BWzOTSs/a1IhZ9AlKGgBoDJBk+/BMJy2vEWQW+ESG
 jp+hhgH0RwHJF0X8zWY7CDq2oQAXFQGa/6zSND2vpuMNS0+J3UYUIbYRLXhr4cGRYy090OFfL
 0da4IviR52Fcru9kQgV6hqfTxXe/RCKJO3SECg4CRK+O3N4HWZYZhUC3q+bP/9XSdnjLS224c
 yiie9FUHRUbwyuMkKraG9mn3+DZfkaPJgiPpwHBm8eYc8JVRRqzLX9jetu2S8I/njAz7aEjIF
 7HNaa7VnfZ4J+PWg6uTbXAw3LSe4TJ0pnZqVmFrwJPcGcj5S2kFL9MBnSc/pDQniiYCpcrgv5
 /bJt8P+YYJXH6aRyK0n9G8sxdI7g5fqnaKwJWA7WTpJRt53fEhFFr7SWUnH259I1RMZKU3QXf
 5F31zQ8VTwc9u18hjZ2oPUzqdIra8t5WeOiLNqY3//LcnBrLePUMM2bjr7oktDKdX++AYoI74
 ABaoIUqcIYmPectMeJgsRn+Dz4wdckmGaPBUhqQJstahBNv/1TiNS5hqQfiGmVFCeLIFBfOTs
 bbUE7F2EapreEuf//VGfJCIyaeFkqJG4WlWCvglCC0kZ+NliJLmFUZ8Q89HrMX6KQi4c8MI6P
 jJ6E9avno0naNvncNe5GWUvja9T/uHRF1UrLgwwiTP3/G3qtQf//FJLFRTyvzhREJfwbzU49q
 +cdrLwGG4BnQ8ViOcctf303f/7yrm0iHZV0/SBizaXhM1+R9ApyzKIVpfyM3A5JztxRYw9hR1
 i1ZEXQqlbZAYc5gRHS0PC8y5tqbaGSTEXSwtcFeQYlAYyhEfuGPa5DhvmCjQqPnCBSb97qzlB
 h1VO/ugpgE8q18J/00BnDzvxzOM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.04.23 um 11:41 schrieb Gabriel Furstenheim Milerud:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>> repository in branch A
> git name-rev $(git rev-parse HEAD) --name-only
>> returns A
> git checkout B
> git name-rev $(git rev-parse HEAD) --name-only
>
>
>
> What did you expect to happen? (Expected behavior)
> It should return B
>
> What happened instead? (Actual behavior)
> It returns A

Do you have a short recipe for creating the branches to reproduce this
behavior?  Here's my (failed) attempt:

   # create repository
   git init -q /tmp/repo
   cd /tmp/repo

   # create branch a
   echo a >a
   git add a
   git commit -q -m a
   git branch a

   # create branch b
   echo b >b
   git add b
   git commit -q -m b
   git branch b

With that done Git v2.34.1 gives me the output you expect:

   $ git switch a
   Switched to branch 'a'
   $ git name-rev $(git rev-parse HEAD) --name-only
   a

   $ git switch b
   Switched to branch 'b'
   $ git name-rev $(git rev-parse HEAD) --name-only
   b

> What's different between what you expected and what actually happened?
> git rev-parse does not seem to update. Same is happenning with git
> rev-parse @{-1}

   $ git name-rev $(git rev-parse @{-1}) --name-only
   a

This is expected because @{-1} means the branch/commit checked out
before the current one.

What does "git rev-parse HEAD" return for you in each case?  Do your
branches perhaps have the same HEAD commit?

> Anything else you want to add:
> git version 2.34.1
>
> I recently migrated to ubuntu 22. In ubuntu 18 with previous git
> version is was working as expected.

I guess you use LTS releases, i.e. jammy (22.04) and bionic (18.04)?
bionic shipped with Git 2.17.1 according to https://packages.ubuntu.com/

Ren=C3=A9

