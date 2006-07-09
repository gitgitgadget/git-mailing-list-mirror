From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Sun, 09 Jul 2006 19:04:32 +0200
Organization: At home
Message-ID: <e8rcu5$je5$2@sea.gmane.org>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com> <e8p8pj$jk3$2@sea.gmane.org> <Pine.LNX.4.63.0607090011000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jul 09 19:04:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzci1-0004KW-OR
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 19:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWGIREb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 13:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGIREb
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 13:04:31 -0400
Received: from main.gmane.org ([80.91.229.2]:2749 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964863AbWGIREa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 13:04:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fzche-0004H6-N1
	for git@vger.kernel.org; Sun, 09 Jul 2006 19:04:18 +0200
Received: from host-81-190-31-220.torun.mm.pl ([81.190.31.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Jul 2006 19:04:18 +0200
Received: from jnareb by host-81-190-31-220.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 09 Jul 2006 19:04:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-220.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23560>

Johannes Schindelin wrote:


> On Sat, 8 Jul 2006, Jakub Narebski wrote:
> 
>> moreau francis wrote:
>> 
>>> Would it be possible to let the user stick a short explanation
>>> on  what a branch is supposed to implement during its creation.
>> 
>> It would be possible when/if branch and remotes config would migrate
>> to .git/config. Currently too many I think relies on refs/heads being
>> simple sha1 of "top" commit.
> 
> But it does not need a change of existing practice at all! Just add the 
> information provided by --topic as branch."pathname".description to the 
> config. And make format-patch aware of that.

And make tools remove stale descriptions. I sometimes rename branches "by
hand", as currently there is I think no tool for this...

By the way, did this series of patches (adding support for branch and
remotes configuretion to config file) made into 'next', 'master' or even
'pu', or after some discussion it stalled?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
