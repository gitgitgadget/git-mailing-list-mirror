From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 12:51:40 +0200
Organization: At home
Message-ID: <eha9no$5t7$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <Pine.LNX.4.64.0610190757100.3962@g5.osdl.org> <20061019161319.GA75501@over-yonder.net> <Pine.LNX.4.64.0610190948540.3962@g5.osdl.org> <Pine.LNX.4.64.0610191110290.3962@g5.osdl.org> <7vac3sru9a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 20 12:55:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gas28-0003DY-GG
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 12:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWJTKzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 06:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWJTKzP
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 06:55:15 -0400
Received: from main.gmane.org ([80.91.229.2]:5043 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161087AbWJTKzM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 06:55:12 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gas1n-00038S-0d
	for git@vger.kernel.org; Fri, 20 Oct 2006 12:55:03 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 12:55:03 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 12:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29445>

Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
>> The other big difference is being able to do merges in seconds. The 
>> biggest cost of doing a big merge these days seems to literally be 
>> generating the diffstat of the changes at the end (which is purely a UI 
>> issue, but one that I find so important that I'll happily take the extra 
>> few seconds for that, even if it sometimes effectively doubles the 
>> overhead).
> 
> An interesting effect on this is when people have a column for
> merge performance in a SCM comparison table, they would include
> time to run the diffstat as part of the time spent for merging
> when they fill in the number for git, but not for any other SCM.

So if you want to compare merge performance with other SCM, you should
either add time to run diffstat for other SCM, or substract time to
run "git diff-tree --stat".

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
