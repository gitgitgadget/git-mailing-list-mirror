From: Andreas Krey <a.krey@gmx.de>
Subject: Remote's 'currently active branch' not HEAD?
Date: Tue, 3 Sep 2013 12:46:52 +0200
Message-ID: <20130903104652.GA5813@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 03 12:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGoFZ-000185-0E
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 12:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719Ab3ICKyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 06:54:17 -0400
Received: from continuum.iocl.org ([217.140.74.2]:48447 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710Ab3ICKyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 06:54:16 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2013 06:54:15 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r83AkqQ06925;
	Tue, 3 Sep 2013 12:46:52 +0200
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233714>

Hi everyone,

I have a strange behaviour from a bare repo I inherited;
when I clone from that one (ssh) the branch checked out
is *not* the one referenced in HEAD in the remote repo,
but apparently some variation of the alphabetically first
or temporally last, or the last *new* branch pushed.

Where would I look to find the reason for this behaviour?
How does git transfer the 'current branch' info during the clone?

There is no 'master' branch in the original bare repo,
but HEAD points to a valid value (refs/heads/r1).

Testing with another repo unfortunately doesn't show any
consistency, more like heisenbuggish.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
