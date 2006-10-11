From: Pazu <pazu@pazu.com.br>
Subject: core-git and porcelains
Date: Wed, 11 Oct 2006 11:39:08 -0300
Message-ID: <egivn8$5mf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 11 16:59:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXfWs-0004HE-2E
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 16:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWJKO5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 10:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWJKO5f
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 10:57:35 -0400
Received: from main.gmane.org ([80.91.229.2]:48608 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161066AbWJKO5e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 10:57:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXfO0-00015k-TM
	for git@vger.kernel.org; Wed, 11 Oct 2006 16:48:44 +0200
Received: from 201.37.98.50 ([201.37.98.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 16:48:44 +0200
Received: from pazu by 201.37.98.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 16:48:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 201.37.98.50
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28717>

I'm a newcomer to git, and for the last few days, I've been struggling 
to learn how to better use git in my day to day. One particular thing 
that has been puzzling me is how much git is self-sufficient, and how 
much I should depend on porcelains.

Apparently, I'm not alone in this: 
http://thread.gmane.org/gmane.comp.version-control.git/6194/focus=6194

The above post was made about three months ago; where things stand now? 
Do you feel that git-core should suffice for most developers, or should 
I really look into something like Cogito?

Depending on the project, my git usage would fit one of two profiles. I 
run some standalone projects, where I'm the sole developer. I was 
looking into using cogito for this scenario, but one thing that baffled 
me is how git-core and cogito use different branch representations.

For the larger part of my day, however, I'm looking into using git as a 
personal tool in a very large corporate project; This project is 
currently controlled using subversion, and my idea is to use git as a 
'staging' system, where I work (possibly offline) before pushing changes 
to the upstream (remote, slow as hell) subversion repository. Here, 
git-svn seems to be my best friend.

Any advice to this poor newbie?

-- Marcus
