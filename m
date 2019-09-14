Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF0C1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 20:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfINUjn (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 16:39:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:62631 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfINUjm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 16:39:42 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i9EpX-0001bZ-8f; Sat, 14 Sep 2019 21:39:40 +0100
Subject: Re: Git versioning policy - PatchMyPC compatibility on Windows
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Audric GUERIN <audric.guerin@gmail.com>, git@vger.kernel.org
References: <c760038f-7c50-73df-5187-a186868c995b@gmail.com>
 <20190914193825.GS11334@genre.crustytoothpaste.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <10d0e87d-1ba8-bb82-bf9d-72a468c16bb0@iee.email>
Date:   Sat, 14 Sep 2019 21:39:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190914193825.GS11334@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/2019 20:38, brian m. carlson wrote:
> On 2019-09-14 at 12:49:40, Audric GUERIN wrote:
>> Hi,
>>
>> I use PatchMyPC to keep all my applications up to date on Windows but there
>> is one application that is never properly detected as up to date... and it
>> is Git as you guessed.
>>
>> According to Justin Chalfant, Director of Engineering of PatchMyPC, Git
>> version "number" / identifier is not "standard".
>> https://patchmypc.com/forum/index.php?topic=3032.msg8211#msg8211
>>
>> PatchMyPC seems not to like that:
>> Git version identifier = version number + platform specific identifier
>>
>> command "git version" currently returns:
>> git version 2.23.0.windows.1
> This is the version number of Git for Windows.  This is a version of Git
> developed by the Git for Windows project which contains additional
> patches designed to make it work better on Windows than standard Git
> (although it will also work on other platforms as well).
>
> The Git project itself doesn't provide binaries; various other people
> (such as Linux distros and Git for Windows) provide binaries for their
> particular platforms.
>
>> git executables (like git-cmd.exe for instance) displays this "File version"
>> on Windows:
>> 2.23.0.1
>>
>> What are your thoughts? And can you answer to Justin Chalfant on PatchMyPC
>> forum?
> Since this is a custom build, you'd be better off reaching out to the
> Git for Windows project at https://github.com/git-for-windows/git.  They
> can help you figure out the best way forward.
There is some discussion about the semver approach on 
https://github.com/git-for-windows/git/issues/2223 and how the 
.windows.<n> indicates patches beyond the upstream releases. Semver 
isn't sufficient in these cases.

Philip


