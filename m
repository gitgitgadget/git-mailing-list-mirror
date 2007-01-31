From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More precise tag following
Date: Wed, 31 Jan 2007 18:35:47 +0100
Organization: At home
Message-ID: <epqjv2$19h$1@sea.gmane.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org> <87bqkf1tey.fsf@morpheus.local> <m3abzz6upz.fsf@localhost.localdomain> <87y7nj161j.fsf@morpheus.local> <m364an6rxp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 18:36:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCJMr-0004sD-RI
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 18:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbXAaRfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 12:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbXAaRfF
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 12:35:05 -0500
Received: from main.gmane.org ([80.91.229.2]:59880 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030446AbXAaRfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 12:35:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCJM4-0004sg-DS
	for git@vger.kernel.org; Wed, 31 Jan 2007 18:34:44 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 18:34:44 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 18:34:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38281>

Peter Eriksen wrote:
> David K?gedal <davidk@lysator.liu.se> writes:
>> Peter Eriksen <s022018@student.dtu.dk> writes:
>> 
>>> David K?gedal <davidk@lysator.liu.se> writes:
>>>
>>>> Usage instructions:  Open a file and type M-x git-blame-mode
>>>> 
>>>> ;;; git-blame.el
>>>
>>> I saved the elisp code in a file .emacs.d/git-blame.el, and loaded it
>>> with M-x load-file.  Then I visited git/cache.h, and typed M-x
>>> git-blame-mode, but the background colours did not change.  What did I
>>> forget to do?

I always used M-x load-library, not M-x load-file...
 
>> Probably you forgot to use the latest version :-)
>> 
>> See my mail with the subject line "git-blame.el".
> 
> I saw that mail just after I responded.  The newest version does not
> work either, that is, it does not work in the same way, as the old
> version.  Closing Emacs I can see, that Emacs did fork of "git blame"
> processes.  So it is just the colours, I cannot see.

Do you use new enough version of git, one which has git-blame --incremental?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
