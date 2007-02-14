From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 14:49:19 -0500
Message-ID: <20070214194919.GE28290@spearce.org>
References: <17875.25882.784307.731860@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQ8S-0004OF-8C
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbXBNTtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbXBNTtY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:49:24 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40298 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbXBNTtX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:49:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHQ7t-0001et-ND; Wed, 14 Feb 2007 14:49:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E1A9420FBAE; Wed, 14 Feb 2007 14:49:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17875.25882.784307.731860@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39734>

Bill Lear <rael@zopyra.com> wrote:
> I have not yet figured this one out: I have not tagged anything, but
> know that I checked in something lame sometime between now and two days
> ago.  How do I get my working repo to be that as it was, say, yesterday?
> 
> Do I do:
> 
> % git log --since="2 days ago"
> 
> parse, the output for the commit I want, and then do
> 
> % git reset <SHA>

No.  This would update your branch and your index to <SHA>, but
leave your working directory alone.  That's not what you want here.

Use `git checkout <SHA>` which will detach your HEAD and seek to
the commit, leaving your current commit alone.  Later you can get
back by `git checkout oldbranch`.
 
-- 
Shawn.
