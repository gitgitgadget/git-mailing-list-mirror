From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [QUESTION] Selective fetch possible?
Date: Mon, 10 Mar 2008 18:53:02 -0400
Message-ID: <20080310225302.GE8410@spearce.org>
References: <47D5AFF3.90000@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Filippo Zangheri <filippo.zangheri@yahoo.it>
X-From: git-owner@vger.kernel.org Mon Mar 10 23:53:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYqsM-0008EV-Bq
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 23:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbYCJWxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 18:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbYCJWxG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 18:53:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44236 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbYCJWxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 18:53:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYqrW-00011V-2P; Mon, 10 Mar 2008 18:52:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 06CB720FBAE; Mon, 10 Mar 2008 18:53:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47D5AFF3.90000@yahoo.it>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76766>

Filippo Zangheri <filippo.zangheri@yahoo.it> wrote:
> Is it possible to git-fetch only a portion of the tree
> of the specified repository, say, fetch only one directory or a
> subset of files matching some regular expression? This is currently
> - to my knowledge - only possible via wget iff the GIT repository
> has gitweb enabled. But that's just a workaround.

No.

You can use a shallow clone to fetch only X commits back into
history on any branch, and you can also manually configure the
fetch specification in .git/config to only fetch specific branches,
but you must fetch the entire tree to get any of the files in it.

If the repository is available by git:// protocol you may be able
to use git-archive to obtain a tarfile for just the directory you
want (service has to be enabled on the remote side) but that is
just a raw UNIX tar; there is no Git repository and no ability to
commit/fetch/push/diff/apply/log/etc.
 
-- 
Shawn.
