From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Wed, 09 Aug 2006 13:01:32 +0200
Organization: At home
Message-ID: <ebcf9s$h32$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org> <7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org> <7vejvsyum8.fsf@assigned-by-dhcp.cox.net> <ebcd8r$bi7$1@sea.gmane.org> <7vy7ty41xb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 09 13:01:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAloh-00064r-42
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 13:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbWHILBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 07:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbWHILBf
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 07:01:35 -0400
Received: from main.gmane.org ([80.91.229.2]:56754 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030680AbWHILBe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 07:01:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAloR-00062m-6m
	for git@vger.kernel.org; Wed, 09 Aug 2006 13:01:23 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 13:01:23 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 13:01:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25112>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> It is needed in gitweb to create pagination/paging navigation bar. 
>> Currently it is done by reading all the output into array, and 
>> checking length of this array.
> 
> If you want to show 10 and do ... when you have more than that,
> the standard technique is to ask for 11 ;-).

It's not a problem to do '...'/'next' link _after_ the body, but
the paging navigation bar is at the _top_ of page, before 
outputting the body. See e.g.
  http://www.kernel.org/git/?p=git/git.git;a=shortlog
there is "HEAD * prev * next" at the top, and "next" at the bottom
of the revision list.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
