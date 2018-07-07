Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91391F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 12:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeGGMAE (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 08:00:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:40459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753889AbeGGMAD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 08:00:03 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LuJDv-1g3zdD1t4R-011jJT; Sat, 07
 Jul 2018 13:59:56 +0200
Date:   Sat, 7 Jul 2018 13:59:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Pratik Karki <predatoramigo@gmail.com>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] builtin/rebase: support running "git rebase
 <upstream>"
In-Reply-To: <CAP8UFD3_+0EDSzcrx9f70HBpWKvr94re5ZimuXDhfTZzJpfCvQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807071356520.75@tvgsbejvaqbjf.bet>
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180706120815.17851-1-predatoramigo@gmail.com> <20180706120815.17851-5-predatoramigo@gmail.com> <CAP8UFD3_+0EDSzcrx9f70HBpWKvr94re5ZimuXDhfTZzJpfCvQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DvhomodM827BrTOpEihey+2YeEklaD2dLX5j7C0UyB/MBhrdbjf
 wwhY3pkLiokZ3RQJb22AL5dZtY+v+xDGz0PtHa/xM+S7UvIjtAr81MJWDtCaXW/RQ71Uo64
 O9L2XYu0RUAXy4yuu9He3xxHm0NQHH//GUaNnDFFTpe6y7ZWjq50fEzBezzXnRup0CsgWYC
 f24F5+D/GzPnxuM00lYJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hLclAK3/Q8k=:Qlzshnn8BUco1R9F+H94ol
 vpFHHwflJocIhM+QnXHhiysuu/n+BO4Sl6ihhl7JD4GTHK8nYsQZuLVapdz209binitV+oMZ4
 QoGm6Mqtq8Yz3/UfML46B+2evjNMi7DcenbWBCxf2UP4enwC1J+5fbXaGGLTrWGGXmAAcECce
 EfXORrthlyafZ9QkbVHL8b2WtrBHrgBAdKjYIDGAne/GWz2t3QNngLJXwOe0605KBTRfmCtDk
 DoCoiBUhbp8sloLPQpgvvJw1/IlKsgkyq1SelLuzK0/hJs4xAKvG/KscCXJSv9c9KYgherbLa
 Jlikn7Mn9LkvtN1QSTK0eFF9cGIHCVhSfZT78New9rVWEjZZtDnlZZnjBNdXqTMh7987S17U2
 3JvhSaf0+WChO+ToQqBu/ndm0jvTRlkdA3cqMRiLMOXBxJp4OUlxg+fPiUgcFAR/1DBX8c1FP
 LwXOzFDcoceizbzBwcvfzwi6m4eqH+0Tix7x3vm5XFbBAzuvlb+2A0UveWF9Si/VG8idMEx6k
 0oDjsUeIY6t2boJmdoh7uJA+xRB1FSzgatWnuyomQNNb7AmO/AnpoySHSM7ThtBVABe+6hQtC
 qyNTc8omUSX5nxHZANa7ehDk7/cTqe8+M3wgWoQcA0Hb/uz9hOxUZR1VXIYp0AQnkieULHDBZ
 VMkUZIiYqIqhCNQM2HAYOWP6Wui/bCpL/k8qnfvcm7TEdCsGjdfQAJlbzB8X4n+qP7IL3Oofi
 8Rs3pULF8m8kZIrhwoIxso1FFx4blF8i0Cgj4MPw/QYoWR0jknpwpobhVbLsISvytL02yepLA
 4s5jEts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Sat, 7 Jul 2018, Christian Couder wrote:

> On Fri, Jul 6, 2018 at 2:08 PM, Pratik Karki <predatoramigo@gmail.com> wrote:
> 
> > +       switch (opts->type) {
> > +       case REBASE_AM:
> > +               backend = "git-rebase--am";
> > +               backend_func = "git_rebase__am";
> > +               break;
> > +       case REBASE_INTERACTIVE:
> > +               backend = "git-rebase--interactive";
> > +               backend_func = "git_rebase__interactive";
> > +               break;
> > +       case REBASE_MERGE:
> > +               backend = "git-rebase--merge";
> > +               backend_func = "git_rebase__merge";
> > +               break;
> > +       case REBASE_PRESERVE_MERGES:
> > +               backend = "git-rebase--preserve-merges";
> > +               backend_func = "git_rebase__preserve_merges";
> > +               break;
> > +       default:
> > +               BUG("Unhandled rebase type %d", opts->type);
> > +               break;
> 
> Nit: I think the "break;" line could be removed as the BUG() should always exit.
> 
> A quick grep shows that there are other places where there is a
> "break;" line after a BUG() though. Maybe one of the #leftoverbits
> could be about removing those "break;" lines.

But what if there is a bug in the BUG() function? Shouldn't we then not
call `die()` directly after the `BUG()`?

Okay, sorry, I let myself loose a little, as I think that we are still
safely in the territory where the code needs to be made correct. We can
nitpick when there are no "biggies" left to comment about. Maybe focus a
little more on whether the code does what it should do, rather than
whether some stylistic guidelines are violated?

I mean, we can argue back and forth about white-space, indentation,
superfluous break statements, etc. But that way, we won't get anywhere
with the builtin rebase.

Let's help Pratik instead to complete his project, okay?

Ciao,
Dscho
