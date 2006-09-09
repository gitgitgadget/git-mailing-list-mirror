From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sat, 09 Sep 2006 10:39:37 +0200
Organization: At home
Message-ID: <edtuj5$p76$1@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net> <46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com> <7vac5ancvo.fsf@assigned-by-dhcp.cox.net> <9e4733910609080720s7a143d9bp5a1dd36869967c22@mail.gmail.com> <eds3fg$u30$1@sea.gmane.org> <20060909031307.GE23891@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 09 10:39:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLyNJ-0006tw-RP
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 10:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWIIIj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 04:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWIIIj1
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 04:39:27 -0400
Received: from main.gmane.org ([80.91.229.2]:33194 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932370AbWIIIj0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 04:39:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLyMt-0006qL-TV
	for git@vger.kernel.org; Sat, 09 Sep 2006 10:39:16 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 10:39:15 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 10:39:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26737>

Petr Baudis wrote:

> Dear diary, on Fri, Sep 08, 2006 at 05:50:40PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> My idea for lazy clone/fetch (lazy = on-demand) is via remote alternatives
>> mechanism. We put URI for repository (repositories) that hosts the project,
>> and we would need at start to download at least heads and tags, and only
>> heads and tags.
> 
>   One thing to note is that you won't last very long without getting
> at least basically all the commits from the history. git log, git
> merge-base and such would either just suck them all, get partially moved
> to the server side, or would undergo quite a painful and slooooooooow
> process "get me commit X... thank you, sir. hmm, it appears that its
> parent is commit Y.  could you get me commit Y, please...? thank you,
> sir. hmm, it appears...".

As I said there is load of troubles with lazy clone/fetch = remote 
alternatives I didn't thought about.

git log/git rev-list and git fsck-objects among them.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
