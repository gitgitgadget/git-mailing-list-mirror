From: Bill Lear <rael@zopyra.com>
Subject: 16 gig, 350,000 file repository
Date: Thu, 18 Feb 2010 14:11:22 -0600
Message-ID: <19325.40682.729141.973125@blake.zopyra.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	<20100214011812.GA2175@dpotapov.dyndns.org>
	<7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
	<201002181114.19984.trast@student.ethz.ch>
	<7vtytee7ff.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.1002181456230.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 21:11:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCip-0000G5-5f
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672Ab0BRULc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:11:32 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:34234
	"HELO blake.zopyra.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1758442Ab0BRULb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:11:31 -0500
Received: (qmail 18054 invoked by uid 500); 18 Feb 2010 20:11:29 -0000
In-Reply-To: <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
X-Mailer: VM 8.1.0-beta under 23.1.1 (i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140369>

I'm starting a new, large project and would like a quick bit of advice.

Bringing in a set of test cases and other files from a ClearCase
repository resulted in a 350,000 file git repo of about 16 gigabytes.

The time to clone over a fast network was about 250 minutes.  I could
not verify if the repo had been packed properly, etc.

However, we are thinking of using submodules or subtrees, to allow a
person to selectively clone only a part of the repo they need for
their work.  Is there a way to do this without submodules/subtrees?

We also need to be able to branch the entire repo, which I think would
make submodules kind of a pain, but don't know...

What is the current thinking on these issues in the git community?


Bill
