From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using the --track option when creating a branch
Date: Fri, 31 Oct 2008 00:24:12 +0100
Organization: At home
Message-ID: <gedfmt$q9c$1@ger.gmane.org>
References: <18696.32778.842933.486171@lisa.zopyra.com> <1225343538.10803.9.camel@maia.lan> <18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se> <2008-10-30-15-23-16+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 00:25:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvgtf-0005h0-9C
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 00:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbYJ3XYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 19:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbYJ3XYd
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 19:24:33 -0400
Received: from main.gmane.org ([80.91.229.2]:41710 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbYJ3XYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 19:24:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KvgsJ-0004Eq-Aq
	for git@vger.kernel.org; Thu, 30 Oct 2008 23:24:23 +0000
Received: from abvo7.neoplus.adsl.tpnet.pl ([83.8.212.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:24:23 +0000
Received: from jnareb by abvo7.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:24:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvo7.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99532>

[Cc: Samuel Tardieu <sam@rfc1149.net>, Andreas Ericsson <ae@op5.se>,
     git@vger.kernel.org]

Samuel Tardieu wrote:
> * Andreas Ericsson <ae@op5.se> [2008-10-30 15:06:16 +0100]
> 
>> --all pushes all refs, even the non-matching ones, which is very
>> rarely desirable and only accidentally sometimes the same as "push all
>> matching refs".
>>
>>> I know that I've never had the intent to push all the refs without
>>> thinking about it first. Most of the time, I intend to push only
>>> the current branch I am in.
>>
>> Then say so. There's a very simple command syntax for it:
>> "git push <remote> <current-branch>"
> 
> I update the branches I'm working in maybe 20 times a day, sometimes
> more. When I make a change and all the tests pass, I prefer to call
> 
>   git push
> 
> rather than
> 
>   git push origin 2.0-beta1
> 
> (and "2.0-beta1" is a short name here, some branches have much longer
> names)

You can use

  $ git push origin HEAD

and I think (but I am not sure) that there is DWIM-mery allowing
to simply say

  $ git push HEAD

and it would use configured branch.$(git symbolic-ref HEAD).remote


And if it is not as I said, the patches would better made it so, instead of
changing default behavior from push matching refspecs to push current
branch only.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
