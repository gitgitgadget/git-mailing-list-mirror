From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-restore
Date: Sat, 24 Sep 2005 01:42:49 +0200
Message-ID: <20050923234249.GI10255@pasky.or.cz>
References: <20050923233603.GE1495@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 01:43:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIxCP-0000Am-04
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 01:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVIWXmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 19:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIWXmw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 19:42:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26819 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751347AbVIWXmv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 19:42:51 -0400
Received: (qmail 13285 invoked by uid 2001); 24 Sep 2005 01:42:49 +0200
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20050923233603.GE1495@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9214>

Dear diary, on Sat, Sep 24, 2005 at 01:36:03AM CEST, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me that...
> What I did:
> ------------------------
> [1:25] hydrogenium:cinit% cg-restore contrib+tools/cinit.graph.text.c 
> git-checkout-cache: contrib+tools/cinit.graph.text.c already exists
> Makefile: locally modified
> contrib+tools/Makefile: locally modified
> contrib+tools/cinit.graph.text.c: locally modified
> [1:25] hydrogenium:cinit% rm contrib+tools/cinit.graph.text.c 
> [1:26] hydrogenium:cinit% cg-restore contrib+tools/cinit.graph.text.c
> Makefile: locally modified
> contrib+tools/Makefile: locally modified
> [1:26] hydrogenium:cinit%
> ------------------------
> 
> Is this the wanted behaviour of cg-restore or should it overwrite
> the specified changed file?

Nope, it should overwrite it only if given the -f option. The
documentation was unclear, confusing, and wrong though - I've fixed that
now, thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
