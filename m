Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1114F1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 19:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeHQW43 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 18:56:29 -0400
Received: from mout.web.de ([217.72.192.78]:40745 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeHQW43 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 18:56:29 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M40zO-1g80b23jk2-00rc1Q; Fri, 17
 Aug 2018 21:46:03 +0200
Date:   Fri, 17 Aug 2018 21:46:00 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180817194600.GA10393@tor.lan>
References: <20180812090714.19060-1-pclouds@gmail.com>
 <20180817161645.28249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180817161645.28249-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:P7V/iGs5VA3YIgw7XKgH59oR+EoYeTqRyAznkuHyxmZ6syFeas5
 XhMeNZfjwEGPnHkY/quSqcA3/tOz6qonbeDmtFw85eLUs5o6AhZGA9vYqZsvUlCNTwEZGuZ
 5972jqgWbn0WkVwP0mugPcZBCT7aICy/54l35IRPqRKi8u347XqoA8itd+5RMHJN3NJhh85
 H6CE0atk6RVapmHv4+RZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SAtyXKgmNYs=:hJeJUO8H3jW3UcTLFXghNc
 MSCSlFQAq04Gj9q+gFVHL8OjUOR/fxdwPgUm5MdINCVIF29pwPsVGoh+AALOsMADviiK8EeFR
 PBOjhHWwC/Vhy9aj0ZjJX/m4rr/RbOsb8XOb9XktGP0crlTO1/34mYakNhv/hNuRehHcuIHDV
 DGBdcoAAjToxchFz0YFl42KCTyoMpXPXcU8stWr8x3xeKT86AIuy9jE/167eVKh5NZGog7CV5
 Qd29Z3TEZBmlH1pCkH5qbEptn6wgCvDxJs7zwIzQbM495V4CNZfOF0ZRs3kYEfDRnd21CEPn9
 SqmOAUTbOPzswBjbpJLzqbSkeC4hwLj/2wFPV3qOx9qq9csiUhYiCWdlqEtD65o8RU37MqVym
 /tRFvDopVX2M9y8ejJrU80Yt514hMTbxldiQwq8mprCsavWjCbkxM2ew0Exwmjwfz+W7iwq9k
 MB6JKM8DUIs04zOOXnMUnhbSy6HjvaucGc9ar5XMxsK6Q9G6qar1RB+RqUoRQii10+fuAirE6
 zN3U1GeLT1EG37yuizY5sINbdViZXitHuODWoeHOTVEeX2Z+zMQLZi3epJ39XqpUwri7lJpbf
 tTMtEmF0m5WKmHxoOb+GwpLhnTJ8df6Qul+Qw3dXPvga/0Tbpgm6f6h0lS44GfAJ47et/01BW
 GyDfzANmKT3SvPQDQi6oZYwAG3yTBgQRSn6vLbUrUjCI3+P7qn1WaKDGhNonQklu7tsG8Fi99
 dFNPpVrOLFnYv84LRj7pWMreLV9Ye89T+veYuvNOHBwRHh+JGAJywKqA6IU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 06:16:45PM +0200, Nguyễn Thái Ngọc Duy wrote:

The whole patch looks good to me.
(I was just sending a different version, but your version is better :-)

One minor remark, should the line
warning: the following paths have collided 
start with a capital letter:
Warning: the following paths have collided 

> Paths that only differ in case work fine in a case-sensitive
> filesystems, but if those repos are cloned in a case-insensitive one,
> you'll get problems. The first thing to notice is "git status" will
> never be clean with no indication what exactly is "dirty".
> 
> This patch helps the situation a bit by pointing out the problem at
> clone time. Even though this patch talks about case sensitivity, the
> patch makes no assumption about folding rules by the filesystem. It
> simply observes that if an entry has been already checked out at clone
> time when we're about to write a new path, some folding rules are
> behind this.
> 
> In the case that we can't rely on filesystem (via inode number) to do
> this check, fall back to fspathcmp() which is not perfect but should
> not give false positives.
> 
> This patch is tested with vim-colorschemes and Sublime-Gitignore
> repositories on a JFS partition with case insensitive support on
> Linux.

Now even tested under Mac OS/HFS+

[]
>  '
>  
> +test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '

My ambition is to run the test under Windows (both CYGWIN and native) next week,
so that we can remove !MINGW and !CYGWIN 

