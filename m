From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: resolve (merge) problems
Date: Thu, 1 Dec 2005 18:05:12 -0800 (PST)
Message-ID: <20051202020512.99856.qmail@web31811.mail.mud.yahoo.com>
References: <7vpsog9s5e.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 03:06:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei0IY-0000wG-Mt
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 03:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVLBCFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 21:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVLBCFP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 21:05:15 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:25224 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964784AbVLBCFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 21:05:13 -0500
Received: (qmail 99858 invoked by uid 60001); 2 Dec 2005 02:05:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BKGobxlor0HQ4GDkkyzxCvdXFcik+OaOHlB+yBD4LdgtZLDh/LMYUOpeKAqt/m/LtaOkL6BRNfwC0PK0wWKbSkaX6b441nGyspcjneGEUMzkSYBKblsvTgNu6pwt2cX0MNsxsDXFuKAYJWBFX/sIpIDID4IjNsOKEUr87sVY9BM=  ;
Received: from [68.221.13.176] by web31811.mail.mud.yahoo.com via HTTP; Thu, 01 Dec 2005 18:05:12 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsog9s5e.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13099>

--- Junio C Hamano <junkio@cox.net> wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Ok, if your patch below resolves the bug (please see my
> > other email just posted) please submit it.  (I'm hitting
> > this bug everytime there's a file deleted from the
> > kernel tree and I try to merge.)
> 
> Sorry to hear that.  The patch I sent you is already pushed out
> and mirrored the public machines.

Yes, I pulled right after I posted and saw you pushed it.

> 
> The failure from '-s recursive' (lack of heapq) makes me suspect
> that your Python installation is too old.  The 'resolve' method
> you've been using should work fine for this case; 

$python -V
Python 2.4.2
$which python
/usr/local/bin/python

>otherwise
> replace '-s recursive' in the message from Linus with '-s
> resolve' for the 'git merge' commandline, like this:
> 
> 	$ git merge -s resolve "merge linus' tree" HEAD master

Ok, I'll try this next time I hit this problem.

Thanks,
   Luben
