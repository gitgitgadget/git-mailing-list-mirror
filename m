Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7DC220282
	for <e@80x24.org>; Mon, 19 Jun 2017 09:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753743AbdFSJLD (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 05:11:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753732AbdFSJLD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 05:11:03 -0400
Received: (qmail 16898 invoked by uid 109); 19 Jun 2017 09:10:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 09:10:52 +0000
Received: (qmail 24805 invoked by uid 111); 19 Jun 2017 09:10:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 05:10:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 05:10:51 -0400
Date:   Mon, 19 Jun 2017 05:10:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        gitster@pobox.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH/ALMOST FINAL] Contextually notify user about an initial
 commit
Message-ID: <20170619091050.kymih3f345kexaf7@sigill.intra.peff.net>
References: <1497771338.1689.4.camel@gmail.com>
 <20170618075301.6431-1-kaarticsivaraam91196@gmail.com>
 <87shix8zik.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87shix8zik.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 10:34:59AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Why not simply "No commits yet", saying "on the branch" is needlessy
> duplicating information in the context of the status output in which
> this is printed, i.e. now you have:
> 
>     $ ~/g/git/git-status
>     On branch master
> 
>     No commits yet on the branch
> 
>     nothing to commit (create/copy files and use "git add" to track)
> 
> But we can just more succinctly say:
> 
>     $ ~/g/git/git-status
>     On branch master
> 
>     No commits yet
> 
>     nothing to commit (create/copy files and use "git add" to track)
> 
> Since we've already pointed out that the user is on a branch.

I thought one of the points was to disambiguate the case of "no commits
yet in the repository" and "no commits yet on the branch". If we don't
care about making that distinction (or think that the mention of the
branch is enough to make it clear), then succinct is fine. I don't have
a strong opinion either way.

-Peff
