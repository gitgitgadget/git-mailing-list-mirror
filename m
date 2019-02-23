Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37D120248
	for <e@80x24.org>; Sat, 23 Feb 2019 18:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfBWSGt (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 13:06:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:46273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfBWSGt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 13:06:49 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIMyZ-1h1Ar20p5D-004Ez1; Sat, 23
 Feb 2019 19:05:59 +0100
Date:   Sat, 23 Feb 2019 19:06:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: does "git clean" deliberately ignore "core.excludesFile"?
In-Reply-To: <xmqqimxao76b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902231905180.45@tvgsbejvaqbjf.bet>
References: <alpine.LFD.2.21.1902231008530.28936@localhost.localdomain> <xmqqimxao76b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XHvn/ABlouh3zuMeDEv5vjMw5cxUp0XKYUK0hM1mrVf0oYlWO84
 ShFJULxM8fUVqtE06Y2999k/db+YbbpIAPkuStgCWn3c/E3Ir7MUXgF7lFLGcu+ymMGPwWP
 BQPz3ERJXrSeliNgaI4PHtBjvfl1BfOT3EBYvcBSmCR5r7ilLW+UZNYfKWOGXBd7oYnef+k
 pkjh6zozCVG4h2AYiqq6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hxz65we1vBU=:ycG64eg/3ApHfl1EbGEv+K
 4SPK+6DjdP2SxLLsKZytmVVkqTpNSks8rnoX/Kw0IyM2JIQMS4NO4EwYLl27tuewQMk9DslYh
 SRaWbv1xjuwU0VdrHwmlTR7YhQH3BILpkx5C0i+zPyikPwgxmVqAz1s8PDiiXMn6oAxUF9Bs3
 AzNigUSmuk0rCzYoHrJrys3O+yBgEvoRxTFQgWHmifVABRLuTILlJGcOBrFrDlDr4Z0R/tYBh
 j2PCMr+CZJkKRNqZ9nz/1E0sV1bixkPO0cuKGrXRuwysN5BVtOHbiO7KjZE0FOWtKEqf0ErL/
 GeDpMONMWVFFDYH7i5LiZWblLYk3x3LmxVmNhwsdzxroeKUosHPeP4zaPQEzLwLMyJJpIRwkx
 ib8aypRVhwxUQ2/4TVru7Jwol8VGYGqKf4/njQSTj4hfSCNIhk1Lta6Uijfis4eToMTqdCF0E
 FvIuzQRnf51ZCxZ9ZSg6dfIkpFj4hx9h6090cgSodO4IN3rf6HMsxHUX5OHT9K+FbvptHYfFY
 Zo4dSOkUZ/f+MvIBD9BWpohDJbWqkDRbNxx/0Mk7A8V9LVl6rvKBdiw6pImHM4D6zhSy/GBoI
 CsTbK3K7gBJ9gtGsX47hb8zFlifEKp27aCeQEfejV0OJOzgpoReMorxYQxgUVpgoZGp2cBDRH
 vUXxCm2LXsoBEY9ZVEiGXCo+cfJm3CDfGAPKX+YqjZYuQHopg5RtnX6Lpz9gBJQB5oqKplBwk
 gI6j8bRFr9bAJrSXHuesevDvb4hhrCwTlejZuPVnrNRZJqv5WW1BGAdavbBH7U421uTe0cuFg
 rIUgeEpSUHPdjzLGejgIjY9A9+c3swU1Rr6XJMkK+S4iWTwa4eGZ9Wwt3Np3qNsGvHzh+qEBr
 9ExSr23Kp74WvTULjwhhlaZYAt84uoTqog1wqFVuHKhmvCCTH5jTgvgzLfE5gCwesM8E06BLC
 oWP9cqDY19g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 23 Feb 2019, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
> 
> >   am i misreading something? and if not, is there a reason git clean
> > does not consult core.excludesFile?
> 
> Can you ask "git log" and "git blame" whch of  core.excludesFile and
> "clean -x" features came earlier and by how big a difference?

Or maybe we can have a look why the `core.excludesfile` regression test
case in t7300 does not catch this?

https://github.com/git/git/blob/v2.21.0-rc2/t/t7300-clean.sh#L408-L417

Ciao,
Dscho
