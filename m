Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFCCC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 10:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1AC61059
	for <git@archiver.kernel.org>; Sun, 30 May 2021 10:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhE3Ky0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 06:54:26 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:21454 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhE3Ky0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 06:54:26 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lnJ3n-0007Ww-9y; Sun, 30 May 2021 11:52:47 +0100
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
To:     Matt Rogers <mattr94@gmail.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email>
 <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email>
 <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
 <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <953d685c-3c89-7377-ed49-b79fb4e0acb5@iee.email>
Date:   Sun, 30 May 2021 11:52:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

quick thoughts..
On 30/05/2021 01:14, Matt Rogers wrote:
> (resending because client reconfigured to not use plaintext)
;-)
>
> Reading through the documentation, Visual Studio seems to support
> CmakePresets.json [1]
Is that stored with the project, or with the VS installation (still to
read [1] beyond a v quick scan..)
>  for handling configuration of cmake options.  It
> might be worth it to keep the defaults as is.

Given that it's just changed, do you mean ' keep it as new - Ninja' or
'keep it as old - VS generator'..

>  But provide a variable
> for forcing vcpkg and a CMakePresets.json for Visual Studio
> (and other such tools) to use.
>
> This is nice since Visual Studio users wouldn't need to rely on the
> slower Visual Studio * generators to run their builds, 
[implies, keep as Ninja, I think ?]
> while leaving
> non Visual Studio users still able to easily run builds.  So maybe there's
> a way for everyone to be happy?
I'm hoping to ensure the project builds 'straight out of the tin' [mixed
metaphor 2,3], for those who are cross disciplinary (such as myself;-)

I'll have a good look at [1], thanks.

Philip

>
> 1: https://devblogs.microsoft.com/cppblog/cmake-presets-integration-in-visual-studio-and-visual-studio-code/
>
[2] https://en.wikipedia.org/wiki/Out_of_the_box_(feature)
[3] https://www.ronseal.com/the-ronseal-phrase/ (UK)
