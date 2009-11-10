From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 14:54:43 +0000 (UTC)
Message-ID: <loom.20091110T154312-665@post.gmane.org>
References: <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com> <20091109210631.GJ27126@dpotapov.dyndns.org> <loom.20091110T093334-810@post.gmane.org> <20091110140428.GL27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 15:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7s8K-0004k3-9o
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 15:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbZKJOzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 09:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756546AbZKJOzI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 09:55:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:51251 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbZKJOzG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 09:55:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7s7i-0004S7-Ky
	for git@vger.kernel.org; Tue, 10 Nov 2009 15:55:10 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 15:55:10 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 15:55:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132571>

Dmitry Potapov <dpotapov <at> gmail.com> writes:

> And then if you really want
> to have good and clean history, you need more than just a branch. You
> should be able to amend your previous commits while you work on some
> feature. With Git, it is trivial, you just run 'git rebase -i' and may
> edit some previous commits, correct comments, squash fix-ups, etc...
> How can you model that? By creating another branch and moving patches
> to it by hands... Well, it is not very productive time spending, and
> the cost of branch becomes even more prominent.

This is a cool feature, but it contradicts to my understanding of VCS. 
It is some kind of re-writing the history of WWII :-) 
BTW, as I undestood it, it is just a feature that can be implemented 
in any VCS (if you have access to its internals).

> A quick look at "What's cooking in git.git" that Junio posted a few days
> ago reveals that there are at least 43 branches that are cooking now and
> the total number of branches that have been merged to 'master' over all
> Git history is 3290. And Git is not the largest project out there...

I meant 4-5 per person (me, precisely speaking)
