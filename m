From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Tue, 5 Feb 2008 20:13:51 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802052011290.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041336030.13593@iabervon.org> <alpine.LSU.1.00.0802050139470.8543@racer.site> <alpine.LNX.1.00.0802042152560.13593@iabervon.org> <7v1w7r7yv0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 02:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYrp-0002qZ-Ik
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 02:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYBFBNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 20:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYBFBNy
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 20:13:54 -0500
Received: from iabervon.org ([66.92.72.58]:49462 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbYBFBNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 20:13:53 -0500
Received: (qmail 23093 invoked by uid 1000); 6 Feb 2008 01:13:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 01:13:51 -0000
In-Reply-To: <7v1w7r7yv0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72742>

On Tue, 5 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Well, it's something I tripped over when builtin-checkout wasn't passing 
> > the tests and I couldn't figure out what it was doing wrong from the 
> > output. Like [3/9], it's relevant to evaluating whether the series works, 
> > even if it's not important for whether it actually does work.
> 
> Yeah, using "diff -u" instead of just "diff" is an improvement
> for debuggability which matters a lot in the test scripts.

I think I asked before and didn't hear back (or maybe I got distracted 
and didn't ask); do you want this to use "diff -u" everywhere or "git 
diff" everywhere? This test is currently part "diff" and part "git diff", 
and I went for git diff" everywhere, but you seemed to prefer "diff -u".

	-Daniel
*This .sig left intentionally blank*
