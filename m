From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] git email submissions
Date: Wed, 16 Nov 2005 13:01:06 -0500
Message-ID: <437B73E2.3080903@pobox.com>
References: <437B4472.1080401@pobox.com> <Pine.LNX.4.64.0511160847250.13959@g5.osdl.org> <437B7213.2020406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 19:05:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcRay-0004oc-QJ
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 19:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVKPSBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 13:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVKPSBR
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 13:01:17 -0500
Received: from mail.dvmed.net ([216.237.124.58]:56757 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030293AbVKPSBQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 13:01:16 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EcRao-0004UA-AY; Wed, 16 Nov 2005 18:01:11 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437B7213.2020406@zytor.com>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12035>

H. Peter Anvin wrote:
> Linus Torvalds wrote:
> 
>>
>> On Wed, 16 Nov 2005, Jeff Garzik wrote:
>>
>>> For people without _any_ hosting, it would be nice to give them a 
>>> method to
>>> submit some git changes via email.
>>
>>
>> Well, as long as you don't expect me to take those things..
>>
>> BK had it with "bk send"/"bk receive", I used it a couple of times and 
>> refuse to do it again.
>>
> 
> Personally I think it would be nice if you could do an augmented 
> patchset so that the end result is the same (with the same SHA1 IDs) as 
> if one had merged a pull, while still being a human-readable patchset. 
> The advantage with that is that once merged it'll do the right thing on 
> the author's end.  I think that's pretty much my answer to Jeff's 
> question :)

Agreed.

Though as a disclaimer to Linus and others, I don't plan to use this in 
my own submissions to Linus.  Just thinking it would be a nice thing to 
have, because there are definitely users out there who don't (for 
whatever reason) have git-capable hosting.

I would presume an email body would look like

overall description of changes
git log master..HEAD | git shortlog
git diff master..HEAD | diffstat -p1
git diff master..HEAD
<pack file MIME attachment>

Smarter programs would send the overall description and pack file as 
"[patch 0/N]", and then post the for-review patches in separate emails 
as "[patch M/N]".

	Jeff
