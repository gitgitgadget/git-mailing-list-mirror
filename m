From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 01:04:37 -0400
Message-ID: <BAYC1-PASMTP07B3618F64E47E873F2379AE1A0@CEZ.ICE>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
	<20060927033459.GA27622@coredump.intra.peff.net>
	<BAYC1-PASMTP0819E6B1CBE028BD171598AE1A0@CEZ.ICE>
	<7v3badkj4k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthew L Foster <mfoster167@yahoo.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 27 07:05:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSRba-0002n5-50
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 07:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbWI0FEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 01:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWI0FEv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 01:04:51 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:65491 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S965275AbWI0FEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 01:04:40 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Sep 2006 22:10:03 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSRb4-0004Zd-4y; Wed, 27 Sep 2006 01:04:38 -0400
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060927010437.5fa57ed0.seanlkml@sympatico.ca>
In-Reply-To: <7v3badkj4k.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Sep 2006 05:10:04.0109 (UTC) FILETIME=[30F1BFD0:01C6E1F3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Sep 2006 21:50:51 -0700
Junio C Hamano <junkio@cox.net> wrote:

> For somebody who is tracking my "master" branch, it does not
> matter when some critical fix appeared on my "next" branch.  The
> user will be vulnerable until that fix makes its way to the
> "master" branch.  The user _can_ switch to track my "next"
> branch, but that is like arguing that the user can apply the
> same patch to his local copy that tracks my "master".
> 
> I may try-pull from Paul to get updates from gitk, but usually I
> do that with "git fetch", not "git pull".  So my repository may
> contain commits and blobs for the latest and greatest gitk, but
> until I merge it and push the result out nobody would benefit
> from it through my repository.
> 
> See?  Having a commit somewhere in the repository does not make
> any difference unless that commit is on some branches you care
> about.

Well, yes.  And all of my examples have assumed the example of
Linus' repository where there is only one branch.  So yes, in the
case where there are more than one branch, you want to be able
to ask the more specific question, when did this commit arrive
into this repo-branch.

But that is really the minutia of the issue.  First we have to
agree that users _do_ want to know the date of commits beyond
just those recorded inside the commit itself.

If we do agree on that point, then the rest is just the details
of how plausible it is to provide those answers.   Shawn has made
it clear that the reflog doesn't really have all the information
we need yet.  On top of which it would be expensive to compute
etc.

Sean
