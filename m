From: KAJed <kailey.joanette@gmail.com>
Subject: git rebase conflicts?
Date: Thu, 3 Feb 2011 13:06:53 -0800 (PST)
Message-ID: <1296767213445-5990493.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 22:07:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl6OJ-0001AN-TQ
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 22:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab1BCVGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 16:06:54 -0500
Received: from sam.nabble.com ([216.139.236.26]:47507 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247Ab1BCVGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 16:06:53 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <kailey.joanette@gmail.com>)
	id 1Pl6OD-0005lj-Ea
	for git@vger.kernel.org; Thu, 03 Feb 2011 13:06:53 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165998>


If I'm rebasing the history on a project, basically squashing all commits to
a point, why are there conflicts?

Keep in mind this is a flat history.  Basically the history came from SVN
and now I'm trying to squash that down to "this was the stable migration
from SVN".

So howcome when rebasing it causes a conflict?
Some times its files that are missing, or being deleted.
Some times I can see it's because an empty directory (at least that makes
sense with git).

Any other suggestions?  What I really want is there to either be NO
conflicts, or simply conflict resolve with the correct (newer) file.
-- 
View this message in context: http://git.661346.n2.nabble.com/git-rebase-conflicts-tp5990493p5990493.html
Sent from the git mailing list archive at Nabble.com.
