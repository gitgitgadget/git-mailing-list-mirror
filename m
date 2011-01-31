From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 16:19:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311601370.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <7vvd144wrl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:19:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk19v-0000dc-K3
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042Ab1AaVTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:19:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62961 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab1AaVTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:19:31 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW009G1OJVHT60@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 16:19:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vvd144wrl.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165754>

On Mon, 31 Jan 2011, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > 1) Create a src/ directory and move *.c, *.h, *.sh, *.perl, *.py and 
> >    the builtin directory from the root directory to it.
> >
> > 2) Create a build/ directory, or bin/ if prefered, to hold the result of 
> >    the build.
> >...
> > 6) And fix up all the Makefiles to cope with the above movements.
> >
> > What do you think?
> 
> Knee-jerk reaction: not very motivated to make the top-level directory
> just a skeleton that holds various directories with a handful of
> administrative files like Makefile, README, etc.  Under your proposal, the
> bulk of the current content at the top would simply move to another single
> directory anyway, so I don't immediately see much point of such a move,
> other than adding merge burden on me and rebase burden on others, that
> is.

I really think that the top directory is not the proper place for source 
files to live, especially considering how big a project Git is now.  
The top directory should be like a table of content and not the content 
itself.

But if you the maintainer doesn't see a long-term value in this to be 
greater than the one-time burden, then I'm afraid there's nothing I can 
do to help it.

> But that is just a knee-jerk reaction, just to fill the "Risks:" section
> you didn't fill.  Your missing "Migration Plans" section might outline a
> clever approach to lessen the interim hurt while merging in-flight topics.

Well, there is no such plan.  Given that 1.8 is meant to be an inflexion 
point for users, it could as well be for developers the best time to 
clean up this mess too.


Nicolas
