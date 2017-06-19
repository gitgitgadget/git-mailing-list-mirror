Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3315420282
	for <e@80x24.org>; Mon, 19 Jun 2017 09:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbdFSJ1n (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 05:27:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:49863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbdFSJ1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 05:27:41 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwaMR-1druAs2oYB-018Nno; Mon, 19
 Jun 2017 11:26:45 +0200
Date:   Mon, 19 Jun 2017 11:26:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Langley <agl@google.com>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
In-Reply-To: <20170616204208.ak5twydrloxefm42@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1706191125510.57822@virtualbox>
References: <20170615110518.ordr43idf2jluips@glandium.org> <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net> <87shj1ciy8.fsf@gmail.com> <alpine.DEB.2.21.1.1706152123060.4200@virtualbox> <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
 <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net> <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com> <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net> <87y3ss8n4h.fsf@gmail.com> <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
 <20170616204208.ak5twydrloxefm42@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xc1CDw17zCQnjFathTA2EC4xx5B76tS/q4R54qQ687XMroftki2
 zysWbPj9XzPoKzZVVj1jph563wzaJeVKZku4vzLgJ1o/b59+4YENjDskiPgoOoWSZ5SdZNz
 oLwJ5FhkhecE3KRTeSPwo+8JQe97u3E0QeGmXVNbW9kpGp7Jj8rNocfGgsPgD6B0+nWGIqn
 HBT7atecABZj/QLaJ7axQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/BrvdTo0I4U=:X0Xnx9xMGKNuwxUVk4jIjg
 XrjrMfzJ8j/aSY6Zwu4vLqU+Ua1aPGCTaFORgoVt8IOTJaKq1KjW8MywgrZZJQAXX08dAatiP
 3C/tOLY7KwtY/LJNxU9ztyKY4Ia0kJzCyWwO1P3CgHGJuhChzFYLbLQrrkOwu1t3k14KpOCk5
 QIkTwF7X5Miz1Rv+96UwWxtf015ZDzs1BQZOp3CSSnnsYuz34VipVw+ELgp74wCQuVLDPiPSr
 NgNbuUaHACm0gb7K7w8yDC4T4IomGYcX3jozVLh51HXdBVlgHdxcaoHRPa5HgOfqtyU9z34NS
 JNY4OXi/sTzX0Oean7HbtDvGsnz43ZxB1ubYUGbmVDEtKZePCFbao9MrPiPOruTxGFTbbXGdE
 ADTcPw1jEG/GxRP3wu9pt8IhebIDudYD6UdB56Nlp12W21qv+ZeW3SJqqgMvk1hQDSOrjYDXI
 VG1w+ZRJWhhSbAAMkMXAXft/FR4az/fP6eQX9NErJMoTrpSNkmnZJRldhUTXiL9uBo1jShqrQ
 auY8yLMoY0UxM1P4ZyTVMmm3fD1x73iMHS5/u1NrWNUB8kQkCbZRtH/WrboMyJ5wDvIRJSB6u
 4wD0+jdK2OZ/BrpTvkluUYU//NOLIVy0AbP9VxGZOgA32iUz4G8EKvCJiSqyr5FVTs1vSN4qL
 S4fDg+ih2Esw8kyjbJ0jM/qe9sHnM5v7BWPbmGO3/SitjamTei9HK3hi86ZZKV37XxhZWyvc2
 d/0r7XELIk1XX2JmA1Gk+IH7MObIUxi8veVQ6lDCxRMPM/EzWp2tiw/dgBs/R2XZvFiaW8The
 0/obqCC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 16 Jun 2017, Jeff King wrote:

> On Fri, Jun 16, 2017 at 03:24:19PM +0200, Johannes Schindelin wrote:
> 
> > I have no doubt that Visual Studio Team Services, GitHub and Atlassian
> > will eventually end up with FPGAs for hash computation. So that's
> > that.
> 
> I actually doubt this from the GitHub side. Hash performance is not even
> on our radar as a bottleneck. In most cases the problem is touching
> uncompressed data _at all_, not computing the hash over it (so things
> like reusing on-disk deltas are really important).

Thanks for pointing that out! As a mainly client-side person, I rarely get
insights into the server side...

Ciao,
Dscho
