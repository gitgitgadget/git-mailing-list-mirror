From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 8/9] Use git diff instead of diff in t7201
Date: Tue, 5 Feb 2008 15:39:05 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802042152560.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041336030.13593@iabervon.org> <alpine.LSU.1.00.0802050139470.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUa2-00046i-TF
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759282AbYBEUjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759127AbYBEUjK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:39:10 -0500
Received: from iabervon.org ([66.92.72.58]:48628 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758836AbYBEUjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:39:09 -0500
Received: (qmail 9486 invoked by uid 1000); 5 Feb 2008 20:39:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 20:39:05 -0000
In-Reply-To: <alpine.LSU.1.00.0802050139470.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72693>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> 
> > If the test failed, it was giving really unclear ed script
> > output. Instead, give a diff that sort of suggests the problem.
> > 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  t/t7201-co.sh |    4 ++--
> 
> This is not really a part of the series leading to builtin checkout.  But 
> as a standalone patch, I like it (obviously... I tried to push for more 
> --no-index uses in the test suite).

Well, it's something I tripped over when builtin-checkout wasn't passing 
the tests and I couldn't figure out what it was doing wrong from the 
output. Like [3/9], it's relevant to evaluating whether the series works, 
even if it's not important for whether it actually does work.

	-Daniel
*This .sig left intentionally blank*
