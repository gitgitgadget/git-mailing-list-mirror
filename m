Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41BD1F790
	for <e@80x24.org>; Mon,  1 May 2017 11:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164657AbdEAL47 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 07:56:59 -0400
Received: from mout.web.de ([212.227.17.12]:57388 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163999AbdEALzT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 07:55:19 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEVlN-1dKH8y41gf-00FiN2; Mon, 01
 May 2017 13:55:06 +0200
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
 <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
 <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de>
Message-ID: <8754b32d-9eec-973d-a225-175085fc7e82@web.de>
Date:   Mon, 1 May 2017 13:55:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JB/ZuonZ2KRZ6YlmEoqx7lRnVG6QG8mzuT0Yl3nHhgGYMbStDt2
 i2yiFvG2isXPrAZJtuwvrnRzwWvV29J1o9H4H4Odfet+gtMnTt8YTBe903/k7yc+z4pBfwD
 n5zLyp3F2I1VZ+TzbvaKmC7R4KL1Yuo/sYhny3Ud1EgMUNa1TJ0uKo05+yyyZVDFgoh+8++
 I24jbDEYS0452ccHX8NUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vXm/FDzlBtw=:NyujCYhKB8OtnwcbqYy7cm
 wFmANsvY2mLLKyG5HfcKGCgxZHZTdokHqn8Soec7WVd8GNKtk+R+bSSiekEcrD0kaC9lplRp4
 REEZJ3V/NPfS4PxD1lRIdj9DDIjM3QlG2sJwT/5QSgwiurCLLY4szYAESfa7G5OWlG3qY0CdT
 Y953kuEMv3tfwpK9Zks4+UBi7Ou0THmtraRpxC2pF2WzGtkCaMqKpVWlYJZ/e4ZfyXejTsXaM
 xxKalmw22rWJswR32TuoVwpZAT/UIKLwEXicAV4PZSiW4f/NMHJF/8chV8Ua49nLZhEbhfVsD
 85/GasAktPsjJLGJn2wGIDs7B+Fo7Vxyd+FUHtFMp8LIUyRw6ijgyjHaRLezk2zAwvbUX3lYn
 NH9EYQRe8VYPsYvtpnAzg2Lxh+o5wLYW3ZLXw33VBbZKGcMmDRX9OU72tMe8hTilhBt4OUH99
 39/SiKbYx9GNvD2+5FAY6KIfCAMgn3HXRtki6JY5sVnwMmF1mhgVNZvQde1u2VEhKun3GkCaD
 1zpnb/HywhSAqe4BJHb1R2lrCGaDihKC4CfwbUS503GJVO56eL/I/955PhgSmrdlWf4CWlnoT
 gKZUJ6IkbpBMH6vBSPC0FL2EIgqNVqWRj9IwMsAVeYwZiIPp93ZoRZIDDBh4YjexFry5v2ZQK
 jDCSlNCv8JKwG7tmGGB/3AvWCyi0lpMG5j1uqXLLdbQ7l5z9iYqZx9qLHvIba5N/okEXuh1k+
 LCCjw5K6lcy59rIjqiaJj9zDeprIX5ytiZJvyvrmH08cIVbKZIXZebfRIh6x9uS8RtShhQiy5
 S17KM/a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.2017 um 13:23 schrieb René Scharfe:
> But I can't get Valgrind to report overlapping (nicely explained in
> http://valgrind.org/docs/manual/mc-manual.html#mc-manual.overlap, by
> the way), not for t7009 and not for the short test program at the
> bottom.  Do you set flags in GIT_VALGRIND_OPTIONS or use a special
> version of Valgrind?  I use valgrind-3.12.0.SVN from Debian testing.
> 
> Thanks,
> René
> 
> 
> /* Compile with -fno-builtin. */
> #include <string.h>
> int main(void) {int i = 1; memcpy(&i, &i, sizeof(i)); return i;}

Actually I can, on Debian stable x86 (Valgrind-3.10.0).  Not sure
whether it's the older version of Valgrind or the 32-bitness, but
it gives me a way to reproduce, so nevermind.

René
