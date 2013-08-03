From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: change remote to track new branch
Date: Sat, 3 Aug 2013 12:28:21 -0400
Message-ID: <20130803162821.GA945@analysisandsolutions.com>
References: <20130803024032.GA28666@analysisandsolutions.com>
 <m2d2pvp7nw.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Aug 03 18:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5egs-0004Xu-Kh
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 18:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab3HCQ2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 12:28:23 -0400
Received: from analysisandsolutions.com ([50.116.58.177]:60823 "EHLO
	analysisandsolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab3HCQ2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 12:28:22 -0400
Received: by analysisandsolutions.com (Postfix, from userid 1001)
	id BDE4218973; Sat,  3 Aug 2013 12:28:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=analysisandsolutions.com; s=default; t=1375547301;
	bh=Xjg7tHvbIahWbk8fnzx58I66+DGFEPuWgi+dQ2ET1gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNLNkCoeWVhUUDseOXnGFg4UlGXZcU4B6wfp6t3b7sXvHHyMVJE0Ixb2OJmFxf5r9
	 7kWaqt59bAl90LMFRVyt/1imjxYQBn7EA29fgSMcMnNB5NxEOzsP4DUOH6XRUgXusf
	 wT58wVlx0zevGm8emqwpB66EaznCJVEODIm9kUi8=
Content-Disposition: inline
In-Reply-To: <m2d2pvp7nw.fsf@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231600>

Hi Andreas:

On Sat, Aug 03, 2013 at 09:14:59AM +0200, Andreas Schwab wrote:
> Daniel Convissor <danielc@analysisandsolutions.com> writes:
> 
> > Long ago I added a remote to my repo.  It is set to track what was then
> > WordPress' main release branch (3.4-branch) and created a local branch
> > to use it.  Well, time marches on.  I want to update my remote and
> > branch to track the new main release branch (3.6-branch).
> >
> > Here's how I set things up at the time:
> >
> > git remote add -t 3.4-branch -f wp https://github.com/WordPress/WordPress
> > git checkout -b wp wp/3.4-branch
> 
> Use "git remote set-branches" to change the tracked branches of a
> remote.  Use "git branch --set-upstream-to" to change the upstream of a
> branch (or create a new branch from the new upstream).

Thanks.  Those commands were introduced in 1.8.  Is there a way to do it
in 1.7, please?

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
        4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335
