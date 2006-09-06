From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GitWiki lost ability to parse macros
Date: Wed, 06 Sep 2006 13:46:02 +0200
Organization: At home
Message-ID: <edmcd6$9or$1@sea.gmane.org>
References: <edm7h3$nij$1@sea.gmane.org> <20060906113052.GC23891@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 06 13:47:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKvrf-0004yY-BI
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 13:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWIFLqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 07:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWIFLqj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 07:46:39 -0400
Received: from main.gmane.org ([80.91.229.2]:36013 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750725AbWIFLqj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 07:46:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKvrB-0004pO-Bd
	for git@vger.kernel.org; Wed, 06 Sep 2006 13:46:13 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 13:46:13 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 13:46:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26516>

Petr Baudis wrote:

> Dear diary, on Wed, Sep 06, 2006 at 12:22:47PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>>
>> Somehow, the GitWiki (which is MoinMoin wiki) lost the ability to parse
>> macros. Macros are now output as is, instead of being substitutes with
>> their expansion. It looks like MediaWiki-like syntax plugin got broken,
>> because besides of {{macroname}} not being expanded, additionally pipe
>> links [[target|label]] are not parsed.
>> 
>> See for example
>>   http://git.or.cz/gitwiki/RecentChanges
>>   http://git.or.cz/gitwiki/FindPage
>>   http://git.or.cz/gitwiki/SystemInfo
>> 
>>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools 
>>   (table of contents lost)
>> 
>> So anyone has idea what has happened, and how to repair it?
> 
>   this was connected with the server upgrade, sorry. Fixed.

Hmm... I still get for http://git.or.cz/gitwiki/RecentChanges

 {{RandomQuote()}}

 {{RecentChanges}} 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
