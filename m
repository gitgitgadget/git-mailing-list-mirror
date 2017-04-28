Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B156207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 15:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969532AbdD1PPh (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 11:15:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:55436 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969530AbdD1PPg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 11:15:36 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW8PN-1damne0VnV-00XPR3; Fri, 28
 Apr 2017 17:15:27 +0200
Date:   Fri, 28 Apr 2017 17:15:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/9] rebase -i: also expand/collapse the SHA-1s via
 the rebase--helper
In-Reply-To: <xmqq7f25mlpc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281714480.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <df5263cc0cad5cffbd1932d4b9b8e5c0507536e6.1493207864.git.johannes.schindelin@gmx.de> <xmqqr30eo36n.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1704272331190.3480@virtualbox> <xmqq7f25mlpc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NDzEp6LY4deKEaKNbINOVIEfEK9GGj6CENYeoCX7CMVwEMaMDKx
 1uXWEQGRzXuXWC/rskriNKNiXT2EkniFQqLrtMlRYJcjKbTfPLpxezy2zMBJeR4yTm27pnL
 hb+eVBIAsNUctpynaOiN+3PYoloRvboksdPla8GkrWxJUh5+ySBmqyNsOi4vlD5MeNShYr7
 MXfieFMy+xRt64xu+ayKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PNKOR1YisLI=:+gbUXlI9m5HUez4sAHCd+g
 07A8sCmCxvW4P/q0VX7jE1qJ80+NwpJABnOc4lGbYdf0zg2Tnz4ljbKpCIlWlUGjvFs/YLu0H
 xdfW8cG16REnvdRIcWogNgPEbJ4GkbablrVcDodOjOrLUjfeBSIDYYEnz/HjGtfSMvOp4+4va
 4lb3KevswK7fcSXHoHGmtpuBcsQTxA4o1RCVjyLkHUNDEo1lg0e70ZjYvKcoL3J0aa7JBQ6j+
 5Aq3vobDSjTR8ROPe0NI+oTekNOL6IKwM3kDoDDdVwmVNOca2BIK4OeQ3VxCDurz3pZ0xJ25O
 eJ8TtCmkHapKNyqes8sPh3sGFT49ndrb9cEH49/Xy3I76o1wwIFUnST39jTI9/GrRtNdecdLv
 ZTrZ4oknb8wnvzpeYj20TeMlb83QwXaSgGvTpDl0Wf+uP2RBznsAplbamVjauW78Kb4Hu0GL0
 LMBoJIQkkty5HfbjDtceUXp7JfKFhjdzKUMyPajcUejbj0shrxKaPQaQ6lSPAFvD2aKeBgWnv
 symMXEz9QHoEPKTdR4Vj+yESmIrjUHmmTmF6gkAVayAP5u0SX3xPF8RrwoS/HR2DC305SizLH
 PA+xi71CFygWSs2RjurBqwuStiwauhsMrr7+6B8CB2WNmrqGdtzzvjHJd+J8q0E+kyH/QoFXS
 EqDzGELOzVhVclumHkCdqawUW/MI9PDBwV1ndXmuL9M2B3S8yZoA9BwXi8QArBF6uXd+VSawu
 WfsrHq3H0PNYwZ50YaYkjaCo2Fzg7jXmwxmAUPF7B8iGS95uktzmedaDJEmSGoigmBg97PpBQ
 vrjOJNa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 27 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +	out = fopen(todo_file, "w");
> >> 
> >> The usual "open lockfile, write to it and then rename" dance is not
> >> necessary for the purpose of preventing other people from reading
> >> this file while we are writing to it.  But if we fail inside this
> >> function before we fclose(3) "out", the user will lose the todo
> >> list.  It probably is not a big deal, though.
> >
> > I guess you're right. It is bug-for-bug equivalent to the previous shell
> > function, though.
> 
> I think the scripted version uses the "write to $todo.new and mv
> $todo.new to $todo" pattern so you'd at least have something to go
> back to when the loopfails.

My mistake.

Sorry,
Dscho
