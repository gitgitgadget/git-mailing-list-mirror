From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 18:24:25 +0200
Organization: At home
Message-ID: <ehat7i$mua$1@sea.gmane.org>
References: <aaron.bentley@utoronto.ca> <200610201728.13327.jnareb@gmail.com> <Pine.LNX.4.63.0610201736440.14200@wbgn013.biozentrum.uni-wuerzburg.de> <200610201805.40235.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Fri Oct 20 18:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaxBP-0004VR-O4
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 18:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWJTQZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 12:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWJTQZP
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 12:25:15 -0400
Received: from main.gmane.org ([80.91.229.2]:390 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932273AbWJTQZO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 12:25:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GaxAz-0004Q1-1q
	for git@vger.kernel.org; Fri, 20 Oct 2006 18:24:53 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 18:24:53 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 18:24:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29503>

Jakub Narebski wrote:

> Johannes Schindelin wrote:
>> On Fri, 20 Oct 2006, Jakub Narebski wrote:
>>> Johannes Schindelin wrote:
>>>> On Fri, 20 Oct 2006, Jakub Narebski wrote:
>>>> 
>>>>> Christian MICHON wrote:
>>>>> 
>>>>>> - git is the fastest scm around
>>>>> 
>>>>> Mercurial also claims that.
>>>> 
>>>> Funny. When you type in "mercurial" and "benchmark" into Google, the 
>>>> _first_ hit is into "git Archives: Mercurial 0.4b vs git patchbomb 
>>>> benchmark". Performed by the good Mercurial people.
>>>> 
>>>> Leaving git as winner.
>>>  
>>> Check out http://git.or.cz/gitwiki/GitBenchmarks section "Quilt import 
>>> comparison of Git and Mercurial" for the latest (OLS2006) benchmark
>>> by Mercurial.
>> 
>> Thanks for the hint!
>> 
>> BTW the tests in Clone/status/pull make sense, especially the "4 times 
>> slower on pull/merge". In my tests, merge-recur (the default merge 
>> strategy, which was written in Python, and is now in C) was substantially 
>> faster.
> 
> As it was mentioned somewhere else in this thread, to compare times
> for pull/merge in git with other SCM one should in principle substract
> time for diffstat/git diff --stat.

Or as reminded, use -n, --no-summary option to git pull.

BTW. I'd rather have -n == --no-commit for git pull...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
