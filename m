From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] 'git-svndump'
Date: Tue, 19 Jun 2007 23:40:15 -0700
Message-ID: <20070620064015.GB25840@muzzle>
References: <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com> <7d5543ebd8ac45e49a6d3f300e988189561512f1.1182235492.git.ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, J.Sixt@eudaptics.com, masterdriverz@gmail.com
To: Sergey Yanovich <ynvich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 08:40:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0tra-0003Sd-T1
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 08:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759480AbXFTGkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 02:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759468AbXFTGkT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 02:40:19 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38085 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758431AbXFTGkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 02:40:18 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1685D8D4027;
	Tue, 19 Jun 2007 23:40:16 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 19 Jun 2007 23:40:15 -0700
Content-Disposition: inline
In-Reply-To: <7d5543ebd8ac45e49a6d3f300e988189561512f1.1182235492.git.ynvich@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50539>

Sergey Yanovich <ynvich@gmail.com> wrote:
> A git tool to keep a subversion mirror
> 
> git-svndump is essentially a wrapper around 'git-svn commit-diff'. It
> will work only when it is the sole method of committing to the
> Subversion repository.

We could probably just implement this directly in git-svn.  I'll try to
find time to take a closer look at it this weekend or the next if I
don't have time.  If you or anybody else feel comfortable doing more
work in Perl, feel free to go ahead with it.

> It is designed to export a linear git branch. However, thanks to the way
> 'git' handles source code, 'git-svndump' seems to work in other
> conditions. For example, when branches are switched or merged.
> 
> git-svndump provides a solution when you need to export your source code
> in Subversion format (who would need this with git :), but do not want
> to have all the shackles that 'git-svn init' puts on your repository.

> Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
> ---
>  Documentation/git-svndump.txt |   97 ++++++++++++++++++++++++++++++++++++++++
>  Makefile                      |    1 +
>  git-svndump-init.sh           |   85 +++++++++++++++++++++++++++++++++++
>  git-svndump-sync.sh           |   98 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 281 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/git-svndump.txt
>  create mode 100755 git-svndump-init.sh
>  create mode 100755 git-svndump-sync.sh

I'm really not excited about having even more shell scripts in git.

-- 
Eric Wong
