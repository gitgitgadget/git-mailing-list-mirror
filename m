From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 08:31:48 +0000 (UTC)
Message-ID: <loom.20091110T092404-595@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <20091109183404.GI27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 09:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7m9G-00054i-5x
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 09:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZKJIcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 03:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbZKJIcJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 03:32:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:44831 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbZKJIcI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 03:32:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7m96-00051z-Hw
	for git@vger.kernel.org; Tue, 10 Nov 2009 09:32:12 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 09:32:12 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 09:32:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132550>

Dmitry Potapov <dpotapov <at> gmail.com> writes:
 
> Yes, but then I do not see any reason to do any time consuming building
> and testing in the working tree. I create a snapshot of the interesting
> version using 'git archive' and then run build&test on it... In this
> way, I can make sure that the archive I deliver is tested properly. If
> you do your testing in the working tree, sometimes uncommitted or some
> other files that are left over from previous builds may affect result.
> So, if it takes considerable time anyhow, why do not do clean build and
> test? And if you worry about compilation time, you can use ccache.

It is not clear for me. Yes, I have to get some fixed version to reproduce
the bug reported by someone. Then I need to fix it and commit the change 
back (on the head). Also, it is obvious to reproduce the issue and 
test the fix on the tip. Can do this with 'git archive'?
BTW, doesn't 'git archive' sync to some version that I probably already 
have in other clone? ;-)
