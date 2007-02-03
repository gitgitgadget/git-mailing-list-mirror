From: Pavel Roskin <proski@gnu.org>
Subject: Re: stg pull doesn't pull anymore
Date: Fri, 02 Feb 2007 22:44:38 -0500
Message-ID: <1170474278.26823.11.camel@dv>
References: <1170471647.9733.24.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 04:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDBpe-0007XG-OL
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 04:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946311AbXBCDol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 22:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946312AbXBCDol
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 22:44:41 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:41099 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946311AbXBCDok (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 22:44:40 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDBoO-0001tg-4k
	for git@vger.kernel.org; Fri, 02 Feb 2007 22:43:36 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDBpO-0007YJ-Kn; Fri, 02 Feb 2007 22:44:38 -0500
In-Reply-To: <1170471647.9733.24.camel@dv>
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38550>

Hello again!

Sorry for postscript.

The failure of test 4 in t1200-push-modified.sh (that's the StGIT
testsuite) is clearly related to the problem.  The test passes if I
change make test-lib.sh copy my .gitconfig to the new $HOME.  And
my .gitconfig is:

[stgit]
        pullcmd = git-pull
        pull-does-rebase = no

"stg pull" in test 3 doesn't pull anything, and that's why test 4
doesn't produce an expected failure.

Now I'm quite confident that stgit.pull-does-rebase=yes is not working
the way it should.

-- 
Regards,
Pavel Roskin
