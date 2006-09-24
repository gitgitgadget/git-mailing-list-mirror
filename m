From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 01:40:26 +0200
Organization: At home
Message-ID: <ef750s$jg4$1@sea.gmane.org>
References: <20060924212142.GB20017@pasky.or.cz> <8aa486160609241457u40fffdd8h298e44351749bb29@mail.gmail.com> <20060924221644.GE13132@pasky.or.cz> <8aa486160609241534yc78b194g64038fe22048c443@mail.gmail.com> <20060924224017.GC20017@pasky.or.cz> <ef72ts$dk9$2@sea.gmane.org> <20060924231108.GE20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 25 01:40:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRdaG-00058J-Hv
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 01:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWIXXkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 19:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWIXXkY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 19:40:24 -0400
Received: from main.gmane.org ([80.91.229.2]:30904 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751381AbWIXXkX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 19:40:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRda6-00056n-5o
	for git@vger.kernel.org; Mon, 25 Sep 2006 01:40:18 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:40:18 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:40:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27718>

Petr Baudis wrote:

> Dear diary, on Mon, Sep 25, 2006 at 01:04:41AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> Petr Baudis wrote:
>> 
>> > Dear diary, on Mon, Sep 25, 2006 at 12:34:24AM CEST, I got a letter
>> > where Santi <sbejar@gmail.com> said that...
>> >> It could be I'm wrong (for sure, I miss something), but I see the
>> >> branches/ files like [remote] sections files with just one fetch:
>> >> 
>> >> .git/branches/git:
>> >> git://...../git.gi
>> >> 
>> >> would be:
>> >> 
>> >> [remote "git"]
>> >> url=git://...../git.git
>> >> fetch=refs/heads/master:refs/heads/git
>> > 
>> > That's basically right, the point is that with moving to remotes
>> > support, we will make each remote live in its own separate namespace,
>> 
>> Which is overkill if we fetch only from one directory.
> 
> Why?

s/directory/repository/ of course. And as of why: I'd rather have 'next',
'maint, 'html', 'man' in main namespace (with 'origin' substituting
'master') instead of remotes/origin/next etc.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
