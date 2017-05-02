Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D89B1F790
	for <e@80x24.org>; Tue,  2 May 2017 12:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdEBMjJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:39:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:52200 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbdEBMjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:39:08 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsxuQ-1e3VPv2KB0-012bHg; Tue, 02
 May 2017 14:38:57 +0200
Date:   Tue, 2 May 2017 14:38:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 14/25] setup_discovered_git_dir(): help static
 analysis
In-Reply-To: <xmqq4lx3ewrc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705021438300.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de> <cbd8e917f1318190d9f979f4cc9b62dcd838bbb0.1493387231.git.johannes.schindelin@gmx.de> <xmqq4lx3ewrc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OdE/syOYfsucLP1VZbfparIKEBo3X+511PKRYxRMz5cZrvF0Nz4
 8MkpcaPqr3AOJPNbDU8akiZypnPdxOxjL+2fTAJRy6QzSfTrTYAnOyOsBjvleqJ2rklvL24
 65u5sxWpErNBXe8rcAjc5h78lY8wGMM/kber++vpy5jdB8fB0zIwG7vJWLXTjzXahNfJwfE
 fgUvKICQXLss6bCjiNMnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kk6/yEGJJaY=:olsLgP3yxDdmWhjtw3azrg
 HR9gpLO8ZAoST7XEF6JmdhoD+yRkfL9WVYv9SdDSnOgTz9Vafr9Gt+P7Ggx8RC89VwbE/W7vJ
 aX2/BcjqgGYiebBJVrciio1xO/4ntjFzjS30U8apqU70sEpFJpyvaUV6+qCzIHuRV4FWe69Ri
 ZIoFLokNTcIOrnwFZR+mXw323cHWG0uLicRtmwKYLW5VuF2vdOjEh7VpvsTsgg9hvUc7gf1SL
 2WylEm03gSTQTDrpOWo531YdatIDg0eustg/MwxT7FIbyV/VQV/rJseCwSgwv7x3GNnw/xWps
 Ht90Wt2KAL250vdvzIQ3UsJIVWeGQ6nWqtaTvKADNtUdWM9zytTPKu+MkhMErcX8j2XTJLhNc
 uCPFkmj6qB6t6bYj84EX4SSGR7iEKN/8pFrAXVUms78rIS0PiwIWYFmE03PQLaLs/lDks7Vuy
 rVZCBS5bWyoxTwOg5oEh2lh65IuGLcxdzRhuLKTkY0bH+dlesp8DNuzBRh+zp26MyF9yHs6hT
 7AoptOZeZhAKMX7e72lJCDPBIqs/XfILSJLQoatWD0ZaQn2TGKiK1RDtx8r3WDmCYnXpPQuXo
 ySpMpb6GB0sc+2kaDkdx9H7xT2/Fnq/CN4MlkUSFvKdjJBG30k6MmLQHUh9KrEwki2Dvl5bzH
 n5ADJtVWuUait5JuovsC2NJ93ujmJKm64sPyTne+7KJIbhlt6fwBUrlV5kpPi8J3N9zd5YpuA
 BBDYrdxTMyt8S2O0DCajqev74uGIsPs/3MUa5u+5NOZfos5Lc+cMgBk6+xZD4IHDa3H7XqRnY
 A3rSUaO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 1 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Coverity reported a memory leak in this function. However, it can only
> > be called once, as setup_git_directory() changes global state and hence
> > is not reentrant.
> >
> > Mark the variable as static to indicate that this is a singleton.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Does something different from what is explained above.  Rebase gotcha?

That, or just a brain fart.

Thanks, will send an updated iteration.

Ciao,
Dscho
