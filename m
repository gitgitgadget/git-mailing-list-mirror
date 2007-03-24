From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert: Revert revert message to old behaviour
Date: Sat, 24 Mar 2007 13:34:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703241333580.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0703230805450.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703231705150.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703230926380.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703232013330.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v648rm0g5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 13:34:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV5S2-0002ap-SG
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 13:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbXCXMeP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 08:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbXCXMeP
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 08:34:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:60417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753476AbXCXMeO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 08:34:14 -0400
Received: (qmail invoked by alias); 24 Mar 2007 12:34:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 24 Mar 2007 13:34:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8VchecwT8+cVkyahX+ag7cp3Xla6c0N/bG11fu/
	gZ5ZGvXprCj0tZ
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v648rm0g5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42997>

Hi,

On Sat, 24 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> How about the empty line in between the message and the "This reverts 
> >> commit "..
> >> 
> >> > +		add_to_msg("Revert \"");
> >> >  		add_to_msg(oneline);
> >> > -		add_to_msg("\nThis reverts commit ");
> >> > +		add_to_msg("\"\nThis reverts commit ");
> >> 
> >> This should probably be
> >> 
> >> 	add_to_msg("\"\n\nThis reverts commit ");
> >> 
> >> with *two* \n's, no?
> >
> > Yes. Sorry.
> 
> Not only that.  
> 
> The older one had two, duplicated abbrev, and your fix reduces
> it to once, but we do not want any abbrev there.

D'oh.

Thanks,
Dscho
