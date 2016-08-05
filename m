Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838EB2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 16:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbcHEQFG (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 12:05:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:54425 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759909AbcHEQFF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 12:05:05 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M0cs6-1bFgQL2PUs-00uooL; Fri, 05 Aug 2016 18:04:31
 +0200
Date:	Fri, 5 Aug 2016 18:04:11 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
In-Reply-To: <20160803180820.2raazmsfjavoaogo@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608051800190.5786@virtualbox>
References: <20160803084743.3299-1-judge.packham@gmail.com> <alpine.DEB.2.20.1608031621590.107993@virtualbox> <xmqqr3a5al7z.fsf@gitster.mtv.corp.google.com> <20160803180820.2raazmsfjavoaogo@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L/uhCC/irgqdKh3uBNHSJLmACgraPMwjF5CTJRdB7WD9ppSnjbR
 6hDn91aGYFTOiinTR0ZRewP7oiAx23i9Jc3LTOfk3VNgfXxzS+3q5Y64IF2qQpLbvQqeErG
 HjRGwXhyoGIArcy7DsAfLnGTlO4IiN0kLYnjhJhhrKjnuO6U8EpmIOik5PIpTt/YCehYF+J
 uKy0KDbnxpCrvTisXcN2g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:IB1ToWK/Hjg=:ZeOwwMhVcASeoko7t/qSX+
 1wDXLJUWa8bevnXffz9nD+0algFC8K4rhK5MrYq13Cvmpsqr8UXL7qbhOorq4TJaX46vesEIb
 icbrHWvBAB4YeapM9ZY218gknuDfl3/sJrOtPpkjKMRHLe97oNn84qg5rqk4XEoWAHr0rEkYx
 nOYsyzK7AyTVBF0ewJERy/BIEZIdgkzal4DkzjgztOOMAJfqPV8DK6z3aeltCPTmkbdcvMe3p
 rpISyxLk33gMe7s0nYgti87o8fP2DvkuS7EUoRh83P211Pbj/fsANmNsxPSmx4F8Dw1zGKe12
 x+RuhJ2ZXCwtVG+VOqh2TZXemorFYj9hPgWoRA+la3vMkW8ekvjcSdWBZ10VQBYvIBGWcF+ni
 6j0vPkvtiih7Cj4WZ78VfR2qkJPHi6UHUTnFtU8RCOD2K9Dg/C5Pj3M1oVdmgC8G2I6E8o86E
 8c/F9LtYOCQwgJISJr4/JjW+ug+uuXmTR6yY5P91DRviccDP7/F+rPZSaFGVE6FuSMu5/rFf/
 EgnHuld3cSbdwmNkhQBU+JWxCJACsOhEzHIauzLkNBUB7FUToPguxEZdD1uu8HMY4O3t/i5nU
 2+3S60n0bQFFiXySx5SpnpigJYzlhY44hn3Sk9T7+wZrADzS9deQfqZetrdmClDAFay7AghSS
 9GSNb4L2/ayBvMX5P4iSOZHHCBC9q/2les6I4veEaAfb6NJ4LZ+Ee9TS3iLDzW3rm5LcCT++6
 QnfY2TJnkKUHLIyjRUdbEd7p/VrGFWVGhFxRKIB3wWuuNz4dhRX2JXAahZOk0PNgqgE6FgKUd
 1wMr7Z5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Wed, 3 Aug 2016, Jeff King wrote:

> On Wed, Aug 03, 2016 at 09:08:48AM -0700, Junio C Hamano wrote:
> 
> > > However, I could imagine that we actually want this to be more
> > > extensible.  After all, all you are doing is to introduce a new
> > > rebase -i command that does nothing else than shelling out to a
> > > command.
> > 
> > Yup, I tend to agree.
> > 
> > Adding "sign" feature (i.e. make it pass -S to "commit [--amend]") may
> > be a good thing, but adding "sign" command to do so is not a great
> > design.
> 
> I'm not sure what you mean by "feature" here, but it reminded me of
> Michael's proposal to allow options to todo lines:
> 
>   http://public-inbox.org/git/530DA00E.4090402@alum.mit.edu/
> 
> which would allow:
> 
>   pick -S 1234abcd
> 
> If that's what you meant, I think it is a good idea. :)

I looked at the code in git-rebase--interactive.sh again and stumbled over
something important: if you "pick" a commit, it *already* uses the
information provided to the rebase command via the -S option, *unless* the
pick fast-forwards.

That is, I came to believe that the "sign" command is unnecessary, and
that the --force-rebase option in conjunction with the -S option is what
should be used.

Ciao,
Dscho
