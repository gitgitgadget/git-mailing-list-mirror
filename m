From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] rebase --no-verify
Date: Mon, 6 Oct 2008 18:07:16 +0200
Message-ID: <20081006160716.GC14479@leksak.fem-net>
References: <20081005222654.6117@nanako3.lavabit.com> <b19eae4e0810021710v14a3901an1f793de00c439ba1@mail.gmail.com> <20081006141429.6117@nanako3.lavabit.com> <20081006143028.GC7684@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 18:10:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmsdS-0007Zh-NX
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 18:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYJFQH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 12:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbYJFQH2
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 12:07:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:44973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752501AbYJFQH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 12:07:27 -0400
Received: (qmail invoked by alias); 06 Oct 2008 16:07:25 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp005) with SMTP; 06 Oct 2008 18:07:25 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/VODQegFzV7NyaP+EE/8xa6ICL/pKQkXmzh8A94d
	F54PSxn9V7/f78
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1Kmsc8-0003PN-EA; Mon, 06 Oct 2008 18:07:16 +0200
Content-Disposition: inline
In-Reply-To: <20081006143028.GC7684@spearce.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97599>

Hi,

Shawn O. Pearce wrote:
> >     It probably is better to fix "rebase -i" to share more code with the main
> >     "rebase" script to avoid duplicated run-pre-rebase-hook function, but it
> >     is beyond what I can do right now.  Perhaps people more smart and
> >     beautiful than me can help (^_^;)
> 
> True.  But its already a mess.  git-sequencer is probably the
> right approach to merge it all together.

Hmm, I don't think I like the pre-rebase hook in sequencer. The user
scripts (git-rebase--interactive.sh and git-rebase.sh) should run them;
that's ok.

I think, for the moment it is ok to have the code duplicated.  After
sequencer has merged into master[1], I will probably take a look at
merging git-rebase.sh and git-rebase--interactive.sh if somebody
else is interested in it and if there is a good way to achieve that.

Regards,
  Stephan

Footnotes:
 1. For the *very* interested ones of you,
 	http://repo.or.cz/w/git/sbeyer.git
    is the way to go. seq-builtin-dev is the active development branch
    and git's master is frequently merged into it. seq-builtin-rfc^ is
    an approach to possible patchsets (for review).

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
