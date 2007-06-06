From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Thu, 07 Jun 2007 00:34:07 +0200
Organization: At home
Message-ID: <f47cen$hms$1@sea.gmane.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> <f427ur$ohs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 00:29:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw40D-000653-LB
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935683AbXFFW3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935669AbXFFW3J
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:29:09 -0400
Received: from main.gmane.org ([80.91.229.2]:36415 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935124AbXFFW3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:29:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hw3zr-0001b5-Ol
	for git@vger.kernel.org; Thu, 07 Jun 2007 00:28:55 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 00:28:55 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Jun 2007 00:28:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49328>

Jakub Narebski wrote:

> Bryan Childs wrote:
> 
>> 3) With a central repository, for which we have a limited number of
>> individuals having commit access, it's easy for us to automate a build
>> based on each commit the repository receives.
> 
> Check out contrib/continuous/ scripts in git repository: you would have
> to enable it only on one machine, of course.

You can also use something similar to dodoc.sh script in 'todo' branch of
git repository, which script makes some build results and saves them in
_separate_ branch of repository.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
