From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Document core.excludesfile for git-add
Date: Thu, 17 May 2007 17:39:21 +0200
Message-ID: <20070517153921.GQ4489@pasky.or.cz>
References: <1179378530822-git-send-email-michael@ndrix.org> <7vwsz89ftr.fsf@assigned-by-dhcp.cox.net> <20070517143542.GB15709@ginosko.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 17:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoi4g-00049e-BS
	for gcvg-git@gmane.org; Thu, 17 May 2007 17:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbXEQPjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 11:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbXEQPjY
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 11:39:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49111 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959AbXEQPjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 11:39:23 -0400
Received: (qmail 26943 invoked by uid 2001); 17 May 2007 17:39:21 +0200
Content-Disposition: inline
In-Reply-To: <20070517143542.GB15709@ginosko.local>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47533>

On Thu, May 17, 2007 at 04:35:44PM CEST, Michael Hendricks wrote:
> On Wed, May 16, 2007 at 10:31:12PM -0700, Junio C Hamano wrote:
> > Thanks, but wouldn't this belong to Documentation/config.txt
> > instead, I wonder?
> 
> It appears to my untrained eye that core.excludesfiles only works for
> git-add.  It seems to have no effect on git-status and the only code
> that mentions core.excludesfile is builtin-add.c

I believe the current policy should be that all config options are at
least briefly listed in config.txt and possibly are described in more
detail in the documentation of relevant command.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
