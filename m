From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 08:51:53 +0000 (UTC)
Message-ID: <loom.20091110T093334-810@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com> <20091109210631.GJ27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 09:52:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7mSe-0004He-9L
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 09:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbZKJIwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 03:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbZKJIwM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 03:52:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:49128 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbZKJIwL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 03:52:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7mSV-0004FN-Bc
	for git@vger.kernel.org; Tue, 10 Nov 2009 09:52:15 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 09:52:15 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 09:52:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132551>

Dmitry Potapov <dpotapov <at> gmail.com> writes:

> With many other VCS, a typical policy is that you do not commit your
> changes unless you have finished and tested them. But it means that
> your changes are not committed and stored only in the work tree for
> a long time. Moreover, when you eventually decide that they are good
> enough to commit, you will produce a huge patch, which will be difficult
> to review or to bisect history later.

oh, yes. but this is just a policy. You can make your changes on your 
branch and commit them (for example, for review). Later someone just 
need to integrate it on original branch. The same as with Git, 
isn't it? The problem is just a price to branch.
BTW, once I started to talk about review, we can see that most 
"benefits" of DVCS go away... Just because you still need some 
central storage to save the record of this review that should 
be available for SQA later...
 
> So, you can always commit your changes as your progress to your goal and
> review amend them later before publishing. This means that you can have
> as many work-in-progress branches as you wish, and you do not need a
> separate work tree for each of them -- everything can be stored in the
> repository, and you can go to another computer, issue 'git fetch' and
> continue your work at the exact point where you left it. So, it is very
> flexible.

As for me, I would not to have more than 4-5 such deferred changes in the same 
repository. Otherwise, I will be entangled finally :-)
