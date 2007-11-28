From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 20:40:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282039430.27959@racer.site>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxTiu-0001ii-Sv
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 21:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956AbXK1UlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 15:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756829AbXK1UlD
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 15:41:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:56634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756804AbXK1UlC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 15:41:02 -0500
Received: (qmail invoked by alias); 28 Nov 2007 20:41:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 28 Nov 2007 21:41:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xKiYW63Jx7lFvF/wYbyi9+g/JI/7TWaOznEEtw+
	p1XiHKdT6v9fce
X-X-Sender: gene099@racer.site
In-Reply-To: <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66425>

Hi,

On Wed, 28 Nov 2007, Steven Grimm wrote:

> On Nov 28, 2007, at 5:11 AM, Johannes Schindelin wrote:
> > As a convenience, you can set the default behavior for a branch by 
> > defining the config variable branch.<name>.rebase, which is 
> > interpreted as a bool.  This setting can be overridden on the command 
> > line by --rebase and --no-rebase.
> 
> I wonder if this shouldn't be branch.<name>.pulltype or something like 
> that, so we can represent more than just "rebase or not." Values could 
> be "rebase", "merge" (the default) and maybe even "manual" to specify 
> that git-pull should neither merge nor rebase a particular branch even 
> if it matches a wildcard refspec.

I am not convinced that this is a good thing... We already have 
branch.<name>.mergeOptions for proper merges, and I want to make clear 
that this is about rebase, and not about merge.

Ciao,
Dscho
