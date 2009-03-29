From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn init --username ignored
Date: Sun, 29 Mar 2009 15:41:37 -0700
Message-ID: <20090329224137.GA20675@dcvr.yhbt.net>
References: <9FB623A2-03A6-4B35-B631-DF4745971DB9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 00:43:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo3ig-0006Fm-T2
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 00:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbZC2Wlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 18:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZC2Wlj
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 18:41:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59503 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbZC2Wlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 18:41:39 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700CD1F79C;
	Sun, 29 Mar 2009 22:41:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9FB623A2-03A6-4B35-B631-DF4745971DB9@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115045>

Lachlan Deck <lachlan.deck@gmail.com> wrote:
> Hi there,
>
> Is it a bug that the when specifying --username=foo for either git-svn  
> init or git-svn clone  that this isn't stored in .git/config?
>
> It means that for http[s] urls you need to specify it each time for  
> git-svn fetch, for example.
>
> Is there any way to specify it manually in the config file - or would  
> that have some bad consequences?

Hi,

Subversion already stores credential information in ~/.subversion/ which
git svn should respect and use if available and allowed to.  Did you
disable set "store-auth-creds = no" in your ~/.subversion/config ?

-- 
Eric Wong
