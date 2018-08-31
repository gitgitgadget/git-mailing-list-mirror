Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8F71F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIABsf (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 21:48:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:57443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeIABse (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 21:48:34 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4nYT-1fhCQL2TIT-00z0MD; Fri, 31
 Aug 2018 23:39:00 +0200
Date:   Fri, 31 Aug 2018 23:38:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Jeff King <peff@peff.net>, Gabriel Holodak <gthepiper@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Possible bug: identical lines added/removed in git diff
In-Reply-To: <CAGZ79kYVLNM4fMwXAw9FbKFNJ1tTR7e04nBqKdnYPX3wYveUfg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808312336270.71@tvgsbejvaqbjf.bet>
References: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com> <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com> <CAE6=WB_t7zG3jtELiMfggqxjvD4jJyJ02pNPmV3fey=3nSejuA@mail.gmail.com> <20180830025457.GA665@sigill.intra.peff.net>
 <CAGZ79kZNVw4-q9KYAi9G3axb7-Ggpc2EAK8ZxAZoPEnZvEL-DQ@mail.gmail.com> <20180830192019.GB19685@sigill.intra.peff.net> <CAGZ79kYVLNM4fMwXAw9FbKFNJ1tTR7e04nBqKdnYPX3wYveUfg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I71R5UM8/+lXetJKcqY3YT8TzVWmZn+MN6f4uyXpyl2a8zD1utJ
 8+PqQD6puF0OnxZorn1allWXtFDp24R2nZbmmxpXHpaUa8VfZxV3CiL+Qe3FSL5sFaGdULp
 KW5D6sjTrP2dgziR+nPSdZ1Ljvo46opPAg5pJ7Y2/8lGrunXmTgg5/ZLxa6zkXxXYz8Vmnj
 gMsussJMLgos5SdFTZsPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XkK2h0+ped8=:KrV2mTANWWS4PTKS85lgLm
 Xp9tmN9p5Pmevp2mG1bTkps6JZ032UuIZ7uMyyEWJFMD+hn2sQV8I5E3xnZbRAuI4pOM26tsN
 7yiTrlYDFy/i2Z1QmSZm+xiLfaZ6w/7lSi/aTNmOcUXui5BlQfeKtNhQtSH+hYu6Gb1PmUcV6
 fMt6bS+Ml3uyLtvZuAhEWvFnSKjcjfbyMYW41l2rVkZRaTWSWRN3eLVac+Wq27N9nEq64JedA
 XiUB8IQDWPYLbd4DQWQB2FxlNzhRAypDm3ZCPjJ/5KfdLOoJhd8h3WbYZt9TuRnDdbTOzrz+s
 AjnnlyocIKw+Gh9igR4+X4Nz68SyZvIt3CK8NQRmEFrPoBgfOzgirQUf5oS1qhokJyAAi2DKQ
 6Dk2zgkKpT7WjF9cI7NU7SrtDPUrMo2XX9ii2T6MXVidpPARC2V/3HP7NmTdr5EImnRlohe5W
 dLSbSPaVW5oh/5PZ9gXhDGXCkAn7TFwNU3gL2VyiiAeqIibWkATIsN5EEOARL6oVHrZ10nTyP
 qFzvut8PwfecT4VykkDjXbVHmMc4ypvDwrTaRJu7LA5rvKiP341/QJOFVBAfx8hSZPNhoPJ8F
 1fZ0bCbFtv+FElCgdIDcMyZMFEUXesTCS3oora9jgVaADYrO558l/Suh5ZOvjYv3UiNpINuN/
 IWrgjR4qNtRlV7+b66GOrdiAOLuw3NLsnfAAXb+dX1co6xiDIpDUPeL8lEK4xtHUjXaG3syq5
 TTVy7Soc+mUi7XgqdhIBLqnHBUtxpsg4ES0TJck54QmiJSF9du9WOXe1eb3hFaLrpRTkL7UH4
 ikvECn5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 30 Aug 2018, Stefan Beller wrote:

> On Thu, Aug 30, 2018 at 12:20 PM Jeff King <peff@peff.net> wrote:
> >
> > [...] Myers does not promise to find the absolute minimal diff. [...]
> 
> The `Myers` (our default) diff algorithm is really the Myers algorithm +
> a heuristic that cuts off the long tail when it is very costly to compute
> the minimal diff.

IIRC Myers promises minimal diffs only for -U0. As soon as you add
context, Myers might in fact end up with a suboptimal diff, even without
that heuristic.

Ciao,
Dscho
