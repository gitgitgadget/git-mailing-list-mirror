From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [PATCH 2/3] Fixes bug: git-svn: svn.pathnameencoding is =?utf-8?b?bm90CXJlc3BlY3RlZA==?= with dcommit/set-tree
Date: Thu, 3 Feb 2011 20:28:34 +0000 (UTC)
Message-ID: <loom.20110203T212349-287@post.gmane.org>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-2-git-send-email-zapped@mail.ru> <201101041818.09365.trast@student.ethz.ch> <20110104232029.GA15889@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 21:28:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl5nR-0003dh-KW
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 21:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab1BCU2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 15:28:48 -0500
Received: from lo.gmane.org ([80.91.229.12]:47371 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831Ab1BCU2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 15:28:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pl5nK-0003aQ-Cu
	for git@vger.kernel.org; Thu, 03 Feb 2011 21:28:46 +0100
Received: from ppp85-140-55-146.pppoe.mtu-net.ru ([85.140.55.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 21:28:46 +0100
Received: from zapped by ppp85-140-55-146.pppoe.mtu-net.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 21:28:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.140.55.146 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.237 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165995>

Eric Wong <normalperson <at> yhbt.net> writes:

> 
> Thomas Rast <trast <at> student.ethz.ch> wrote:
> > Zapped wrote:
> > > git-svn dcommit/set-tree fails when svn.pathnameencoding is set for native 
OS encoding (e.g. cp1251
> for Windows) though git-svn fetch/clone works well
> > 
> > I'll let Eric judge whether loading the encoding here is the right
> > fix, but here too the commit message states only what is broken, not
> > why you fixed it that way.  Can you elaborate a bit?
> > 
> > Also, this should be easy to cover with a test case, can you make one?
> 
> I second Thomas's requests.  I'm also a bit disappointed the original
> option is missing tests, especially since not many people are likely to
> use it.
> 

Yes, I remember that, sorry, but I just have no enough time to get
into git tests and make my own ones.
