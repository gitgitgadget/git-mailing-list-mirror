Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFB01F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 14:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbcHBOew (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 10:34:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:64056 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933925AbcHBOek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2016 10:34:40 -0400
Received: from misery ([80.109.83.31]) by mail.gmx.com (mrgmx001) with ESMTPSA
 (Nemesis) id 0M4WuC-1b4rC51QMe-00yeJo; Mon, 01 Aug 2016 23:50:05 +0200
Date:	Mon, 1 Aug 2016 23:49:09 +0200
From:	Stefan Tauner <stefan.tauner@gmx.at>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: Un-paged commit messages in git filter-branch's commit-filter?
In-Reply-To: <20160801213631.2ttdlermxw2wbnbi@sigill.intra.peff.net>
References: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
	<20160616095947.GA15988@sigill.intra.peff.net>
	<0MTjMy-1buKad2Fg8-00QUQV@mail.gmx.com>
	<20160801213631.2ttdlermxw2wbnbi@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-ID: <0LzskF-1bGAH81g5T-014za7@mail.gmx.com>
X-Provags-ID: V03:K0:2EJBfULjPJDL6AKgoCvpVto+tnuzjU9RyIpbsAIXTRroZnfhII5
 MtQl+OKCvzseJ1K1BF+sGnIeYQX2oOLX+MD5T5oXNukPfvbZke3PTqxWBASwPWTqVGS6VR7
 Q290zvVCBEz1xLmGjGRvWXvJNWDEoB+MGt8GoiEbaxdmY3vMre89OFEmQ49mGWvIjyg45tt
 s9EMo1HCuFXCyNVmUIc5A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qJTQ//CpuBI=:Zq2xzzX8Qlu/6FwAfPvtyd
 B7dL34bBIZu5lbyVpEn/Y5qZe9o6hDCf0k9/wB9WAI4J0Q3UaK7NV5oVTcBvPGFsoFyI2u/O2
 2C0Ebu8O7NukoGPqOtjZcIYqIQ1q2OAx2qmdlmTJfK55FW4XgGn9NCgOKdghgkU+mNG4VX/Yc
 w+iIKesADN7WCu7HlXiJUf80wztM3d0gddVcChRYyZY5plcE8bziug5luXvcDoTgmhrzGur9u
 +Y5TcoL3pPAGuOltFUX4sysNrgOadDdjheEn55Zn+yhMESz2ppcJj+BsL0YTCr5G67+7obXI2
 4/lf3QU2k2Me3KmnuN5TcMaocSCxBRHEfvoVbzQtLkxtgAUSHotPA8L8oI+3K9peOKiMRpNF+
 x236tdt0/OkinHHTqKSLC/UhCmBEl6IAFU//iMZSxvN4GbtJsHJgwIuFaxFgTOXG+gn28dBZ2
 7ala3/ZstrwfWX/ecmHvDAX3YhfE3KI3DuA+xF3E4GnPDQjq206R66Y7cmqNm4ybhbdXPJqr4
 N+YVJ6BiV5O4ZHBOBSwl6IO85E7LEOjeOBedpn/ASt5X4c3fkxzognur3ssuFZfqX/b0E6XWu
 ehbOiCYi4rVTRkOt7VlrT563Sc8x5aak/kj6dHxjb/qFX8n0nhvrPOGCEul0kbnsAhYZB6DA7
 DyT1O7RzZpvAGp5nsl7IpDp3bwce/GkPm0Ta9UB8/EW6Cku7NTFero5cMRnN4nFG/ejkhOiRc
 I/wyFIuS/vT4U4DfDNQeTDK3kC4HEjl/fdcGAldgYStE8m3f+LxCL+u1rN8a6nLabkdrRR8NF
 1LPWWa1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 1 Aug 2016 17:36:31 -0400
Jeff King <peff@peff.net> wrote:

> On Sun, Jul 31, 2016 at 06:39:35PM +0200, Stefan Tauner wrote:
> 
> > > There are some output formats that will wrap lines, but by default,
> > > filter-branch should not be using them (and I could not reproduce the
> > > issue in a simple test). Can you show us what your commit-filter looks
> > > like?  
> > 
> > Thanks for your answer. I have tried to reproduce it in other (newly
> > created) repositories but failed. However, it seems to relate to some
> > kind of persistent paging setting, is that possible?
> > git config -l does not show anything suspicious.
> > 
> > The following commands produce paged output:
> > git show hash
> > git show --pretty=%B
> > git log hash^..hash
> > Commit message in gitk
> > 
> > 
> > These do NOT produce paged output:
> > git patch hash^..hash
> > Commit message in gitg 0.2.7  
> 
> What is "git patch"? An alias for "format-patch?".

Yes, sorry.
And this is the most amazing thing about this behavior... what's so
different between format-patch and log or show --pretty=%B. Shouldn't
these match 100%?

> 
> > This is the script I tried to use to reproduce the problem:
> > 
> > #!/bin/bash
> > export LC_ALL=C
> > input=$(cat)
> > echo "===========================
> > $input
> > ===========================" >> /tmp/paging_bug.txt
> > git commit-tree "$@" -m "$input"  
> 
> Can you be more specific about the input you're feeding to git and the
> output you're seeing?
> 
> For instance, if I do:
> 
>   git init
>   echo content >file
>   git add file
>   git commit -m "$(perl -e 'print join(" ", 1..100)')"
> 
> I get a commit message with one long unwrapped line, which I can view
> via git-log, etc.

That's approximately what I did in my tests as well. And like you, when
I do this in a fresh repository, it works like that..

> Now if I try to run filter-branch on that:
> 
>   git filter-branch --commit-filter '
> 	input=$(cat)
> 	{
> 		echo "===================="
> 		echo $input
> 		echo "===================="
> 	} >>/tmp/paging_bug.txt
> 	git commit-tree "$@" -m "$input"
>   '
> 
> then the commit remains unchanged, and paging_bug shows one long line.

as well as filter-branch. That's what I meant when I wrote I cannot
reproduce it with a new repository (to create a MWE). I wrote the first
mail under the presumption that filter-branch is somehow involved but
apparently it is not the only git command and receives the mangled
input already as the commands stated in the last email show.

> What am I missing?
> 
> (I wondered at first if the extra "cat" and "-m" could be messing up
> whitespace for you, but it should not, as the quoting around "$input"
> should preserve things like newlines. And anyway, the bug in that case
> would be the _opposite_; I'd expect it to stuff everything onto a single
> line rather than breaking lines).

The commit messages I try to process are nothing special really... just
very long and not subject-like (because SVN and not giving too much
thought to them sometimes). The only special thing I can think of is
that they have been processed by git-svn earlier.

-- 
Kind regards/Mit freundlichen Grüßen, Stefan Tauner
