From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 17:45:26 +0200
Organization: At home
Message-ID: <ee9925$6cp$1@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 17:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNWwf-00049i-Ob
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 17:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWIMPqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 11:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWIMPqX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 11:46:23 -0400
Received: from main.gmane.org ([80.91.229.2]:8884 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750965AbWIMPqW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 11:46:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNWw0-0003zy-TS
	for git@vger.kernel.org; Wed, 13 Sep 2006 17:45:56 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 17:45:56 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 17:45:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26916>

Johannes Schindelin wrote:
> On Wed, 13 Sep 2006, Petr Baudis wrote:
> 
>> Dear diary, on Wed, Sep 13, 2006 at 05:17:59PM CEST, I got a letter
>> where Jon Smirl <jonsmirl@gmail.com> said that...
>> > Abandoned branches are common in CVS since it is not distributed.
>> > People start working on something in the main repo and then decide it
>> > was a bad idea. In the git world these branches usually don't end up
>> > in the main repo.
>> 
>> Can't you just toss the branch away in that case? :-)
>> 
>> You could also stash the ref to refs/heads-abandoned/ instead of
>> refs/heads/ if you want to keep the junk around for some reason. Of
>> course you don't get the nice marker with explanation of why is this
>> abandoned and who decided that, but you can just use an empty commit for
>> the same purpose.
> 
> ... or a tag (remember, you can stash a tag into refs/abandoned/, instead 
> of a commit) with the further benefit that you really cannot commit on top 
> of that.

Or refs/Attic/ ;-)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
