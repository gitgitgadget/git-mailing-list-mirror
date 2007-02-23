From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Fri, 23 Feb 2007 18:52:22 +0100
Organization: At home
Message-ID: <ern9gn$h4d$1@sea.gmane.org>
References: <17885.60477.53356.123095@lisa.zopyra.com> <20070222193625.GA4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 18:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKeZE-0005vI-7S
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 18:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbXBWRuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 12:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbXBWRuj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 12:50:39 -0500
Received: from main.gmane.org ([80.91.229.2]:42796 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbXBWRuh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 12:50:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HKeYu-0006TH-Ur
	for git@vger.kernel.org; Fri, 23 Feb 2007 18:50:29 +0100
Received: from host-81-190-30-32.torun.mm.pl ([81.190.30.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Feb 2007 18:50:28 +0100
Received: from jnareb by host-81-190-30-32.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Feb 2007 18:50:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-30-32.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40455>

Petr Baudis wrote:

> On Thu, Feb 22, 2007 at 08:17:17PM CET, Bill Lear wrote:
>> Git "indexing" of commits has a way to "go back":
>> 
>> % git diff HEAD~3
>> 
>> Can I say "all the way back", or "all the way back - 1" somehow?
> 
> What would that mean? :)
> 
> Do you mean to the "root" of the history? The trouble is, there can be
> many of such roots (coming up from merges of previously disjunct
> histories); even the git project itself has several. Which one to
> choose?

Actually HEAD~n follows first parent, so it would be only one such root.

The git project has 4 or 5 roots for mainline + 3 separate disjoint 
branches with separate roots (html, man, todo).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
