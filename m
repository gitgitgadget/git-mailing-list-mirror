From: Bill Lear <rael@zopyra.com>
Subject: Re: Organizing (large) test data in git
Date: Tue, 27 Feb 2007 14:41:12 -0600
Message-ID: <17892.38760.241965.552855@lisa.zopyra.com>
References: <17892.28995.328911.23188@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272049560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17892.36336.249022.904854@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272113430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17892.37416.358405.211524@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272119430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM99H-0008Mh-Fo
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933098AbXB0UlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933092AbXB0UlT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:41:19 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61289 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933098AbXB0UlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:41:17 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1RKfFa10354;
	Tue, 27 Feb 2007 14:41:15 -0600
In-Reply-To: <Pine.LNX.4.63.0702272119430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40791>

On Tuesday, February 27, 2007 at 21:22:31 (+0100) Johannes Schindelin writes:
>...
>Basically, shallow clones cut off branches at some point, even if those 
>commits have references to their parents.

Ah, so a sort of temporal surgery.

I don't think this will help, and I don't think this is a unique
git issue, either.  It happens with any system, I would think.

Let's say I have 6 code repos on my system and one data repo.  If I
make changes in one of my code repos that requires a test data
change, I have to move to my test data repo, make the change
there, and commit there.  Then, back in my code repo, I commit also.

Now, instead of one tidy package (a commit) that holds code and test
together in a coherent package, I have two separate commits in two
repos that now have to be coordinated.  Imagine I do more changes in
similar fashion, and others do as well.  Now our lead of the QA
department is pulling his hair out, trying to figure out which commits
in the data directory match those in the code directory so he can do
regressions properly.

As I said, I don't think this is a git-specific issue, but more one
of organizational techniques.  Perhaps there is no good answer...


Bill
