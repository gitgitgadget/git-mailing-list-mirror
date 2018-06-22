Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620EB1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 21:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeFVVpU (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 17:45:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:59529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754265AbeFVVpT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 17:45:19 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ld0jY-1fwyud1oSO-00iAiU; Fri, 22
 Jun 2018 23:45:11 +0200
Date:   Fri, 22 Jun 2018 23:45:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/7] grep.c: teach --column to 'git-grep(1)'
In-Reply-To: <20180621120159.GC15293@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1806222344280.11870@tvgsbejvaqbjf.bet>
References: <cover.1529365072.git.me@ttaylorr.com> <cover.1529524852.git.me@ttaylorr.com> <20180621115302.GB15293@sigill.intra.peff.net> <20180621120159.GC15293@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GhE9+WZV0uQS5CS8Lq4ynMvIj02JO4JPTbdh2dfys6gEyY1hCJm
 KSWizkqWOJnNcIybjm2CJzd0yMDyHkdyf3ByjzUOHOaecyYAi1ZLCLEvKjiOJbZAq3yIDX9
 ebwJtnl75JLPcGP+nG6KC8/x+oYg6hn1tRcdPHFX9bmTdt0OCP7SV0oMv4pspzS8+CB+rqq
 ffOrIbyciHyHw9IZ6utIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FwYALWZ4+6E=:XKUl6QEIAWrFPBH4Luo8+v
 7V5am8TzGKDxDWWPciHTgU2qDXll8rLkrHHIHnffD7Ztz0Tn6HRSyig1SJuBHogSQhQ5hUY3D
 wuszDNFaCMtPuv2qWIqoYbHJPCDaC67hZAfV2XPP2VmE50BtfTMm8HlPopyde6eY8ItnDkbSf
 4QJ0JcBcwKMugjrBH81HNeBecCDpO/8CNJBk9o0TUkN9w+4qRz6MJmx3zujGODYV0a4ZyZmiy
 40jUV4+GO+arwj+DUUwxzdVt5ZLMmTdLgMzS5n7LgIxaLkkOp8ypSNaKXtGQnpJCSqF4vERJ7
 y/t2QJusheHBKdvyW5OaGmXfoRR+Hh42fGHx0hJWw0eYSIVPxOm/rzKw6cwZXPDYzdwGWAAXx
 lbJbqfL0nFvpMwbChZTdl2a/UfNGu1LcRG6R+nuTC51cDaj0gfKR7pNgl8e1Jg/eWGu/PtQUX
 NDpS77y8Ge0yCYgTETkVO4e9mZ3rCGLSIGd3igGDpzqiF3b0rl7JkNZL/I56bVHmn5qdRXevR
 VNLGS9OdzPc2nsy4QcrBpkfAh94kNANJYUEdFoem1uDVuGckMdyteT1qFfM5e+7pH43B6ezz5
 TDsOkMPo3Jrebz9XI7ay7WQF7+fzOEitxh4tdVnR11hxIh7W1SxODFqIOG59pS6+6pRMVXDhp
 PB7eEI2VkSQWouuZpnXMeVvgAO1tjq4kIjNeIRL/DTYsXKvKcxCH5BUsiUChEhkVk/wrFwHrp
 mDb6nkvtGbg2L3UO35R2QYM4ZDwJoPIkWCt9mioi4zxpzZkvs7APIi3zXhYLEMOU4+2Hf1H0C
 zuYciXN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 21 Jun 2018, Jeff King wrote:

> On Thu, Jun 21, 2018 at 07:53:02AM -0400, Jeff King wrote:
> 
> > > @@ -1429,7 +1447,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
> > >  	 */
> > >  	if (opt->columnnum && cno) {
> > >  		char buf[32];
> > > -		xsnprintf(buf, sizeof(buf), "%d", cno);
> > > +		xsnprintf(buf, sizeof(buf), "%zu", cno);
> > 
> > Unfortunately %z isn't portable. You have to use:
> > 
> >   xsnprintf(buf, sizeof(buf), "%"PRIuMAX, (uintmax_t)cno);
> 
> To clarify: yes, it is in C99. But traditionally we have not required
> that.
> 
> This might be a candidate for another "weather balloon" patch to see if
> anybody complains, though. The last time time we dealt with this in a
> major way was over 7 years ago in 28bd70d811 (unbreak and eliminate
> NO_C99_FORMAT, 2011-03-16).
> 
> I know Johannes switched out some "%lu" for PRIuMAX as recently as last
> August[1], but I think that is more about the Windows size_t not matching
> "unsigned long", and the decision to use PRIuMAX was to match the
> existing codebase. AFAIK %zu is available on Windows.

Nope, it's not available:

git.c: In function 'cmd_main':
git.c:733:10: error: unknown conversion type character 'z' in format [-Werror=format=]
 die("x: %z", (void *)(intptr_t)0x123456789a);

Ciao,
Dscho
