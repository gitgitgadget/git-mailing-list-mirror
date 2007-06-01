From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Breaking up repositories
Date: Fri, 01 Jun 2007 12:25:29 +0200
Organization: At home
Message-ID: <f3orsv$97l$1@sea.gmane.org>
References: <465EEF96.6050307@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 12:20:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu4FL-0004yy-SR
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 12:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044AbXFAKUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 06:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758117AbXFAKUa
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 06:20:30 -0400
Received: from main.gmane.org ([80.91.229.2]:50378 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758044AbXFAKU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 06:20:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hu4F6-0001jp-Ab
	for git@vger.kernel.org; Fri, 01 Jun 2007 12:20:24 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 12:20:24 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 12:20:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48864>

Josh Triplett wrote:
> Jason Sewall wrote:

>> I recently imported my subversion repo with git-svn and I'm curious
>> what the best way to break up the monolithic repo (my many disparate
>> projects from my single svn repo) into individual git repos of their
>> own.
> 
> In the specific case of git-svn, you can probably give git-svn the
> appropriate paths to import each project separately; that may do what you
> want, depending on your repository layout.
> 
> In the general case, if you want to split a subtree of a git repo into a git
> repo, you want git-split, by Jamey Sharp and I:
> <http://people.freedesktop.org/~jamey/git-split>
> From a copy of the git repo you want to split, just run "git-split subdir",
> optionally with a newest and oldest commit, and it will output the sha1 of
> the new top commit for use as the new branch ref.  Remove all other
> branches, reflogs, and other references to the old commits, and use prune
> or gc to get rid of old objects.  Repeat as desired for other subdirs.

I have added info about git-split to Git Wiki
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

Please improve this information, and correct if it is wrong.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
