From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Thu, 20 Sep 2007 22:54:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709202252570.28395@racer.site>
References: <20070919202615.GK3076@jukie.net> <Pine.LNX.4.64.0709201132381.28395@racer.site>
 <20070920123849.GD12076@jukie.net> <Pine.LNX.4.64.0709201403540.28395@racer.site>
 <7vtzppj9d1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:55:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTzv-0007re-IJ
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbXITVzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXITVzm
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:55:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:48623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbXITVzm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:55:42 -0400
Received: (qmail invoked by alias); 20 Sep 2007 21:55:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 20 Sep 2007 23:55:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CIxJmoJHCH+CSUXDgi4isgpWlGZfqGEvq249TwN
	wubvxrXkh4ctoL
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtzppj9d1.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58812>

Hi,

On Thu, 20 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Further, it probably makes sense to have the option to say _both_: 
> > "Find me a commit that contains Bart in one line, but not Simpson, and 
> > that does not contain the word "Sverdoolaege" at all."
> 
> Yeah.  And I think we would also want to have that at the
> underlying "grep" layer wouldn't we?

That's what I tried to get at...  Already on IRC, I tried to direct the 
attention to that thread on the list...  There I had an ugly patch, which 
was incomplete, mainly because I did not sort out the semantics first.

But the idea was to put this into grep.c so that both git-log and git-grep 
could benefit from that feature.

Ciao,
Dscho
