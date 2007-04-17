From: Rene Herman <rene.herman@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 17:47:36 +0200
Message-ID: <4624EC18.4000500@gmail.com>
References: <4624CD58.90103@gmail.com> <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com> <4624EAAA.6040000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdpwG-0004pr-SP
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031045AbXDQPto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031040AbXDQPto
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:49:44 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:52474 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031045AbXDQPtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:49:41 -0400
Received: from [213.51.130.190] (port=52812 helo=smtp1.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hdpw4-0004DO-7m; Tue, 17 Apr 2007 17:49:40 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:33712 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1Hdpvw-0005q1-6M; Tue, 17 Apr 2007 17:49:32 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
In-Reply-To: <4624EAAA.6040000@gmail.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44785>

On 04/17/2007 05:41 PM, Rene Herman wrote:

> On 04/17/2007 04:31 PM, Brian Gernhardt wrote:

>> However, I'm somewhat confused as to why you'd want HEAD and the 
>> working directory to get out of sync.
> 
> Thank you for the answer. Well, as said, it's not essential, but I was 
> just now rebuilding a repo and have a few branches that I all want to be 
> based on the same revision. Say, branch a, b and c, based on v2.6.20.
> 
> git clone -l -s -n <a local linux repo> local
> git checkout -b v20 v2.6.20
> git branch a
> git branch b
> git branch c
> 
> Step 1, 3, 4 and 5 of this are nearly instantaneous but 2 isn't -- this 
> repo sits on a P1 with 64M of memory and a disk doing 8 M/s which is 
> probably the only reason I thought asking about it was a good idea in 
> the first place...
> 
> You'd be quite right in saying that there isn't much point; if I want to 
> now start populating branch a, I have to "git checkout a" anyway, and 
> that action _will_ now be instantaneous. If I'd replaced 2 with:
> 
> git branch --create-and-set-as-current v20 v2.6.20
> 
> then I will not have won any time until that 6th "git checkout a" step.

s/until/after/

> The checkout of v20 was superfluous in this though, and I just expected 
> I should be able to skip that. It fitted my mental model...

Rene.
