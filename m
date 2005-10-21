From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Cogito README: add a block describing team workflow with git+ssh
Date: Fri, 21 Oct 2005 17:14:51 +0200
Message-ID: <20051021151451.GH30889@pasky.or.cz>
References: <11298728883894-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 17:17:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESybh-0003B5-Jn
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 17:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVJUPOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 11:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVJUPOy
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 11:14:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39824 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964974AbVJUPOx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 11:14:53 -0400
Received: (qmail 12600 invoked by uid 2001); 21 Oct 2005 17:14:51 +0200
To: Martin Langhoff <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <11298728883894-git-send-email-martin@catalyst.net.nz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10434>

Dear diary, on Fri, Oct 21, 2005 at 07:34:48AM CEST, I got a letter
where Martin Langhoff <martin@catalyst.net.nz> told me that...
> This is a resend, with a silly typo (chgroup/chgrp) fixed.

It was missing the signoff, but I worked that around by taking your
original patch from the end of September. ;-)

> The README doesn't talk about teams with "peer" access to a shared repo.
> It took me a while to figure our the /right/ way to do it. Document for
> future generations and general happiness.

Thanks. The long sequence of permissions setup inspired me to adding
cg-admin-setuprepo which automates that. I also changed the git-push
to cg-push. Please review the final result.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
