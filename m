From: bdowning@lavos.net (Brian Downing)
Subject: git archive ignores .gitignored files?
Date: Thu, 26 Jul 2007 12:32:06 -0500
Message-ID: <20070726173206.GR21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 19:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE7Cp-0003Lu-5H
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 19:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbXGZRci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 13:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763884AbXGZRci
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 13:32:38 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:29502 "EHLO
	asav13.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764131AbXGZRch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 13:32:37 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav13.insightbb.com with ESMTP; 26 Jul 2007 13:32:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah5FAJ13qEZKhvbzRmdsb2JhbACBTYVpiCgBAQE1AQ
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 9E0D1309F31; Thu, 26 Jul 2007 12:32:06 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53846>

git archive seems to not output files marked in .gitignore.  I find
this behavior a little perplexing, since it does not create an archive
from the working directory, and if something is committed, even if it
is marked in .gitignore, it should probably wind up in the archive.

The reason I discovered this is that I'm trying to keep a debian build
branch for Git, and the debain/git-daemon directory was mysteriously
missing from anything generated with git archive, as "git-daemon" is
in Git's /.gitignore.

Is this intended behavior?  It seems kind of a misfeature to me.

(Of course it's possible /.gitarchive should have "/git-daemon" rather
than "git-daemon"; that's certainly how I will work around the issue.)

-bcd
