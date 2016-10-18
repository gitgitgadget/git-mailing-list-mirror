Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EA420988
	for <e@80x24.org>; Tue, 18 Oct 2016 16:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756100AbcJRQmP (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 12:42:15 -0400
Received: from mout.web.de ([212.227.15.3]:57747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754743AbcJRQmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 12:42:13 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Lgb2b-1ciGoO1Jcz-00nz78; Tue, 18 Oct 2016 18:42:09
 +0200
Subject: Re: git checkout crashes after server being updated to Debian X86_64
To:     Raffael Reichelt <raffael.reichelt@gmail.com>, git@vger.kernel.org
References: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1c70da04-d26b-f0af-8939-edc96de586d9@web.de>
Date:   Tue, 18 Oct 2016 18:42:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:NVyczHNwuxkuEjL2VpHdMwUuDZB/HBCsr05FAeHb0/v4DQUuonl
 6boUh3XDeuWLHcIKYYc3z0wZqP7MeQj7uflLKT7zRlLFl44rwoW016m63mkbiG8N4MdgBl5
 JWvkjoFriVKrlE3FAkO0Lc+Coddce3UZhyLuMxD3FeZG6l9Q3CRbiURZ6E5OU3lNORxFqWj
 WTfbXy+bCx/B/mGoGgAdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T4lbEeXEHJw=:BySRtyCfIR+F9s2/B8nF0Y
 uISP6CQGGN3ixVe9GKtycPSMkXePPjucZ5h0LKGKO3+QsNUFrxL2N41ocJsRINKKfEdtxUabw
 6fLN6lqH2KdtFGQ9P7DZLH5o3H1fRe922NLR85ApAB82uZl4vGvuZv+F9MqiMaZjjmu/JDrYU
 qKQfQOGWm6I8tXFAdRlvlEJNlAgQqojNGZdzW8n1Dh9tW1x7V/2w1yGdItLVi3aLaZ0EsKKhP
 EywuMEOTOa+COLgQ2jv6WFvt/cOol/2/DcMwqdJ61NyLPwP/2gNjNYvfSr6HyILA+BaiWiQad
 XV0NqKN4fltq1/8KJobb80gUQPjmQH3exAWYMFtveW5eBVy89QC97kopYVcUa1dB/jIY0iUV1
 9LugVeAbttpfk4gwdVrjEVOSGEvZ34sWzqvHiFxfO57h8Ve72UnaYprrPtjVaftGAdSmAFjhh
 bI+K6AixPWugoAcLQ2vRhtKNpoBM+t4iciP9eHpSxzPiBmjG/k0812XWAk/1h3WtJ7pjY5P2x
 RbQ70/bbbL0WBdn+ZjV809SPqGIQbHX0OD6pVohfcpeAGgmCknokYMlHrNDdAr5V3DtRCWFBd
 Quk7LXNYoEXf+vZ/UZ7Oc8zFW+Yqh0gmpFHHPW07M0h1kq0futfGgUkUSldDNoF1OCCxhOQWm
 a8/QRpFT5I5s4kvEomOyW8fAep3pyQc3NrEjDobgxAdOq4L5sTqdfUwLOjWTXOZqYB9AW5Qpl
 6s2rqY+CPotgbQKyfpClc++2HAsNJqxU5UAcAKFTAIucuk7mvK0FwWoKUfE+SdSTKRUVyh6QK
 P1WY56H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.10.2016 um 17:17 schrieb Raffael Reichelt:
> Hello!
>
> I have a serious problem with git, After my provider had updated to a
> X86_64 architecture git crashes with various memory-related errors.
> This is happening remote when pushing to the repository from my local
> machine as well as trying it on a shell on the server itself.
>
> This are the error-messages:
>
> fatal: Out of memory, realloc failed
> fatal: recursion detected in die handler
> fatal: recursion detected in die handler
>
> or
> fatal: unable to create threaded lstat
> fatal: recursion detected in die handler
> or
> fatal: unable to create threaded lstat
> *** Error in `git': double free or corruption (fasttop): 0x0000000000a8ade0 ***
> fatal: recursion detected in die handler
> Aborted
>
> It’s obviously not a problem of the repository - happens with all of
> them. I think it is also not a question of size - happens with a 80M
> Repository as well as with a 500M one.
>
> Any way: did a
>
> git fsck
> Prüfe Objekt-Verzeichnisse: 100% (256/256), Fertig.
> Prüfe Objekte: 100% (56305/56305), Fertig.
>
> git gc --auto --prune=today —aggressive
> git repack
>
> Additionally I played around some config parameters  so my config now looks like:
> [http]
>     postbuffer = 524288000
> [pack]
>     threads = 1
>     deltaCacheSize = 128m
>     packSizeLimit = 128m
>     windowMemory = 128m
> [core]
>     packedGitLimit = 128m
>     packedGitWindowSize = 128m
>     repositoryformatversion = 0
>     filemode = true
>     bare = true
>
> I am running
> git version 2.1.4
>
> on
> Linux infongp-de65 3.14.0-ui16196-uiabi1-infong-amd64 #1 SMP Debian 3.14.73-2~ui80+4 (2016-07-13) x86_64 GNU/Linux
>
> Anyone out there to help me getting out of this trouble?

Git 2.1.4 is the version that comes with Debian stable according to 
https://packages.debian.org/jessie/git, so I guess using a more recent 
version is not a reasonable option.

What do "file $(which git)" and "ulimit -a" return?  Do you have an 
x86-64 binary and no unnecessarily low limits set?

René

