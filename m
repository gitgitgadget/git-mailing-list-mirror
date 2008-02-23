From: Chase Venters <chase.venters@clientec.com>
Subject: Question about your git habits
Date: Fri, 22 Feb 2008 18:37:14 -0600
Organization: Clientec, Inc.
Message-ID: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 02:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSilr-0007TA-RY
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbYBWBBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYBWBBG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:01:06 -0500
Received: from lotis.site5.com ([74.53.58.75]:32977 "EHLO lotis.site5.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbYBWBBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 20:01:04 -0500
X-Greylist: delayed 1405 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2008 20:01:04 EST
Received: from cpe-76-185-130-42.tx.res.rr.com ([76.185.130.42] helo=[10.0.0.128])
	by lotis.site5.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <chase.venters@clientec.com>)
	id 1JSiOO-0006FX-8Q; Fri, 22 Feb 2008 18:37:28 -0600
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - lotis.site5.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - clientec.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74775>

I've been making myself more familiar with git lately and I'm curious what 
habits others have adopted. (I know there are a few documents in circulation 
that deal with using git to work on the kernel but I don't think this has 
been specifically covered).

My question is: If you're working on multiple things at once, do you tend to 
clone the entire repository repeatedly into a series of separate working 
directories and do your work there, then pull that work (possibly comprising 
a series of "temporary" commits) back into a separate local master 
respository with --squash, either into "master" or into a branch containing 
the new feature?

Or perhaps you create a temporary topical branch for each thing you are 
working on, and commit arbitrary changes then checkout another branch when 
you need to change gears, finally --squashing the intermediate commits when a 
particular piece of work is done?

I'm using git to manage my project and I'm trying to determine the most 
optimal workflow I can. I figure that I'm going to have an "official" master 
repository for the project, and I want to keep the revision history clean in 
that repository (ie, no messy intermediate commits that don't compile or only 
implement a feature half way).

On older projects I was using a certalized revision control system like 
*cough* Subversion *cough* and I'd create separate branches which I'd check 
out into their own working trees.

It seems to me that having multiple working trees (effectively, cloning 
the "master" repository every time I need to make anything but a trivial 
change) would be most effective under git as well as it doesn't require 
creating messy, intermediate commits in the first place (but allows for them 
if they are used). But I wonder how that approach would scale with a project 
whose git repo weighed hundreds of megs or more. (With a centralized rcs, of 
course, you don't have to lug around a copy of the whole project history in 
each working tree.)

Insight appreciated, and I apologize if I've failed to RTFM somewhere.

Thanks,
Chase
