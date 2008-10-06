From: Jeff Kowalczyk <jtk@yahoo.com>
Subject: Repairing fatal: ref HEAD is not a symbolic ref (git checkout of svn remote)
Date: Mon, 06 Oct 2008 10:00:58 -0400
Message-ID: <pan.2008.10.06.14.00.57.104051@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 16:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmqfH-0005X3-QG
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYJFOBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbYJFOBM
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:01:12 -0400
Received: from main.gmane.org ([80.91.229.2]:54626 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbYJFOBM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:01:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kmqe3-0000gi-O4
	for git@vger.kernel.org; Mon, 06 Oct 2008 14:01:07 +0000
Received: from 75-94-104-185.roc.clearwire-dns.net ([75.94.104.185])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 14:01:07 +0000
Received: from jtk by 75-94-104-185.roc.clearwire-dns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 14:01:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 75-94-104-185.roc.clearwire-dns.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97580>

To test a particular upstream revision, on a git svn remote checkout (i.e.
branches/1.2, 76c7af2...), I checked out the equivalent of HEAD^^ (git
checkout 4a3d99c0c9).

Now back at the branch tip, I get fatal: ref HEAD is not a symbolic ref
on git svn rebase: 

(4a3d99c...) $ git checkout 76c7af2
HEAD is now at 76c7af2... Minor changes to CONTRIBUTORS
(76c7af2...) $ git svn rebase
fatal: ref HEAD is not a symbolic ref Current branch HEAD is up to date.
Segmentation fault

How can I manually correct ref HEAD?

Thanks.

(The segmentation fault is a separate issue)
