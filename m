From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 13:30:07 -0400
Message-ID: <20070417173007.GV2229@spearce.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	Tomash Brechko <tomash.brechko@gmail.com>,
	Pietro Mascagni <pietromas@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:30:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdrVX-00013w-0w
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 19:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbXDQRaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 13:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbXDQRaP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 13:30:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58475 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161179AbXDQRaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 13:30:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HdrVC-0000Ab-Op; Tue, 17 Apr 2007 13:30:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9F2B820FBAE; Tue, 17 Apr 2007 13:30:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200704171818.28256.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44805>

Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007, April 17, Guilhem Bonnefille wrote:
> > So, my conclusion is the better model in a corporate is a centralyzed
> > repo with some users using Git as "frontend". Other people will
> > simply use the native tools for accessing the repo.
> 
> Git has you covered there - it works better than other version control 
> systems for that model too.  I do it all the time; the only difference 
> is that with git it's not the tool doesn't force the choice on you.

Actually my day-job corporate repo is probably more secured in
Git than in PVCS Version Manager, even though every developer
has the entire history on their laptop.

Basically with PVCS users cannot save their work-in-progress very
well, so they copy files onto random network shares to make backups.
Our checked out tree is only about 120 MiB or so, but we have (and
I'm not kidding) over 3 GiB worth of various copies of the source
on an open network drive that anyone in the company can access, even
if they aren't authorized to view the source code of the product...

Now that developers have switched to Git, they have stopped making
those copies onto the network drive.  Why?  Simple, the network drive
copy takes longer (and more effort) than `git commit; git push`!
Users are all pushing to private branch spaces on the server, so
their work isn't merged until they really are ready for it, and
that server is backed up to secure tapes nightly, so all-in-all
its a much better situation.

-- 
Shawn.
