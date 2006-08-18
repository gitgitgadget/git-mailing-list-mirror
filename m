From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git diff - no newline after @@ ?
Date: Fri, 18 Aug 2006 14:40:17 +0200
Organization: At home
Message-ID: <ec4cfi$9dn$1@sea.gmane.org>
References: <44E5AE42.6090506@scssoft.com> <81b0412b0608180525t284d3124j867a9461bf14ed91@mail.gmail.com> <44E5B496.3070901@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 18 14:41:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE3es-0004xB-4J
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 14:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWHRMlC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 08:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWHRMlB
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 08:41:01 -0400
Received: from main.gmane.org ([80.91.229.2]:22709 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932227AbWHRMlA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 08:41:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE3eT-0004pa-8m
	for git@vger.kernel.org; Fri, 18 Aug 2006 14:40:41 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 14:40:41 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 14:40:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25657>

Petr Sebor wrote:

> Alex Riesen wrote:
>> On 8/18/06, Petr Sebor <petr@scssoft.com> wrote:
>>> Hello,
>>>
>>> has anyone noticed that the 'git diff' output somehow lacks the newline
>>> after the @@ tag?
>>>
>>
>> Why should it? It's hunk comment.
> Hunk comment? Maybe we don't understand each other...

Hunk comment as in "diff -p":

  -p     Show which C function each change is in.

(which is simpliefied to: show first line preceding hunk which begins with
word character in first column). 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
