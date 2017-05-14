Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA917201A4
	for <e@80x24.org>; Sun, 14 May 2017 19:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759314AbdENTrY (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 15:47:24 -0400
Received: from freefriends.org ([96.88.95.60]:35982 "EHLO freefriends.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754259AbdENTrX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 15:47:23 -0400
X-Greylist: delayed 1642 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 May 2017 15:47:23 EDT
X-Envelope-From: arnold@skeeve.com
Received: from freefriends.org (localhost [127.0.0.1])
        by freefriends.org (8.14.9/8.14.9) with ESMTP id v4EJEUoS029574;
        Sun, 14 May 2017 13:14:30 -0600
Received: (from arnold@localhost)
        by freefriends.org (8.14.9/8.14.9/submit) id v4EJETGf029570;
        Sun, 14 May 2017 19:14:29 GMT
From:   arnold@skeeve.com
Message-Id: <201705141914.v4EJETGf029570@freefriends.org>
X-Authentication-Warning: frenzy.freefriends.org: arnold set sender to arnold@skeeve.com using -f
Date:   Sun, 14 May 2017 13:14:29 -0600
To:     Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: Re: [PATCH 1/7] compat/regex: add a README with a maintenance guide
Cc:     stefano.lattarini@gmail.com, ramsay@ramsayjones.plus.com,
        neleai@seznam.cz, j6t@kdbg.org, git@vger.kernel.org,
        avarab@gmail.com, arnold@skeeve.com
References: <20170504220043.25702-1-avarab@gmail.com>
 <20170504220043.25702-2-avarab@gmail.com>
 <xmqqwp9m99zw.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1705121214470.146734@virtualbox>
 <xmqqbmqx6bbh.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqbmqx6bbh.fsf@gitster.mtv.corp.google.com>
User-Agent: Heirloom mailx 12.4 7/29/08
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > - rather than scraping the files from the CGit website (which does not
> >   guarantee that the first scraped file will be from the same revision as
> >   the last scraped file), I would very strongly prefer the files to be
> >   copied from a clone of gawk.git, and the gawk.git revision from which
> >   they were copied should be recorded in git.git's commit adding them.
>
> Wow, I didn't even notice that was how the "original" came about.
> No question that we should be taking from a known-stable snapshot,
> not from a moving target.

Gawk's regex has been fairly stable of late.  But marking the revision
from which you take the regex is a good idea in any case.

With respect to bug fixes that may have happened downstream, please do
let me know of any.  But I do request it as a bug report to bug-gawk@gnu.org
and not just a pull request with no commentary.

Thanks,

Arnold
