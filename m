From: Pavel Roskin <proski@gnu.org>
Subject: branch.pu.forcefetch
Date: Wed, 27 Dec 2006 15:31:59 -0500
Message-ID: <1167251519.2247.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 27 21:32:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzfRY-0007Lm-G5
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 21:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbWL0UcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 15:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbWL0UcE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 15:32:04 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:44057 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbWL0UcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 15:32:03 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1GzfRG-00087j-CX
	for git@vger.kernel.org; Wed, 27 Dec 2006 15:31:50 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1GzfRQ-0001o7-0y
	for git@vger.kernel.org; Wed, 27 Dec 2006 15:32:00 -0500
To: git@vger.kernel.org
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35478>

Hello!

I'm testing the current git from the master branch, and I like the idea
of moving the remotes to the config file, but I think there is a
significant omission in the new syntax.  There is no way to specify that
some branches are fast forward.

For example, I clone the git repository anew, and I try to update it by
git-fetch a few days later.  I get an error:

* refs/remotes/origin/pu: not updating to non-fast forward branch 'pu'
of git://www.kernel.org/pub/scm/git/git

It would be great to have a "non-fastforward" option in the config file
for every branch.  I'm thinking about something like:

[branch "pu"]
        forcefetch = 1

It would be even better to initialize such option while cloning.

-- 
Regards,
Pavel Roskin
