Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A64E1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 07:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJLPbI (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 11:31:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:42261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJLPbI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 11:31:08 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbMmA-1fnPVF0JYY-00kujI; Fri, 12
 Oct 2018 09:59:51 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbMmA-1fnPVF0JYY-00kujI; Fri, 12
 Oct 2018 09:59:51 +0200
Date:   Fri, 12 Oct 2018 09:59:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Teach the builtin rebase about the builtin
 interactive rebase
In-Reply-To: <xmqqy3bavdmk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810120957480.45@tvgsbejvaqbjf.bet>
References: <pull.23.v2.git.gitgitgadget@gmail.com>        <pull.23.v3.git.gitgitgadget@gmail.com> <xmqqy3bavdmk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mYgMsEDflwNkjtcboFAk+LT+UHOWlRwvDJOZlMz7S+6vdM1GCwz
 O8HXV8CeldrRv2FxDZyvkaKdSfjCZJugeEnUWJyQCbmX0U2MHQ6xBS2WcGqrRKXH3mUAMZR
 KdWuzEV0qRyqkU3IeuTblrdTUeyZcQQfRvBRrrlqhvLy3Cf1E0Mkmr+0owugB1Fwqb7jzdm
 9H7P7zqsCj4k09G2LB1Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BN6H7Dw0TJA=:HBRPnCi/gGNo/fGEM8uffq
 rkRGQqb7cPeq1Q/npThmdruHxIS9XSAbtiIzBHd/XfSi5crY5fuvEcuCnaDzt50rwJtXlwd44
 uudiX3aFKGMuGQ42jvf2jdmw1YATljCuciIFyuZiI1Erp9Dovh2OrL04CVEYNYkSnX1LPXi13
 EJZ1WobNAyak6GwNoi8rE0au97ZR6WVtrwNWkFNBW6HFvn7MuqGZVy4Pq3HTrjq3lHcSFk0oN
 MIOswHCBsw7Nv2fXQX31Bwe7/nzSU5A19p2g1R2AAueb0Ln+zgMoVcQySyZY8GjDeIHcE1AFz
 y7cfHRMToWHrORZtBHv7zA3KuqCTqduaSSrRwtN5YLF7If2csCDNWipN73NlzuGyXJ08wfuWb
 JUMT/+Pqq2w8FL8RziLRZbIff6mgNh5S7ve/eFKGlWUF6Ii+osW+zcEguYHPkFQe4WMGrNj5H
 AtVkaAvMJLr/w9omNz1eH1ueiOYEVyhdkLr+EPQ+1nrsb72nXd7aMqR2nvMjiN1h2mvk9jr/V
 KQw2yTLmJmO/4++/LfCjUwjGd4ZEcsmT+9WMYMbYi77bS63bdnN9+yBUGZ8RIxIKRy2ZbCYc4
 k9QC/kMMClTymYJwkT+o74SJMkbbT2dAxjf/l0egzmki0m/EmIP9VFJgCf2bPP/506KGhU+jU
 bqaAVTGRiYnmRx36tbrMewO4hwHaC5o7S1hx917jbSqJeeAl14VApV2BHQ6WGxjId630eoXy7
 IaUogE2xfe+rtHDRTII7uBqS2/sS/czpby3RKymbhh0yF/5ZR0dkpCEOTWLDAnBX40epah6C2
 iJfPn8nqhC7YrOVsIYdkQq/K6qdryWyaDx0nyjtDNyj8Gp8FX8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 7 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > Note: while this patch targets pk/rebase-in-c-6-final, it will not work
> > correctly without ag/rebase-i-in-c. So my suggestion is to rewrite the 
> > pk/rebas-in-c-6-final branch by first merging ag/rebase-i-in-c, then
> > applying this here patch, and only then cherry-pick "rebase: default to
> > using the builtin rebase".
> 
> Is this a stale comment in the context of v3, where we pretty much
> know how the resulting topic should intertwine with other topics?  I
> am trying to see if I have do to anything differently this time, or
> just replacing the single commit while keeping the structure around
> that commit the same is fine.

Just replacing the single commit. For technical reasons, I still have to
target pk/rebase-in-c-6-final in my branch.

> Also, I see there is a new iteration v8 of ag/rebase-i-in-c on the
> list, sent on Sep 27th (you were CC'ed but I suspect it was before
> you came back).  Are you happy with that update?

To be quite honest, I did not yet have time to look over it, but I
verified that it has my suggested fix for the -S option.

Ciao,
Dscho
