Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4541F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932794AbeAXWDF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:03:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:56722 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932741AbeAXWDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:03:05 -0500
Received: from [192.168.178.43] ([88.70.141.243]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lq9Ma-1fIDj93UsS-00dqNI; Wed, 24
 Jan 2018 23:02:59 +0100
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Isaac Hier <isaachier@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180123001648.24260-1-isaachier@gmail.com>
 <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
 <c5d21b22-e4cd-e338-c953-90a81981e23c@gmx.net>
 <CAG6xkCbtVYa_eqZj4m74jXo7yC8kS8kjWm-fALePmHaH5yY0qg@mail.gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <e3d1e1f4-9927-47eb-7662-2c6918555058@gmx.net>
Date:   Wed, 24 Jan 2018 23:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAG6xkCbtVYa_eqZj4m74jXo7yC8kS8kjWm-fALePmHaH5yY0qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ZoWPIhIxWkX6ZOhk+oaSUt0sfJThajhueoANKuNldhrsLLXF0Ux
 iKIvCDyiafTch5IXR0dUHxhZsReLf0wUgAF8LwMJ2jZKRQA7fAxtnydoqITYWIEhl8A198G
 LnuVAx22LvzL+jVpJQLj61zJsjiYanMAMDkcazLc5LDVRiAgCPNlP/lD4qKlPtppaygYZJe
 C2PvOcHbSjzxApOUZhyog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CBJuzjdkAqI=:uaFC2egv9moM+SzlPDFPd1
 BeGXp3/sD58ikUp/Pzymno1N8cX/9ZmEAfcpwqyi5v2IRNXiHHB2JGLfLl/nL9zSc77dNV8od
 WWz+mmb6ESHZBYPTYCdhxDiaNNWNaApqJUEBLthT3xVB/boGofGQaDx3a9n4yfV76BJWGPfhO
 LFDtCWB/On7tLxwLoQ0cHqr3oWtzOwN77yc/cKRjrXST5aE4xNfi5t3I0+sTWpJZahVHIgXxa
 C312VA8+j1079HaMR6Ql230qTatnZF+0LdXp8GGFua68Ma2cqtcvaaeZCPa2pzCASssCMCH2Y
 nXo+W8oREvAF8ZsloRmq+Ye4E3mWEdPOWIEEgZkVcZb+5Yae/cx1KBSjbf4TsEBJTM7kxrgKJ
 0pOosDffwfpjpelK4+KSzJ+ZfB6hOxp3jTp36wX9vngMsbHrlg0wdOP0ZcsAZBfpr/VsRaCcQ
 BKakoCarWTsn3XlJbCS193nBiyrbs1TXgf6qNgxtVGNDWMJ3LK4C4YfA50A+j2dKN+LaV7rfx
 +SribnLHnNxv5DBDSS7xcAMSkbnS/6AA/+esaHWLCKjSpMwb46zSDSo2B5dsRrEZYuik7Hu6/
 +AbtktuUuBInDBW0HN5dV5FZYjq5GDqd4IsJGk23ayR/FZ7cf4hwKzzGoTC6/S21rO/MP/Ifc
 M+t3S30fHMQAt59vZV6RSc+pCcO4cxZZhssxxdQUxE8Le99XPHnpkweEKQ4BR/4BsnTMwFSfx
 WvN5NncuBZkx9GTCsuxnPlh4qiqPiGiRblYfJWmrTNvh5cnBIDFQpgqFzAfvwGhP8Z/Frm/1W
 DffhRjpl7/JK/ssV7bUN3kcD0Img5biZf2ZCm5HHymRr6S19uo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/24/2018 10:19 PM, Isaac Hier wrote:
> Thanks for your interest! This patch is based on the cmake-build
> branch of https://github.com/isaachier/git, but the full history is on
> the cmake branch (squashed it for easier readability). Hope that
> helps.

Thanks. I use the cmake branch because I prefer "real" history over one
huge commit.

And I already love it. Thanks for all the work!

From a first short glance, I wonder if you should mark a lot more
options as advanced options, like the paths (e.g., SHELL_PATH,
LESS_PATH, GETTEXT_MSGFMT_EXECUTABLE, etc.) and probably also things
like GIT_USER_AGENT. If you use a configuration tool like ccmake, you
see a lot of options and many of them are not relevant to the average user.

I also think some variables have weird names, for example, POLL, PREAD,
MMAP should be USE_POLL, USE_PREAD, USE_MMAP, respectively... or even
USE_*_SYSCALL, I don't know.

By the way, regarding up-to-dateness, you are missing these recent
changes that have been merged to master:

  edb6a17c36 Makefile: NO_OPENSSL=1 should no longer imply BLK_SHA1=1
  3f824e91c8 t/Makefile: introduce TEST_SHELL_PATH

(which is not surprising)

~Stephan
