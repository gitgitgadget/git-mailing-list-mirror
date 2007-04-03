From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit cherry-picking
Date: Tue, 3 Apr 2007 01:19:47 -0400
Message-ID: <20070403051947.GE15922@spearce.org>
References: <20070403034234.GB24722@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alberto Bertogli <albertito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 07:20:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYbRG-00085k-PS
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 07:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbXDCFTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 01:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbXDCFTv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 01:19:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51491 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbXDCFTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 01:19:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYbQq-0006Vr-Vr; Tue, 03 Apr 2007 01:19:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6BD2620FBAE; Tue,  3 Apr 2007 01:19:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070403034234.GB24722@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43612>

Alberto Bertogli <albertito@gmail.com> wrote:
> I often use darcs, and one feature I miss when I use git is the ability
> to do cherry-picking on what I'm about to commit.

Have you tried:

	git add -i
	git commit

?

The `git add -i` flag starts up an interactive tool that you can use
to add patch hunks to the index, staging them for the next commit.
Running commit with no arguments will then commit exactly what is
in the index, leaving the other hunks beind in the working directory.

Or did I miss something?  Note that `git add -i` was added as a
new feature in Git 1.5.0 (and later).

-- 
Shawn.
