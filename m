From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 22:05:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610192202340.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca>
	<200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca>
	<87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca>
	<878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca>
	<87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 07:05:26 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GamZP-0003EZ-CE
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 07:05:23 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GamZG-0000G1-3f; Fri, 20 Oct 2006 06:05:14 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GamZB-0000Fu-QV
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 06:05:10 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9K551aX020824
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Oct 2006 22:05:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9K550jM007477;
	Thu, 19 Oct 2006 22:05:01 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45382120.9060702@utoronto.ca>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29409>



On Thu, 19 Oct 2006, Aaron Bentley wrote:
> 
> I understand your argument now.  It's nothing to do with numbers per se,
> and all about per-branch namespaces.  Correct?

I don't know if that is what Carl's problem is, but yes, to somebody from 
the git world, it's totally insane to have the _same_ commit have ten 
different names just depending on which branch is was in.

In git-land, the name of a commit is the same in every branch.

Do you have something like

	gitk --all

in your graphical viewers? That one shows _all_ the branches of a 
repository, and how they relate to each other in git. How do you name your 
commits in such a viewer, since every branch has a _different_ name for 
the same commit?

			Linus
