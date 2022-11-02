Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD4AC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 16:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKBQxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKBQxB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 12:53:01 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 09:52:59 PDT
Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86F2FE
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 09:52:59 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id qGvzo4IvNoRCFqGw0oErdj; Wed, 02 Nov 2022 16:49:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1667407788; bh=4W5u95g2vD5KTdi+Qfb53w97OasOD8xMKQXGS8OhyW4=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=a6sCbTuphFaoux/omzXKBBi8g4ICy/QEcwPq7AtaCoHzvMzs5wipSITc+xRdZoOP9
         Xn0lIigI9T1ssHejOI+gpcNCEhnSOXgDKDvR+Cl6ur/KvmGcsfE/zXkthpgj/ZZHQE
         Vz33pLLfaUFj9siMXq7nikdDCibaNpuNtI+Pyowc659WEqmoEY7csqNBZHJzCMQGsu
         pbVYdo3Wg1MfTn4GE1GErYz5Y2EcMiKxPXZ3XZIcSu0bmRC9gb+Xg1Wt6aj/NOb/AG
         KEbRpmguRqoOb/i+iyK5jkEI9MO7Q1rGwKyZAO3CK1iTDx2YH+/HwMO1H90dv2+eR2
         2EMLp0UcqAq0w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=K8IxogaI c=1 sm=1 tr=0 ts=63629fac
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=Oh2cFVv5AAAA:8 a=C8lbFo3dAAAA:20
 a=kulwNnLLeRbAQUJt3toA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=7KeoIwV6GZqOttXkcoxL:22
X-AUTH: ramsayjones@:2500
Message-ID: <eee42f09-32ca-a254-d362-27be1045c558@ramsayjones.plus.com>
Date:   Wed, 2 Nov 2022 16:49:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: What's cooking in git.git (Oct 2022, #09; Mon, 31)
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <Y19dnb2M+yObnftj@nand.local>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Y19dnb2M+yObnftj@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHVyUmslsp+LIAoxz9f63gWREJeDtf4NzgGM+asGH+xI98elEISyXX96Opgrl5uUgpAFHwHjXVKp6qIDhsB5OJZKcLsZHVQi26pvIB4R74JBQM+fX7zX
 QkbQFTnNMKI5nSpXa/7GlW4Sih/5mXVmbR7Ku5++9PvoV4Qq/AOHwGa/tB+KgcVM87vciJDtU6kDaj/3AzDzhThKzTT+dINnoS4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/10/2022 05:31, Taylor Blau wrote:
> What's cooking in git.git (Oct 2022, #09; Mon, 31)
> --------------------------------------------------
[snip]
> 
> The following mirrors are currently out-of-date while the usual
> maintainer is offline.
> 
> 	git://git.kernel.org/pub/scm/git/git.git/
> 	git://repo.or.cz/alt-git.git/
> 	https://kernel.googlesource.com/pub/scm/git/git/
> 	https://gitlab.com/git-vcs/git/
> 

Ah, I wondered why it had gone quiet ... :)

On Linux (same on 32-bit Linux and cygwin):

    $ git config remote.origin.url
    git://git.kernel.org/pub/scm/git/git.git
    $ 

[yes, an old curmudgeon!]

Well, I guess I should just enjoy the silence until
Junio returns. :D

ATB,
Ramsay Jones




