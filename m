From: Maaartin <grajcar1@seznam.cz>
Subject: Folding commits together
Date: Wed, 22 Sep 2010 10:51:43 +0000 (UTC)
Message-ID: <loom.20100922T123419-101@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 12:52:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyMve-0007i3-G6
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 12:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab0IVKvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 06:51:53 -0400
Received: from lo.gmane.org ([80.91.229.12]:32774 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab0IVKvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 06:51:52 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OyMvW-0007f8-Sg
	for git@vger.kernel.org; Wed, 22 Sep 2010 12:51:51 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 12:51:50 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 12:51:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.61)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156796>

I've made a couple of trivial commits I'd like to fold into a single commit now. 
In the manpage of git-rebase I saw a recipe how to do it using rebase -i and it 
seemed quite trivial, but it doesn't work for me. I'm in a clean state on branch 
master and want fold the last 3 commits into one - this is probably the most 
trivial use case. Whatever I try I get an empty .git/rebase-merge/git-rebase-
todo, so I can't get to the point of using <<If you want to fold two or more 
commits into one, replace the command "pick" for the second and subsequent 
commits with "squash" or "fixup".>>
