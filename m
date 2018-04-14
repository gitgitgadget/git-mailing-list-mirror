Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1D41F42D
	for <e@80x24.org>; Sat, 14 Apr 2018 00:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeDNAwK (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 20:52:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:56409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeDNAwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 20:52:09 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ld0jY-1egvL53rKC-00iG3l; Sat, 14
 Apr 2018 02:52:00 +0200
Date:   Sat, 14 Apr 2018 02:51:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v6 05/15] sequencer: introduce the `merge` command
In-Reply-To: <85232331-97a0-7989-e095-854ed962c7a0@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804140248110.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <8a5ae61f603df8d8cb19268e1b8470f0a4993445.1523362469.git.johannes.schindelin@gmx.de> <55216d0b-cb37-6514-7f80-91f4617c105d@talktalk.net>
 <85232331-97a0-7989-e095-854ed962c7a0@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fA0xOLs/AyQ8WZnUEqYkV98fgvaph1ZOM2e3JuIxI1FNs2EY+zS
 c7htjGM5L7HY0boeM6e2vJdjQDnc951OE/Bf8iQZYOguHjfPdzK/IZS1c8kdEG6tKfJPXH7
 OwIobYh0zkcBd22rCSJfJlO4k5dRxYbtmelW/FQkKP159tq2EfeE8zCkPbp7x1Udkn8Ex1k
 m4GW564pARl4yn6akJ0MQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BCpLShPI2dg=:e+JHbQEoYtktjNJ6YBguYU
 0ugGh+IXyYBGDQ9dl22lgRTik32sXBCSPmIYRMTOkGLNx0VsR3PVgLnKucpWEMn4u8EY3PLuG
 pSvywfbFj47ylrM7CHLPoFYayN4xGTvVXVqQV9BKSQSIuAm2kSmjM0dCvoHfX+k+Y2BrZ7136
 LiDgLsmZCjAbE9ZPZBaMVf8qFUbPm3EQsCAkM9JZIjsJO8nnqmLzHnRNhJhxTXn2lsp8dJaww
 W+42X2PLqBHmJYP2wlfbqJ+dlpwTKBLBpIBIrmgeNAC2Mm3VEcyJtouzTeIwLS8jTYm1Dvdof
 JZ/ItKh2s6T2YB0us8sM3wKtm+u8Z6KtljP3CaWWIUHQouikdvyudaixgsklBrlpTUVhxR2mI
 esNZe3W+Gj9cSLf2B+vSXhFPDhXsYP36rvAvUMg++7fRFYehUZfe+HL2lboAO1YLxJpADrKBE
 Rn0y5HoejxLCNUWeBtFswd1fJ5+w48rrBua/aatA48IA5L7BGy04aMRVMvatbbjpvspIJxpru
 Wy8fZKCn8OjbRN26YAbaJNqaX3fhDFG1AoWSMbb1wB7rw1g2PAA0To3tIPUwAE5S2oizNRS8z
 9vVojhc8V/2a6swNexs+joK9lvbvn8ycvC6jGsTbzO8R03P/wuKGB/pxJvxUi5MqFGmRoZ25L
 sN13zoRESsz7erbfcS8QGSOF0b9r9cuAZ4mAEIxT6WO71kffTcaOpVChtj2sWq0NzPdna36mU
 wPE8jWL8/sJfsSrCrUauupYd+dLa5V02Hop7aWYtMlRuc+6DEKSJJn/o8WMoqswG6uxEGfdAA
 YW3BgqgRrLZsj8IOvWFBqLSE0w3AsLAkIVGHl4K84ykUAC/f6o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Apr 2018, Phillip Wood wrote:

> On 13/04/18 11:12, Phillip Wood wrote:
> > @@ -3030,7 +3029,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >  			return error(_("unknown command %d"), item->command);
> >  
> >  		if (res < 0 && (item->command == TODO_LABEL ||
> > -				item->command == TODO_RESET)) {
> > +				item->command == TODO_RESET ||
> > +				item->command == TODO_MERGE)) {
> 
> Unfortunately it's not as simple as that - we only want to reschedule if
> merge_recursive() fails, not if run_git_commit() does.

Correct. How about introducing a flag `reschedule` that is passed to
do_label(), do_reset() and do_merge()?

Seeing as do_reset() and do_merge() already have a replay_opts parameter,
we could add a field `needs_rescheduling` and pass the replay_opts also to
do_label().

Ciao,
Dscho
