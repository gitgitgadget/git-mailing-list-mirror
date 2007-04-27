From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 4/4] server info: Add HEAD to info/refs
Date: Fri, 27 Apr 2007 06:28:02 +0200
Message-ID: <20070427042802.GW4489@pasky.or.cz>
References: <20070427020601.22991.13792.stgit@rover> <20070427020608.22991.29273.stgit@rover> <7vhcr2qxtj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 06:28:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhI42-0003AV-2z
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 06:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbXD0E2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 00:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbXD0E2H
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 00:28:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54073 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906AbXD0E2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 00:28:05 -0400
Received: (qmail 9648 invoked by uid 2001); 27 Apr 2007 06:28:02 +0200
Content-Disposition: inline
In-Reply-To: <7vhcr2qxtj.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45682>

On Fri, Apr 27, 2007 at 05:51:36AM CEST, Junio C Hamano wrote:
> I always considered it was a bug that the native transport sends
> SHA-1 of HEAD after dereferencing the symref, instead of saying
> which branch it points at.

Yes, you are right. That was what I was originally after, but then got
sidetracked into working on something else and this easy bit was the
only thing left done, so I just passed it along. :)

> How about proceeding along these lines?

Looks generally good.

>  * We add native protocol extension to let upload-pack to say
>    what HEAD symref points at, in addition to the SHA-1 HEAD
>    points at.  Update peek-remote to show this information like
>    this:
> 
> 	->refs/heads/master<TAB>HEAD<LF>
>         0d5e6c97...<TAB>HEAD<LF>
> 	...

Yet another obscure syntax? Why not just reusing the actual ref: syntax?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
