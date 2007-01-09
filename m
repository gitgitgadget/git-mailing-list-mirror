From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bug in git-status with non-ascii characters:
Date: Tue, 9 Jan 2007 00:28:32 -0500
Message-ID: <20070109052832.GA2371@spearce.org>
References: <7BACA5DE-9DBA-4299-A965-E248263E27E2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 06:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49XM-0007yD-6m
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbXAIF2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 00:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbXAIF2h
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:28:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51741 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbXAIF2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 00:28:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H49XG-0000zz-FQ; Tue, 09 Jan 2007 00:28:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8D32120FBAE; Tue,  9 Jan 2007 00:28:32 -0500 (EST)
To: Brian Gernhardt <benji@silverinsanity.com>
Content-Disposition: inline
In-Reply-To: <7BACA5DE-9DBA-4299-A965-E248263E27E2@silverinsanity.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36312>

Brian Gernhardt <benji@silverinsanity.com> wrote:
> This is on Mac OS X, file system is HFS+ (Journaled).  Is this  
> expected?  I can't figure out why it's happening.

There's a bug in the Mac OS X filesystem apparently.

Git created the file with one encoding.  Later when Git does a
readdir() to find out what files are in the directory Mac OS X is
returning it with a different encoding.  There's more details in
the list archives; all I know is Mac OS X is broken here.  And we
Mac users get to suffer...

P.S. I'm also a Mac OS X user.  I've gotten used to that file
showing up and just visually ignore it now.  *sigh*

-- 
Shawn.
