From: H Krishnan <hetchkay@gmail.com>
Subject: Re: svn repository URL and git
Date: Thu, 28 Oct 2010 16:58:28 +0000 (UTC)
Message-ID: <loom.20101028T184823-831@post.gmane.org>
References: <loom.20101027T170254-268@post.gmane.org> <4CC845EE.5040602@debugon.org> <loom.20101027T180316-38@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 18:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBVoN-0003yD-Gx
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 18:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759258Ab0J1Q6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 12:58:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:51431 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253Ab0J1Q6l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 12:58:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PBVoC-0003u6-V9
	for git@vger.kernel.org; Thu, 28 Oct 2010 18:58:39 +0200
Received: from b134.fluent.co.in ([203.199.154.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 18:58:36 +0200
Received: from hetchkay by b134.fluent.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 18:58:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.199.154.134 (Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160187>


Hi,
I think I resolved this problem by using --rewrite-root as suggested. I used a 
dummy root during the git-svn clone:

git-svn clone --rewrite-root http://git.is.great <myrepo>

All my commit messages now have http://git.is.great but I am able to change the 
repository URL and continue.

Could this approach be used as an insurance against svn url changes? When 
initializing the repository, we could use --rewrite-root. Subsequently, if the 
svn repository relocates, we need to edit only .git/config. 

Thanks for your help.

Krishnan
