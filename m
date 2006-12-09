X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Documentation/git-commit.txt
Date: Sat, 09 Dec 2006 21:49:13 +0100
Organization: At home
Message-ID: <elf7bt$hiq$1@sea.gmane.org>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612082141260.2630@xanadu.home> <7vpsatelvv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612091442470.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 9 Dec 2006 20:47:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 40
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33832>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt96L-0000M3-DT for gcvg-git@gmane.org; Sat, 09 Dec
 2006 21:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937672AbWLIUrP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 15:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937673AbWLIUrO
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 15:47:14 -0500
Received: from main.gmane.org ([80.91.229.2]:36415 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937672AbWLIUrO
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 15:47:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gt969-0007ZD-CS for git@vger.kernel.org; Sat, 09 Dec 2006 21:47:05 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 21:47:05 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 09 Dec 2006
 21:47:05 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:

> On Fri, 8 Dec 2006, Junio C Hamano wrote:
[...]
>> Another reason I described the merge workflow is it would become
>> much less clear why --only is useless in merge situation if the
>> reader does not know that a conflicted merge stages the
>> auto-resolved changes.
> 
> Sure, but the whole merge concept might still not make any sense at the 
> moment the user is learning about commit.  In other words, the "commit" 
> documentation must not depend on the "merge" concept.  It should rather 
> be the other way around, i.e. the "merge" documentation can easily 
> depend on the "commit" documentation.
> 
> Just like I carefully avoided talking about "commit -a" in the git-add 
> man page to avoid circular conceptual dependencies.  But obviously the 
> git-commit man page must talk about the "add" concept.
> 
> This way you get a progressive knowledge base with git-add which pretty 
> much stands on its own, then you move to git-commit that depends on 
> git-add, then you move to merging and resolving conflicts that depend on 
> git-commit.  And so without being distracted by concepts you don't need 
> to know just yet along the way.

IMVHO for reference documentation (and manpages for commands are such
documentation) it is more important to be complete, than to be
self-contained and without circular conceptual dependencies. The latter
(and defining things before using it) is more important for things like
tutorial or quickstart.

If one is not doing merge then one can skip the talk about merges. If one
git-commit complains about using --only (because of merge), one would
rather search for information in git-commit(1), not git-merge(1) or
git-pull(1); well, the merge might be result of git-checkout -m.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

