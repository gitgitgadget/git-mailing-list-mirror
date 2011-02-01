From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Tue, 01 Feb 2011 08:08:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102010805420.8580@xanadu.home>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <20110201014807.GA2722@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101312238170.8580@xanadu.home>
 <201102011342.06910.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 14:08:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkFy0-0005yz-SC
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 14:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab1BANIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 08:08:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27474 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1BANIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 08:08:15 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFX00B6TWHDXSE0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 Feb 2011 08:08:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <201102011342.06910.trast@student.ethz.ch>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165802>

On Tue, 1 Feb 2011, Thomas Rast wrote:

> Nicolas Pitre wrote:
> > What I see in the root of the Git source 
> > tree is a huge clutter of source files, binary files, scripts, and 
> > subdirectories all mixed together.  If you know by hart where things are 
> > because you've been hacking on them for the last 5 years then of course 
> > you might not see the point.  But since I didn't work much on Git 
> > lately, things are not as obvious to me as they used to be.  Looking 
> > back at it now with some distance, this tree looks like a mess and it is 
> > really annoying to work with.
> 
> But judging by that assessment, shouldn't we strive to make it
> *easier* to find things?
> 
> In particular a prospective git hacker would not care whether
> something is a source file or a script (you seem to imply the
> opposite).  He would instead expect to find git-foo implemented in
> something named of that sort, so we could probably help him by mapping
> 
>   git-foo.sh      ->   git-foo.sh
>   builtin/bar.c   ->   git-bar.c
>   baz.c           ->   lib/baz.c
>   baz.o           ->   build/baz.o (or whatever, just elsewhere)
>   baz.gcov        ->   build/baz.gcov (ditto)

I'm not proposing to go that far, especially given the current 
resistance to any changes.  IMHO anything that unclutters the top 
directory is good.

Nicolas
