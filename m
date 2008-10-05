From: Jeff Kowalczyk <jtk@yahoo.com>
Subject: git svn: Bad URL passed to RA layer: Unrecognized URL scheme
Date: Sun, 05 Oct 2008 13:24:04 -0400
Message-ID: <pan.2008.10.05.17.24.02.167465@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 19:31:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmXRw-0001BN-1e
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 19:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbYJERaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 13:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbYJERaI
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 13:30:08 -0400
Received: from main.gmane.org ([80.91.229.2]:46830 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbYJERaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 13:30:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KmXQh-0006Ny-4K
	for git@vger.kernel.org; Sun, 05 Oct 2008 17:30:03 +0000
Received: from 75-94-104-185.roc.clearwire-dns.net ([75.94.104.185])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 17:30:03 +0000
Received: from jtk by 75-94-104-185.roc.clearwire-dns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 17:30:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 75-94-104-185.roc.clearwire-dns.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97522>

I made an ill-advised upgrade to from subversion-1.4.6 to
subversion-1.5.2. While I had subversion-1.5.2 installed, git svn rebase
ended with a 'segmentation fault' error. 

Now back at subversion-1.4.6, git repositories with svn remotes updated
during the aforentioned upgrade now give an error:

(master) $ git svn fetch
Bad URL passed to RA layer: Unrecognized URL scheme for 'http://code.djangoproject.com/svn' at /usr/libexec/git-core/git-svn line 1400

(master) $ git svn rebase
Bad URL passed to RA layer: Unrecognized URL scheme for 'http://code.djangoproject.com/svn' at /usr/libexec/git-core/git-svn line 1909

Others which were not updated recently work fine for git svn operations.

How can I repair the affected git repositories?

Thanks.
