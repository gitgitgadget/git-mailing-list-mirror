Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B683F1F404
	for <e@80x24.org>; Fri, 27 Apr 2018 07:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757513AbeD0HYn (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 03:24:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:57919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757367AbeD0HYm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 03:24:42 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCL6r-1f3TPi0SqP-0094p7; Fri, 27
 Apr 2018 09:24:23 +0200
Date:   Fri, 27 Apr 2018 09:23:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
In-Reply-To: <CABPp-BERgc9EZ=hw4CepgXptO283mW3O30_pHrj4jtz3QSCFjQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804270918430.72@tvgsbejvaqbjf.bet>
References: <20180420133632.17580-1-benpeart@microsoft.com> <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-3-benpeart@microsoft.com> <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com> <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
 <xmqqy3h9z8sj.fsf@gitster-ct.c.googlers.com> <CABPp-BERgc9EZ=hw4CepgXptO283mW3O30_pHrj4jtz3QSCFjQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aGVf9WF/imoZ6NuSuHe1YR7AK8Ef+FhWxeBZ/E+vasFMIqBxCIY
 +Zu2ZoFfExD3Z5Rswz+kKR9ZsKRmHoRzBnkNNKM0blrQHW27m2V9x9MNRUA2/3dYvPFMscn
 rX60fuws52ocpYy8vYEwM/37aq7tRNkDWABJY5O3S9f4wQ/IopDZEM1GTMm6H/kftBxReLw
 T2gV0PPj3ZvliZ3mlGHNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kVvI9SO4+EY=:RDM28DTndiJvEnwABwdW/8
 AojUpEbaKwqgMbYzWrS+DGNo/WnXWoXzyQzp3sJVO2e00uJ5OPwjYZFE73ep/yPWd4/w3YNAy
 vqNlC5x2NwUqNdOyhH7KkvI1BY/ZwsE0SAg4t4n0S6rN/E2J0dqn9NH1O7WbzfQ0Fzp7bXLXb
 wdSszY2K+D/Ey2iJ+rv1trBnILav2unF6Oe+wz9azg/f++QUCJ9TrXzeXY/JyiOLWUQdzNR+I
 Ke8ICJgdiwDHUcQ7d7Zk3yGVL1NhcW8EdPMou7yQUw/hCNuuqVlCLFZPYPJNzhFNpiNEmu6xX
 2lu51u0Hosoub6I9cQdjZDjXhQo0uOOXaTlbRj3RjfVqyFFz3tpdjxO7bTxwGgdTGt11nkcZQ
 xFu4Qzos6rXulE1k45M7Sb2XP9ZQkJj64xF4M4y+a6d07CNFPZndQSVWfj3KJknDr92Q3ZEym
 IjFe66dwNq7gnUjTPFdyRzEDsAurZqiS5J3NQQP66UAoH6sJIIbk9PbNbPGcVLArn806a3/eT
 XGCO7Jq5uwbZnLUYo/PB85rwAm9rCutKowDSS69Qx45GHMXIwLX34lExIVJ2RZwytOnY4lO1c
 eRpp8gztsXcEJRAp5cLAig66J46L2wGQtfuj/Z1jb6nOroGqKSOtaR2FHcQAW3wGHJEs1ObFc
 Wk2rDWvToQm5TxOl64H5TFdsM9/aYXvvNq8aqAeC8Or3N9Q7x7vbmRAGPEjsY5FwzGnqo5W9K
 A+1t3T8Yn5ZhAjJzlwH0q8XVH6xJIhO9yIqH61t0FMfIPJzbfkO9JK2A45WW9qy60IREYdCR+
 JMaqJbk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 26 Apr 2018, Elijah Newren wrote:

> On Thu, Apr 26, 2018 at 7:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Ben Peart <peartben@gmail.com> writes:
> >
> >> Color me puzzled. :)  The consensus was that the default value for
> >> merge.renames come from diff.renames.  diff.renames supports copy
> >> detection which means that merge.renames will inherit that value.  My
> >> assumption was that is what was intended so when I reimplemented it, I
> >> fully implemented it that way.
> >>
> >> Are you now requesting to only use diff.renames as the default if the
> >> value is true or false but not if it is copy?  What should happen if
> >> diff.renames is actually set to copy?  Should merge silently change
> >> that to true, display a warning, error out, or something else?  Do you
> >> have some other behavior for how to handle copy being inherited from
> >> diff.renames you'd like to see?
> >>
> >> Can you write the documentation that clearly explains the exact
> >> behavior you want?  That would kill two birds with one stone... :)
> >
> > I think demoting from copy to rename-only is a good idea, at least
> > for now, because I do not believe we have figured out what we want
> > to happen when we detect copied files are involved in a merge.
> >
> > But I am not sure if we even want to fail merge.renames=copy as an
> > invalid configuration.  So my gut feeling of the best solution to
> > the above is to do something like:
> >
> >  - whether the configuration comes from diff.renames or
> >    merge.renames, turn *.renames=copy to true inside the merge
> >    recursive machinery.
> >
> >  - document the fact in "git merge-recursive" documentation (or "git
> >    merge" documentation) to say "_currently_ asking for rename
> >    detection to find copies and renames will do the same
> >    thing---copies are ignored", impliying "this might change in the
> >    future", in the BUGS section.
> 
> Yes, I agree.

Guys, you argued long and hard that one config setting (diff.renames)
should magically imply another one (merge.renames), on the basis that they
essentially do the same.

And now you are suggesting that they *cannot* be essentially the same? Are
you agreeing on such a violation of the Law of Least Surprise?

Please, make up your mind. Inheriting merge.renames from diff.renames is
"magic" enough to be puzzling. Introducing that auto-demoting is just
simply creating a bad user experience. Please don't.

It is fine, of course, to admit at this stage that the whole magic idea of
letting merge.renames inherit from diff.renames was only half thought
through (we're in reviewing stage right now for the purpose of weighing
alternative approaches and trying to come up with the best solution after
all) and that we should go with Ben's original approach, which has the
rather huge and dramatic advantage of being very, very clear and easy to
understand to the user. We could even document that (and why) the 'copy'
value in merge.renames is not allowed for the time being.

Ciao,
Dscho
