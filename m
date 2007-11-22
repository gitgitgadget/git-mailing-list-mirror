From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/3] git-svn: allow `info' command to work offline
Date: Wed, 21 Nov 2007 19:56:05 -0800
Message-ID: <20071122035605.GB30134@soma>
References: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net> <20071122022343.GA9992@soma> <4744F66D.7030007@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>, git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 04:56:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv3B3-0007F1-Us
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 04:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbXKVD4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 22:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbXKVD4J
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 22:56:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37124 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753294AbXKVD4G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 22:56:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 413BB7DC0FE;
	Wed, 21 Nov 2007 19:56:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4744F66D.7030007@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65740>

Adam Roben <aroben@apple.com> wrote:
> Eric Wong wrote:
> >+	my $k = "svn-remote.$self->{repo_id}.reposRoot";
> >  
> 
> "repoRoot" seems slightly more intuitive than "reposRoot", given that 
> "repository" is normally abbreviated as "repo".

>From a git-only point of view, yes.  But it's repos_root everywhere
inside git-svn because SVN uses "*_repos_root" for their API.
This is inside the hidden metadata file that users
shouldn't have to touch anyways.

On a side note:

I personally *hate* camelCase names (or worse, alllowercase), but
git config doesn't allow underscores in config keys for some
strange reason (especially strange since most of the git and Linux
source code use snake_case...)

-- 
Eric Wong
