From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [RFC] format-patch stuff
Date: Sat, 12 May 2007 23:40:34 +0200
Message-ID: <20070512214034.GD7184@planck.djpig.de>
References: <Pine.LNX.4.64.0705121109520.18541@iabervon.org> <7vy7jtx01y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 23:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmzKV-0006RA-5T
	for gcvg-git@gmane.org; Sat, 12 May 2007 23:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbXELVkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 17:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbXELVkl
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 17:40:41 -0400
Received: from planck.djpig.de ([85.10.192.180]:3368 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183AbXELVkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 17:40:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 78137274014;
	Sat, 12 May 2007 23:40:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YeEh2lAPQVNI; Sat, 12 May 2007 23:40:35 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 06FD8274013; Sat, 12 May 2007 23:40:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy7jtx01y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47099>

On Sat, May 12, 2007 at 01:24:25PM -0700, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > It would be nice if git-format-patch would generate a [PATCH 0/n] message 
> > at the start of the series if some option were given. This would, of 
> > course, have to be editted afterwards to include actual information, but 
> > it would at least be pre-generated in series and with the configured 
> > headers and such.
> 
> It would be helpful for git-send-email users.  I've done that by
> hand by copying 0001-*.txt to 0000-*.txt and editing as needed
> by hand.

But git-send-email users can already use --compose which serves
exactly this use case, doesn't it?

I would have thought such an option would be useful exactly for
git-send-email non-users ;)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
