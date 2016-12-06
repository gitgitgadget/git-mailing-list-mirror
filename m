Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FAD1FBB0
	for <e@80x24.org>; Tue,  6 Dec 2016 03:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbcLFDQx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 22:16:53 -0500
Received: from mout.web.de ([212.227.15.4]:64897 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbcLFDQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 22:16:52 -0500
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLK6-1cmszf0Kwc-00ZtxZ; Tue, 06
 Dec 2016 04:09:57 +0100
Subject: Re: git 2.11.0 error when pushing to remote located on a windows
 share
To:     thomas.attwood@stfc.ac.uk, peff@peff.net
References: <AABB04BF1441D24CB4E9FCF46394F17D666F34E1@exchmbx01>
 <20161202223749.2n7wa37e5w6446uv@sigill.intra.peff.net>
 <20161204080914.GB2415@tb-raspi>
 <AABB04BF1441D24CB4E9FCF46394F17D666F3805@exchmbx01>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <91983cb6-eed8-987d-bdda-c0fe55a9d139@web.de>
Date:   Tue, 6 Dec 2016 04:09:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <AABB04BF1441D24CB4E9FCF46394F17D666F3805@exchmbx01>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rVeanKXcruc67MJ5pwIUTDx1WFOvBATErBOPPGVbnEEiVBFzk+L
 0umOJJddT090yusRqOIMb+Np5NmwqPuifziNgzXaxLspmzZMkbI57RoIiRyPvtIY/PGIGMJ
 6WHy1mkxAY2btBemR2HeODZLbr6fzE0fHkdq8NPwCi/suwFja/5mBTaeIOtqpUUGhXi+TQB
 L+/WG/Vqirm7iFpJvI0Tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jAH7eTg5Zp8=:5xcmEcTKw5Ktl4HpXSCS2K
 MEGxGvSMrAeLhwT474+U4qQZ847fIEmYLw53TCVlrBws/1ki1YkQKngpzNeFAi4xB2W3nqGGe
 8HR5iv6qN/hFxRvz2XXi72R1n4G+d9yKiKXI5g3xH1mPSCcOG/Xo9kEuJtxE/u/Md/GTikf6P
 XA2oSXBK8UddB4BXuUi8ItSPTdwJVHujqjFPDNWmF7tHLmzRwTMkfF0vt+QkkUMXra61wAFMP
 n4l0IAQzR8fAxZdF+Tu0D1HONu6yJbhybN6UU1REi+SF7TXT1x0vRthak/UvI2toUypQoKzg9
 FiOpQMYF+EjZJOLgMgd0NNZX0pyvZRToyXKxbnVkhGhpzAhIg0lmfQXhW23xeIkqkus4TL/hn
 PMBS56ztr0L5dNiPAxfw4pTc9szNB/kRSN6UAz8fqsuJpJvLgFKVCFCJh/fgdylWLxykAVWxr
 uSla73UkyHrdjxHTy8pkZottH+7BzpyMlfY16evBNezl/SOlReUL2X7zYOrZjIdzVG33C2KXh
 8NPu3KuxZkZzHO3MUlqQJcE21QA0l4zzuo/t6e68I9MC1RobAlXhWBQ4jAzUIOijc7Fa17ucb
 nC0FG7H8hfv+tIa3tdlc/7HQ+2wCIn6vp75DZb3+U1cTywYk6lzhun7iO+V8TWGAvjPfMaRBY
 EHkDZEnFMk0kRD7VztQoiXGIppvHX88H1JSYrdPlpyHJrXPIJyXC1AMbQgFUVSkPBP+lzTKGd
 tkX6L1/9RyvKSLT/6DLFlp/9LbgjbBBVOFfGkwvCnlpSP051bNq4IzXiOu6s4h+c2PPp0egPI
 5JcM4sT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-12-05 12:05, thomas.attwood@stfc.ac.uk wrote:
> On Sun, 4 Dec 2016 08:09:14 +0000, Torsten Bögershausen wrote:
>> There seems to be another issue, which may or may not being related:
>> https://github.com/git-for-windows/git/issues/979
> 
> I think this is the same issue. I've posted my trace command output there as
> It might be more appropriate:
> https://github.com/git-for-windows/git/issues/979#issuecomment-264816175
> 
Thanks for the trace.
I think that the problem comes from the "cwd", when a UNC name is used.

cd //SERVER/share/somedir
does not work under Windows, the is no chance to change into that directory.
Does anybody know out of his head why and since when we change the directory
like this ?
Or "git bisect" may help.



