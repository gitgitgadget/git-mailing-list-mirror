From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Kill git-resolve.sh
Date: Sun, 24 Sep 2006 00:39:49 +0200
Organization: At home
Message-ID: <ef4d3d$7vk$2@sea.gmane.org>
References: <20060923195530.5570.23774.stgit@machine.or.cz> <7v64fensge.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 24 00:40:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRGAM-0003B7-1j
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 00:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWIWWkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWIWWkG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 18:40:06 -0400
Received: from main.gmane.org ([80.91.229.2]:61596 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750834AbWIWWkE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 18:40:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GRGAD-00039q-MU
	for git@vger.kernel.org; Sun, 24 Sep 2006 00:40:01 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 00:40:01 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 00:40:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27637>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>> Seriously, is anyone still using this thing? It's collecting dust and
>> blocking the name for something potentially useful like a tool for
>> user-friendly marking of resolved conflicts or resolving index conflicts.
>>
>> We've loved you when Git was young, now thank you and please go away. ;-)
>>
>> Signed-off-by: Petr Baudis <pasky@suse.cz>
> 
> I've always wanted to do this at some point.  Perhaps add a big
> red warning to git-resolve.sh right now and say "after the next
> 'master' release this will go away" to its stdout for a few
> weeks to find out who screams?
> 
> On a very related note, we should prepare plan to deprecate
> merge-recursive.py.  My preference is:
> 
>       (1) rename merge-recursive.py to merge-recursive-old.py,
>           make it available as "recursive-old" strategy.
> 
>             install git-merge-recur as git-merge-recursive.
>             Calling for "recur" or "recursive" strategy gets the
>             same thing from this point on.
> 
>       (2) remove merge-recur synonym once people who are using
>             "USE_RECUR_FOR_RECURSIVE" or "merge.twohead = recur"
>             to use the bleeding edge migrate.
> 
> and I think step (1) can happen fairly soon.  Maybe immediately
> after the next release from the "master".
> 
> Perhaps that is the good timing to remove git-resolve.sh as
> well.  Or maybe immediately before that release?  I dunno, and I
> do not think anybody cares really much.

On the fairly unrelated note, would the next release be 1.4.3, or would it
be 1.5.0 (the packed refs, the new index format, ...)?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
