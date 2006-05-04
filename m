From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Thu, 4 May 2006 11:06:31 +0200
Message-ID: <20060504090631.GV27689@pasky.or.cz>
References: <7vbque5hq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 11:05:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbZmX-0007ac-E6
	for gcvg-git@gmane.org; Thu, 04 May 2006 11:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWEDJFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 05:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWEDJFe
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 05:05:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31148 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751450AbWEDJFd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 May 2006 05:05:33 -0400
Received: (qmail 10999 invoked by uid 2001); 4 May 2006 11:06:31 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbque5hq9.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19559>

Dear diary, on Thu, May 04, 2006 at 10:14:54AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - core.prefersymlinkrefs can be given to use symlink HEAD;
>    this may be needed to bisect kernel history before January
>    2006 whose setlocalversion script depended on HEAD being a
>    symlink.

Oh, I expected this to end up in 1.3.2, actually. :-)

Shouldn't this belong to the maint branch? It is "physically" a new
feature but I would consider "cannot bisect kernel before January" a bug
certainly worth fixing and the feature is pretty tiny. (It seems to be
backwards-incompatible but that only means you should provide some
transition path, I think. ;)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
