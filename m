Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A82A1F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 09:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbcHQJUm (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 05:20:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:49259 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbcHQJUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 05:20:41 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LhOvA-1anfkP10iG-00mZis; Wed, 17 Aug 2016 11:13:45
 +0200
Date:	Wed, 17 Aug 2016 11:13:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
cc:	Stephen Morton <stephen.morton@nokia.com>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	git@vger.kernel.org
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
In-Reply-To: <968827697.1226723.1471337060482.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Message-ID: <alpine.DEB.2.20.1608171112580.4924@virtualbox>
References: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com> <968827697.1226723.1471337060482.JavaMail.zimbra@ensimag.grenoble-inp.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3eqoMddH8khfxGscnoj1w5bA/7lskesuLoLOUxtTh2jOYFLbhV4
 KBhJS3c67kIK6r1ew7YK+y6IBloVfi5VBG+Cx/6NjFCP51Bo+ZOe9ELx19wkNzAEY8EKn4Y
 SZjxNy/GD48SBq5LNiFJXreeyG3+hh9JT8OT98V4eafZmwQ35yL5fQCgF3VoLateQiglm8v
 Ybv8qG+KKdIrHtAwRfAcg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:4UU1V1ZEWkA=:EM5EeAogl+R/0G3QqFp47o
 dJxXhsYqwCP4Gd+qv9EtfyEzSVsL0T4ZfoF/KO6vXMDyddW5uePqcXLV/UqNTfbpX4QqTHKj2
 eFfSRO3oWO3bclMa8u57/WXFrD1xRqKFTSB10iuB6f5Zg03R1JVC17PuXQ/YS5z3I/e2eOARY
 mY26a/tKGYWMD/HkMZCBa334A3C1qKdzM3BaTkTZaILo/1pRAFHYgZ7WIxUrfgdboN6Pvv3xF
 Aza0NyYaxlISQfS0iYbKcI+qk7oTM+lHaUa5KufWPo4Cn6wp8Ij3a7MXxidd/bROx1xhz9r5R
 377E0+qE4lzMtb6N4UT1navHbj9zp9sArgdFJW1OZLdrzWNGT3vubP2PKmTdFwv09Yalow496
 NxjWrE4dOdWa9I7EzRHjw732cWbuskt0XiVqe+M0U7aQJDmwlQItC9O5Wj9I6OaTuf3umrw7H
 FFA4/6pMzCUyFPfwptoeB8z6yYhjuxstpsqm766TM7RmaIFVu7MjnKEu8kUDbSvzD0+vwkWQL
 HzXllEl/fZmWsOMo3a8ENB5o9aG1FsjNfxPqICDlKA+Jrplfaw8cKT1vLfLTPxiRSB6dVamzU
 /xw18tXCz2zK+alU72LSuIN8eIegv0dps5IV7upJ86qFGnV+kSmoN2+EF4hYiV53aqWNTjfjJ
 AAfOlYjouPYora5zfSr90T5qXc3kRLFY4KVSoPDF8/kT3nzH/jtZ0Auc4MllFwtAuFObybHU3
 dDFP0/bB4hg3c0WDzb09lPEDZCdOILnS+QIsk1ZS3oP5YJDH8CaL/ctG59X6BX4g/Rzx7/JRz
 BPLq9gI
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Tue, 16 Aug 2016, Remi Galan Alfonso wrote:

> Stephen Morton <stephen.morton@nokia.com> writes:
> > +                        if  (multiple_commits)
> > +                               advise(_("after resolving the conflicts,
> > mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
> > +                                        "then continue with 'git %s
> > --continue'\n"
> > +                                        "or cancel with 'git %s
> > --abort'" ), action_name(opts), action_name(opts));
> > +                        else
> > +                                advise(_("after resolving the
> > conflicts, mark the corrected paths\n"
> > +                                        "with 'git add <paths>' or 'git
> > rm <paths>'\n"
> > +                                        "and commit the result with
> > 'git commit'"));
> 
> In both cases (multiple_commits or not), the beginning of the advise
> is nearly the same, with only a '\n' in the middle being the
> difference:
> 
> multiple_commits:
>  "after resolving the conflicts, mark the corrected paths with 'git
>  add <paths>' or 'git rm <paths>'\n"
> 
> !multiple_commits:
>  "after resolving the conflicts, mark the corrected paths\n with 'git
>  add <paths>' or 'git rm <paths>'\n"
>                                                   ~~~~~~~^
> 
> In 'multiple_commits' case the advise is more than 80 characters long,
> did you forget the '\n' in that case?
> 
> If you end up using the same beginning of advice, maybe it's possible
> to give it before the 'if(multiple_commits)' and avoid duplication of
> the lines.

I concur with this, and also with Christian's advice to append the
parameter consistently as last one, and also with renaming it to
"last_commit".

Ciao,
Johannes
