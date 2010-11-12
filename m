From: gzoller <gzoller@hotmail.com>
Subject: Newbie:  Restore messed up code from local or remote repository
Date: Fri, 12 Nov 2010 00:22:43 -0800 (PST)
Message-ID: <1289550163511-5731540.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 09:22:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGouL-0002kd-Cf
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 09:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589Ab0KLIWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 03:22:44 -0500
Received: from kuber.nabble.com ([216.139.236.158]:33870 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab0KLIWo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 03:22:44 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <gzoller@hotmail.com>)
	id 1PGouB-0007xy-Gh
	for git@vger.kernel.org; Fri, 12 Nov 2010 00:22:43 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161330>


Hello -- Extreme Git Newbie

I have a project that is checked into a local git repository as well as
pushed to a remote repository.

Through misadventure I've managed to screw up my working code and want to
restore what I had from my last commit on either the local or remote
repositories.

So I blew away my messed up working files and tried:

git checkout
git pull -f /path/to/remote/repos
git fetch -f /path/to/remote/repos

None of the above did the trick.  The two remote commands reported that
everything was Already up-to-date! (even though I'd deleted a lot of local
working files)

What am I missing?  How can I restore my previous state from last commit?

Thanks!
Greg
-- 
View this message in context: http://git.661346.n2.nabble.com/Newbie-Restore-messed-up-code-from-local-or-remote-repository-tp5731540p5731540.html
Sent from the git mailing list archive at Nabble.com.
