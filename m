From: Rene Herman <rene.herman@gmail.com>
Subject: tags "problem"
Date: Fri, 14 Sep 2007 21:31:21 +0200
Message-ID: <46EAE189.5000804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 21:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWGtN-0001y3-Rv
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 21:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbXINTbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 15:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754284AbXINTbt
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 15:31:49 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:33158 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbXINTbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 15:31:48 -0400
Received: from [213.51.130.190] (port=35224 helo=smtp1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1IWGtG-000088-TR
	for git@vger.kernel.org; Fri, 14 Sep 2007 21:31:46 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:41214 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1IWGtE-0006pZ-6p
	for git@vger.kernel.org; Fri, 14 Sep 2007 21:31:44 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58182>

Hi people.

(please keep me in CC)

Was just busy constructing a tree and noticed a "problem" -- no doubt caused 
by me, but help appreciated.

I clone linus' kernel tree into ./local, then do a

	git checkout -b v22 v2.6.22

to get a 2.6.22 branch. I like to have a simple "git pull" while on this 
branch pull from the upstream stable tree, so as advised earlier, I put:

[branch "v22"]
         remote = linux-2.6.22.y
         merge = refs/heads/master
[remote "linux-2.6.22.y"]
         url = 
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.22.y.git
         fetch = refs/heads/master

in ./git/config. "git pull" now indeed works nicely.

I just noticed now though that this doesn't automatiically fetches tags as 
well. That is, no v2.6.22.x tags after that. "git fetch --tags" (or git pull 
--tags directly, I assume) gets them without problem, but I was expecting 
they'd be fetched automatically.

Should they? Can they? Can I put anything in the config so they will?

Rene.
