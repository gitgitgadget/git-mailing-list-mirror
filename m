Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436D3202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 20:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbdKWUJc (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 15:09:32 -0500
Received: from mout.web.de ([212.227.15.4]:51206 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753276AbdKWUJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 15:09:32 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Le4fk-1ewmCV28JI-00pxDC; Thu, 23
 Nov 2017 21:09:15 +0100
Date:   Thu, 23 Nov 2017 21:09:13 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: RFC: Native clean/smudge filter for UTF-16 files
Message-ID: <20171123200913.GA29990@tor.lan>
References: <BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:7HsImhXnO9pSDvW/pQ84QWysQvl0yOqXnOHckFgiMJVlG/GBumg
 9Az8VewxiX0bMDIgD1h0U3U4x9Pt8Kd6JiZNNLjEHsThzQDiWffvKFpXb+N3HwN7s2JJWRL
 RwB9hv7MGXUjT1h2CIfPQctR/qNSTyIFBGaaxhSI1086KTQqDT4Z1nmDGcHqjay+kwW08UJ
 3+Vi6XlQm0xo2C8fNkXxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BxOZ/jdAMkc=:6vGo1q5LXnIcKCgDxilnj0
 AfXtu92lekmaQZq5EztxCVUQ1BflKRRbHC7/i0FhIWJV02eXpnKLtrdfWPWxr7Yl/XcqfwOl/
 H64FJIQ+2Gd4M79qCsklcE3NoFb11gjdIOd8aQpyQP4sMAkL1Qg3mRJAOiN+q98LHaNsDzT5m
 CbZqFiXhe7M8+IQzF96ymIAo9KgJGAoaJlGUFHXyGZT5f9xwaivtJ687Bq+T8ah3O5KeclRmj
 xmMELnlX3BWimpANDN1XxZfdv0D59c0KIkV3TJRuUUzWDd0UIwODBDpjs2BrJTdg64jwghBTR
 GmQY4GWqWm0XdQw41oa4/5ynL/91NXJqLZy1G+/De6aje3rLruGehFpe+Hcg8ub7VsDbD4vzt
 yrqDcJU6Hu3tgDNely2/8hZpc3Hxo3/fk5xGApeQk5heV5I1B3hyozGsEubOaIz+tlnNqPGyS
 l6F3uO9dZvVLikA+g3W3jHc6/exTszUkdM8FswLg5RywytY1WmL7fSV7OjiRaAfFkgqsNVY5A
 5QIaYlyuQlYCkxfD+YYyUamVwUVnL8qFACiPmaArm/EO99EcKYf2xCnNbTkK2vWesqFp6e2GL
 DAKu2Oz+c5asnjLNsCUN4JIjY8pzGSz5jVx+LfZO3ACQ5YK4c/Wy6Ygaz7hjOxSg4oqcJ4Qmr
 CFcFuNTl0n5Wgl5YtWT2cmhzygByKW32FBEzvDVrHWlZmgD1OYTSCmXdK17rljl2PJtq027SD
 XVOTw1yJ5nnHbeRoR71hD6H8RCz11in2rm9a+1IY9CrCMBWsKVy9i7m2x9gfjQMo/bruz6Yev
 9uN1DY763blOjhRwCwfHG4FZzpRlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 04:18:59PM +0100, Lars Schneider wrote:
> Hi,
> 
> I am working with a team that owns a repository with lots of UTF-16 files.
> Converting these files to UTF-8 is no good option as downstream applications
> require the UTF-16 encoding. Keeping the files in UTF-16 is no good option
> either as Git and Git related tools (e.g. GitHub) consider the files binary
> and consequently do not render diffs.
> 
> The obvious solution is to setup a clean/smudge filter like this [1]:
>     [filter "winutf16"]
>         clean = iconv -f utf-16 -t utf-8
>         smudge = iconv -f utf-8 -t utf-16
> 
> In general this works well but the "per-file" clean/smudge process invocation 
> can be slow for many files. I could apply the same trick that we used for Git
> LFS and write a iconv that processes all files with a single invocation (see
> "edcc85814c convert: add filter.<driver>.process option" [2]). 
> 
> Alternatively, I could add a native attribute to Git that translates UTF-16 
> to UTF-8 and back. A conversion function is already available in "mingw.h" [3]
> on Windows. Limiting this feature to Windows wouldn't be a problem from my
> point of view as UTF-16 is only relevant on Windows anyways. The attribute 
> could look like this:
> 
>     *.txt        text encoding=utf-16
> 

I would probably vote for UTF-16LE.
But we can specify whatever iconv allows, see below.

[]
> Do you think a patch that converts UTF-16 files to UTF-8 via an attribute
> "encoding=utf-16" on Windows would have a chance to get accepted?

Yes.
The thing is that we have convert.c and utf8.c (reencode_string_iconv()
and possible strbuf.c, which feels that they are in charge here.

Having a path using mingw.h would mean that this is Windows only,
and that is not a good solution.
(I sometimes host files on a Linux box, export them via SAMBA to
 Mac and Windows. Having that kind of setup allows to commit
 directly on the Linux fileserver)

But even if you don't have that setup, cross platform is a must, I would say.
There may be possible optimizations using xutftowcsn() and friends under
Windows, but they may come later into the picture (or are not needed)
What file sizes are we talking about ?
100K ?
100M ?

It is even possible to hook into the streaming interface.

> 
> Thanks,
> Lars
> 
