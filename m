Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837BA20248
	for <e@80x24.org>; Thu, 14 Mar 2019 09:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCNJiE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 05:38:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:41955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfCNJiE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 05:38:04 -0400
Received: from mail.schuerz.at ([78.47.150.33]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVGq-1hM2Be3eVs-00HgY7 for
 <git@vger.kernel.org>; Thu, 14 Mar 2019 10:38:02 +0100
Received: from tag-331.vpn ([10.0.100.9])
        by mail.schuerz.at with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <wertstoffe@nurfuerspam.de>)
        id 1h4MoM-0005gg-4K
        for git@vger.kernel.org; Thu, 14 Mar 2019 10:38:02 +0100
Subject: Re: ls-remote set timeout
To:     git@vger.kernel.org
References: <0MUoma-1haJEB1Ckm-00Y6Wl@mail.gmx.com>
From:   =?UTF-8?Q?Jakobus_Sch=c3=bcrz?= <wertstoffe@nurfuerspam.de>
Date:   Thu, 14 Mar 2019 10:38:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0MUoma-1haJEB1Ckm-00Y6Wl@mail.gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-AT
Message-ID: <0Mey7N-1hOXHn3kBF-00OYB8@mail.gmx.com>
X-Provags-ID: V03:K1:n8fih6j84adI+l7pfA8F+qe4MLbdwRp6kULsovrOLWoX56T/Bg9
 s9cn+K+JvqiKjCOADkuycsftJwLQJq8JMkhSmCLEU6NONyLJhB5NghNliJ9cS60byu9YrDS
 W2KBH3fyi/ZZIH6r3bL8z7wHO+mGeumYtU2z/xPHOxP4bZwTw1oxZOOauM9ujBAFA3VSJ91
 JRDuCh+EQaHEU4uY3j3jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wAgZ3KznmJA=:rZxPcBuknDvVEReLA0Lsjy
 dDztEQ268klXxD19ZBcMhzMk6oDVdCGgyY6dxz7Hp6t2TltlMsnTkxQ5dccGiRoGLJVMKstBv
 g8LYY0xh/B3PLneFn2u/7o96HlKj9OhL3bs/Wgn2JlIoTQnGK9boLGQVq5VcVQwPa+b1L9xSX
 Tg91oHoq56CJ7K/vjXJc3nST2iS1rTdyxrjoL/5y0ZEKMTmUny1sKBa7nbkT/PpeQoF6q51XK
 rPiVx1oY+SawLb03uJwJOJbq8nYXodhpolY06epI/fr+m2iSHlvemwJTWYqtXilPDLmHo5u1n
 +o+q/0HTBqP9Azyq2CXQixRZWb4lDlZY46oSMqY5zYt0gbHu0rGcPbPttYGfh9eYzGucBAbwA
 y+08VZ81v6Dbhrb21IynyA2LUeQfokxVTp4xImXASEAr9W5YUmt9EdsQI49ojxUZC/+fkwrdd
 xGfqnBVUgNV9RJvRI4sd+q1RMJQYqhOQdcZ68wt6hvHTRmO+LKHBJ3IY2gRz4QtilId25v0iR
 UI07mC+RF/aiLzpzaO08Dil+Vg3D0uJyDNWgONarRQ0f9SNLfePk2jnH8hqXhQTC4hlvBqMHn
 y+gETNq/h8xSpG674VgG80jHekdhRH3BOL9OLbAkU+5Lx+pZQppAqPPeppUrFZCOSLmCTz8eQ
 kgSna4w9lajGKcic1DEYbfHXxPphUheaa1Yigo+Mq3FCJ3e3K/3z8qsb4NSiwks4UXChJD8C9
 Df6pqxrTkiiKNNKUDNHTDqVu0KP9NX1YQ4DkQHqAMNgcSt5eO8OFk77LKVftin9wOuhTGMSPn
 AycwkS/rVsmXyiz775idV04xZygULC3ia9BXXa444GE0UyzVCCUJDoJGnZpTDinmm9O2FJQSj
 ttbKOjMAGH6Laj4kTVik8d5fqTPtGhIDxK6+nEBS8SZtQzWd5NkOqdBay/CaMf7abEO+IIwpx
 dAiSsffVdlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ping!

Does anyone has an idea?


Jakob

Am 08.03.19 um 10:31 schrieb Jakobus Schürz:
> Hi there!
>
> Im new to this list - so hello, hope I'm welcome.
>
>
> My problem is: I have a configuration for my bash saved on a private
> git-repo. Every time, i start bash, my .bashrc checks this repo out to
> get all changes (alias, some functions, $PS1 and so on). So i can have
> my working environment on all my servers with personal login.
>
>
> Now I'm working on a new customer, where github.com is not reachable
> (firewall/proxy). Parts of my configuration (some plugins/scripts for
> vim) cannot be updated there, because they are hosted on github.com. :-/
>
> Now i tried to fiddle in a check, if a repo is reachable in my .bashrc.
> And i found out, that git ls-remote is a good choice, because it handles
> redirections from http to https correctly behind this proxy. (direct
> https links to git-repos do even not work in this surrounding... don't
> ask why, please).
>
> I can check, if my private repo (git bare repo with gitweb) is reachable
> (http pull, ssh is also closed!!!) with git ls-remote. But this check
> hangs on github.com in case of a redirection from the proxy to a "this
> is forbidden"-site... . And it hangs forever (1 Minute, 2 Minutes or
> even really forever!)
>
> Is it possible, to include a "--connection-timeout" and/or the
> "--max-time" option for curl, that i can give to my "git ls-remote"
> command? So i can call
>
> git --connection-timeout 3 -m 3 ls-remote <REPOURL>
>
> and the command stops after 3 seconds with an errorcode, which I can
> evaluate?
>
> I tried netcat and curl directly. In this environment only git ls-remote
> will work correctly on reachable repos, but it hangs on blocked... :-/
>
>
> Thank you for your interests
>
>
> Jakob
>
>
