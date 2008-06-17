From: Eric Raible <raible@gmail.com>
Subject: Incorrect default for git stash?
Date: Tue, 17 Jun 2008 22:21:23 +0000 (UTC)
Message-ID: <loom.20080617T220852-922@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 00:22:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8jZL-0002OV-L9
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667AbYFQWVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758397AbYFQWVc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:21:32 -0400
Received: from main.gmane.org ([80.91.229.2]:36782 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757981AbYFQWVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:21:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K8jYQ-0000Yi-OB
	for git@vger.kernel.org; Tue, 17 Jun 2008 22:21:30 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 22:21:30 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 22:21:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85333>

Does it bother anyone else that the default for
git stash is inconsistent with branch & tag?

git branch -> list branches
git tag    -> list tags
git stash  -> create a stash

I understand that branches & tags must explicitly named
and that stashes are by default automatically named.

But wouldn't it be less surprising to me if the default
was 'list' instead of 'save'?

- Eric
