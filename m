From: Dmitry Smirnov <divis1969@gmail.com>
Subject: P4 Sync problem
Date: Tue, 10 Nov 2009 13:56:27 +0000 (UTC)
Message-ID: <loom.20091110T145046-137@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 14:57:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7rDU-0000tz-9H
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 14:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbZKJN4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 08:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZKJN4w
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 08:56:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:46324 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbZKJN4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 08:56:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7rDI-0000oi-6Y
	for git@vger.kernel.org; Tue, 10 Nov 2009 14:56:52 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 14:56:52 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 14:56:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132568>

Hi,

I'm trying to import Perfoce client into Git repository.
I had configured git-p4.clent=MYCLIENT and git-p4.useclientspec=true.

When runnign git p4 sync --verbose I got the follwing:

c:\p4\views\Git\p4client>git p4 sync --verbose
Reading pipe: git config git-p4.useclientspec
Reading pipe: git config git-p4.user
Reading pipe: git config git-p4.password
Reading pipe: git config git-p4.port
Reading pipe: git config git-p4.host
Reading pipe: git config git-p4.client
p4 -c MYCLIENT -G client -o
Opening pipe: p4 -c MYCLIENT -G client -o
Reading pipe: git rev-parse --symbolic  --remotes
branches: []
Getting p4 changes for ...
Traceback (most recent call last):
  File "/usr/sbin/git-core//git-p4", line 1929, in ?
    main()
  File "/usr/sbin/git-core//git-p4", line 1924, in main
    if not cmd.run(args):
  File "/usr/sbin/git-core//git-p4", line 1676, in run
    changes = p4ChangesForPaths(self.depotPaths, self.changeRange)
  File "/usr/sbin/git-core//git-p4", line 442, in p4ChangesForPaths
    assert depotPaths
AssertionError

I would appreciate if someone help to solve this problem.

Dmitry
