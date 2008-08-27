From: issackelly <issac@servee.com>
Subject: Sample Workflow Help
Date: Wed, 27 Aug 2008 14:27:15 -0700 (PDT)
Message-ID: <19190079.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 23:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYSYv-0003F8-D2
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYH0V1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbYH0V1Q
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:27:16 -0400
Received: from kuber.nabble.com ([216.139.236.158]:44105 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbYH0V1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:27:15 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KYSXr-00038Q-76
	for git@vger.kernel.org; Wed, 27 Aug 2008 14:27:15 -0700
X-Nabble-From: issac@servee.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93957>


I'm new to git.  I need some help refactoring my workflow.

Here is my setup.

There are three of us working on one server, each with individual
repositories (clones) on the server (this is important because our test
environment can't work from branches, it needs to work from actual files)

so, there is the 1_1 folder (main repo)
1_1issac for me
1_1kasey and 1_1josh

So, here is my sample workflow

--Begin doc

I'm Issac.  I'm working on some calendar code, on my mac, it's at
~/1_1issac/admin/pageType/calendar/admin.php (this is a clone of my
repository)

I've made some local edits, to put it on the server I now do this (on my
local terminal)

    cd ~/1_1issac #my root directory

    git commit -a #find all of my changes and commit them to the local
repository

    git push ssh://<server>/<repoDir>/1_1issac

Now, I've made a new icon at /admin/pageType/calendar/icon.png

git add admin/pageType/calendar/icon.png

git commit -a

git push ssh://<server>/<repoDir>/1_1issac

I e-mail kasey "Kasey, I've put a temp icon in the 1_1issac folder under
admin/pageType/calendar/icon.png could you give me a better one?"

He does, first he jumps on the server and updates his current working files
with the things that I'm working on:

ssh <server>
cd <repoDir>/1_1kasey
git pull ../1_1issac
exit
# your back to your regular environment now
cd <wherever the stuff you normally work on it>

git pull ssh://<server>/<repoDir>/1_1kasey

#edit my crapy paint drawing

git commit -a

git push ssh://<server>/<repoDir>/1_1kasey

--end

Please tell me what I'm doing wrong (if anything) and what I could be doing
better.  I've been using git for about two days, and I'm trying to teach my
team to as well.
-- 
View this message in context: http://www.nabble.com/Sample-Workflow-Help-tp19190079p19190079.html
Sent from the git mailing list archive at Nabble.com.
