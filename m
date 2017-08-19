Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089F5208CD
	for <e@80x24.org>; Sat, 19 Aug 2017 05:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbdHSF0z (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 01:26:55 -0400
Received: from mout.web.de ([212.227.17.11]:49291 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdHSF0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 01:26:54 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrJse-1db3Vj05SG-0138BD; Sat, 19
 Aug 2017 07:26:39 +0200
Subject: Re: Bug?: git archive exclude pathspec and gitattributes
 export-ignore
To:     git@vger.kernel.org
Cc:     David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
Date:   Sat, 19 Aug 2017 07:26:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:36VJSQLT1TDq0T7u8ME20/szV81xDekSP164KOUXvkrYEVdFN5j
 Xhov2zZN+iTVLSlyqDW6BX8MoDDL41rlysjBR7o610M5z4ThrKcN6DouZiJz1Nbm4WDG/2b
 BLBbfLzjYRaBBbDR2VVv5mgFq/Fb4LuO9VvdRo3F6UkaM5f6iwSiQxrbfHCL8zR5yqV3Jq2
 wogQpdzq05ALI8kj0UlFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cgonCsh9km8=:eTZ1qJg/7bgA4/pGXfa9uC
 78OwgwFjyMuW4OJQoXAx9ZID7+xLoA7Z69H+7kaqUNJsMLYSKMmsx7jUPIfOfDTExFfipnx+Z
 LOJd3SHOQksnuBWw38Eoe77Pa92Rp3e9THrUFrmApZkDmvzVbCxsJd5UqI0TJWcLoxKHUxMSX
 XfTbh5bXttJV4iH0xEoLG1lgcaxT8Fjnar7AoAGFGtZ6jRFHOlzEGmwriQHRgF7CbulGMcI65
 tiuzTs0rNtkoJBJ9vOYbXHxa8B03lxJ87wxCQwR02DnFjzsi9sfPcpqDpymiJe7NoZFYhfPrg
 txbFjb9Jyx/bqPd3tKQvDcS64QPsrtW8UtDtT/Dyn1/kYkmjaITufCDCaD61NPRmSDvXPAllZ
 hSZzIYe3AoAB46M7+KKrfjhTv6UanLR4lu/z1a5Q9X96O1Y959j83i6GbutWK7nm4FvSqAPFe
 K6gR54LGdXPHF0mI0rJk9lEhgSH+mgG9ql/cyiR9LwkDcQHhBGjsEx8qG32VWPna2Z48esbUt
 SRpkhgJyle1fsTdQz9yPlpfOhZXj+4mqR/Glkp2xwc3WvK6O+ypOoqKBWLpV5LechDWcoX3ik
 AagkfaDv/EZ2aXq8gmiQoUB7UkWqL6iTJOdOYC5m0GV0q38deWZrgvjbQqMYEX373aAxh4+5b
 aMvp7Fh590G2dqjVP9gystYcE7mhRnXTQkRExlsW4IQwwwGp6F6PzU8SpTT8LAsdtQOpSUhwL
 MvHCjYPVs+4naTCCsodHYOA34CVUNxwOkoh8StDaMD5PoRrsy1ezNaHjsTScSQhfw3C79c1JJ
 V35uBopst0jUvfaGQr2rXFCWhiXpp39m2/os4xskMEU5ExFvjo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.08.2017 um 18:43 schrieb René Scharfe:
> The real solution is probably to teach tree-walk.c::do_match() how to
> handle attributes and then inject ":(attr:-export-ignore)" as a default
> internal pathspec in archive.c::parse_pathspec_arg() instead of handling
> it in archive.c::write_archive_entry().

That's complicated and I'm not sure anymore if it's even a good idea.
Let's solve this in git archive for now.

  t5001: add tests for export-ignore attributes and exclude pathspecs
  archive: factor out helper functions for handling attributes
  archive: don't queue excluded directories
  archive: queue directories for all types of pathspecs

 archive.c               | 49 +++++++++++++++++++++++++++++++++++++++++--------
 t/t5001-archive-attr.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 11 deletions(-)

-- 
2.14.1
