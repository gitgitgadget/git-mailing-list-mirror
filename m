From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git svn rebase/dcommit break (index) if not run from directory
	containing ./.git
Date: Wed, 26 May 2010 11:51:57 -0700
Message-ID: <20100526185157.GB24211@dcvr.yhbt.net>
References: <4BCF2E27.1010906@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 26 20:52:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHLi3-00034S-4v
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 20:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934303Ab0EZSv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 14:51:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40424 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756742Ab0EZSv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 14:51:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A53C1F4F3;
	Wed, 26 May 2010 18:51:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4BCF2E27.1010906@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147819>

Matthias Andree <matthias.andree@gmx.de> wrote:
> [resending this with new Subject since there wasn't a reply in 33 days,  
> cc:ing Eric]
>
> === Reproduce ===
>
> 1. Use a git-svn checkout that has at least one subdirectory
>
> 2. cd to that subdirectory
>
> 3. run git svn rebase. It concludes successfully, then:
>
> 4. git diff-index HEAD -> output like the one shown above.
>
> This is on Cygwin 1.7.5 w/ Windows 7 32-bit professional German.

Hi Matthias,

I can't reproduce this on a GNU/Linux system, so I'm guessing this
is a weird Cygwin/Windows issue, and I don't know Windows.

-- 
Eric Wong
