From: Felix Natter <fnatter@gmx.net>
Subject: git repack vs git gc --aggressive
Date: Tue, 07 Aug 2012 20:22:21 +0200
Message-ID: <87zk66r28y.fsf@bitburger.home.felix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 20:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyoQQ-0005dl-NK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 20:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab2HGSWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 14:22:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:58216 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab2HGSWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 14:22:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SyoQK-0005SR-5e
	for git@vger.kernel.org; Tue, 07 Aug 2012 20:22:32 +0200
Received: from pd9e84d31.dip.t-dialin.net ([217.232.77.49])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 20:22:32 +0200
Received: from fnatter by pd9e84d31.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 20:22:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e84d31.dip.t-dialin.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Cancel-Lock: sha1:GgLIpEXuIf9Wbpo1bAI3VQaxQjg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203033>

hello,

I read this:
  http://metalinguist.wordpress.com/2007/12/06/the-woes-of-git-gc-aggressive-and-how-git-deltas-work/
where
  git repack -a -d --depth=250 --window=250
is mentioned as a (recommended) alternative to git gc --aggressive.

I am a bit confused, because the page also mentions that git gc --aggressive
is recommended when a repo has been imported using git fast-import.

So my questions are:

1. is the above repack command (with --depth=500) safe? Of course I want
   to be absolutely sure that our repo will be consistent.
   Do I need another command ("git gc", "git prune") as well?

2. is it the right tool for the job or shall I use git gc --aggressive?

Thanks!
-- 
Felix Natter
