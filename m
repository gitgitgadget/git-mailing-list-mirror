From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] Add for_each_remote() function, and extend
 remote_find_tracking()
Date: Mon, 9 Jul 2007 23:55:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707092323160.6977@iabervon.org>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707092203100.5546@racer.site>
 <7vzm25tex6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707100401070.4131@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 05:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I86pn-0007dR-Lq
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 05:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbXGJDz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 23:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755063AbXGJDz4
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 23:55:56 -0400
Received: from iabervon.org ([66.92.72.58]:2610 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754918AbXGJDzz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 23:55:55 -0400
Received: (qmail 19871 invoked by uid 1000); 10 Jul 2007 03:55:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2007 03:55:53 -0000
In-Reply-To: <Pine.LNX.4.64.0707100401070.4131@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52037>

On Tue, 10 Jul 2007, Johannes Schindelin wrote:

> The function for_each_remote() does exactly what the name suggests.
> 
> The function remote_find_tracking() was extended to be able to search
> remote refs for a given local ref.  You have to set the parameter
> "reverse" to true for that behavior.

I think I'd like this better if reverse meant that it looked at 
refspec->dst and set refspec->src, rather than returning the refspec 
reversed; the current version sets the refspec so that it's effectively 
something from the list, which makes it easier to understand.

Maybe make it so the user calls it with at most one of src and dst NULL, 
and it returns with neither NULL or returns -1 if it can't find anything?

	-Daniel
*This .sig left intentionally blank*
