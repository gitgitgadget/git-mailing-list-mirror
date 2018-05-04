Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6874D1F42E
	for <e@80x24.org>; Fri,  4 May 2018 06:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeEDGlD (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 02:41:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:54045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeEDGlC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 02:41:02 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7ojs-1eSJee3bou-00vSJe; Fri, 04
 May 2018 08:40:52 +0200
Date:   Fri, 4 May 2018 08:40:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet>
 <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pD+1ZcliPkCrSWPdZj5NDaUZDP31khGk9hdxCBxEKkyShyAJdaf
 EBV7vUt2DdIKGFCl8jYJ59D1TFSiLFZppQmtY21H5POQbmcBOfu6z/o2fT7KvXzNnaawHVB
 z0Mp3ZP/LI4u4cTZEwhinjMGAR82WQo7XX1deU7PQ4Wxyl6fR2lREW+3Nw2vcTJxftDTTF3
 knlOiV/E5tabHj5B2Nxlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SNUVWe8lICw=:Cu+mvbMo6mQnzfTeDI/1EW
 so/ojSZodz+hP/c7u25Lap4jlMddOnMgL9tnvq6JPi5QQr4+kGmuxQn3FE0SHEiNU684vKjWJ
 jUkpARzWEGUT9onsgfkaE/UzVYbfKPF4SkgIc5g//iQMOqpjON5sG8ixSKQKnP/WyH5MQiNTq
 wj6a2qMgt9jw+8DleBftPxTo0CpYJb9xCs18ExWrqpDtWD5BGCcuIbCI/OAVLUTRDbYoC62S9
 S3sO0rxZTBrfwIJdYyyCe21ROVDKGHdn26rfGaglToPuARi8vh4ToTGrAcSezf+EccGq/42ua
 uLqAgxBc9Nza3r9xb1uVSQIiyOXP6wn7OUpmjrinkuS1bEclImge5PBaJ1AEZHrIw6eebUw6A
 qwWBk+Ve/0vxJlrNHL7PWxiCqQRlV0tfyukk6SXk7VpRn8Lg/tTvByhOF6N4a4jG2YS+Svd3z
 o1VDSS9+ILbydhhJWFS3X0gyXewlJU7EuSB8rzoOQbIZwwfG05vmOKz8OXS0w5SqidXykbml9
 6wuilZugUPTKpA4gvX8pGtbg5yTDgI+ZK+FXSAZWEwgm2cq3ZslwPFKwcJTgMPDCNwBzcsBon
 B+tEi/+exKhCpI95dSJAwni5SoGJoWnyg3ODxf+6uf21dil2Yj7GUl7rqtBdRfxfbiSFFxOMk
 tFBf8+AvyVitJUVSBeeTShY1LCOlWX/WOgJPF0c0XG8xuis7TWtt7mjhfa7n0Z02tBLryzMBl
 K39e0cWdS/IheUVJvQgwlKJ+v6PbhJmYCcbcpOOfMJHwlQpl5gFjMihPEgppPgPjWv1yw0rlm
 ZalO3qP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Fri, 4 May 2018, Ramsay Jones wrote:

> On 03/05/18 21:25, Johannes Schindelin wrote:
> 
> > On Thu, 3 May 2018, Ramsay Jones wrote:
> 
> >> On 03/05/18 16:30, Johannes Schindelin wrote:
> [snip]
> 
> >>> diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> >>> new file mode 100644
> >>> index 00000000000..97266cd326d
> >>> --- /dev/null
> >>> +++ b/builtin/branch-diff.c
> >>> @@ -0,0 +1,40 @@
> >>> +#include "cache.h"
> >>> +#include "parse-options.h"
> >>> +
> >>> +static const char * const builtin_branch_diff_usage[] = {
> >>> +	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
> >>
> >> s/rebase--helper/branch-diff/
> > 
> > Whoops!
> > 
> > BTW funny side note: when I saw that you replied, I instinctively thought
> > "oh no, I forgot to mark a function as `static`!" ;-)
> 
> Heh, but I hadn't got around to applying the patches and building
> git yet! ;-)

;-)

> Sparse has two complaints:
> 
>   >     SP builtin/branch-diff.c
>   > builtin/branch-diff.c:433:41: warning: Using plain integer as NULL pointer
>   > builtin/branch-diff.c:431:5: warning: symbol 'cmd_branch_diff' was not declared. Should it be static?
> 
> I suppressed those warnings with the following patch (on top
> of these patches):
> 
>   $ git diff
>   diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
>   index edf80ecb7..1373c22f4 100644
>   --- a/builtin/branch-diff.c
>   +++ b/builtin/branch-diff.c
>   @@ -1,4 +1,5 @@
>    #include "cache.h"
>   +#include "builtin.h"
>    #include "parse-options.h"
>    #include "string-list.h"
>    #include "run-command.h"
>   @@ -430,7 +431,7 @@ static void output(struct string_list *a, struct string_list *b,
>  
>    int cmd_branch_diff(int argc, const char **argv, const char *prefix)
>    {
>   -       struct diff_options diffopt = { 0 };
>   +       struct diff_options diffopt = { NULL };
>           struct strbuf four_spaces = STRBUF_INIT;
>           int dual_color = 0;
>           double creation_weight = 0.6;
>   $ 

Thanks!

> The first hunk applies to patch 02/18 (ie this very patch) and
> the second hunk should be applied to patch 05/18 (ie, "branch-diff:
> also show the diff between patches").

I actually have a hacky script to fixup commits in a patch series. It lets
me stage part of the current changes, then figures out which of the
commits' changes overlap with the staged changed. If there is only one
commit, it automatically commits with --fixup, otherwise it lets me choose
which one I want to fixup (giving me the list of candidates).

BTW I ran `make sparse` for the first time, and it spits out tons of
stuff. And I notice that they are all non-fatal warnings, but so were the
ones you pointed out above. This is a bit sad, as I would *love* to
install a VSTS build job to run `make sparse` automatically. Examples of
warnings *after* applying your patch:

connect.c:481:40: warning: incorrect type in argument 2 (invalid types)
connect.c:481:40:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
connect.c:481:40:    got struct sockaddr *ai_addr

or

pack-revindex.c:65:23: warning: memset with byte count of 262144

What gives?

Ciao,
Dscho
