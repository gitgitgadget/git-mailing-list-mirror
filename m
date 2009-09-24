From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] print_wrapped_text(): allow hard newlines
Date: Thu, 24 Sep 2009 02:19:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909240214550.4985@pacific.mpi-cbg.de>
References: <7vfxaercma.fsf@alter.siamese.dyndns.org> <1253655038-20335-1-git-send-email-heipei@hackvalue.de> <alpine.DEB.1.00.0909232232050.4985@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909232232560.4985@pacific.mpi-cbg.de>
 <alpine.LFD.2.01.0909231659010.3303@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Gilger <heipei@hackvalue.de>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 24 02:17:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqc1r-0002I4-BC
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 02:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbZIXARi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 20:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbZIXARh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 20:17:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:32926 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751134AbZIXARh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 20:17:37 -0400
Received: (qmail invoked by alias); 24 Sep 2009 00:17:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 24 Sep 2009 02:17:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uBHpT040uwGz2BMrf9S53wBZwHMpnLAQaUj+IKb
	FVtSZ/tXJn6L2/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0909231659010.3303@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129015>

Hi,

On Wed, 23 Sep 2009, Linus Torvalds wrote:

> On Wed, 23 Sep 2009, Johannes Schindelin wrote:
> > 
> > print_wrapped_text() will insert its own newlines. Up until now, if the
> > text passed to it contained newlines, they would not be handled properly
> > (the wrapping got confused after that).
> > 
> > The strategy is to replace a single new-line with a space, but keep double
> > new-lines so that already-wrapped text with empty lines between paragraphs
> > will be handled properly.
> 
> May I suggest doing this _only_ if the newline is followed by an 
> alphanumeric characer?
> 
> If the thing is indented ("newline + space") or quoted ("newline + ">" or 
> whatever) then reflowing it is likely wrong and will result in an unholy 
> mess.

It seems Junio is dead-set on ignoring my patches, so I will probably just 
keep the patch as-is in my tree for the time being.  The other Johannes' 
patch is too limited for me to use, so I _will_ keep my patch, but I have 
way too little time to fight an uphill battle to get my patch in.  And 
since it stays a private patch (just like my strbuf_vaddf() patch) I will 
have to refrain from putting more work and time into it than I already 
have.

Sorry,
Dscho
