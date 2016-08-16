Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C10C1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbcHPPLe (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 11:11:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:64620 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbcHPPL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 11:11:29 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MM0bQ-1bYa5B434u-007i0n; Tue, 16 Aug 2016 17:10:38
 +0200
Date:	Tue, 16 Aug 2016 17:10:36 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
In-Reply-To: <xmqqinv1do2d.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608161710100.4924@virtualbox>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de> <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com> <xmqqoa4tg2yi.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608161026110.4924@virtualbox>
 <alpine.DEB.2.20.1608161035320.4924@virtualbox> <xmqqmvkddoqi.fsf@gitster.mtv.corp.google.com> <xmqqinv1do2d.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KFWGcdirjKxz3Y5o6XcivRqBjvmlsQ/2p3JJngC+SacrSf2pQQj
 CFpiA+NmM7J9jYFUheEnJ2iKdrz6F4POVgwpyAhqaIXBv8yFazgFKR4G22P4cTGoGZSNbOP
 rMvwDiBpHIg8YUfOeYXfYZOAUjtihgf73miOJ8U0oVcJzK53AbF4CgcQWwmX0QNXtAa9ANz
 i+iV9E2nFKulY+nDvSKTw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kXPHb9+yO1A=:kN2pPonbL5iiyiCjxZQ/QZ
 S5d9E255pyQish8Wkc4ulMcTKYbOd+1uB9tpQI0VAtPxNQPjOnr5Qx45zuo2fEhlv65mrHOJM
 CnJ6oQtGgGSFTJJdvkW/e+0aoXharyyseY5ErjVSP+rVjxsuZ8cpVhp5miMxXzYewR2MrAyhp
 8kfV/tp5qAINELoPtoZ5XqcH+1IrDgzpYU+5vh4PoZ9G6Zt5bGjbY10/y2HyVbE4w/At3JRgW
 qfFo/5Gp6N5Tss759c/lVI5BD7YlnYiKqt6UYiBf8XHFyNqfDomr0P/VDjlSpIl/RrbFx8OYD
 ORHSReiKUEYtFywc7Swoxf8GnwpGexRl7EgKZ/L0qmYFhYP9OxgfFB6FFD/th/OAeFzxomng+
 qKJ1h+QxYePErUCzoXyr0rNqG4x2NTGhb9mW8Zxx/eZMaoiod/CgKqmtEJnJLv4wo7S4Sy2hx
 fpr9VOQdcyGIX5qZ1F2HSHWZHHz4Azd+DfOkFwcfqrrV5ig7lRSFgiysDGraWAY7qzldvtRv5
 x65KDkUTXs11GniI979Q2dtuPDzg58z6DBmOYyqn8wQZHGl7KrJk5646A7oUJbzT6I5M6/PwJ
 xgHWbt+oMWBPwlqWK54RgaZHaaCb5YTbQBAqvL1HX/21w99oKq90Fg2azmg2QUDGEFbPHMEEK
 j1MoNHc+r0SBvUWMlrFfKPVClCK9MNMPo9Hlit7hbgBa4QtGjJWozeRWTOGKG1hCUK7jlADdq
 Rpx2Oer6yfHDDCAI01WtYWHW/sInGkkxTmhBzaDYD+P9NfXE3atNVbAFw0KPNO0e/6eXLWYIX
 nmqi7+W
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 16 Aug 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The trick to catch non-ascii depends on core.quotepath set to true
> > (which is the default).  You would need to run ls-files with an
> > explicit "-c core.quotepath=false" to be safe.
> > ...
> > The invocation of "git -c core.quotepath=false ls-files" needs to at
> > least have 2>/dev/null to squelch an unnecessary error message.  In
> > such a scenario, we may miss a new offending pathname, but we will
> > not have false positive and I think that is the best we can do.
> >
> > Thanks.
> 
> Needless to say (1) both "false" should have been "true"; (2) I
> shouldn't be crawling out of bed and typing with hazy brain early in
> the morning.
> 
> Sorry for typoes and thinkos.

Sorry for not even expecting an answer from you that early. I will send
out a v3 in a moment that should address your concerns.

Ciao,
Dscho
