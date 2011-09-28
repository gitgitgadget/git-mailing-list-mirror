From: Abscissa <bus_nabble_git@semitwist.com>
Subject: SVN -> Git *but* with special changes
Date: Wed, 28 Sep 2011 09:37:29 -0700 (PDT)
Message-ID: <1317227849979-6840904.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 18:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8x8Y-0007XS-Vv
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 18:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab1I1Qhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 12:37:31 -0400
Received: from sam.nabble.com ([216.139.236.26]:51345 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab1I1Qha (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 12:37:30 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bus_nabble_git@semitwist.com>)
	id 1R8x8T-0002kd-Vy
	for git@vger.kernel.org; Wed, 28 Sep 2011 09:37:29 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182341>

I have a couple big projects in SVN that I'd like to convert to Git. Being in
SVN, they've operated under a couple assumptions that are not true under
Git. These assumptions are:

1. Directories can exist even if there's nothing in them (just like any
filesystem).

2. Keeping binary files in version control isn't a big deal because the
whole repo doesn't get copied to everyone's system or use up people's GitHub
storage space.

The SVN repos have been relying on those, but both are false under Git, so I
need to do a "modified" conversion, rather than just a straight one.

So, how can I convert an SVN repo to Git, and have the conversion add dummy
files to empty directories and exclude specific files? (Also, there are tags
and branches to be converted too, in the SVN-standard "tags" and "branches"
directories.)

--
View this message in context: http://git.661346.n2.nabble.com/SVN-Git-but-with-special-changes-tp6840904p6840904.html
Sent from the git mailing list archive at Nabble.com.
