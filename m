From: Sal Mangano <smangano@into-technology.com>
Subject: Supressing sorting of trees
Date: Mon, 12 Oct 2009 13:27:56 +0000 (UTC)
Message-ID: <loom.20091012T152113-874@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 16:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxLpO-0003mq-SU
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbZJLOP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756761AbZJLOP4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:15:56 -0400
Received: from lo.gmane.org ([80.91.229.12]:42319 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756771AbZJLOP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:15:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MxLg1-0007GJ-0s
	for git@vger.kernel.org; Mon, 12 Oct 2009 16:15:05 +0200
Received: from ool-18bd213f.dyn.optonline.net ([24.189.33.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 16:15:05 +0200
Received: from smangano by ool-18bd213f.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 16:15:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.189.33.63 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.25 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130016>

I am using Git in a non-standard way and need to make a few twaeks in my 
custom build. I have added a --nosort option to git mktree which will suppress
the qsort of the tree. 

Will this break any other git functions? Are there any commands that assume 
trees are always sorted?
