From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/4] git-svn: fix the trivial case of 'src and dst not
	in the same repo' during branch/tag
Date: Mon, 11 Jan 2010 20:27:50 -0800
Message-ID: <20100112042750.GA14884@dcvr.yhbt.net>
References: <4B4B4FDB.4000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Igor Mironov <igor.a.mironov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 05:28:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUYMK-0008Ss-SZ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 05:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab0ALE1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 23:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691Ab0ALE1x
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 23:27:53 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43166 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab0ALE1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 23:27:52 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF631F50B;
	Tue, 12 Jan 2010 04:27:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B4B4FDB.4000602@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136683>

Igor Mironov <igor.a.mironov@gmail.com> wrote:
> This fixes the following issue:
> $ git svn branch -t --username=svnuser --commit-url=https://myproj.domain.com/svn mytag

Thanks Igor!

I've shorted the subject lines and line-wrapped the commit messages to
fit in standard terminals, and pushed them out to:
git://git.bogomips.org/git-svn

Igor Mironov (4):
      git-svn: fix mismatched src/dst errors for branch/tag
      git-svn: respect commiturl option for branch/tag
      git-svn: add --username/commit-url options for branch/tag
      git-svn: document --username/commit-url for branch/tag

I'll be working on dcommit error handling in a bit
before asking Junio to pull.

-- 
Eric Wong
