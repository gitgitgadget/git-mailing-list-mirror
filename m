From: Anton Tropashko <atropashko@yahoo.com>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 17:21:25 -0800 (PST)
Message-ID: <891197.22028.qm@web52611.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 02:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPqHB-0002xE-Pt
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 02:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbXCJBV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 20:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992672AbXCJBV1
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 20:21:27 -0500
Received: from web52611.mail.yahoo.com ([206.190.48.214]:42314 "HELO
	web52611.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752777AbXCJBV0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2007 20:21:26 -0500
Received: (qmail 22735 invoked by uid 60001); 10 Mar 2007 01:21:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=4j2RYE8yxL5B1CVbo91MFBhNEcJi12WYvAp8/hYnX9WLSn+9MJN7fbZZHwkLozw+FPblxgtZ1pqbOpJhaYQmKpvQFqgz5yYjyeDzsfSBxh+VjaqiyWuE7PAmq0DlN+O4FTcWf8RevePPb5m2Ch/MNNDxNNPToS0ZSnHuW7gvIx4=;
X-YMail-OSG: feOf310VM1kiLdDdFnVzHX7Oa2_KYe9KWW.WsTRvzBBAw49PwSR9.6TiyzALYv6I7HEoYVObSZcweff3qE8fdfCHm7sB.kKhtdJKYm5QY7NtlNbn39.Z7ZRRj44JQS4sW3CskAaeEgdgz0TByd3hm9QYoA--
Received: from [129.188.69.145] by web52611.mail.yahoo.com via HTTP; Fri, 09 Mar 2007 17:21:25 PST
X-Mailer: YahooMailRC/471 YahooMailWebService/0.6.132.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41831>

> I should try it out with some made-up auto-generated directory setup, but 
> I'm not sure I have the energy to do it ;)

but your /usr should be large enough if /usr/local and /usr/local/src are not!!!
I don't think you need to generate anything.
Or you are saying that the problem is the number of files I have, not the
total size of the files? In any event there should be a plenty of files in /usr

> That said, it might also be a good idea (regardless of anything else) to 
> split things up, if only because it's quite possible that not everybody is 
> interested in having *everything*. Forcing people to work with a 8.5GB 
> repository when they might not care about it all could be a bad idea.

> "git reset --hard" will do it for you. As will "git checkout -f", for that 
> matter.

> "git revert" will just undo an old commit (as you apparently already found 
> out)

Yep. I found checkout -f works before I got the rest alternative.

I was pleased that git did not lock me out of committing a few
deletions for *.pdf, *.doc and makefiles after repack started.
repack -a -d just finished and I started clone again.
It's already deltifying at 6%.

Thank you.






 
____________________________________________________________________________________
Now that's room service!  Choose from over 150,000 hotels
in 45,000 destinations on Yahoo! Travel to find your fit.
http://farechase.yahoo.com/promo-generic-14795097
