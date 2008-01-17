From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Thu, 17 Jan 2008 01:54:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801170151040.17650@racer.site>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
 <alpine.LNX.1.00.0801152256480.13593@iabervon.org> <alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org> <7v1w8hploy.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801161524390.13593@iabervon.org> <7vprw1mfpr.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801170108440.17650@racer.site> <7vejchmeom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:54:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJxy-0001Cz-BY
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYAQByV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbYAQByV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:54:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:57060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbYAQByU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:54:20 -0500
Received: (qmail invoked by alias); 17 Jan 2008 01:54:18 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp019) with SMTP; 17 Jan 2008 02:54:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uGb1DMa0ukc9+GYwbrLNVfud9uznf/t0aAcrZyY
	+0rX1vUUgBvJyU
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejchmeom.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70808>

Hi,

On Wed, 16 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Having had time to think about it for a while, I think that the 
> > --no-prefix still can make sense with --git.  For example, if I want 
> > to submit a gitk patch, but only have git.git (and consequently, made 
> > the fix in that repository), I could use "git diff --no-prefix" to 
> > make it easier for Paul, no?
> 
> No, what you are talking about is a need of negative prefix, which you 
> did not implement in that no/src/dst-prefix patch.

I'm probably missing something, but wouldn't a "diff --git gitk-git/gitk 
gitk-git/gitk" instead of "diff --git a/gitk-git/gitk b/gitk-git/gitk" in 
mbox format be directly grokkable by git-am?

> Using --no-prefix is a _hack_ that may happen to work only when
> the subtree-merged project is one level down.

Yep.  But my point was more to show that it is still a valid git diff.  
With all the niceties that come with it, like "rename from", "rename to".  
So "--no-prefix" is not that good a reason to strip the "--git" away.

Probably I missed something, though.

Ciao,
Dscho
