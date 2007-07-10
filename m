From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] Add for_each_remote() function, and extend
 remote_find_tracking()
Date: Tue, 10 Jul 2007 01:23:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707100109290.6977@iabervon.org>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707092203100.5546@racer.site>
 <7vzm25tex6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707100401070.4131@racer.site>
 <7vy7hosv7v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 07:23:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I88CN-0001nO-CO
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 07:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbXGJFXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 01:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbXGJFXj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 01:23:39 -0400
Received: from iabervon.org ([66.92.72.58]:4654 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbXGJFXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 01:23:38 -0400
Received: (qmail 20928 invoked by uid 1000); 10 Jul 2007 05:23:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2007 05:23:37 -0000
In-Reply-To: <7vy7hosv7v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52043>

On Mon, 9 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	You're right. I completely missed that functionality. Well, a
> > 	few tweaks were needed. If this clashes too seriously with
> > 	Daniel's work, I will gladly redo it after his changes are
> > 	in "next".
> 
> No offence meant to Daniel, but I am inclined to postpone the
> current round of changes from him to move the stuff further
> to get us closer to built-in git-fetch until 1.5.3 final is
> done.  The amount of C code changes otherwise would be a bit too
> much for me to be comfortable between -rc0 and -rc1.

That's what I'd expect; I'm posting stuff now so that I'm not proposing it 
unreviewed after 1.5.3. Certainly anything that's needed to fix current 
issues should go ahead of these changes, and it doesn't look like there 
would be any conflicts anyway, aside from maybe adding two functions in 
the same place in the file, which is trivial to fix by hand.

	-Daniel
*This .sig left intentionally blank*
