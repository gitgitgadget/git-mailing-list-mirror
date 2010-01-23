From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] two git-svn changes to help work with chromium.org
Date: Sat, 23 Jan 2010 03:26:26 -0800
Message-ID: <20100123112626.GA21553@dcvr.yhbt.net>
References: <1264235401-44051-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Andrew Myrick <amyrick@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 12:26:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYe8O-0000w0-Lg
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 12:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab0AWL02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 06:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754756Ab0AWL02
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 06:26:28 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48251 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748Ab0AWL01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 06:26:27 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D411F488;
	Sat, 23 Jan 2010 11:26:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1264235401-44051-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137838>

Jay Soffian <jaysoffian@gmail.com> wrote:
> Google nicely mirrors the subversion chrome repository with git-svn. However,
> the git-svn mirror has only trunk. I wanted to add in a couple other branches
> to my clone of the git-svn mirror, but to do so I needed the ability to lie
> about the UUID since the publically accessible subversion repository has a
> different UUID than that which google is cloning from using git-svn.

Thanks Jay, pushed out to git://git.bogomips.org/git-svn
along with a few other changes I've been forgetting about:

> Jay Soffian (2):
>   git-svn: allow UUID to be manually remapped via rewriteUUID
>   git-svn: allow subset of branches/tags to be specified in glob spec

Andrew Myrick (3):
      git-svn: ignore changeless commits when checking for a cherry-pick
      git-svn: handle merge-base failures
      git-svn: update svn mergeinfo test suite

Igor Mironov (4):
      git-svn: fix mismatched src/dst errors for branch/tag
      git-svn: respect commiturl option for branch/tag
      git-svn: add --username/commit-url options for branch/tag
      git-svn: document --username/commit-url for branch/tag

-- 
Eric Wong
