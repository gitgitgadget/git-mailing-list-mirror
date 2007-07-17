From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Update a bare repository
Date: Tue, 17 Jul 2007 08:30:26 +0200
Message-ID: <20070717063026.GA5823@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 08:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAgZr-0004Q7-CQ
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 08:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbXGQGa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 02:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbXGQGa2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 02:30:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:61760 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754812AbXGQGa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 02:30:27 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 70C843F435; Tue, 17 Jul 2007 08:30:26 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52741>

Hello,
what I would like to do is the following:

I have a _bare_ clone of a git repository and would like to update it
from Junios repository at kernel.org from time to time.

How do I do that? In a way that it is a fire and forget solution? It
should also fetch new upstream branches.

"git pull" does not work. "git fetch" does, but it does update all
references?

	(faui02) [~/work/repositories/mirror/git.git] git pull
	fatal: /usr/bin/git-pull cannot be used without a working tree.
	(faui02) [~/work/repositories/mirror/git.git] git fetch
	(faui02) [~/work/repositories/mirror/git.git]

I also would like to check that it is impossible to push anything to the
repository.

		Thomas
