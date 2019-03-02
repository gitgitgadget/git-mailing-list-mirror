Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D460B20248
	for <e@80x24.org>; Sat,  2 Mar 2019 19:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfCBTzG (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 14:55:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:32837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfCBTzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 14:55:06 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0ME47n-1glbCl3sQp-00HSNO; Sat, 02
 Mar 2019 20:54:53 +0100
Date:   Sat, 2 Mar 2019 20:54:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
In-Reply-To: <20190301220112.GA14966@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903022053290.45@tvgsbejvaqbjf.bet>
References: <pull.130.git.gitgitgadget@gmail.com> <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com> <20190301213619.GA1518@sigill.intra.peff.net> <20190301215414.GB1518@sigill.intra.peff.net>
 <20190301220112.GA14966@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HAUVjAqfmmhO8nYcj9S+mRn3lQBzRKfFYvRipt6oCQ/ltt07Sg0
 ojmw/dLSY27hNFlxQ+P+Rg4Jq/O7FFRhMc+66xoWV+lvKpg2xNS7KCLW4t/XVRM21VQpOiV
 QXsZKNphHFmViB6rROetwxMP1FoHmioDVGRlyjYaQVHxyTMdKmfp6/LAbi/nZvNMyqcNnvM
 xvcKye6v+lXhB52pArYvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/QKq7durrqo=:8e1inXPp0aAe7FYilsXFy9
 BlYuL8WSqQt9b6Bvb4wTwY+/7RI0J/QzT7oHJYPXEmS7DpatQmqYK+V+Bd7orLixVptmf0hXP
 yl5RZkKW7lyJ6H9zwt6UGZChvfjpDCi90F6rZzPQCIFsbjC70VgYS1UgfiSkJfi4a9rqQR2Vk
 dQk1wscoEvTEN4rm76M/dcCXeuZWrwDrkypMcs9AALEbYxxpKcj6//sLh86CZhu8guWM8HQBI
 RJ5YbzwiJPPLaV0KI6YDQlfXT3RDQYTuVmfXla5lUThQMX0WJhan/2m1EilIoReZVAcw/14LZ
 bI8o6zFoQ1ooaL24Eu4m/5O8kgBQ8I2Tsa2LEnuD0FsLY7QSne070oaU3vecG1fDnW87Bkb/l
 /uE/IY3zeIjRXO7mxfZfIeQoUOxA0jGrW584uOQkEHNRoJ17MWMSYGtBf6E6cZkB5WTSgD8Sg
 bbxNQC8AiBjU3hnadWlq+woiKO8isIl0wYxpp6LcE3MBmvvsXOkNG2Mp8RMdvloqQDaywb5Qj
 vQ8Clj3e9PzD5mG/KFZFBoeok7EYq04sw7GTTcEf/QGEpYCMFlxZuuT/o8UAJ7+ZEyp2RcEsp
 dwKy6fQk6VN3QewAb3Io0ezDZdWUlZsXcncuJZ999NW2zrMaFeG4L4riczgEFt1Lsw+dTG0X1
 7CxMeBbvhs2gXQXWcPI5BrwBJv8CvidCsSMtxXEHmog4dMzkZsZporg2Dutb1K0O78u+iEZeO
 P3QgaSfnAdWwozLkI1hdvp1O4VuTUVgleAmELveAVuyninSEbsoXRBLyuQlPLWfJXgGTBxrZK
 AJ/MH42iC0t15n6Pw0DoLRG4m9nXrzvCRYHuNdaLSALp5D+5zJVFvtcs46hQ8STL/0amzSjlE
 iAIvUmO9CZdChoKGmR23rvvS8adu7vZF0dD2r5HgZotMLvgtXy/iJwYaZm4EXUfw2Q1vR8fPm
 ZxHDkxtJHdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 1 Mar 2019, Jeff King wrote:

> On Fri, Mar 01, 2019 at 04:54:15PM -0500, Jeff King wrote:
> 
> > The one thing we do lose, though, is make's parallelization. It would
> > probably be possible to actually shove this into a sub-make which
> > defined the hdr-check rules, but I don't know how complicated that would
> > become.
> 
> This seems to work, though it's kind of horrid.
> 
> It costs at least one extra process to run "make hdr-check", and
> probably more for things like $(GIT_VERSION) that the Makefile include
> likely triggers. But when you're not running hdr-check (which is the
> norm), it's zero-cost.

If we want to go that route (and I am not saying we should), we could
easily just add another target (say, `check-headers`) that requires a list
of headers to check to be passed in via a Makefile variable that is
defined via the command-line.

Ciao,
Dscho

> 
> -Peff
> 
> diff --git a/Makefile b/Makefile
> index c5240942f2..ab6ecf450e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2735,16 +2735,8 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> -GEN_HDRS := command-list.h unicode-width.h
> -EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
> -CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
> -HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
> -
> -$(HCO): %.hco: %.h FORCE
> -	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
> -
> -.PHONY: hdr-check $(HCO)
> -hdr-check: $(HCO)
> +hdr-check:
> +	$(MAKE) -f hdr-check.mak hdr-check
>  
>  .PHONY: style
>  style:
> diff --git a/hdr-check.mak b/hdr-check.mak
> new file mode 100644
> index 0000000000..b8924afa90
> --- /dev/null
> +++ b/hdr-check.mak
> @@ -0,0 +1,12 @@
> +include Makefile
> +
> +GEN_HDRS := command-list.h unicode-width.h
> +EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
> +CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
> +HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
> +
> +$(HCO): %.hco: %.h FORCE
> +	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
> +
> +.PHONY: hdr-check $(HCO)
> +hdr-check: $(HCO)
> 
