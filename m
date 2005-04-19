From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [script] ge: export commits as patches
Date: Tue, 19 Apr 2005 21:41:08 +0200
Message-ID: <20050419194108.GN12757@pasky.ji.cz>
References: <20050419134843.GA19146@elte.hu> <20050419170320.GG12757@pasky.ji.cz> <20050419185607.GA26756@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 21:38:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNyXS-0007Z0-VI
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 21:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDSTl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 15:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDSTl1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 15:41:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9413 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261253AbVDSTlR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 15:41:17 -0400
Received: (qmail 12165 invoked by uid 2001); 19 Apr 2005 19:41:08 -0000
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050419185607.GA26756@elte.hu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 08:56:07PM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
> and please fix gitXnormid.sh to simply echo nothing and return with a -1 
> exit value when a nonsensical ID is passed to it. Right now the output 
> is quite ugly if you do 'ge blah'.

That's a feature; you can do || exit 1. Put its stderr to /dev/null if
you want your own error reporting.

BTW, I still think my gitpatch.sh is nicer. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
