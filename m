From: bob <kranki@mac.com>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 9 Nov 2007 13:06:57 -0500
Message-ID: <57F319AB-F5F9-4917-B1FE-ED263BF1E7DD@mac.com>
References: <6C571F0D-442F-49B9-8CF8-D7DACB41FC1A@mac.com> <alpine.LFD.0.9999.0711091103540.21255@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYGW-0006OA-Q4
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbXKISHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbXKISHV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:07:21 -0500
Received: from smtpoutm.mac.com ([17.148.16.75]:60827 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbXKISHU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:07:20 -0500
Received: from mac.com (asmtp005-s [10.150.69.68])
	by smtpoutm.mac.com (Xserve/smtpout012/MantshX 4.0) with ESMTP id lA9I76To020754;
	Fri, 9 Nov 2007 10:07:07 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp005/MantshX 4.0) with ESMTP id lA9I745Y012716
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 9 Nov 2007 10:07:05 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0711091103540.21255@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64237>

Thank you, Nicolas.  I will look into installing a new
zlib.

I moved the two large files into their own repository
and then both repositories worked correctly.  So,
it must be something related to the size, hopefully,
in zlib.

Again, thanks for the reponse.

On Nov 9, 2007, at 11:11 AM, Nicolas Pitre wrote:

> On Fri, 9 Nov 2007, bob wrote:
>
>> Sorry, but I am not that familiar with git's internal workings,
>> but here is a failure that I can consistently create.  I am
>> running MacOSX 10.4.10 with git compiled from source.
>> Here is the problem output that I am receiving:
>>
>> remote: Generating pack...
>> remote: Done counting 11402 objects.
>> remote: Deltifying 11402 objects...
>> remote:  100% (11402/11402) done
>> Indexing 11402 objects...
>> 100% (11402/11402) done
>> Resolving 3356 deltas...
>> fatal: serious inflate inconsistency
>
> A similar problem (if not the same problem) has been reported on  
> MacOSX
> in the past.  The conclusion was that either the gcc version or zlib
> version on MacOSX was bad and updating them fixed it.  I don't  
> remember
> the details now but you should be able to find them in the mail  
> archive
> (or maybe someone else remembers).
>
>
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
