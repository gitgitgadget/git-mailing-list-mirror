From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Tue, 20 Sep 2005 21:36:06 +0200
Message-ID: <20050920193606.GD28621@pasky.or.cz>
References: <46a038f905091921154a70123f@mail.gmail.com> <11253960093915-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kevin@catalyst.net.nz
X-From: git-owner@vger.kernel.org Tue Sep 20 21:38:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHnuf-0007hC-QD
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 21:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbVITTgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVITTgK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 15:36:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58500 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965097AbVITTgI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 15:36:08 -0400
Received: (qmail 4929 invoked by uid 2001); 20 Sep 2005 21:36:06 +0200
To: Martin Langhoff <martin@catalyst.net.nz>,
	Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f905091921154a70123f@mail.gmail.com> <11253960093915-git-send-email-martin@catalyst.net.nz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9018>

Dear diary, on Tue, Aug 30, 2005 at 12:00:10PM CEST, I got a letter
where Martin Langhoff <martin@catalyst.net.nz> told me that...
> Calls to cg-diff without filename parameters were dependent on GNU xargs
> traits. BSD xargs is hardcoded to do --no-run-if-empty -- so if the filter
> is effectively empty we avoid calling xargs.
> 
> Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

Thanks, I've applied it and also fixed the second git-diff-tree usage.

Dear diary, on Tue, Sep 20, 2005 at 06:15:28AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> We still have a bug in cg-diff when using the BSD xargs. I posted a
> fix, and Junio posted an alternative approach. The original patches
> are here http://marc.theaimsgroup.com/?l=git&m=112541165904627&w=2

Looks like I've overlooked it in my fast Cogito patch scan. There are
still parts of mailing list history in late August and early September
that I didn't read.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
