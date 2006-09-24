From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 01:04:41 +0200
Organization: At home
Message-ID: <ef72ts$dk9$2@sea.gmane.org>
References: <20060924212142.GB20017@pasky.or.cz> <8aa486160609241457u40fffdd8h298e44351749bb29@mail.gmail.com> <20060924221644.GE13132@pasky.or.cz> <8aa486160609241534yc78b194g64038fe22048c443@mail.gmail.com> <20060924224017.GC20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 25 01:05:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRd23-0007aY-6Q
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 01:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWIXXEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 19:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWIXXEn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 19:04:43 -0400
Received: from main.gmane.org ([80.91.229.2]:8100 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751671AbWIXXEm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 19:04:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRd1c-0007Vl-AP
	for git@vger.kernel.org; Mon, 25 Sep 2006 01:04:40 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:04:40 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:04:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27712>

Petr Baudis wrote:

> Dear diary, on Mon, Sep 25, 2006 at 12:34:24AM CEST, I got a letter
> where Santi <sbejar@gmail.com> said that...
>> It could be I'm wrong (for sure, I miss something), but I see the
>> branches/ files like [remote] sections files with just one fetch:
>> 
>> .git/branches/git:
>> git://...../git.gi
>> 
>> would be:
>> 
>> [remote "git"]
>> url=git://...../git.git
>> fetch=refs/heads/master:refs/heads/git
> 
> That's basically right, the point is that with moving to remotes
> support, we will make each remote live in its own separate namespace,

Which is overkill if we fetch only from one directory. Besides using
separate remotes (hmmm, we should add support for refs/remotes/ in gitweb)
is a policy decision.

On somewhat unrelated issue: should git-clone create [remote] section
(and perhaps [branch] sections) instead of remotes file?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
