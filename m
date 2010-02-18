From: Bill Lear <rael@zopyra.com>
Subject: 16gig 350,000 file git repo
Date: Thu, 18 Feb 2010 14:16:06 -0600
Message-ID: <19325.40966.804154.791489@blake.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 21:16:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCnK-0003zP-H1
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420Ab0BRUQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:16:14 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:46603
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1758678Ab0BRUQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:16:13 -0500
Received: (qmail 18418 invoked by uid 500); 18 Feb 2010 20:16:11 -0000
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140370>

We have just pulled in a large ClearCase repository (no history),
resulting in 16 gig of files, mostly test cases, in a fairly
deeply-nested directory structure.  Time to clone over a fast (10gig)
network is 250 minutes, though I have not been able to verify that the
repository was packed or not.

We would like to be able to branch the entire repository as one entity,
but are unsure how to reduce the clone time without going to submodules
or subtrees (have no experience with the latter and little with the
former).

Is there anything that can be done to be able to clone only a part of
the repository?

Any suggestions on how to better manage this?

Thanks.


Bill
