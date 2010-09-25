From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (girocco) 0/3] Fix svn mirroring of branches + more...
Date: Sat, 25 Sep 2010 12:01:18 +0400
Organization: St.Petersburg State University
Message-ID: <20100925080117.GA3603@roro3.zxlink>
References: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 25 09:59:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzPfZ-0003Ok-PI
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 09:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab0IYH7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 03:59:31 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:34953 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab0IYH7b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 03:59:31 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id E0991FF704; Sat, 25 Sep 2010 11:59:28 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1OzPh8-00010Z-2n; Sat, 25 Sep 2010 12:01:18 +0400
Content-Disposition: inline
In-Reply-To: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157131>

+ pasky@suse.cz

On Sat, Sep 18, 2010 at 01:58:51PM +0400, Kirill Smelkov wrote:
> Petr, rorcz-admins,
> 
> Today I've spot that rorcz does not propagate svn branches to git namespace and
> tried to fix it.
> 
> Please apply and thanks,
> Kirill
>
>
> Kirill Smelkov (3):
>   taskd/clone: Store git-svn refs under svn-origin remote
>   taskd/clone: ask git-svn to store branches under svn-origin/heads/*
>     instead of svn-origin/*
>   Revert "Finalized fix, we can't git fetch any longer."
> 
>  jobd/update.sh |    1 +
>  taskd/clone.sh |   12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)


Silence... But it fixes regression and recent breakage... Anyone?!!!
