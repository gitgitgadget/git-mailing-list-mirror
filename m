From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Fri, 11 Nov 2005 13:17:07 -0800
Message-ID: <43750A53.9090602@zytor.com>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43730E39.6030601@pobox.com> <43737F9E.60703@zytor.com> <437392AD.20906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 22:19:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EagHj-0004zD-Kh
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 22:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVKKVRS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 16:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKKVRS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 16:17:18 -0500
Received: from terminus.zytor.com ([192.83.249.54]:12715 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751202AbVKKVRR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 16:17:17 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jABLHCi1021065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Nov 2005 13:17:12 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437392AD.20906@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11636>

Andreas Ericsson wrote:
>>
>> It's nice in concept, but I think there are a lot of reasons why this 
>> is a bad idea:
>>
>> - "man" doesn't handle it.  It would be another thing if "man" could 
>> be taught to understand commands like "man cvs checkout" or "man git 
>> fetch".
> 
> This is moot. man-pages can still be named git-fetch.
> 

Yes, of course, but that requires the user to be aware of yet another 
program-specific convention.  I do believe that supporting hierarchial 
man pages would be a good thing, but one has to start that in the proper 
point.

>> - There is no general way to teach shells etc about it, for tab 
>> completion etc.
> 
> Add the lib directory to the path (for git-<tab><tab>) or have it 
> auto-evaluate the result of a git command-listing.

... which means the end user has to do something specific to their 
environment.

All in all, I think the negatives outweigh the positives.

	-hpa
