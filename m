From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel cherry UN-picking?
Date: Fri, 11 May 2007 17:56:58 -0400
Message-ID: <4644E6AA.9050908@garzik.org>
References: <4644E0A2.90008@garzik.org> <20070511145509.09f3c354.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 11 23:57:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmd6n-00057r-Rl
	for gcvg-git@gmane.org; Fri, 11 May 2007 23:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbXEKV5C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 17:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758750AbXEKV5C
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 17:57:02 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43508 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbXEKV5B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 17:57:01 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1Hmd6h-0008T2-VD; Fri, 11 May 2007 21:57:00 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <20070511145509.09f3c354.akpm@linux-foundation.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46989>

Andrew Morton wrote:
> On Fri, 11 May 2007 17:31:14 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> So, I merge the next batch of net driver patches.  After I merge a PPP 
>> patch, deep in the pile-o-patches, Andrew says "I shouldn't have sent 
>> that to you, don't apply it"  ;-)
> 
> I'm bad.

You're just an example.  This is a problem guaranteed to appear...


>> Right now, my process for reversing this damage is to start over: 
>> create a new branch, manually double-click the mouse on each commit in 
>> the "damaged" branch, and git-cherrypick it.  Very, very time consuming 
>> when you have more than a couple commits.
>>
>> Is there a better way?
>> Is there any way to say "cherrypick all commits except <these>"?
> 
> Let me refactor your question more usefully.  What we want is quilt-export
> and quilt-import.  And I really mean that: commands called git-quilt-export
> and git-quilt-import.
> 
> coz then, your problem becomes
> 
> 	git-quilt-export
> 	<delete one line from the series file>
> 	git-quilt-import

Doesn't work when I've pulled git trees from Linville...

	Jeff
