Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB79020229
	for <e@80x24.org>; Thu, 10 Nov 2016 21:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934996AbcKJVzy (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:55:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:59604 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbcKJVzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 16:55:53 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MATlG-1byria41Lm-00Bbc7; Thu, 10
 Nov 2016 22:55:39 +0100
Date:   Thu, 10 Nov 2016 22:55:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Andreas Schwab <schwab@suse.de>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v2] t6026-merge-attr: don't fail if sleep exits early
In-Reply-To: <xmqqbmxn6t11.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611102254340.24684@virtualbox>
References: <mvmtwbhdhvb.fsf@hawking.suse.de> <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net> <alpine.DEB.2.20.1611091437280.72596@virtualbox> <mvmzil8btzb.fsf@hawking.suse.de> <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net>
 <mvm8tsrbusp.fsf_-_@hawking.suse.de> <xmqqbmxn6t11.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vYf8vHrGYhV3IDQa00Cv7LFEZv8U2RXaBhhKanVCEArAdPhBaLJ
 7qeFevAwq1saboKv62Ou9F8X6yRWWHz6MsUUW5jbC5cvMIw5LvOx2BGlsVBkGtLWBNw1Sf3
 BdmYkAas/I/sV84VBXgpUV0JHaY3fXSYN1O+wd/UErDJybbqv3NjmGtcJbNRkBTDuBmZeRG
 5AS4PiVma+T+UZYzeFoGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EfPKHqn7SYg=:cuj4LRmGmstzBuH1uvOf7G
 CkryvgIigt6twQsheB5+cmNsesxzaiLlePdDfBxugHgPmSjusitkSDj7ot4mtk5VfWSsQYbju
 t5d0zVuf+InO229s2YU1YXd8A0MGd7+48M3QHq+yoz3L9daUKksAyoVg1QaN1K1XSo2j2UmbD
 MyzLnhDPMWh6bUJrrhgMNSXwuSIaFecHNl89grJJXS/U1Vu8z7HbBOY/Mkp5ri648XFWuz3z8
 NXjMX7MVc+5g7V0eS6tDu7mZXNxj8PLI8HmFEZfBYgiuVvVq3nIix01lJ+Lax3JLAsqXKYOt1
 bDt1/m1QBnuUtGFkwePxJifFd2yav3/Udau5ylZgoWnErd0sZJQPVZHXS15l4jDmQ45o3L1m1
 h4xUp64X4QVyeGGkZrnJzZb/BxthWnerKny8GJSUwqv84VbnCs7u9aYsoSZHh/6bX02ODFJ2v
 gCiaXgav/2kKnKeiTsftaXwfYz/obFTAVKbxbqOnG+kacb1geOI5Dhr527YPAlzopy1tipABU
 zUcutHpltkuRvR+rIFK52VX5zgqSJwyJTV0SYSYPv7p90GE8YlC7jqPj4lwUkkllDkYUnvQMk
 1Mknq6txTqAEYcJC8eGR5glENclOUpAnhl5HlbLz3XQkspUl/+v19oLsta5qlDuX9VQkwGrK2
 iRFyW0Qc4W5H2vGks5xFQb/aI5WibIpQpa/aLbCyeUpYmbeamt7wVykod2RHUBRde1uWWaxOa
 e2ZHxBh4sE/qjR/xda/RPKVPYSZgDivBAFCEY4Msm1S366jupusrkTYJoeYL9pB6+3TBCW3oe
 r49BE5a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Thu, 10 Nov 2016, Junio C Hamano wrote:

> Andreas Schwab <schwab@suse.de> writes:
> 
> > Commit 5babb5bdb3 ("t6026-merge-attr: clean up background process at end
> > of test case") added a kill command to clean up after the test, but this
> > can fail if the sleep command exits before the cleanup is executed.
> > Ignore the error from the kill command.
> >
> > Explicitly check for the existence of the pid file to test that the merge
> > driver was actually called.
> >
> > Signed-off-by: Andreas Schwab <schwab@suse.de>
> > ---
> 
> OK.  sleep.pid is a reasonable easy-to-access side effect we can
> observe to make sure that the sleep-one-second merge driver was
> indeed invoked, which was missing from the earlier round.

No, this is incorrect. The condition that we need to know applies is that
the script is still running, and blocking if the bug reappears.

It is not enough to test that the script *started* running. If it exits
too early, the problematic condition is never tested, and the test is
useless.

Ciao,
Johannes
