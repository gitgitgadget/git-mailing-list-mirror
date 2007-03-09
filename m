From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Fri, 09 Mar 2007 15:41:02 +0100
Organization: At home
Message-ID: <esrrh3$rmb$1@sea.gmane.org>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org> <Pine.LNX.4.63.0703081755500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 16:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPgdL-00015p-Ii
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 16:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbXCIPDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 10:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbXCIPDr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 10:03:47 -0500
Received: from main.gmane.org ([80.91.229.2]:59539 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529AbXCIPDq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 10:03:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HPgTq-0001Za-5I
	for git@vger.kernel.org; Fri, 09 Mar 2007 15:54:03 +0100
Received: from host-81-190-29-212.torun.mm.pl ([81.190.29.212])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 15:54:02 +0100
Received: from jnareb by host-81-190-29-212.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 15:54:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-212.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41796>

Johannes Schindelin wrote:

> On Thu, 8 Mar 2007, Linus Torvalds wrote:
> 
>> On Thu, 8 Mar 2007, Junio C Hamano wrote:
>>> 
>>> Not so.  "git shortlog" acts as a filter when no revs are given, 
>>> unlike "git log" which defaults to HEAD.  It was reading from its 
>>> standard input.
>> 
>> Could we just change that?
>>
>> [...]
>> 
>> Yeah, as a filter it *can* stil lbe useful, of course, but I suspect the 
>> usefullness is limited.
> 
> How about something totally different: "git log --shortlog". I.e.

Or have old filter behavior only with "git shortlog --stdin" option?
Perhaps in git 1.5.1...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
