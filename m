From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 22:27:26 +0200
Message-ID: <46252DAE.4020604@dawes.za.net>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org> <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:28:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HduHf-0007PC-7Y
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbXDQU1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161331AbXDQU1r
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:27:47 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:35599 "EHLO
	spunkymail-a16.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161306AbXDQU1q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 16:27:46 -0400
Received: from [192.168.201.100] (dsl-146-26-121.telkomadsl.co.za [165.146.26.121])
	by spunkymail-a16.dreamhost.com (Postfix) with ESMTP id 1069C7CC51;
	Tue, 17 Apr 2007 13:27:43 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44817>

Linus Torvalds wrote:
> 
> On Tue, 17 Apr 2007, Rogan Dawes wrote:
>> Well, if the only keyword we support is $BlobId:$, then if the tree/object
>> hasn't changed, then we still don't need to touch the object.
>>
>> Not so?
> 
> Correct. However, is that actually a useful expansion?
> 
> Most of the time, I'd expect people to want things like "last committer, 
> time, story of their life" etc.. I don't think the SHA1 ID's are pretty 
> enough that anybody would ever want to see them. But yes, they are 
> certainly stable.
> 
> 			Linus

Well, one example for wanting a keyword expansion option was where 
people modify the entire file, and just email it back to the maintainer. 
It surely helps to have the SHA1 of the original object when applying 
the changes.

You also stated in another email that doing keyword expansion prevents 
people from using non-git tools. I agree that you'd probably end up with 
diffs that may include the keyword (object id) being mailed to you if 
the submitter is not using git. But when a git maintainer applies those 
diffs using git-apply, the keyword unexpansion could still take place, 
making the diffs usable in practice.

None of what I said necessarily supports the view that it is a good idea 
from the perspective of trusting the results, of course.

Regards,

Rogan
