From: H Krishnan <hetchkay@gmail.com>
Subject: Re: svn repository URL and git
Date: Fri, 29 Oct 2010 03:07:36 +0000 (UTC)
Message-ID: <loom.20101029T045420-973@post.gmane.org>
References: <loom.20101027T170254-268@post.gmane.org> <4CC845EE.5040602@debugon.org> <loom.20101027T180316-38@post.gmane.org> <loom.20101028T184823-831@post.gmane.org> <20101028190227.GC46314@acme.spoerlein.net> <4CC9CF86.7040307@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 05:07:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBfJo-0007Af-9c
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 05:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760239Ab0J2DHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 23:07:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:58795 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760134Ab0J2DHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 23:07:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PBfJg-00077Z-Dd
	for git@vger.kernel.org; Fri, 29 Oct 2010 05:07:44 +0200
Received: from b134.fluent.co.in ([203.199.154.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 05:07:44 +0200
Received: from hetchkay by b134.fluent.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 05:07:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.199.154.134 (Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160264>

Hi,
Would the following approach for svn switch --relocate 
(even for current git clones):

1)If svn-remote.svn.rewriteRoot does not exist in config file:
    git config svn-remote.svn.rewriteRoot <currentRepository>

2)If svn-remote.svn.rewriteUUID does not exist in config file:
    git config svn-remote.svn.rewriteUUID <currentRepositoryUUID>
 
  currentRepositoryUUID can be obtained from .git/svn/metadata

3) git config svn-remote.svn.url <newRepository>

If the above works, it would be much simpler than other solutions 
that have been proposed for svn repo relocations.

Krishnan
