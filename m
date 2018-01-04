Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4C81F404
	for <e@80x24.org>; Thu,  4 Jan 2018 17:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeADRAB (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 12:00:01 -0500
Received: from mout.web.de ([212.227.17.12]:49708 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeADRAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 12:00:00 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvBMs-1ex5z62MJ0-010NLj; Thu, 04
 Jan 2018 17:59:54 +0100
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
To:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>
 <df39f62558314cf6a9d9df3e23f31dd8@OS2PR01MB1147.jpnprd01.prod.outlook.com>
 <5A4B2DA5.907@hiroshima-u.ac.jp>
 <59a1fc058278463996ed68c970a5e08a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
 <955dae095d504b00b3e1c8a956ba852a@OS2PR01MB1147.jpnprd01.prod.outlook.com>
 <5A4D9089.3050209@hiroshima-u.ac.jp>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f7654cd9-2cd0-0775-3b10-8e3dc1a66dae@web.de>
Date:   Thu, 4 Jan 2018 17:59:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5A4D9089.3050209@hiroshima-u.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JZUg5gs3UONKj9oW1IIDmEe07nxEg1zP6dNImFSHDr5M54S149K
 nhAhgQnfoaSEwxUQ1435A/xTA8mWm9HMCsQ/PzK53VHla0UgB6gshr3QyFXMQv39Llw1t00
 fsNXqDOmXVxeqTX2JfLOAcJijwYw3Fed5129u+B4jCJTQZVNvQEHBfZeiurFDjzIUOxK4L9
 XEt3NvlaoxDvcOHHvDdeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GAg+7rsFLos=:DOkJQvyI+egmJo53Dm0PZj
 r4AcP5mp5LeprIZdGbdtWkRYPFr1FISXiDH5ZROxByr81nyvppmPU6caFsTUaEqjCx8kCU/ec
 9lWIvKxSzbERHc59RYIzAiDwBrwXF3XjqyGyNG5c6UxAqnz0+uk1k+wM9+GCIDwRVUayl6FfD
 OzZOsi+aYfb+hfQRhULcpclizvWfGX7SefPPW1McKvMbH4xYhHnpM4B+fGWQs5CJil+7nu256
 g6jF97rghg/BufIByF3qxbPJt1WnSULYXV7+LMQ27i3agNdm6hFPdWQ4sYl75zNGIL2YN/XmF
 oqDJDuDRdQ6c+gDos34abQkeooeeTuxc41z5Krp6AIVPYtUHDpDqYO+Hh1bCJ1jfyeBwoIQPn
 X4L8IixZozuL09eKzgasR4LPXUkz4470dP1nZ401YXymdkNKzOr21GriUTtQexgzaLG/cJAl2
 cD/KRsM2L2K8jlTwnyo/rHPHKx97iPU+oEq3jT72s9TjZD2oQyRFOGsEStQfgiMhRgZKt3YV1
 qn6A4Nw6wmoUS3TcE6FLZms1AfS4x/ZtUpD3+k/mV780kfB8cMc/jjrugcTHnW2R5eTDM6OP7
 oyvul1iG23oe4HAmT4OekZw7ao6qqemwbPckjwi2iP3ZYdHcD+rz68FPaI8PJRtlIwxoDsY5w
 g1AVXwMj53E2Psuqt0rovAFe8b7MYwxMRYS/SE00nrNj1WIZmUdL6dDAUFDKe1OKzFmSb9XvQ
 VSrQeYlLPPp4g5WohH2a/sehzjTweOEi+rIYmleRZdpYT/vblPTr05of2wDD5zVi77YkBI3Ei
 uTPHkOKm6YWQ3MHx70gY08bLc7yUDr7UyCr4LfoWr3A4pkuPhE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.01.2018 um 03:25 schrieb suzuki toshiya:
> Taking a glance on parse-options.h, I could not find the
> existing class collecting the operands as an array (or
> linked list) from multiple "--xxx=yyy" options. Similar
> things might be the collecting the pathnames to pathspec
> structure. Should I write something with OPTION_CALLBACK?

There is OPT_STRING_LIST; Documentation/technical/api-parse-options.txt
says:

  `OPT_STRING_LIST(short, long, &struct string_list, arg_str, description)`::
      Introduce an option with string argument.
      The string argument is stored as an element in `string_list`.
      Use of `--no-option` will clear the list of preceding values.

I don't know if it's a good idea, but perhaps we don't even need a new
option.  We could change how pathspecs of untracked files are handled:
Instead of aborting we could include them in the archive.  (Sounds like
the simplest possible interface, but may have practical problems.)

René
