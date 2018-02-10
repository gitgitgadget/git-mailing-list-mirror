Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8AB1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 09:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeBJJbn (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 04:31:43 -0500
Received: from mout.web.de ([212.227.17.11]:42417 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeBJJbm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 04:31:42 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8hsl-1exHDz1xrP-00wEYI; Sat, 10
 Feb 2018 10:31:40 +0100
Date:   Sat, 10 Feb 2018 10:31:40 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Crash when clone includes magic filenames on Windows
Message-ID: <20180210093140.GA11525@tor.lan>
References: <CAH8yC8nodewYm-J3ye5Lnq-Zf9JziejL8L3TxTEwVoq8hD--HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8nodewYm-J3ye5Lnq-Zf9JziejL8L3TxTEwVoq8hD--HA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:FYFxtJ8d9COrrvKxOmeulcP2mnWYYa8ZCdKLHbyHgNdhBue9iTf
 tIpqeC4rEG/uzbA9t57yLyNfk6PUkTkBT34XU1ofGAp5qM+TMfQewKYzrsIBGFK6v2SPWDb
 oBesEaSDzFNcWGCnSjwNc5gsdcTmTnI/b8619e2BlfHD7IDTQ/yQWPpdJRksJ7s4OXPBdat
 c2hd2eHW6FqyFShd5PElw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IedlsNFWTs8=:luPfD7sqX1D1A1zPPHryj+
 gJNOonloHtp3zVVogXX3E4nv44tSTNTwvZQY9C2q6Xw5EOgGqtYiCEg3RbNfQ9fVrrCjxU9H8
 LqzPGOJIJVqTCJDUc33U23GLXG/KtuIqSZBZj+f1Y0/7ry76ediD+OG+Puw34iineX2M/RM4J
 c+TcUB3MAclneWXSc5SmJHJrwWxZqeCCHPyUBKnd1cv6BsDPqSB4Ll8rxRzbg73wCE4rPmhbY
 xr7AxIqdVshnDvFf6Pp4LUxJpyCFrA8naQ/nJIRSbZkTJUtr6ID+ctV0ZCzuN/C9Y1WRNm0RW
 tbOtK7QSsGN0gxVwOdqh4VO8ZbrfdPnX8dDCFYHCvIgNGOdgB+lVCGfrEbiay25wF1RRD1UC9
 5jG/o6a4Qx+fmu/AwYKKnzrPRXfuF1L6FXNJajLD3LjpwQcpayNhElkDJAqlAwN0TkHP5p98L
 U/BLNGCTHX//9VtfByqfEP+O2zE2yVJnVl6NfogHiTp8tRqsjTSaYBKxgETJv0JCU6WI5JE6P
 Q69bG3qoCIziZWgISZ6GYiZBtHiZasHp5Eb1zOW1qTBaQZ7rxPkREtmL3ehgZ1Mfk7K+X2+lJ
 lvW/I0kt72MwtJSy2G1vz0KFlwkJ6moikTV1+TCf9YBLXoFgweqOvLC8sp9tySCdAitDrJSCO
 qrLoZvuxNndczTrrgQgrsp+lPLXaSY3YKJ4Rr04rRGez0kk9Wu+DICtwtZmN8RNDcjtrwE/nx
 jOAFR3sWABwG0QFTfB/YHp2k/GlHUGm2iBc2UgQuQE6DECvt7FBxURPhqC6fI0S39cPFpQyd2
 Ab/VRDGZ2//iTbidClcEv9MuUS6vnBKcR/210CxBB7qUP3N0+s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 03:55:58AM -0500, Jeffrey Walton wrote:
> Hi Everyone,
> 
> I'm seeing this issue on Windows: https://pastebin.com/YfB25E4T . It
> seems the filename AUX is the culprit. Also see
> https://blogs.msdn.microsoft.com/oldnewthing/20031022-00/?p=42073 .
> (Thanks to Milleneumbug on Stack Overflow).
> 
> I did not name the file, someone else did. I doubt the filename will be changed.
> 
> Searching is not turning up much information:
> https://www.google.com/search?q=git+"magic+filenames"+windows
> 
> Does anyone know how to sidestep the issue on Windows?
> 
> Jeff

Thanks for the report.

(Typically nobody (tm) here on the list opens a web-browser to look at external
 material, so here is a shortened version of the pastebin:)

error: unable to create file crypto_stream/lexv2/e/v2/schwabe/sparc-2/e/aux.c: No such file or directory
error: unable to create file crypto_stream/lexv2/e/v2/schwabe/sparc-2/e/aux.s: No such file or directory
Segmentation fault:  99% (26526/26793)

There are actually 2 problems:
- The filenames named aux.c
  It could be that git -c core.longpaths=true clone xxx
  works, but I don't have a Windows box to test at the moment-

- The crash
  Which Git version do you use?
  It may be a good idea to report it here
  https://github.com/git-for-windows/git

