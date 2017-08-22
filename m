Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,WEIRD_PORT shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D681F667
	for <e@80x24.org>; Tue, 22 Aug 2017 14:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbdHVOoS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 10:44:18 -0400
Received: from mout.web.de ([212.227.15.4]:59788 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933004AbdHVOoF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 10:44:05 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3gLx-1dSuZb33ib-00rELj; Tue, 22
 Aug 2017 16:43:58 +0200
Date:   Tue, 22 Aug 2017 16:43:57 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: t5551 hangs ?
Message-ID: <20170822144357.GA5304@tor.lan>
References: <20170822051059.GA26331@tor.lan>
 <20170822052625.wzlhckjm6gwr2q6f@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170822052625.wzlhckjm6gwr2q6f@LykOS.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:HuemmmReQo9seoZiDeqapcCKhiw9hRF3O4RGTCzlFZqhMnmMsAt
 Dv4hpfLj2snEyJP7W0DdsQl6ZpL7C6atGrXvD6qtQk3nOoZ5ruaxndIfZZMX3PkDWYhpQpa
 mES0TbpvtI2Q5+NrBbtwE43XgDiB2mqzJDmbsxjuh+h41yXxmGn7zYrGX+JDe4A8X1O12Ol
 3IkOaZzy+IVRrx+OFxBPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tUvqJ+6BBgM=:9lX+EbtXPm6w6xRsMZVWeI
 C3GlAcE8PfXocU/OcPrHSQ01EjXacWFSluZN2oNe2BAbYjU0/0oU3f/10pDMbZ1GJM18LL3bc
 49rM16NPYSP2eW9gxFRR09FwW2DNJm/BbwDqXpQd10rUYYCBx9na3X4XInJfHCVlxIssF6XBl
 S62CgPqow02vj+EbulZchorRm0bUhvTPlg3kRY5JmNQB2gIcnzFG+hdTB+dn8WjcEp2Y2sXZ0
 09X2RLuMNK7Hh48tSYy/BFryx7yFk3wVaPg/sbdTJGwxTbiAQUUAgaQrZGBqQHXjaLc+K7mBQ
 B8Wp8CpisoTsgbcr34in/rNJJuysuDc3kCf/1CqwWQb3yspFNR6MamLcm5o/rfEbR3TTRMKy7
 iPPuaXwRyb0cBIIIxyglFEpf85eso0DAn4696ecZqZVsiluPf/WDo0v+jGW2mpGTWnmHZKZyG
 5iGpHEIHe3fDhLntZAl+I6Wju0wfqExR9rNqlQhLL9pQZJvj8N/SvEG59yGFUE+1apj55pr3N
 IwFnprdj7R5FA38+5tR3qWdk4C4cKfzV2QknVw/LxxT3Z1yo+urcYZUdu1lGU7hhONPLsbqlB
 yOnhn3A+AC4wmzPTIrN/+xl6Z5RaofJV4/tLD8K5r9aGkRziaVZHBD5bkKyrsEdEhOvxrJt4O
 Mniu7zSdYAyLdcPvWYKwQdpHneyfN7HCi+/YwkLKQRtdMx/B1JWnmLtqTrGlcG9RGhUIZMrRF
 /a01syw9vJePAewhdgpUr8Bdko9vlJ4DCqFDWg/O/an0Q1bSNUwLzKodR4UsvgKfUzZHg/Qe5
 qZOCj+TuMi0IgRT+bBOWd3TY6cEpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 01:26:25AM -0400, Santiago Torres wrote:
> Hello, Torsten. 
> 
> On Tue, Aug 22, 2017 at 07:10:59AM +0200, Torsten Bögershausen wrote:
> > Hej,
> > I found 2 threads about hanging t5551, one in 2016, and one question
> > from Junio somewhen in 2017.
> > I have it reproducable here:
> > - Debian 8, 64 bit
> > - SSD
> > - Half-modern processor ;-)
> 
> I don't think the SSD/regular disk have anything to do with it. 
> 
> - Are you running tests concurrently? (e.g., with -j x)
> - What happens if you run the test individually (i.e., cd t and
>   ./t5551...)

No concurrency.
That's what I do: ./t5551-http-fetch-smart.sh

> - You probably want to see the version of apache this is running/etc.

The one that comes with Debian -
I am not an expert here, what is it that is interesting ?

> - What happens if you kill the apache processes? 

I am left with these processes:
/home/blabla/pu/git -C too-many-refs fetch -q --tags
/home/blabla/pu/git-remote-http origin http://127.0.0.1:5551/smart/repo.git

> 
> I can't reproduce on my side, but let me see if I can dig a little into
> it.

Thanks, more tips or things I can do are welcome.
t5551 seems to be flaky - from time to time.
It seems that I have it reproducable unstable, so if someone has more
ideas, please.

> 
> Cheers!
> -Santiago.


