Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1DE81F597
	for <e@80x24.org>; Tue, 17 Jul 2018 16:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeGQROH (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 13:14:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:54491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729668AbeGQROH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 13:14:07 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaIPo-1fLjDK41xQ-00Jsma; Tue, 17
 Jul 2018 18:40:31 +0200
Date:   Tue, 17 Jul 2018 18:40:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 20/20] range-diff: make --dual-color the default
 mode
In-Reply-To: <CAPig+cSyTKLOXbfGx3z_RWbHaTZU_EKWJrCqwCaw+urQph=4Tw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807171840160.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <4a68b95ce2a6463708c92d1bcc0208352c14f836.1530617166.git.gitgitgadget@gmail.com> <CAPig+cSyTKLOXbfGx3z_RWbHaTZU_EKWJrCqwCaw+urQph=4Tw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7zlOV6nET4+w6GiO1ATkN8kkR+SoeihZzKNxkOPAzUz49pSS7CR
 E3UGzqDk4eCLX5wtvpeEQBkzTXjbob1LRoFE0ytKm0UW4Z+vazfkMfTgXcMhlqEuLcMFkUu
 2hgGk5aBzIpXJx42N0gbrzJt9iyTkCB/JHqYtPvCGWAaSlISM5r9lXTTXlLM00WW/CSyu2g
 hwpZGNm1JMAV9WZX1y+sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RvI0k6X/jvY=:gNBURdJ/0EDClAcSKKJjSN
 XyIPx3n1EEUj/JnKt6IuZWCB6Y/nrGh9v/o6y4ntxHYZy8X609WLfvF+vQqtLIvxbLxheyz2y
 sKjyc/oev6/9R2JkOWe8R4G2yaw3qCQc4/QwUldkyFw3+hQ5xoOcE4S3UONUdgWz6TeGZO4tV
 o0HUtDRjGbCyWPUNwYD1OEb8Z8K5wlVTnhOCBxAUeh4VmVyhhxHNOy3zNOWuHO7EOC6mh3VsA
 VSWk3qIelmXXN4JVH1mNzETf6PomElzAvum4X+jTCpjtysOMX4Wu+PGc+up0EGF1SySmW3BmX
 QGkHqPrepnQPpscApiDg1DRHlJXIJUz2StOdOOF5eeWtVGhqNmJT7SzH895rr+PcJ/e2EXkoh
 ozP6nvUNlwt7qyZ7HG281CbpR5ixAriVa4Rqf5btcfn89LqxA5OQkJSgwpbv0+E3zX0kEv/Q7
 3XVCaW0upt3E4W+RTcP8qYDwVtjQefrkUUa71tqBcQIm756Ed8MMSUUNTxmurgqHjz4mpsFHW
 kXSnSMsNrChR+KdeQ2kUNsaAHXUpbLLfFxjYB+m0sj40LuC6lDHd6d/KLkj6TWYLPc4vn/iWk
 3Akd7fycA4KAuUXSf59tHChDxMQU9boyha8MLgs1aeaRz9WMkerz46tzfwSsmumXV8WyoJBgK
 jI3t8Dzqbj0LqU4VAV9ipv89/GSPkkkkMhX516GqxXzp/hUL1ugBW7lcmtlYkYKefidIun/rS
 MDGXZ/7PnVfI98Hrb0Y5PsuTMcN+DoipvmMhKWmtG9x7jMQbV7pmlYJ8eR+O+OjUtkGFqZE9Y
 DUC+r8q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 16 Jul 2018, Eric Sunshine wrote:

> On Tue, Jul 3, 2018 at 7:26 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > After using this command extensively for the last two months, this
> > developer came to the conclusion that even if the dual color mode still
> > leaves a lot of room for confusion what was actually changed, the
> 
> "...confusion _about_ what..."
> 
> > non-dual color mode is substantially worse in that regard.
> >
> > Therefore, we really want to make the dual color mode the default.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> > @@ -31,11 +31,14 @@ all of their ancestors have been shown.
> > ---dual-color::
> > -       When the commit diffs differ, recreate the original diffs'
> > -       coloring, and add outer -/+ diff markers with the *background*
> > -       being red/green to make it easier to see e.g. when there was a
> > -       change in what exact lines were added.
> > +--no-dual-color::
> > +       When the commit diffs differ, `git range-diff` recreates the
> > +       original diffs' coloring, and add outer -/+ diff markers with
> 
> s/add/adds/
> 
> > +       the *background* being red/green to make it easier to see e.g.
> > +       when there was a change in what exact lines were added. This is
> > +       known to `range-diff` as "dual coloring". Use `--no-dual-color`
> > +       to revert to color all lines according to the outer diff markers
> > +       (and completely ignore the inner diff when it comes to color).

Yep, thank you very much!
Dscho
