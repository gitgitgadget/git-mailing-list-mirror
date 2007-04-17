From: Rene Herman <rene.herman@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 18:55:07 +0200
Message-ID: <4624FBEB.5080805@gmail.com>
References: <4624CD58.90103@gmail.com> <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com> <4624EAAA.6040000@gmail.com> <4624F4BB.7010308@gmail.com> <Pine.LNX.4.64.0704170938510.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 18:57:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdqzT-0005BN-Mh
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 18:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031105AbXDQQ5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031179AbXDQQ5M
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 12:57:12 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:40323 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031105AbXDQQ5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 12:57:11 -0400
Received: from [213.51.130.189] (port=51339 helo=smtp2.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HdqzK-000710-BE; Tue, 17 Apr 2007 18:57:06 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:48228 helo=[192.168.0.3])
	by smtp2.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HdqzI-0000p4-BP; Tue, 17 Apr 2007 18:57:04 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
In-Reply-To: <Pine.LNX.4.64.0704170938510.5473@woody.linux-foundation.org>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44797>

On 04/17/2007 06:44 PM, Linus Torvalds wrote:

> So you could have avoided the checkout completely, and done
> 
> 	git clone -l -s -n <a local linux repo> local
> 	git branch v20 v2.6.20
> 	git branch a v20
> 	git branch b v20
> 	git branch c v20
> 
> and now you'd have four branches that all point to the v20 thing, and none 
> of them are actually checked out. And all of that would have been 
> instantaneous, even on an old machine (apart fromt he clone itself, of 
> course ;)

Yes, this is exactly what I wanted, thank you. I'm only learning about "git 
branch" (as opposed to git checkout -b) now and it didn't in fact occur to 
me that I could specify that <start-point> although I should've noticed in 
the manpage and certainly in Lars' reply from a few minutes back -- managed 
to go into that and still not have it click.

Nothing left for me to desire...

Rene.
