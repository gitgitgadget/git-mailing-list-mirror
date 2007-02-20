From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Numeric constants as strings
Date: Tue, 20 Feb 2007 14:06:42 +0100
Organization: At home
Message-ID: <ererl9$df0$1@sea.gmane.org>
References: <200702190916.35813.andyparkins@gmail.com> <slrnetitgs.sbe.mdw@metalzone.distorted.org.uk> <200702191103.00431.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 14:05:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJUgF-0000QO-8w
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 14:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbXBTNFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 08:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932933AbXBTNFJ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 08:05:09 -0500
Received: from main.gmane.org ([80.91.229.2]:44531 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932929AbXBTNFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 08:05:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJUft-0003VK-9k
	for git@vger.kernel.org; Tue, 20 Feb 2007 14:04:53 +0100
Received: from host-81-190-18-211.torun.mm.pl ([81.190.18.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 14:04:53 +0100
Received: from jnareb by host-81-190-18-211.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 14:04:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-211.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40236>

Andy Parkins wrote:

> On Monday 2007 February 19 10:04, Mark Wooding wrote:
> 
>> #define STRINGIFY(foo) STRINGIFY_REALLY(foo)
>> #define STRINGIFY_REALLY(foo) #foo
>>   printf("%-" STRINGIFY(HASH_WIDTH_ASCII) "s %s%s (%d subtrees)\n",
> 
> Ah ha!  Magical.  You've taught me something there.  Thanks.

This trick is in the cpp documentation. 
(cpp.info.gz)Stringification

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
