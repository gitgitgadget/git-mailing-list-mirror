From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document git-filter-branch
Date: Wed, 11 Jul 2007 18:53:29 +0200
Organization: At home
Message-ID: <f731u9$1ir$1@sea.gmane.org>
References: <Pine.LNX.4.64.0707031746400.4071@racer.site> <20070703220540.GN12721@planck.djpig.de> <Pine.LNX.4.64.0707040004200.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 18:53:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8fRf-0006xD-8z
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 18:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbXGKQxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 12:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbXGKQxj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 12:53:39 -0400
Received: from main.gmane.org ([80.91.229.2]:54061 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbXGKQxj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 12:53:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8fRY-0002WU-0Q
	for git@vger.kernel.org; Wed, 11 Jul 2007 18:53:36 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 18:53:36 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 18:53:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52175>

[Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Frank Lichtenheld <frank@lichtenheld.de>]

Johannes Schindelin wrote:
> On Wed, 4 Jul 2007, Frank Lichtenheld wrote:

>>> +Note that since this operation is extensively I/O expensive, it might
>>> +be a good idea to redirect the temporary directory it off-disk, e.g. on

By the way, could git-filter-branch use git-fast-import to reduce I/O?

>>> +the id of the commit being rewritten.  The author/committer environment
>>> +variables are set before the first filter is run.
>> 
>> Maybe give the actual names of the environment variables here?
> 
> If you think so:
> 
>       Also, GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, 
>       GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE is 
>       set according to the current commit.

Or

        Also, GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, 
        GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE  
        are filled with data taken from the current commit. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
