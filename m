From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: Rebasing local patches
Date: Sat, 07 Mar 2009 10:01:22 +0100
Message-ID: <49B237E2.3080606@morey-chaisemartin.com>
Reply-To: devel@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 10:10:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfsXn-0000Ou-GS
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 10:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZCGJIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 04:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbZCGJIi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 04:08:38 -0500
Received: from 2.mail-out.ovh.net ([91.121.26.226]:55841 "HELO
	2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752554AbZCGJIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 04:08:36 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Mar 2009 04:08:36 EST
Received: (qmail 6502 invoked by uid 503); 7 Mar 2009 09:05:23 -0000
Received: from b6.ovh.net (HELO mail412.ha.ovh.net) (213.186.33.56)
  by 2.mail-out.ovh.net with SMTP; 7 Mar 2009 09:05:23 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 7 Mar 2009 09:01:53 -0000
Received: from agrenoble-152-1-99-159.w86-200.abo.wanadoo.fr (HELO ?192.168.10.12?) (devel@morey-chaisemartin.com@86.200.72.159)
  by ns0.ovh.net with SMTP; 7 Mar 2009 09:01:51 -0000
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 4034943792393932510
X-Ovh-Remote: 86.200.72.159 (agrenoble-152-1-99-159.w86-200.abo.wanadoo.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.500583/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112518>

Hello everyone, 

I have a few questions about the workflow we sue at work.
On one of our project, we depend on an external source which uses git.
On our side of the project, we create some patches (this part is not the problem), but only some of them are intended to be pushed (ie pulled by) the external source.
So basically, we have a set of patches on local branch that we rebase every so and then against master to keep our version up-to-date with the external one.

Is this the right way to do it?

Then, internally we have a centralized repository and many personal ones. When the need to go to the next version, one of the developper rebases the company patches branch afaisnt master and push it into the centralized repo.
What is the best way for the other developpers to get up-to-date with the rebased branch? 
git pull --rebase seems to me like a good way to keep local modifications.
If all our patches were already pushed on the centralized repo, we tend top use git reset --hard origin/our_patches

Final question:
I noticed that when the branch was rebased on the centralized and repo and origin/our_patches is up-to-date in mine. 
If I checkout another branch and then ckecout our_branches, I got a message telling my our_patches and the one from the server have diverged (or you are two commits behind...).
How can you get this info directly without leaving/rejoining your branch?


Regards

Nicolas
