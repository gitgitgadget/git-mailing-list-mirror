From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 18:48:17 +0200
Organization: At home
Message-ID: <ec4r0h$u9m$1@sea.gmane.org>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> <44E5ED82.8090904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 18 18:49:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7X4-0007mN-AW
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 18:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWHRQtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 12:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWHRQtO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 12:49:14 -0400
Received: from main.gmane.org ([80.91.229.2]:53228 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161042AbWHRQtN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 12:49:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE7Wb-0007ek-95
	for git@vger.kernel.org; Fri, 18 Aug 2006 18:48:49 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 18:48:49 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 18:48:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25677>

Aneesh Kumar K.V wrote:

> Junio C Hamano wrote:
> 
>> * Jeff Garzik reports that the summary page of gitweb does not
>>   look at anything other than "master" which is not appropriate
>>   for his tree.
>> 
>>   Message-ID: <44D874F0.6000907@garzik.org>
>> 
>>   I probably should bug gitweb gang (Jakub, Luben, Martin Waitz,
>>   Aneesh) about this.
> 
> I just tried editing HEAD. For the project 
> 
> http://git.openssi.org/~kvaneesh/gitweb.cgi?p=ci-to-linus.git;a=summary
> 
> $more HEAD
> ref: refs/heads/from-linus
> $
> 
> Is this solution fine ?. Or do we want to add a git-rep-config 
> variable to indicate which branch to show. 

Err, of course gitweb shows "Last Change" for HEAD, which usually is master.
The solution would be to show "Last Change" date to be the date of last
change of all/any branch.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
