Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154611F404
	for <e@80x24.org>; Thu, 16 Aug 2018 08:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbeHPLjg (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 07:39:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:35571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731216AbeHPLjf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 07:39:35 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgtWa-1fUH7n2WBs-00M4C7; Thu, 16
 Aug 2018 10:42:31 +0200
Date:   Thu, 16 Aug 2018 10:42:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: fix numbering in squash message
In-Reply-To: <xmqqy3d7h21r.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808161039300.71@tvgsbejvaqbjf.bet>
References: <20180815094125.12530-1-phillip.wood@talktalk.net> <xmqqbma3ijyq.fsf@gitster-ct.c.googlers.com> <27c91e67-7567-f820-c641-c7980965fcef@talktalk.net> <xmqqy3d7h21r.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lVuNhuwx5DbuIzkzUklX73tweOcpCjZI2dHZxZA7MJc8EVcrG1u
 +A7wjRN/FoLMcuDuF3dnZAY0z9a7dMG1cUNsKcOANUYDfhGo4oQXflfP2VjKu2fWI4Xbek5
 hpgmPKeRk3+RlBHYMWByR8TFTCcBVDi/d0Hn9tb27mDWy78qpIKrGMSFxCJFOBz9Nh86MIp
 xwfq0wckKJripKS/6RZMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f3qaai7pRDQ=:bLaQ8TbseOu/axLaQKwcM1
 s45ub4cFeThtod2EftjqeEJw6DDG0O7wb81ZiRwyCZs7w+6PH8OCUepOombN27WIvtcJKIDP7
 eeznrsQnd6c0IGJB6fbucTl8AdEcXL2282CER4hu0bepcrLda9wUiFilDRNGE1KREaV8QxqEM
 lEZ1H8uaBUtJtpXtz8EglHBVQ6b5SIEriDSagH89siFHgRG/+LZyAiYHD/87KYfIyHpDzSwcC
 OcbDgQaDKY+vP6AkAZ3JfRcO62E7FakHpqqI7PrzqiHrCvirGVMXLE7UnyAaSNM2Z3AhPkFzS
 WwFbA4ymEhdP9fRLd8FnqO5vSSrE+iKTT6qyeoqUVqZFIeXC8HvYDwV+x1WmMhbYOOBao/HYG
 lrtrF7fsXiUK3gwleb9Vmt+cmsQJrrL2durFmD2eUF+1jjpA/zD5f5cBo3LquLPxLiL96EID5
 a8SumbsyzON2ynNTfm3J0oMC1EaYpdyYaJcmdFSDSoFbzl8m8El06orhV0JR5ZXmPqIRKHAsr
 JSa1+Rg2sehTclgWXoEp09Qejj0FSIbkJDpSFBmCenhX/0umF9Ps+G+hp7fLek7R/2x+nDP2O
 LENDzfVj4p7bMfZ1Z4QeFxmrcJgFTHpI7LNawAm9yEiPnJk2iIpEYgOB89GGCVqG4kufH6gSf
 XBb2mtjHHgDhIIFBvPMCHIi+LLwSQR+Zsw5r9UieuIalKXkCVPzxILgNg3dC5ZRDz7154cuEJ
 To0GQQgPsI9ko27hh62Hnp4ZS46dc9+eHB8QJUtt5psZvhXSMHboFwNu/dAkKE46z/+hGbWcQ
 1kFlZgG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 15 Aug 2018, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> >> I wonder if it makes it easier to read, understand and maintain if
> >> there were a local variable that gets opts->current_fixup_count+2 at
> >> the beginning of the function, make these three places refer to that
> >> variable, and move the increment of opts->current_fixup_count down
> >> in the function, after the "if we are squashing, do this, if we are
> >> fixing up, do that, otherwise, we do not know what we are doing"
> >> cascade.  And use the more common post-increment, as we no longer
> >> depend on the returned value while at it.
> >> 
> >> IOW, something like this (untested), on top of yours.
> >
> > I think you'd need to change commit_staged_changes() as well as it
> > relies on the current_fixup_count counting the number of fixups, not the
> > number of fixups plus two.
> 
> I suspect you misread what I wrote (see below for the patch).  

I had the same reaction as Phillip: is your patch good enough, or does it
only touch one part, but not other that may need the same "touch-upping".

> The fixup_count is a new local variable in update_squash_messages()
> that holds N+2; in other words, I am not suggesting to change what
> opts->current_fixup_count means.

Sure, and the better cleanup could possibly be to change the meaning of
opts->current_fixup_count altogether.

> > Having said that using 'current_fixup_count +
> > 2' to create the labels and incrementing the count at the end of
> > update_squash_messages() would probably be clearer than my version. I'm
> > about to go away so it'll probably be the second week of September
> > before I can re-roll this, will that be too late for getting it into 2.19?
> 
> I actually do not mind to go with what you originally sent, unless a
> cleaned up version is vastly more readable.  After all, a clean-up
> can be done separately and safely.

At this point, I think Phillip's version would be safer, as it would make
it easier to do a more complete cleanup without the pressure of having to
fix a bug in one big hurry.

So: ACK on Phillip's patch from me.

Ciao,
Dscho
