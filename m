Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878F01F404
	for <e@80x24.org>; Mon, 27 Aug 2018 15:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeH0TWc (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 15:22:32 -0400
Received: from mout.web.de ([212.227.17.12]:40301 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeH0TWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 15:22:31 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxfGh-1ft9ap2IFX-017BW9; Mon, 27
 Aug 2018 17:35:24 +0200
Date:   Mon, 27 Aug 2018 17:35:24 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Automatic core.autocrlf?
Message-ID: <20180827153524.GA18025@tor.lan>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:kZQRqvhQ4iInC1vc7jSfH4wIeKKxu8SJaCgWFvOyHiB2zoydz0w
 FXmFWpNDksmc4ZZiOKxy63vs/vvY3Um8FZy6w7D96i/Ts3dfzbUwV5nEvAEjYRnMSfDWTOl
 NpMes/u0AwopR5vAmjxOEO94whD2rayiebnYRxF8OG6enP/oddItA21Qo5NgQV2xpcKOwAT
 XXnEij/d5Ict/X40hcaJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RcWDpH9+Z5o=:MWT3JCyykoaIdxYqQC5gfT
 lifuMUF5Il91ycLXYTAVGwmI928mcuaBADMrqxvZ0pfRpbnhvnflcx0BTLYWRz4aCbl7p0yAd
 r1PeHuG077aQ7VVQ/fCPKC4tP3QixaED6+lhb1I0aMSe7tNQoitPuEPuW2JvpksN3tIZkwX56
 lQecmU04MZ1vpQ4yW3cULdvoUMvMDp90FLkWxEeUiq1qU8ZTo2MN3J4DHD2G1HuaIR+Fi62UM
 0BNIFxZPmu5EKeX9Uzh4NIaQcwpePoBZGbS0BzqezK+g8VMVvc2CSJkApzVhDEF3VZ/je0p4J
 mRDlXtSoGswD2MywKIsXdT0qnvVIQ27XFwQ2a7J1ByzYN+Dvhga5puaBah9wjGAa83xSjyjpm
 WWzlN9NfnFoFWoiWW5JoyB+2mILYqLSme+3fDsreyet0sA+XUMxwf30dJxciez0jyqdzas0hR
 QAfCf/0QH/BC4D1QLQHSY8hl5+VTlzXfmXWweVlvzgTwaCy85ZDJhEIL6FctyTwFWkUZUSuWX
 EtRZPpMr2BsDyc/GVRIsH7s5b9sFN3hUlLtMm03SGEPWYXP16c8OSpAGgcD/CZDhvHZDagjJI
 vRL8a1W5AbC+1hF4DTPJkBBMJNYGOHZNdVGfMy/5faDXiXyFAsLQIC4zlQ2Tgq8sYyHmfXFte
 11ifDRhMjFmXG2NS/EDkQokUBcnkIlGel1q8TkP9TBptVWYXR2P02WItglSt15eLFHkD3J49W
 yf1VUvIe7Mv8hp00tL7R52O3BJuA2v74K53lJ5n7xGYE0IrIZyvPnSh3jh4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 09:10:33AM -0500, Robert Dailey wrote:
> Is there an 'auto' setting for the 'core.autocrlf' config? Reason I
> ask is, I want that setting to be 'input' on linux but 'true' on
> Windows. I have a global .gitconfig that I sync across different
> platforms with Google Drive, and I hate to manage 2 copies of it on
> each platform (linux and Windows). If there's some way to make the
> line ending configuration the same between both, that would be
> awesome.
> 
> Note that I do rely mostly on git attributes files for this, however
> not all upstream repositories have one, and I don't always have
> permission to create one there.

How many repos do you look at, and how big is the "pain level" here?
Would it be possible to submit pull-requests ?

> In those cases, when it falls back to
> configuration for line ending management, I want it to be
> automatically configured based on the host platform.

There is
git config core.eol native

But that is already the default, and it needs the 'text' attribute
to be set (or auto), the simplest solution is to have
* text=auto
in .gitattributes

> 
> Any advice is appreciated here. Unfortunately Google isn't much help
> on this topic, Stack Overflow is a swamp full of different information
> and none of it seems authoritative.


Out of interest, not to blame anybody:
Did you ever look at

https://git-scm.com/docs/git-config

The authoritative answer is in the Git project itself,
under Documentation/config.txt

In summary, if I understand you right,
the solution would be to use .gitattributes in every project.

HTH

