From: Jeff Kowalczyk <jtk@yahoo.com>
Subject: Start git svn clone at specific revision for cloning subprojects in large svn repositories?
Date: Wed, 22 Oct 2008 11:00:24 -0400
Message-ID: <pan.2008.10.22.15.00.21.403423@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 17:02:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsfDh-0004DO-Eg
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 17:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbYJVPAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 11:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYJVPAk
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 11:00:40 -0400
Received: from main.gmane.org ([80.91.229.2]:60264 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbYJVPAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 11:00:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KsfCL-0008Gk-Pq
	for git@vger.kernel.org; Wed, 22 Oct 2008 15:00:33 +0000
Received: from 75-94-104-185.roc.clearwire-dns.net ([75.94.104.185])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 15:00:33 +0000
Received: from jtk by 75-94-104-185.roc.clearwire-dns.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 15:00:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 75-94-104-185.roc.clearwire-dns.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98875>

I would like to git svn clone subprojects from a large community
subversion repository (plone collective).

The repository is currently at 74K commits, but subprojects of interest
are typically much more recent, and their initial import revision is known.

I would like to avoid a) unnecessary traffic to the svn server and b)
the very long delay in git svn cloning these subprojects.

Is there a way to specfiy a starting revision to git svn clone?

Thanks.
 
