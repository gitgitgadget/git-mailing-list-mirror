Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029CD20357
	for <e@80x24.org>; Fri, 14 Jul 2017 20:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdGNUjf (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 16:39:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:51923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbdGNUje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 16:39:34 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8Nik-1dst2p3EFG-00vxKQ; Fri, 14
 Jul 2017 22:39:21 +0200
Date:   Fri, 14 Jul 2017 22:39:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v6 00/10] The final building block for a faster rebase
 -i
In-Reply-To: <CAGZ79kbGqSadRDSQbg3N6pj04igFQG1x15S_vDUD4A6sXRSzXA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1707142237310.4193@virtualbox>
References: <cover.1500043436.git.johannes.schindelin@gmx.de> <CAGZ79kbGqSadRDSQbg3N6pj04igFQG1x15S_vDUD4A6sXRSzXA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aV6DKHy4+vy5rbCqAWwAVoKjttphSuUyx554AeOO1oDmCDOKHTg
 6t0SYdpHJK9CxE5fvLWvVpsrMz3YT3Uoz3STVEFaH2k5/teAbC8FwQDtAF0Q5mIbQJ10gyh
 JYS/79hUDbLv54g+b+6Wjukl7Mp1yMKTWASeeS1fRql3rNgQUbwqqSDKCE1Jr8B+I9wYW90
 Ydn1usqq9udPsfBEH3Xfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MOw1DVDTmco=:BNnaa+W5qh3hoBeTfhyqs8
 3L3DtOI5KuGOiC28XUy2LFVaNabwAWfyQxViRNKI0HGJYtjQE3KNH//rrHRe6iuDZWUyWALOh
 p/M13y1lBjYRB143Isz6AW4aayj/v+y470RH/Ai5HNtPq+UCauJ2S6ghE3D528Fznsj3PjpmX
 Sn2Qxy4yCwd/VHb70VCvNDLluDlHSrN5ZR3z0IR9UFpOZAnQO2evf6v8lrMd3WF5EJbza1FqA
 RXykTWdySawWg52fOes+KIFwH/Mv/grWvoNDZbNzOegvdwHZ5j6jQam9FfGISkhlnMvBgGPSK
 Np++ZNYl9PmF1k7ziD6ahySz4npLt/SQcsTLp++UYkFRZ7DuNXcI3aCnLSpM16W4t3rWZBzgq
 F6BfW72t+B3WewADgml3+HVvg2zsI11UnMyRkxEx/UDoEyMFAov1T+T+cWGmAfHqC7ZQEUHlm
 w3oA05BtOXPNNV5m5tjJKHsGz5lrjK6svhH1ABTi8V8RpoxrMizTIgna9FnA35LS/wVhrR+Kq
 arguS/AJcvNISNfXMqFE/JO3+c4QIhArrMHpvbQxXfOlRV6IERLPD7Ji3lDN9vbyERWJvD5Kf
 731aj4ljB/GdnIq0V7doLuz7lMLbvow2Ra2lh58LIx2FH6Lo7nDZuuTe5TFOF0T5xqh6EHrAw
 vbMYJYFhB55sk0pKWq2PRaeAtBxNArJzL65FNGHSiyrKhi1GfWWGWtGi259p6/eJyAdwcnOQV
 pHPRgTTVLfXC2/GDPq+hpbF8aSsk2dbqlTe0sOHbNteSn61RVWw78SaNvPCo03wGzGQ/I3P6B
 ulF9f985WdxG0QhQgFtPpMded2aibImdJJaFhavtqyqf/sDtas=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 14 Jul 2017, Stefan Beller wrote:

> On Fri, Jul 14, 2017 at 7:44 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>
> >  -static int subject2item_cmp(const struct subject2item_entry *a,
> >  -      const struct subject2item_entry *b, const void *key)
> >  +static int subject2item_cmp(const void *fndata,
> 
> This could also be named unused_fndata.

Sure. I simply took the version Junio used when he merged the previous
patch series iteration into `pu`.

The function is short enough, though, that I feel it obvious that the
parameter is unused.

Ciao,
Dscho
