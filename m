From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 16:30:39 +0100
Message-ID: <45E5A01F.7060204@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org> <200702281522.14965.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:30:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQlP-00004q-LD
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbXB1Pal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbXB1Pal
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:30:41 -0500
Received: from server.usilu.net ([195.176.178.200]:47806 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751783AbXB1Pal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:30:41 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Feb 2007 16:30:39 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <200702281522.14965.andyparkins@gmail.com>
X-OriginalArrivalTime: 28 Feb 2007 15:30:39.0411 (UTC) FILETIME=[66877030:01C75B4D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40940>


>>    git checkout -b branchname remote/upstreambranch
>>    git config --add branch.branchname.remote remote
>>    git config --add branch.branchname.merge refs/heads/upstreambranch
>>
>> Is there a reason why "git branch" and "git checkout -b" should not
>> automatically do the two "git-config --add"s when the source branch is
>> remote?
> 
> I can see why that would be handy, but I often make short lived branches off a 
> remote; and I wouldn't want my config cluttered up with branch defintions.

So, is there a reason why the config not could be cleared out by branch -d?

(The "is there a reason" has the same meaning: it seems obvious to me, 
but I surely miss a lot of usecases because of inexperience).

Paolo
