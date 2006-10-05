From: Jeff Garzik <jeff@garzik.org>
Subject: Re: How to checkout a tag?
Date: Thu, 05 Oct 2006 07:13:06 -0400
Message-ID: <4524E8C2.3060404@garzik.org>
References: <4524E2D5.3030907@garzik.org> <4524E72D.9030101@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 05 13:13:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVRAE-0003rM-W9
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 13:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWJELNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 07:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWJELNK
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 07:13:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:222 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751654AbWJELNI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 07:13:08 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GVRA3-0005wN-EX; Thu, 05 Oct 2006 11:13:07 +0000
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4524E72D.9030101@shadowen.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28356>

Andy Whitcroft wrote:
> Jeff Garzik wrote:
>> Sometimes I receive a kernel patch based off an older version of the
>> kernel, for example a 2.6.18 patch when the current kernel is 2.6.19-rc1.
>>
>> I would like to create a branch starting at 2.6.18, merge the patch, and
>> then merge up to the current kernel.
>>
>> How does one check out a tag, or create a branch based on a tag's
>> starting point?
> 
> A tag is a ref like any other:
> 
> 	git checkout -b branchname tag

Weird.  No idea why that didn't work before, for me.

Thanks for the clue-hammer.

	Jeff
