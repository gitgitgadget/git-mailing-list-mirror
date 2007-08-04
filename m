From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Sat, 4 Aug 2007 10:28:04 +0200
Message-ID: <43D2B97E-6AC5-4A7E-AA86-DDFF4992A284@zib.de>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B215E2.8010307@fs.ei.tum.de> <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de> <46B2309E.3060804@fs.ei.tum.de> <6715F560-FE69-4F15-8C5F-B5B6071D97ED@zib.de> <46B25FC3.6000205@fs.ei.tum.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 10:34:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHF6A-0005Rx-IG
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 10:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743AbXHDIev (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 04:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbXHDIev
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 04:34:51 -0400
Received: from mailer.zib.de ([130.73.108.11]:37224 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756426AbXHDIeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 04:34:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l748RDKx000526;
	Sat, 4 Aug 2007 10:27:13 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10551.pool.einsundeins.de [77.177.5.81])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l748RCU1009161
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 4 Aug 2007 10:27:13 +0200 (MEST)
In-Reply-To: <46B25FC3.6000205@fs.ei.tum.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54815>


On Aug 3, 2007, at 12:50 AM, Simon 'corecode' Schubert wrote:

> Steffen Prohaska wrote:
>>> yah, that pretty much tells me it is shawn's bug :)  but without  
>>> more details, it is very hard to diagnose.
>> I tried again. Interestingly now togit works but tohg still fails.
>> togit starts with reporting
>> fatal: Not a valid object name
>
> that's fine.

Looks a bit scary. Could you hide the message from the user
if it's fine.

>> as the first line. But besides that it seems to work fine. What
>> concerns me a bit is that the last line togit reports is
>> committing set 18100/18173
>> I'd expect it should report 18173/18173.
>
> that's fine as well.  You only saw multiples of 100, but you didn't  
> consider it would skip the itermediate ones, right? :)

I don't care about the intermediates, but only about the
last one. I'd expect that a successful import would report
as the last line 18173/18173. If the first number is smaller
than the second, this indicates to me that there's something
left to do.


>> BTW, togit creates much more complex branching patterns than cvs2svn
>> does. The attached file branching.png displays a small view of a
>> branching pattern that extends downwards over a couple of screens.
>> I checked the cvs2svn history again. It doesn't contain anything
>> of similar complexity.
>
> haha yea, there is still some issue with duplicate branch names and  
> the branchpoint.  if it doesn't get the branch right, it will  
> always "pull" files from the parent branch.
>
> did you do some manual RCS file copying or manual branch name  
> changing of individual files?  this could be the reason.  I still  
> have to find a simple repo to reproduce this.

Maybe, the repo is 8 years old. It started before I joined the
development.

	Steffen
