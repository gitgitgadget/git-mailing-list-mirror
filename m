From: Gareth Adams <gareth.adams@gmail.com>
Subject: Git merge default?
Date: Mon, 8 Sep 2008 18:03:29 +0000 (UTC)
Message-ID: <loom.20080908T180107-59@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 20:07:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcl8K-0001Pa-AD
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYIHSFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 14:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755363AbYIHSFJ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:05:09 -0400
Received: from main.gmane.org ([80.91.229.2]:53523 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755355AbYIHSFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:05:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Kcl6k-0001Ei-NK
	for git@vger.kernel.org; Mon, 08 Sep 2008 18:05:02 +0000
Received: from cpc1-glfd3-0-0-cust341.glfd.cable.ntl.com ([86.7.217.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 18:05:02 +0000
Received: from gareth.adams by cpc1-glfd3-0-0-cust341.glfd.cable.ntl.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 18:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.7.217.86 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-GB; rv:1.8.1.16) Gecko/20080702 Firefox/2.0.0.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95282>

Sorry that this is cross posted to git-users but I didn't realise how low
traffic that list was.

Why doesn't `git merge` default to the tracked branch in the same way
e.g. `git push` does?

Often I find myself performing a pull, and when I switch branch I'm
told that "Your branch is behind the tracked remote branch 'origin/
master' by 12 commits". However, despite git knowing where my branch
is based and how far away it is, I still have to specify `git merge
origin/master` to perform the merge.

It's been pointed out that another `git pull` will usually have the
same effect, but it seems that this introduces a redundant fetch, and
to be honest I couldn't work out whether the pull would fail if the
remote repo was unavailable for any reason.

Obviously this is a really minor point, and it doesn't exactly affect
my working day for more than a few seconds, but I was curious what I
was missing that such a complete package as git had this little
internal inconsistency.

TIA,
Gareth
