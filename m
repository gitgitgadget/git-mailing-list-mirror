Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04DFA2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbdCCLZM (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:25:12 -0500
Received: from mout.gmx.net ([212.227.15.19]:50763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbdCCLZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:25:11 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lmp-1cN0Jf1D2t-00zWh4; Fri, 03
 Mar 2017 12:16:36 +0100
Date:   Fri, 3 Mar 2017 12:16:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/9] setup_git_directory(): use is_dir_sep() helper
In-Reply-To: <20170303033714.5h7qrq57hdqwoi3y@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031212280.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <d1342d28fd402615f1f94d9190559070ed04b0d7.1488506615.git.johannes.schindelin@gmx.de> <20170303033714.5h7qrq57hdqwoi3y@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3pZeesbp4/VC5Kqm16pbGGIu0Nckx3NApF/wGTSKBhi7a/Oybd3
 w4AGhQNZeqeNZ85Yb+oyIZrLDceG8bEbZEpIHi6gbwxDhaM7PE5K7zKUxp8kEwb0rRynjgI
 801WnIbCqRlNlHHyBgh4ngEUO1libSupBqbum7OWDmP3u601jYpuhsSbaH0/aBfGVLtq+J6
 Px9NS+Paa+RC7mFbBKtLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6q0yq4Cf4HI=:1KG0ZVYB5RDn9PmuJqoDVD
 S7wZEV8QitZFnSOb00Ma1fIO0hC8cj9bYssAxRMzDNha15eeGuOGk+S0K7rfPz9E541SjbiVQ
 gZIKxbaPrJ7aPJ3+UbfdskJRA9VIhRliIv1eSWLnKWb+C14h4CF+QRjyu6PHKMKnpBFjXh5Zj
 1acP7dOgTzWAOuFu3xBYfj2jQInU+mTHNwBqAadHizvzkIcjksJiPKHlwA0ODyzht604ASHBM
 TmaPSUZ6svKlCeGbrkPf/TC/jlVWpqsebUQ0Ui7xlcy0cQVme4XFTqlB0kgRKY85sunwys0jK
 OFD7ERQ0dwMAH5V26HS/H3bb8mdfAMfvPiCtrORi6IKd/ZaDddqSQMb4pnYbaRGmKhK29Egv0
 HuDdlg/eqCO5yFMgAo6aZjP0DUjfOyN+Xk3YtE/I30V9eINR5xOdcepsMvxdpHyYlJRgYU5wP
 5goZVgnXA/DtAyEmu0sk5x1JqIzCfyRhCmcElYiMR4CFbXOmKpwilN8EbIZvMYn9x81XlYb1W
 E2eSOz754aG7XrmjQbTgIPH9PzDUrCn9lcXp6nSjk3K43Wew821qkJZVS4ZaUDPrWB/MI9d6v
 XnxhBUgwG++mQ4Wl/v565AnQMqzC4ngK0km6rPqT2MTxxkEJAgW2W8Ac4a4wK1tuUT2JV9ayn
 KMt78f+knuJ3tQ0//Wzwa5+k6tesROL1DvpPL2nd4SRQSysEBjzIRQX6jdPrg9t7B6m2KlOUG
 WzoLQhG+Tb/d6pG1oB7D8fQxx5kUBPsEhsww+KdsiUqzvNYr54Z8UX1uFwldhqqmn13aSvQCw
 4q+YPV4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 2 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 03:04:07AM +0100, Johannes Schindelin wrote:
> 
> > It is okay in practice to test for forward slashes in the output of
> > getcwd(), because we go out of our way to convert backslashes to
> > forward slashes in getcwd()'s output on Windows.
> > 
> > Still, the correct way to test for a dir separator is by using the
> > helper function we introduced for that very purpose. It also serves as
> > a good documentation what the code tries to do (not "how").
> 
> Makes sense, but...
> 
> > @@ -910,7 +910,8 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
> >  			return setup_bare_git_dir(&cwd, offset, nongit_ok);
> >  
> >  		offset_parent = offset;
> > -		while (--offset_parent > ceil_offset && cwd.buf[offset_parent] != '/');
> > +		while (--offset_parent > ceil_offset &&
> > +		       !is_dir_sep(dir->buf[offset_parent]));
> 
> What is "dir"? I'm guessing this patch got reordered and it should stay
> as cwd.buf?

Oh drats. Usually I do a final `git rebase -x "make test" upstream/master`
run before submitting, but I was really, really tired by the end of that
stretch.

Thanks for being thorough (and I fixed it, of course),
Dscho
