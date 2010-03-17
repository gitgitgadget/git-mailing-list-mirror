From: jateeq <jawad_atiq@hotmail.com>
Subject: Re: Getting a branch's time of creation
Date: Wed, 17 Mar 2010 09:24:06 -0800 (PST)
Message-ID: <1268846646146-4751743.post@n2.nabble.com>
References: <27933166.post@talk.nabble.com> <86wrxakiyj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 18:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrwyf-0005g0-2Y
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 18:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235Ab0CQRYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 13:24:10 -0400
Received: from kuber.nabble.com ([216.139.236.158]:49912 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab0CQRYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 13:24:08 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <jawad_atiq@hotmail.com>)
	id 1NrwyU-0005j5-4v
	for git@vger.kernel.org; Wed, 17 Mar 2010 10:24:06 -0700
In-Reply-To: <86wrxakiyj.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142419>


Great, that works -  it gives me the commit that Branch 1 was at at the time
of cloning.

One concern however. If I clone the repository, create Branch 2 to track
Branch 1, and in the mean while push changes to the master branch of the
repository, the commit that this command gives me changes (to the last
commit that was pushed). The repository I am cloning from is bare, so in
order to make changes to the master, I clone it again, make changes to the
master branch of the clone and push those back (of course, this clone also
has Branch 1 as a remote branch, but I am not making changes to it). What is
git doing? Why does it change the commit history of Branch 1 when I did not
push changes to it? 

Before pushing to master:
$git log --oneline $(git merge-base origin/jateeq.2010-03-16.15-32
origin/master)..origin/master
610cfae added file.xml

After pushing to master:
$git log --oneline $(git merge-base origin/jateeq.2010-03-16.15-32
origin/master)..origin/master
9070a4d removed fcc.xml


Thanks, 
Jawad
-- 
View this message in context: http://n2.nabble.com/Getting-a-branch-s-time-of-creation-tp4750687p4751743.html
Sent from the git mailing list archive at Nabble.com.
