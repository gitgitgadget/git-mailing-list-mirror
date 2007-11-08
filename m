From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 8 Nov 2007 15:23:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081520170.4362@racer.site>
References: <20071104112302.GA2119@ins.uni-bonn.de>
 <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net>
 <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net>
 <4732D7F6.7040006@op5.se> <4732DC98.70304@viscovery.net>
 <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de> <5498B368-053A-424E-B901-A55B66FF5801@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andreas Ericsson <ae@op5.se>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9EK-0002Fl-KZ
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759150AbXKHPXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757816AbXKHPXY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:23:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:56099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756120AbXKHPXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:23:24 -0500
Received: (qmail invoked by alias); 08 Nov 2007 15:23:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 08 Nov 2007 16:23:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186jKRIUaI6CLcoyvQYgcw5jNjTUli1YsPG4PcuWw
	lN6tSKcllfv1EQ
X-X-Sender: gene099@racer.site
In-Reply-To: <5498B368-053A-424E-B901-A55B66FF5801@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64041>

Hi,

On Thu, 8 Nov 2007, Benoit Sigoure wrote:

> On Nov 8, 2007, at 1:54 PM, Steffen Prohaska wrote:
> 
> > Do you use rebase like this in real life?
> > 
> > I thought of the text as background information that might be helpful 
> > for users who want do decide wether to merge or to rebase. The problem 
> > described may be valuable information supporting a decision about a 
> > recommended workflow for a group of users.
> 
> You're missing the point.  Johannes suggested that you rebase *only* for 
> bisecting purpose.  Once you find the culprit commit, throw away your 
> rebased stuff.

Just to clear things up: it was the other Johannes who suggested it.

But I strongly advise not to rebase before bisecting, since you could very 
well end up changing the behaviour of the program by rebasing it.  Even to 
a point where you cannot bisect it any longer, for example when the merge 
of two branches contains an important fix without which the combined 
branches (or even parts of them) will not even compile.

Last time I checked, however, bisect worked like a charm even on 
a history with complicated ancestry.

Ciao,
Dscho
