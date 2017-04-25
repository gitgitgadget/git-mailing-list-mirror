Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7378207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954027AbdDYUNM (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 16:13:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:51877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949626AbdDYUNL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 16:13:11 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ2Tn-1cxu2O3f6J-005LED; Tue, 25
 Apr 2017 22:13:04 +0200
Date:   Tue, 25 Apr 2017 22:13:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v4 0/9] Introduce timestamp_t for timestamps
In-Reply-To: <20170424113758.4orsjmicxbxdxdq4@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1704252212160.3480@virtualbox>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de> <xmqqbmrm1o1k.fsf@gitster.mtv.corp.google.com> <20170424113758.4orsjmicxbxdxdq4@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IrWesj6UDMS0YkMRlhw/Ok6xTPpuX2MgL3s9U0dvvd89W7ZoZik
 d0BT8UOmbb6QT6g5+CjElLPjdP7bcLAMcM7rtxBfCHJvJSStfS7YNHmCKELZEWfGSKn7L7W
 RMSOj66sx76eceRAL4zwAXAAovZJNVUlAeNQOcpZ7uNSgwpiDQm9sBiGZfbeXFOPHjU/F1X
 Fvtfw+Nw+N1b9jKEEjclw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jDOx2zr5VBg=:Nju8bRzATBVL8dCj4LaQup
 CRpeFgu6EtYQq3hh3ZPzTSf6gXzo8NswFTtRI81PTMBbM+mD1TZ2KLkn3bgy0dmhVtDpgqljf
 UxsDNzzIZVjHzPmMg+AcOWGqunCVzY7NQx/3umV3wDlOy7FARIJ9Um1UZhMOPv9NGsAIHu2gB
 VI5FoQ4V69NWD1yQRuvAuco+V04bwAB6a79V5b4PjOUJSReambCRmz22wLz2O3sekGggKXyQ1
 3gWrkjPGzIYTmAWMEUFEGV5s++OF/4pXtLA7N2IGTBnyYVW/4DXUziR0vsLYbA6rFuyEYb0+n
 ZfIL1oZ/7QZa4RmSwtAPjqEkdyPuEjEbjd7rhmlZftFk4h59ZOQ2V0QmKg2yMNXIBYh6NI5dS
 fwXQF1aACnH7xG+ZB43ngKrRP5lJ7EOdX+VcsdXNms+2W33hAaWgOonzvfWyh8/Qx/jOJ5+EG
 dC8DuN+WlpCTj977g2FMLdkvj7G4fz1EQk4SRvITumO50whrH1/hfQmu18prG7RSiPDqyJo3p
 9Eke1y/9i7yOBTlmAPwgRZJ//JNSC09gtyT6sqGt8fDFv6LxKVOLVmvGtn/u68VcBLovDQ3QE
 TTrbxZk08nT8YXRE9qmpJ1vrOBN5/AusDDG1XHMSi5NASVpFdXaRPefbB1CYGcdzbV0FWjOvj
 mjhF5oCL9kKvekRoxs2KXCZC29McsIsa5T+6RCwFRZ3wRDzu71qMpWDcbBK7LjiD7Qc+FfV52
 0JMoNyys6sbo3Sv9XZf2oaFODdyOaoyEvgeDt9WiFqmLVIPP3olUdENjlxq11YR6YTwG3CLMb
 zAL/EKr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 24 Apr 2017, Jeff King wrote:

> On Sun, Apr 23, 2017 at 08:29:11PM -0700, Junio C Hamano wrote:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > 
> > > Changes since v3:
> > >
> > > - fixed the fix in archive-zip.c that tried to report a too large
> > >   timestamp (and would have reported the uninitialized time_t instead)
> > >
> > > - adjusted the so-far forgotten each_reflog() function (that was
> > >   introduced after v1, in 80f2a6097c4 (t/helper: add test-ref-store to
> > >   test ref-store functions, 2017-03-26)) to use timestamp_t and PRItime,
> > >   too
> > >
> > > - removed the date_overflows() check from time_to_tm(), as it calls
> > >   gm_time_t() which already performs that check
> > >
> > > - the date_overflows() check in show_ident_date() was removed, as we do
> > >   not know at that point yet whether we use the system functions to
> > >   render the date or not (and there would not be a problem in the latter
> > >   case)
> > 
> > Assuming that the list consensus is to go with a separate
> > timestamp_t (for that added Cc for those whose comments I saw in an
> > earlier round), the patches looked mostly good (I didn't read with
> > fine toothed comb the largest one 6/8 to see if there were
> > inadvertent or missed conversions from ulong to timestamp_t,
> > though), modulo a few minor "huh?" comments I sent separately.
> > 
> > Will queue; thanks.
> 
> Sorry, I haven't read the series carefully yet (but from a skim I'm
> happy with the overall direction). It does seem to cause failures in
> t4212, though. For example:
> 
>   expecting success: 
>   	commit=$(munge_author_date HEAD 18446744073709551617) &&
>   	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
>   	git log -1 --format=%ad $commit >actual &&
>   	test_cmp expect actual
>   
>   fatal: Timestamp too large for this system: 18446744073709551615
>   not ok 7 - date parser recognizes integer overflow
> 
> We used to convert overflows into a sentinel time, but now we die. I
> originally chose the sentinel approach because it lets you use the tools
> to examine and recover from the broken state. I could be convinced that
> dying is better, but clearly we'd need to at least update the tests.

Sorry, I dropped this patch in v5 because I did not want to fight this
battle.

Ciao,
Dscho
