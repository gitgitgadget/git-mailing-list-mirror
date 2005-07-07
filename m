From: John Ellson <ellson@research.att.com>
Subject: Re: BUG:  "rpmbuild -ta cogito-0.12.tar.gz" fails
Date: Thu, 07 Jul 2005 09:04:25 -0400
Message-ID: <42CD2859.10608@research.att.com>
References: <dah8i2$c8v$1@sea.gmane.org> <20050707062019.GL5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 16:54:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqXlN-0002rM-U8
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 16:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVGGNW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 09:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVGGNHB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 09:07:01 -0400
Received: from mail-dark.research.att.com ([192.20.225.112]:38544 "EHLO
	mail-yellow.research.att.com") by vger.kernel.org with ESMTP
	id S261450AbVGGNEd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 09:04:33 -0400
Received: from [135.207.24.103] (ellson.research.att.com [135.207.24.103])
	by bigmail.research.att.com (8.13.3+Sun/8.11.6) with ESMTP id j67D92tC000957;
	Thu, 7 Jul 2005 09:09:05 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050707062019.GL5324@shell0.pdx.osdl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wright wrote:

>* John Ellson (ellson@research.att.com) wrote:
>  
>
>>"rpmbuild -ta cogito-0.12.tar.gz" fails because cogito.spec.in refers to
>>".bz2" in its "Source:" line, instead of to ".gz".
>>    
>>
>
>Just grab the .bz2, or the SRPM http://kernel.org/pub/software/scm/cogito/RPMS
>(still mirroring, I just uploaded it a bit ago)
>  
>

But:
    cd cogito
    cg-update
    make dist
    rpmbuild -ta cogito-0.12.tar.gz

still doesn't work.    Do you have a different process for generating 
the initial cogito-0.12-1src.rpm ?

>  
>
>>This is obviously a trivial patch.  Do I need prior approval to send 
>>patches to this group?     What is the the significance of 
>>"Signed-off-by:"     Is there a FAQ I should read?
>>    
>>
>
>No approval needed.  Signed-off-by is in reference to the Developer's
>Certificate of Origin 1.1 (see item 11 in the Linux kernel's source file
>Documentation/SubmittingPatches).
>  
>

Thanks.  Thats what I was looking for.

John
