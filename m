From: Christoph Jahn <christoph.jahn@gmx.de>
Subject: Re: Linking multiple Git repositories for version tracking
Date: Sun, 10 Jan 2010 08:12:47 +0000 (UTC)
Message-ID: <hic25v$17i$1@ger.gmane.org>
References: <op.u573txvdn3qeew@klee> <op.u574cwxqn3qeew@klee>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 09:31:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTtCn-0001sv-OX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 09:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab0AJIaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 03:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139Ab0AJIaJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 03:30:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:35614 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab0AJIaI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 03:30:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NTtBV-0001TN-AE
	for git@vger.kernel.org; Sun, 10 Jan 2010 09:30:05 +0100
Received: from frnk-d9331fc4.pool.mediaways.net ([217.51.31.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 09:30:05 +0100
Received: from christoph.jahn by frnk-d9331fc4.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 09:30:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: frnk-d9331fc4.pool.mediaways.net
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136563>

I have had the very same issue a while ago when still using SVN (shame on 
me ;-). SVN offers a special tag "svn:externals" which is something like 
symlinks. Having used it for a while I came to the conclusion that such a 
thing, as well-intentioned as it may be, is something I want to avoid by 
all means.

There are two reasons for that:
- Lock-in
- It is conceptually wrong

The conceptual part -which I consider to be more important- is mostly 
about the fact that we are talking about dependency management and not 
version control any more. Do I really want to "hide" dependencies inside 
the VCS? Also, there may be different dependencies for compilation and 
testing. That's why I chose to use Maven for this task.

My $0.02

-- 
Best regards,
Christoph
