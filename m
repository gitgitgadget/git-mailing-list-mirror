Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8A21F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 11:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeJLS4s (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 14:56:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:44407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbeJLS4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 14:56:47 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpbJm-1fheoR2z2s-00fQvb; Fri, 12
 Oct 2018 13:24:41 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpbJm-1fheoR2z2s-00fQvb; Fri, 12
 Oct 2018 13:24:41 +0200
Date:   Fri, 12 Oct 2018 13:24:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase -i: introduce the 'break' command
In-Reply-To: <3e2f9343-8b01-c6e5-9425-1665920cc920@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1810121322280.561@tvgsbejvaqbjf.bet>
References: <pull.43.git.gitgitgadget@gmail.com> <pull.43.v2.git.gitgitgadget@gmail.com> <c74e02c4b643652d43108c1a5a675df0fae5f059.1539161632.git.gitgitgadget@gmail.com> <fd14c00f-65d5-f5d6-5f0e-ee0de7593a38@talktalk.net> <nycvar.QRO.7.76.6.1810121035190.45@tvgsbejvaqbjf.bet>
 <3e2f9343-8b01-c6e5-9425-1665920cc920@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+GMdJasKmZ5jyaBmLXUJqd0mRy9VfjUqpHqFrY7U8HPYL0YuwXH
 GQN5hdDwC3LrzU9mfwSVyLpO85SNJcOSqG1weWxnUanEEIttScmlOC/AymByZuv6hDdvZz9
 uzZqoITYQ5MGI5P+EnGk6CZoGt8Edsd+QmugiFNwhOTY3TyvUa4lGDY+ZZYE6CxNKpzTDKE
 YG+u3qAKEamIEZR0r4vAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CFaYMeFRQ0w=:f+CrwmCPFgektR8KSxmsSU
 wHeOlmIw6K5trIf/t8hNau6V8yUi3LJbc37pTTZOsQh8LFI13vp5r2egr9MdDC8DKKaoVtKcX
 Jcp1AByGUeTLqOgIhCWoyZHOSjCmMOFM12RcrwRzxyZZFYlVsLKIDkCDSTH5XHCvUyWFrUng4
 QgrzPkWvF36tdadn5g5lSin/2O4NXW1hr7QB9M4cKUni/OLBFFPWzW3S2/VqJh1HuTujr8DTK
 Xxz6hsToSGfFKyB7QGtU4orvvxkdNq0LyYMv2AUdTciGDQa5lL1CUHbre6leg77g8OQ5saXs3
 vH9ucJy54KnDV71qy50dje9N50DNL2EsldTC69cIfdDzNhV8T9IBRXIXl/pEb7ZO8Ki3lSCcJ
 AuBsWN78OlBEK6IxE03DWn2zAZDTCx7ktiVyM8a9CQ62wkYkzSif6l/RBe+S4AGdcNz6v+nh+
 WXKAsL9fAD5ofpfmMDxdUY2fKKLZ3yM5JPzP+fskxwn4Fkm5+jlQt9AQe8FcBIgCJ35hbkupg
 jzJMeDktoPB9qeiZaF/mceW61OBXkalrLrZV+5c31cmVbPo5W6xdABDq9tZ3sYv6WSsXKlgAG
 OaKZh31KW2EHxScXwTTGvkxCxJgOdX0uFtKienixiM0KBu65OE2JJu6KcRh3BIXOPa8m6O7sq
 xbYuNuViX5I1gNUkQ/Av0Wgs8HQfwmb20BIhZrLrT89n9G7j6usurzMcoYITCJ5lMnpQNZmTO
 wn7CKKUDOD5XtEDHpaGJakmcSlMDwhiqYYnfw+a2Y1aiBeRtYiZGxKd0po8fMMnGLWpRBuQbH
 HPQQPdALZOMPsECuNDp8vUnRmD4jIJKpLhmzJs9Rw3jbw+oP5M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 12 Oct 2018, Phillip Wood wrote:

> Hi Johannes
> On 12/10/2018 09:35, Johannes Schindelin wrote:
> > Hi Phillip,
> > 
> > On Thu, 11 Oct 2018, Phillip Wood wrote:
> > 
> >> I think this would be a useful addition to rebase, there's one small
> >> comment below.
> >>
> >> On 10/10/2018 09:53, Johannes Schindelin via GitGitGadget wrote:
> >>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>>
> >>> The 'edit' command can be used to cherry-pick a commit and then
> >>> immediately drop out of the interactive rebase, with exit code 0, to let
> >>> the user amend the commit, or test it, or look around.
> >>>
> >>> Sometimes this functionality would come in handy *without*
> >>> cherry-picking a commit, e.g. to interrupt the interactive rebase even
> >>> before cherry-picking a commit, or immediately after an 'exec' or a
> >>> 'merge'.
> >>>
> >>> This commit introduces that functionality, as the spanking new 'break'
> >>> command.
> >>>
> >>> Suggested-by: Stefan Beller <sbeller@google.com>
> >>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>> ---
> 
> >>> diff --git a/sequencer.c b/sequencer.c
> >>> index 8dd6db5a01..b209f8af46 100644
> >>> --- a/sequencer.c
> >>> +++ b/sequencer.c
> 
> >>> @@ -3293,6 +3295,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >>>  			unlink(rebase_path_stopped_sha());
> >>>  			unlink(rebase_path_amend());
> >>>  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> >>> +
> >>> +			if (item->command == TODO_BREAK)
> >>> +				break;
> >>
> >> Normally when rebase stops it prints a message to say where it has got
> >> to and how to continue, it might be useful to do the same here
> > 
> > That's a very valid point. I'll think of something.
> 
> I'm not sure what gets left on the screen from the previous picks but
> something to say what the last pick/exec was and maybe what the current
> HEAD is would be useful I think.

I first wanted to do that, imitating the "Stopped at <hex>... <oneline>"
of an `edit` command, but it *is* now possible that we are on an unborn
branch... which will look a bit funny, I guess, as we construct a very
special place-holder commit to be HEAD in that case.

> One thing has just occurred to me - what does git status say (and does
> it still work - I'm not sure how much parsing it does on the todo and
> done files) if it is run while rebase is stopped on a break command?

I don't think it says anything special, really. It just reports that we're
in the middle of a rebase, listing up to two already-processed and up to
two to-be-processed todo commands.

Ciao,
Dscho
