Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4761F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 03:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfJZDHm (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 23:07:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:37239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfJZDHl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 23:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572059260;
        bh=q196ygwhLZn5llxvoAd1tUFtuQL2+TtjpGkcJzJH2Ls=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=OTlnhw9CeElVMxSGO/YrXEepD8mj5J4Gyv/AacOa5rjFN4RHpkNpwwqIslCRxqsDV
         mR+Py1HEiL+z8qBf1s0NUq7fYITLfmTokrWcXvXoMTnIrH7Z8FvukDZZSlGnqU0ZOj
         EcwTsFtxyQlCz4W93C3gouq1+eKH5E02IvNJeWf8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([77.183.200.49]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1icorP1eyx-00P3gV for
 <git@vger.kernel.org>; Sat, 26 Oct 2019 05:07:40 +0200
To:     Git List <git@vger.kernel.org>
From:   Ingo Wolf <ingo.wolf@gmx.de>
Subject: WebDav WorkDir Windows not working
Message-ID: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
Date:   Sat, 26 Oct 2019 05:07:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:ht6pbEt3Am9Ghc3fZ+d6MXuBNu+uwzE7zhjE4FYeKCMu3j2/ijk
 8aEtbyZuuSd7E7Gl4gWcZddHHy+jliEoEF+dx6Y0wVs2pQYIknnXaZv6VF28m+RzHXL5cu/
 F4E9hvWstdOdj0bGUn466V1i6c8O5jNntTmLTwOWOnb9EVKR2sIRltg6CQP33Q6mNwuTZeY
 C/PDN+OOI8NkTgUflVxLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yXY+b4rEMkc=:h4USWZRqo84a4FCDJvZVvh
 qgDve/Yql+zS6da+Is1gu486Wojn5MAXc+hLtjgCSd1/R7RTdHHaZLg5/3qbnDr/EwIHOE2a1
 Iiv+muX6PFvguwgR2kxD3ML9UPSzDi8SFKMtt+kAG2b3B5Ea+9bE3xcYxH4RHLxBx4p8FAjMX
 gfg2vVkdqqU2j72lhaKSDWZ0aJ4zNFOWMSmLmIfoB35ByGgBZI/z2wqypuovHY6FLac9/678W
 R1LYQniFpmzYSwjvoymJpTDS47yrfhBkbjQaag52hIaWx92koZFw2rDAUeVdPQezVc4yFUVur
 ZIN3lKTHeFj1/XmWRu8MJR4cvl/c4vOnvWn1buorJr2mHDnWJWEn3NuRaX3XnAf2YBvyyoSj3
 GrpMsiuDbDJ4PGZ5aqUFUOGu2MQq+BjeZEaJ0XoXwVuPtB4bchENDn9Q6NQHpyGEbaka21We5
 JgpG7Z8D/4QivUMc2GWXQLCyPA6c5vGpu4qTKon4fJ0SSajAZSAHVUb/DLHWani/zo14+5cOs
 bmfLmIkJnPKZ1l+f1FkE3L+nS7DlFCMIsQ9bVLEebHFKy3zElAZhyz2kMIlr5h+sQWwWhIQX7
 PW7vDmSL9m7+1u5A/lmxWNfC3O/P3uKSTytaoJYAPjGj17d4nqsKP0HfSWiags3DZJ9nykMAk
 SoICMGWdZtJu1WGkTTbUHuDbf0EZhuE0PhTaix3cx96pY5IT+xUhyeq7NWXfB2Udp6fi9xZpY
 c0Wv6h640634S6cgWdiSNHrqubbW4x/CoWk0Ic+HGwPyZCzXplm5whLr4vae0poQORU9UUpXd
 FiwfxxyKRySI6pF88jkEnyFgsOA73XnmSMFNT2dlqOHu1fRxHg2L7RflHU3KzCrRlEJ59d/X0
 8K4+1aMFXcBrmAwsrYlrSW0Uy8fqVdZ+wNzmgCAu01DyRRlQSdJn6BGaVfcCYr5VRNeYN299E
 j/j/TjavH7473BasbXYoVSBgnWs+kaqA83BxAs3A3xjlkUypuA+FS4e+yi09l1hcHYpobw7UZ
 VH7BzGy3s1yN/LzYv9jHZaws4a26ZatIMws8zpo00U2vTMmNchn3shGA/Ia5fESfRafuhDAH5
 LLRWRvM/CgPmdLZGnM5cwt3d58GRztNYJUOdQaqwzFwVzloPSaUNY9AJ7iz6caOjAiZb+iEQg
 rh9U4J0aShqoT/9XWCY7sDce9NK5qkHX0tWmVsZzow+44i6T0bv5tZ9PUUXnkZwqoMp1SM1DW
 FkfubvIeDHiaxvLHgTbCvZM0TfdmmBenCTMHUpE2eV+WUWuuH9253eMYG0YQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Git Windows somehow does not work with a Webdav Workdir even wenn
connected to a Drive-Letter.
It seems like everything work except stat.
So I can checkout to the Webdav Workdir and all the files are checked out,
but git status says the files are deleted even still there.
I can also commit the files, but next git status says deleted again.
When I checkout the files again checkout says error files exist.
This is somehow strange.
Unfortunately I still can't add a not empty worktree, my workaround is
add the worktree to another dir and then move the .git file and edit
the dir name in the worktrees/xyz folder.
But now I have the strange Webdav Problem...
