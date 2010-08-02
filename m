From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Back-dating commits--way back--for constitution.git
Date: Mon, 02 Aug 2010 14:32:00 -0400
Message-ID: <i372v0$3np$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 02 20:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfzoC-0005ax-3p
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 20:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab0HBScO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 14:32:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:58006 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112Ab0HBScN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 14:32:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ofzo2-0005XF-34
	for git@vger.kernel.org; Mon, 02 Aug 2010 20:32:10 +0200
Received: from pool-173-56-160-133.nycmny.east.verizon.net ([173.56.160.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 20:32:10 +0200
Received: from joelcsalomon by pool-173-56-160-133.nycmny.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 20:32:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pool-173-56-160-133.nycmny.east.verizon.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Lightning/1.0b1 Thunderbird/3.0.6
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152433>

I'd figured to play with Git in an unusual way: to create a repository
for the U.S. Constitution where amendments are presented as patches.
E.g., instead of the First Amendment being placed at the end (as is
usual) I'm putting it in Article 1, Section 9 (Limitations of Congress).
 Proposed amendments get branches, which get merged in later.

But I'm trying to get the dates right, and I'm missing something.  For
example, I made the initial commit with the line

	$ git commit --author="The Philadelphia Convention <>" \
	 --date="Mon, 17 Sep 1787 12:00:00 EST"

but that's not actually setting the commit date to 1787.

Am I doing something wrong, or is Git (quite reasonably) unable to
accept commit dates that far in the past?

--Joel
