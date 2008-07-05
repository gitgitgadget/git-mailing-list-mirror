From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Git, merging, and News/Relnotes files
Date: Sat, 05 Jul 2008 03:24:13 -0400
Message-ID: <g4n7j6$359$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 09:25:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF29L-0002Ug-QY
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 09:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbYGEHYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 03:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbYGEHYd
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 03:24:33 -0400
Received: from main.gmane.org ([80.91.229.2]:39959 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbYGEHYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 03:24:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KF28E-0004LN-0z
	for git@vger.kernel.org; Sat, 05 Jul 2008 07:24:30 +0000
Received: from ool-18e45099.dyn.optonline.net ([24.228.80.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 07:24:30 +0000
Received: from edwardzyang by ool-18e45099.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 07:24:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18e45099.dyn.optonline.net
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87435>

As a policy on a project that I manage, almost every commit warrants a
change to our NEWS (changelog) file, which end-users can browse to get
an in-depth idea of the changes that have happened from the last
release. If it's an added feature, the changelog includes a description
of how to use it; if it's a fixed bug, it briefly describes what
happened. Internal changes may or may not get added, depending on the
visibility of the APIs affected.

Something that I've noticed recently, as we've started migrating away
from the ghetto SVN development model to the Git branchy model, is that
this NEWS file ends up being the source of a lot of conflicts. Granted,
they're easy conflicts to resolve, but still, they make a pull a little
more complicated than it should be.

What would you guys, as experienced Git users, recommend in this case?
Scrapping a NEWS file and simply drawing up the release-notes shortly
before release (as the Git project does)? Aggregating the Git commit
messages into one monster release log? Having the release manager add
the NEWS entries himself, and mandate that no patch have it in them?

Thanks!
