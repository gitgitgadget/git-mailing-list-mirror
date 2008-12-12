From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] autodetect number of CPUs by default when using threads
Date: Thu, 11 Dec 2008 19:55:32 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812111954450.14328@xanadu.home>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
 <7v63lqcptn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 01:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAwKv-0001qC-FC
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 01:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690AbYLLAzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 19:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbYLLAzj
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 19:55:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60108 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575AbYLLAzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 19:55:38 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBQ00A3NNVCJLO1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Dec 2008 19:54:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v63lqcptn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102853>

On Thu, 11 Dec 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > I've spent quite a while wondering why repacking in one repo was faster 
> > than repacking in a clone of that repo on the same machine.  So let's 
> > display how many threads are actually used.
> >
> > We have comprehensive test in Makefile to determine if threads are 
> > available, just to not use them by default.  I think that code has 
> > proven itself for long enough now not to let people benefit from it.
> 
> Hmm, it does appear that distros compile with THREADED_DELTA_SEARCH turned
> on (I only checked Fedora and Debian), and I tend to agree with "long
> enough" but "proven itself" feels bit too strong a statement.
> 
> I think defaulting to autodetect is a good change.  I do not like to add
> new output to stderr deep in -rc, though.
> 
> Can we park this in 'next' and move it to 'master' after 1.6.1?

Sure.  This is probably best for next.


Nicolas
