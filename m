Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B461F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeA2VyA (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:54:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:64823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeA2Vx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:53:59 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LaG7C-1f2j5J2uFy-00m2kc; Mon, 29 Jan 2018 22:53:55 +0100
Date:   Mon, 29 Jan 2018 22:53:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/8] rebase -i: offer to recreate merge commits
In-Reply-To: <xmqqmv19ppen.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801292251240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <xmqqmv19ppen.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2Jjogf1soIs3rLEJjd6M76oVV960DVxzwcYSsV6N0AjEdg3P7m9
 H+hN8HHmg7ekxEL/x5kHjhNBYz8pbzce4GJcwsYqa/lPmdE3xQytZAqwYNrMQ5CZSbgORo6
 5CKQDWRunPM3LigaYTH1w/24mtCsSfN1jA+FwoMlWCe5wr3hYW4bQAUzwe6Ow7S7BIhCSn+
 jIP3iHZukvmT+lWg87ANg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YR4jla9rNOo=:yvqCKvyDRmpOtOZ1DH20Sj
 MY2GTLajSmXYzvNbqga3sQFBLpMSotTxd6F54jggp+lCMsj2K6pnbtTKMS0+txYW22MRusOGL
 h0TspaERchEpI+sOSQiKpem9YRds+dBf6AGPVH0VB2jLZB7WktDOc+7FWlcpxBqvXUTkAeIVu
 ZD7epJEIt4cX4gczbwfZPWlO6TxRTmoWYiVf8diPf4FZpuNtYB/Q/tafNPlUUssDhJSDGB2ZM
 IbZ8EdKt4ov58EBrnF9+5+1ASx8NEOfZXqhqg6OMEkxXQ6FS8tYtO8a556Tsk6IrcbdPDxfpc
 6vsXmeF0x0eQ2SB+B5Y1R/JboqJwAty11BxMlD/KIurp/5NfrBd9CNETe8pWNEZE+S6z7Zmrt
 GKpWJKOup1jyKJTcKfSSR6m9KC5vQjmoNtqcyCTKQPglGZvsniAFdZHt2S9WTzcm94ZKjg5qp
 tr42A01ud4ZyLRgl01xTJ++sbn/4WkhjlIz7STiNq7YXN7MKMO2tfLwBkvD8s9G1d7iXiiP5V
 nVeBl86awyMMZtMYYkfhHnQx4PtgGVeqCbveS+HoS+I/8NDa3lFtmEbKY6SDUiWx3k4+ISaEA
 3XYDNDuiU60yX/1qvcgbxNP74Gn3e3Y0X7Zi+PQy0BFDckNV4tfJf2TPYJHBtAg4CJWpyXOMc
 0b58EWbR4qiZ3FjqjRWWyOpj+esmWQzlZrq1BzfTiuFvEZfvIm0cRII3A7WkOFft5d0KAJtbZ
 tdj+KPzvuPtbAIIEc063Xghh3a2SMRjF5urV8uC1BeEH5v4vsdtplDSMwxL8B4OhKF/wk7rZk
 o+esXs8WwJGfJg7wthj7DSiDVlz3QJWLPD79rQBji9i6vl5o3NC/VvaDfoLdtJ+dFHUweEf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Jan 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Think of --recreate-merges as "--preserve-merges done right". It
> > introduces new verbs for the todo list, `label`, `reset` and `merge`.
> > For a commit topology like this:
> >
> >             A - B - C
> >               \   /
> >                 D
> >
> > the generated todo list would look like this:
> >
> >             # branch D
> >             pick 0123 A
> >             label branch-point
> >             pick 1234 D
> >             label D
> >
> >             reset branch-point
> >             pick 2345 B
> >             merge 3456 D C
> 
> Yup.  I've seen this design talked about on list in the past, and
> I've always felt that this is "sequencer done right".
> 
> At the first glance, it may feel somewhat unsatisfying that "merge"
> has to say effects of which commits should be reflected in the
> result and which commot to take the log message from, i.e.
> (recreated)D is merged to form the resulting tree, and 3456=C is
> used for the log, to recreate C in the above example, while "pick"
> always uses the same commit for both, i.e. recreated B inherits both
> the changes and log message from the original B=2345 (or depending
> on the readers' point of view, "merge" is allowed to use two
> different commits, while "pick" is always limited to the same one).
> 
> But I think this distinction is probably fundamental and I am not
> opposed to it at all.  The result of "pick" has only one parent, and
> the parent is determined only by the previous actions and not by
> anything on the "pick" line in the todo list.  But the result of
> "merge" has to record all the other parents, and only the first
> parent is determined implicitly by the previous actions.  We need to
> tell the "merge" command about "3456=C" in order to recreate the
> effect of original merge commit (i.e. changes between B and C) as
> well as its log message, and we also need to tell it about label "D"
> that it is the "other parent" that need to be recorded.

Yes, this was the hard lesson of the failed preserve-merges design.

> Obviously "merge" command syntax should allow recreating an octopus,
> so whenever I said "two" in the above, I meant "N".  The original
> merge commit is needed so that the effect to replay (roughly: a
> patch going to the original merge result from its first parent) can
> be learned from the existing history, and all the other "N-1"
> parents needs to be given (and they must have been already created
> in the todo list) so that the resulting recreated merge can be
> recorded with them as parents (in addition to the first parent that
> is implicitly given as the result of all the previous steps).

I have two more patch series lined up after this one, the first one
implements --root via the sequencer, and the second one indeed extends
`merge` to handle octopus commits.

> One interesting (and probably useful) thing to notice is that if A
> were not rebased in the above sample picture, and only B were the
> one that was tweaked, then a recreated C may use the same original D
> as its side parent, and the mechanism outlined above naturally can
> support it by allowing an un-rewritten commit to be given as a side
> parent when "merge" is redoing C.

I think that you will get a kick out of reading the commit message of the
last commit, as it does talk about the problematic C: it *would* be
rebased by default.

In the next iteration I will actually switch around the default from
rebase-cousins to no-rebase-cousins for that reason.

Ciao,
Dscho
