From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git diff - no newline after @@ ?
Date: Fri, 18 Aug 2006 15:42:55 +0200
Organization: At home
Message-ID: <ec4g4v$m4v$1@sea.gmane.org>
References: <44E5AE42.6090506@scssoft.com> <81b0412b0608180525t284d3124j867a9461bf14ed91@mail.gmail.com> <44E5B496.3070901@scssoft.com> <20060818124428.GA22328@sigio.intra.peff.net> <44E5BE60.5010901@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 18 15:44:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE4e4-0002pt-4h
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 15:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWHRNoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 09:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHRNoR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 09:44:17 -0400
Received: from main.gmane.org ([80.91.229.2]:2784 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751388AbWHRNoQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 09:44:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE4dk-0002k5-Ce
	for git@vger.kernel.org; Fri, 18 Aug 2006 15:44:00 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 15:44:00 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 15:44:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25664>

Petr Sebor wrote:

> Jeff King wrote:
>> Try diff -p to get a hunk comment.
>>
>> -Peff
>>   
> 
> Ouch.... got it. Is there a way to turn the comment generation off btw?

Other than GIT_DIFF_OPTS (although how to turn off present -p option), or
GIT_EXTERNAL_DIFF (see git-diff-tree(1))?

Why do you want to turn it off? patch understands this format...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
