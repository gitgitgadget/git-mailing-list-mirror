Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B661F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 08:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbeFAIRl (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 04:17:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:54339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbeFAIRh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 04:17:37 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBin-1g7f7K0RkL-00jZaq; Fri, 01
 Jun 2018 10:17:27 +0200
Date:   Fri, 1 Jun 2018 10:17:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Todd Zullinger <tmz@pobox.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/18] branch-diff: use color for the commit pairs
In-Reply-To: <20180508021029.GC26695@zaya.teonanacatl.net>
Message-ID: <nycvar.QRO.7.76.6.1806011016150.82@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <ba4791918c78770005d552856d8669648d7004f1.1525448066.git.johannes.schindelin@gmx.de> <20180505234852.GR26695@zaya.teonanacatl.net>
 <nycvar.QRO.7.76.6.1805062146070.77@tvgsbejvaqbjf.bet> <20180508021029.GC26695@zaya.teonanacatl.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lMt5XlMvZ0QfU8MUy7MbDRoeSJ8tKXgdCjGdItukivqgcT/w+G5
 U23hRRiUTwOhhhBuPx7QOc9DemFaFqlbkMjx3VmY/g3B3/V+EU0eHpKThwrL77OLS3JGG60
 c2BpiGB5XmezOGEjyLFviOcaaO0X+j375ajWrY45ZXdckN55D8QTCgN7Zxu86PqE6CqN7I5
 mNBvPEr5XxVRPRKtDkoeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hH24si2JE+E=:rAxv6dmbWkj3Hv2kxhnSDt
 MGgK3VP075ENQWyERpINBLSiNN2qXCM24doA/8MPJs6rcYSdQpV8wvuwvvGW231sAaSD3jQBH
 EamfxHxm8hvImPbK5u2I/rIYHmuE8hHNt1jz1cygVjiF8tKUn0jx/ylTTMkT0fNHS0SnbesHd
 sm2XC3ApMfqsN7bSgKM63y4s9iMecEe0ynZ+uF2gwwNTmDdKwU3wLfya3UUa4soinDXHfjZKv
 DZOtfoFZ25IBznLG4REYSncbYgu4HGArHaxdF0NLgYzXxzNhZxIByXc4p/OIwzeOcXdmE22sL
 4yxSU1XxtMc1Zo9KAfDip4hcHRQgpulefvnmdqg3f0eD1pQzcFPXEmD2CMtaKz2dwqQO9BATZ
 a0vJMgh/cyvl1Y27CygvHFepf5OZS3ltrOTsNGmEbCIS4e4lXB5Dyzn584NYxraOQn6WuuDC8
 fjjMHnKfUzB+fBcl+5JWwIrtvcpE4JsYJ5Eqh/9/VMwDvWlRs4lpL7M++OhBRCeYewsWRTEEh
 4mpkdpnqslYHbkDJuMRxa35khprWYaPSotysUw+u2DBfXe7P/jfs9I0Y/2szqQp3d+GU8ZyB3
 zYObiWxv1f2mfY55wITYq4D5/fY06RjfyIGDm0wEjSbVGFLFPWOtITTAIUS0jQCoYMCVyFDzn
 pDjAaxzqKXtBPaDMuIisiwELBSdHf0t6eYRy2vvj0MDGEQ7jLgQF3Jkbe4yuLY3nEVZyOKoeu
 0HLhlHl60lwjZv5nkk8Ds63jpRHUX3kfxiA0VY7Gm66rhbqtf+NtvHqhnFpDu6AejNugrbxxC
 zOPlQxo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Mon, 7 May 2018, Todd Zullinger wrote:

> Johannes Schindelin wrote:
> > 
> > On Sat, 5 May 2018, Todd Zullinger wrote:
> > 
> >>> @@ -430,6 +451,8 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
> >>>  	struct string_list branch1 = STRING_LIST_INIT_DUP;
> >>>  	struct string_list branch2 = STRING_LIST_INIT_DUP;
> >>>  
> >>> +	git_diff_basic_config("diff.color.frag", "magenta", NULL);
> >>> +
> >>>  	diff_setup(&diffopt);
> >>>  	diffopt.output_format = DIFF_FORMAT_PATCH;
> >>>  	diffopt.flags.suppress_diff_headers = 1;
> >> 
> >> Should this also (or only) check color.diff.frag?
> > 
> > This code is not querying diff.color.frag, it is setting it. Without
> > any way to override it.
> > 
> > Having thought about it longer, and triggered by Peff's suggestion to
> > decouple the "reverse" part from the actual color, I fixed this by
> > 
> > - *not* setting .frag to magenta,
> > 
> > - using the reverse method also to mark outer *hunk headers* (not only
> > the outer -/+ markers).
> > 
> > - actually calling git_diff_ui_config()...
> 
> Excellent.  That seems to work nicely now, respecting the
> color.diff.<slot> config.
> 
> > The current work in progress can be pulled as `branch-diff` from
> > https://github.com/dscho/git, if I could ask you to test?
> 
> While the colors and 'branch --diff' usage seem to work
> nicely, I found that with 4ac3413cc8 ("branch-diff: left-pad
> patch numbers", 2018-05-05), 'git branch' itself is broken.
> 
> Running 'git branch' creates a branch named 'branch'.
> Calling 'git branch --list' shows only 'branch' as the only
> branch.
> 
> I didn't look too closely, but I'm guessing that the argv
> handling is leaving the 'branch' argument in place where it
> should be stripped?
> 
> This unsurprisingly breaks a large number of tests. :)

You will be delighted to learn that all of this is now moot, as I renamed
the command to `range-diff`, as this is what the wisdom of the crowd
chose.

Ciao,
Johannes
