From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 22:14:42 +0100
Organization: At home
Message-ID: <eojf73$1f4$1@sea.gmane.org>
References: <45AC3B5D.6080700@midwinter.com> <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com> <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD383E.50105@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 16 22:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6vda-00048T-U8
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 22:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbXAPVOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 16:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbXAPVOb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 16:14:31 -0500
Received: from main.gmane.org ([80.91.229.2]:57353 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbXAPVOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 16:14:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H6vdM-0001A2-9b
	for git@vger.kernel.org; Tue, 16 Jan 2007 22:14:20 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 22:14:20 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 22:14:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36965>

Steven Grimm wrote:

> Johannes Schindelin wrote:
>> That is correct, but --ignore-if-in-upstream actually tests the hash of 
>> the _diff_, not of the commit. So, if c really introduces the same change 
>> as f (i.e. the diffs are identical), git-rebase will ignore f:
>>
>> a---b---c---d
>>              \
>>               e'---g'
>>
>> Totally untested, of course. But this is what --ignore-if-in-upstream was 
>> written for.
>>   
> 
> Okay, great, that is certainly an improvement over what I thought was 
> happening. But it won't work if you had to manually resolve a conflict 
> during the rebase, yes? In that case the diffs would presumably not match.

Then git-rerere would help, I think.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
