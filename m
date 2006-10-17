From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 10:34:23 -0400
Message-ID: <BAYC1-PASMTP018A5B086047BE4212EFF8AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org>
	<45340713.6000707@utoronto.ca>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<45348B5E.8000404@op5.se>
	<4534E335.8070203@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 16:35:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZq1W-0003vb-PR
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 16:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWJQOe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 10:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWJQOe0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 10:34:26 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:64870 "EHLO
	bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751094AbWJQOeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 10:34:25 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 07:34:24 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZp5L-0005ze-Nz; Tue, 17 Oct 2006 09:34:23 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061017103423.a9589295.seanlkml@sympatico.ca>
In-Reply-To: <4534E335.8070203@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 14:34:24.0983 (UTC) FILETIME=[57DC1670:01C6F1F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 10:05:41 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:


> No, you don't.  They may have each pulled from a different repository.
> 
> Take revision 00aabbcc, created by Linus.  Linus has it because he
> committed it.  I have it because I pulled Linus' repository.  You have
> it because Andrew Morton pulled Linus' repository, and you pulled Andrew
> Morton's repository.

Well his point was that they have pulled from each other directly or
indirectly.  You can safely say that rev 00aabbcc.. in _any_ repository
is the same rev.  This discussion started because of doubt expressed
by some here on the list that the "simple" numbering scheme used by
bzr can offer the same guarantee.  That is, rev 1.2.1 may be completely
different commits in different repos in bazaar.
 
> With most SCMs that store the repository in the root of the tree,
> disentangling the tree and repository requires care.  OTOH, this is just
> as easy with Arch, CVS and SVN as it is with Bazaar.

Just in case it wasn't clear, this is drop dead easy in Git too.

> No, I *want* the working tree files.  I run bzr from a checkout of bzr.dev.

Why?  Uncommitted changes shouldn't be propagated.  Once you have cloned
the repo, you can checkout your own copy of the working tree files.

Sean
