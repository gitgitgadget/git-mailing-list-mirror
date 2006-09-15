From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bare repositories: packing and fetching
Date: Fri, 15 Sep 2006 20:11:41 +0200
Organization: At home
Message-ID: <eeeqbv$8na$1@sea.gmane.org>
References: <450AEB37.3090909@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 15 20:12:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOIAl-00037N-Ru
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 20:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWIOSMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 14:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWIOSMQ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 14:12:16 -0400
Received: from main.gmane.org ([80.91.229.2]:46782 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751341AbWIOSMP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 14:12:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOIAG-0002yZ-Se
	for git@vger.kernel.org; Fri, 15 Sep 2006 20:11:48 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 20:11:48 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 20:11:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27095>

Andy Whitcroft wrote:

> I was trying to make a bare repo to stage linus' main tree.  As this was
> only to be a local tree for others to pull from I thought that I could
> clone his tree 'bare' and then fetch into that on a regular basis.  That
> does not appear to be the case?  Both git fetch and git repack say 'not
> a git repository .git' and bail.
> 
> Is this expected behaviour.  Do I have to have all the checked out files?

No, but perhaps git doesn't detect _where_ is a git repository. With full
repository git tries to find .git somewhere in the directory, or it's
parents, if I understand correctly.

If running git commands from the inside of bare repository doesn't work, try
setting enviromental variable GIT_DIR (e.g. GIT_DIR=git.git git fetch
origin), or with git 1.4.2 or newer with --git-dir option (e.g. git
--git-dir=git fetch origin).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
