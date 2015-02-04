From: Peter Krefting <peter@softwolves.pp.se>
Subject: git tag --no-merged?
Date: Wed, 4 Feb 2015 16:19:59 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:34:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ1xu-0005pN-4l
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 16:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbbBDPdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 10:33:54 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:36949 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966871AbbBDPds (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 10:33:48 -0500
X-Greylist: delayed 823 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Feb 2015 10:33:48 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id t14FK1MH001106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Feb 2015 16:20:01 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id t14FJxrH001103;
	Wed, 4 Feb 2015 16:20:00 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 04 Feb 2015 16:20:01 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263351>

Hi!

Using "git branch --no-merged" I can get a list of branches that I 
have that I haven't merged into my current branch. "git tag" doesn't 
have such an option, is there a way to achieve something similar 
listing tags that point to commits that aren't in my history?



Background: In my $DAYJOB we have a couple of products that are built 
from a common source tree. Each of the products have their own 
maintenance branches, and releases from these maintenance branches are 
tagged. I want to merge the changes from the maintenance branches to 
master (and possibly to other maintenance branches if there are 
changes relevant to other products), but I only want to do this for 
our tagged released.

Using "git branch --no-merged" I can see which of the maintenance 
branches have commits that haven't been merged yet, but I cannot tell 
whether any of those have been tagged.

-- 
\\// Peter - http://www.softwolves.pp.se/
