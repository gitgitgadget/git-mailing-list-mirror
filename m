From: John Ellson <ellson@research.att.com>
Subject: Re: BUG:  "rpmbuild -ta cogito-0.12.tar.gz" fails
Date: Thu, 07 Jul 2005 13:23:05 -0400
Message-ID: <42CD64F9.1010304@research.att.com>
References: <dah8i2$c8v$1@sea.gmane.org> <20050707062019.GL5324@shell0.pdx.osdl.net> <42CD2859.10608@research.att.com> <20050707170748.GN5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 19:24:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqa6M-0003on-Ee
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 19:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVGGRXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 13:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVGGRXa
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 13:23:30 -0400
Received: from mail-dark.research.att.com ([192.20.225.112]:60103 "EHLO
	mail-yellow.research.att.com") by vger.kernel.org with ESMTP
	id S261471AbVGGRXM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 13:23:12 -0400
Received: from [135.207.24.103] (ellson.research.att.com [135.207.24.103])
	by bigmail.research.att.com (8.13.3+Sun/8.11.6) with ESMTP id j67HRfbS001182;
	Thu, 7 Jul 2005 13:27:44 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050707170748.GN5324@shell0.pdx.osdl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wright wrote:

>* John Ellson (ellson@research.att.com) wrote:
>  
>
>>But:
>>   cd cogito
>>   cg-update
>>   make dist
>>   rpmbuild -ta cogito-0.12.tar.gz
>>
>>still doesn't work.    Do you have a different process for generating 
>>the initial cogito-0.12-1src.rpm ?
>>    
>>
>
>I start from the bz2 from kernel.org.
>
>thanks,
>-chris
>  
>
So now I have to ask, where does that come from if its not created by 
"make dist" ?

Is what I'm asking to do in the above sequence somehow unreasonable?   
Would it
be any loss if the Source: line in cogito.spec.in refered to the .gz 
instead of the .bz2 such that the
above sequence works for those of us that like to build rpms directly 
from the git tree?

Alternatively, perhaps "make dist" could generate the .bz2 instead?

John
