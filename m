From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 14:09:07 -0500
Message-ID: <20070130190907.GE26415@spearce.org>
References: <17855.35058.967318.546726@lisa.zopyra.com> <epo1tn$9sl$1@sea.gmane.org> <17855.35845.922009.364704@lisa.zopyra.com> <20070130182237.GC26415@spearce.org> <17855.36470.309129.391271@lisa.zopyra.com> <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org> <17855.38543.761930.929267@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HByLz-0004KO-6f
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbXA3TJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXA3TJM
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:09:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40115 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbXA3TJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:09:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HByLm-0003T2-Ok; Tue, 30 Jan 2007 14:09:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0010920FBAE; Tue, 30 Jan 2007 14:09:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17855.38543.761930.929267@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38188>

Bill Lear <rael@zopyra.com> wrote:
> % cd /repos/git/project
> % GIT_DIR=. git branch
>   topic
> 
> And then, tried it all again:
> 
> % cd ..
> % rm -rf project
> % mkdir project
> % cd project
> % git --bare clone --shared
> % GIT_DIR=. git fetch git://source/public/project

You did not ask for a tracking branch to be created.  So the
result of your fetch is in FETCH_HEAD only.  Try instead:

GIT_DIR=. git fetch git://source/public/project topic:refs/heads/master

-- 
Shawn.
