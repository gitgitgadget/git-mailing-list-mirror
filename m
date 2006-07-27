From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Licensing and the library version of git
Date: Wed, 26 Jul 2006 21:40:41 -0400
Message-ID: <20060727014040.GA32742@spearce.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 03:40:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5uro-0000dt-T5
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 03:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWG0Bkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 21:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWG0Bkq
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 21:40:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51152 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750773AbWG0Bkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 21:40:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G5urY-0007l4-SD; Wed, 26 Jul 2006 21:40:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EA17820FB77; Wed, 26 Jul 2006 21:40:41 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24266>

Jon Smirl <jonsmirl@gmail.com> wrote:
> Can the library version of git be licensed LGPL instead of GPL? If it
> is GPL then it can't be linked into non-GPL projects like Eclipse.

True.  But I have a pure-Java implementation of portions of GIT:

	- pack file reader, including delta decompression;
	- loose object reader (sans new pack header format);
	- loose object writer (blobs, trees, commits, no tags);
	- ref reader/basic resolver;
	- ref writer;
	- new repository creation;
	- tree and commit parsing;
	- n-way tree structure diff (no blob content diff);

and Eclipse UI for:

	- resource decorator showing object state;
	- rename tracking (well, automatic delete then add);
	- add file/folder to repository;
	- delete file/folder from repository;
	- save workspace state to a tree;
	- periodically flush modified files into blobs;

but I need UI still for creating a commit.  I'd like to get that
code finished this week and get the repository posted on the web
for others to start messing around with if they are interested.
This project has just been slow going for me as I'm working looooong
hours at my day job.  :-)

-- 
Shawn.
