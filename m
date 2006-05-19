From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Fri, 19 May 2006 21:00:00 +0200
Organization: At home
Message-ID: <e4l4j1$vkq$1@sea.gmane.org>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth> <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org> <7viro3nh07.fsf@assigned-by-dhcp.cox.net> <20060518222045.GB6535@nowhere.earth> <20060518225216.GC6535@nowhere.earth> <7vsln7lzbj.fsf@assigned-by-dhcp.cox.net> <20060519185558.GE6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 19 21:00:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhACt-0002po-TT
	for gcvg-git@gmane.org; Fri, 19 May 2006 21:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWESTAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWESTAL
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 15:00:11 -0400
Received: from main.gmane.org ([80.91.229.2]:16781 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932468AbWESTAJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 15:00:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FhACc-0002kr-D1
	for git@vger.kernel.org; Fri, 19 May 2006 20:59:58 +0200
Received: from 212-87-13-71.sds.uw.edu.pl ([212.87.13.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 May 2006 20:59:58 +0200
Received: from jnareb by 212-87-13-71.sds.uw.edu.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 May 2006 20:59:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212-87-13-71.sds.uw.edu.pl
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20352>

Yann Dirson wrote:

> On Thu, May 18, 2006 at 03:53:36PM -0700, Junio C Hamano wrote:
>> Yann Dirson <ydirson@altern.org> writes:
>> 
>> > To make my point maybe more clear: if someone really wants to make a
>> > graft permanent, wouldn't some history rewriting ... be the
>> > way to go,...
>> 
>> Yes.
> 
> So if temporary usage is a typical use for grafts, don't we want to
> protect people using them from pruning ?  I got no feedback to my
> suggestion of changing the default behaviour, even to say it was a bad
> idea :)

Perhaps prune should be conservative by default, and follow both grafts and
original parents, and use appropriate options to preserve or not preserve
grafts.

-- 
Jakub Narebski
Warsaw, Poland
