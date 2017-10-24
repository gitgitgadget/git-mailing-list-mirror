Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D02F1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 19:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdJXTCo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 15:02:44 -0400
Received: from mout.web.de ([212.227.17.11]:61159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdJXTCk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 15:02:40 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYjO-1dZOPm0AEE-00gZcD; Tue, 24
 Oct 2017 21:02:36 +0200
Date:   Tue, 24 Oct 2017 21:02:34 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Consequences of CRLF in index?
Message-ID: <20171024190234.GA21077@tor.lan>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:qwLxpv6G0D0x+QRRjDBD0V/sHFnBA/4pVqU+/nSHI5rTOYXAf++
 Lss1DYSnHTYdKBaKnExbgiACm411Mhss2rA/widFs/8IKbTBr+sfBOnVWTNcZERC8oouCZI
 yezZBWdK918LQr4v9UU6e54YSa9AINySMJyH+VSB7HHpUm8dJshWx7FnGN0Pvq2BrFZ2LmS
 +F6Lf5Q6+O0CbENap+zYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BsbvZCGmslM=:NqYTvhtWJd1EA208oR1Gd3
 NQCBUih6frdK6w0fdz7J8wGmytBjQPapSco63+U+R2iXvDRguM8D5CeFAAMBmJcer5b4sM7n9
 5XvtlR3XvJdrLYHs+7KFURG8ClcZ23xzuupxpaKIarGOpWruehIaMPrvCeZ8xog0StkmJATwf
 r6wCsTrt02pXF5k8NcNMGo8Y36ixlQ7qeXptL0p/mXN5X90mfdimy8af+iuwBCqEwZO+EuJRi
 mFDwePR9VqfaEAYJvYxxEdIGjUKviPxbc3Gt7iSKULa6p/WZ76SJozIuuAQORpgzBOUlvueXw
 qAhbhvmOOIaaITG8ekjBcvfrNCV5T4IXVw2uTM9Nfw2+AquShoS0sjF/dVUFWVcWUrd/6qgrK
 MPG4L+btGl+saADH8Ef0oor5RgmWNQMp6DoPDVPNE2ZeNecNkPjA3I1jWJyyitEdyO3BeS7QE
 s4iZEr6XkHzdOHRxjfKhcZCNhixbcKBo7jqm92BZhnNkxRahpLXRkyrNWQX/p+0bjrzB0ukjr
 MqFJdRdvvpLld3C3AaTCY/Rr26JlTNpOYQjpR5NIT/H/F53QemX8YSlrMu6ll4c6tQ1hDzsXi
 OffDltxXnIKNOU7QbMB083pTWpHljK/ixducwC6r6S7ryHsyoxm/bt3HdkH8/J2Fqu1jSjeFB
 24AtLH/sw0Zc/A23uMynmZMEaZfawQZfR3mGvcq6xDn7ezNev/0bJH3cbrzlv61gfNCfaQ47H
 W8XLWTjegxTn3NeMz/2bb8jZMuH7LT6ASAUBihrz/3lnI5/qhRRdjgInIOMnWDpizhCWQzzL4
 eNGenFoxly5rXZJP36HE+/sEKwyRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 11:14:15AM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Lars Schneider wrote:
> 
> > I've migrated a large repo (110k+ files) with a lot of history (177k commits)
> > and a lot of users (200+) to Git. Unfortunately, all text files in the index
> > of the repo have CRLF line endings. In general this seems not to be a problem
> > as the project is developed exclusively on Windows.
> 
> Sounds good.
> 
> > However, I wonder if there are any "hidden consequences" of this setup?
> > If there are consequences, then I see two options. Either I rebase the repo
> > and fix the line endings for all commits or I add a single commit that fixes
> > the line endings for all files. Both actions require coordination with the
> > users to avoid repo trouble/merge conflicts. The "single fixup commit" options
> > would also make diffs into the past look bad. Would a single large commit have
> > any impact on the performance of standard Git operations?
> 
> There are no hidden consequences that I'm aware of.  If you later
> decide that you want to become a cross-platform project, then you may
> want to switch to LF endings, in which case I suggest the "single
> fixup commit" strategy.
> 
> In any event, you also probably want to declare what you're doing
> using .gitattributes.  By checking in the files as CRLF, you are
> declaring that you do *not* want Git to treat them as text files
> (i.e., you do not want Git to change the line endings), so something
> as simple as
> 
> 	* -text
> 
> should do the trick.  See gitattributes(5) for details.

Exactly.
The "hidden consequence" may be the other way around:
If you don't specify .gitattributes, then all people who have core.autocrlf=true
will suffer from a runtime penalty.
core.autocrlf=true means "auto".
At each checkout Git needs to figure out that the file has CRLF in the repo,
so that there is no conversion done.
The same happens on "git add" or "git commit" (and sometimes on "git status").

The penalty may be low, but Dscho once reported that it is measurable & painful
on a "big repo".

The other advantage of "* -text" in .gitattributes is that new files are handled
consistantly accross developers.

Those who have "core.autocrlf=false" would produce commits with CRLF for new
files, and those developpers who have core.autocrlf=true would produce files
with LF in the index and CRLF in the worktree.
This may (most probably will) cause confusion later, when things are pushed and
pulled.

> 
> I'd be interested to hear what happens when diff-ing across a line
> ending fixup commit.  Is this an area where Git needs some
> improvement?  "git merge" knows an -Xrenormalize option to deal with a
> related problem --- it's possible that "git diff" needs to learn a
> similar trick.

That is a tricky thing.
Sometimes you want to see the CLRF - LF as a diff, (represented as "^M"),
and sometimes not.

All in all "* -text" is a good choice for Windows-only projects.

> 
> Thanks and hope that helps,
> Jonathan
