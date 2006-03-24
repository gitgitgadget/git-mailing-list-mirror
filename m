From: David Mansfield <centos@dm.cobite.com>
Subject: Re: Fix branch ancestry calculation
Date: Fri, 24 Mar 2006 09:45:45 -0500
Message-ID: <44240619.20103@dm.cobite.com>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Mansfield <cvsps@dm.cobite.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 24 15:45:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMnXx-0008UV-PG
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 15:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWCXOpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 09:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWCXOpr
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 09:45:47 -0500
Received: from iris.cobite.com ([208.222.83.2]:60378 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S1751511AbWCXOpq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 09:45:46 -0500
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id AF08197D5D; Fri, 24 Mar 2006 09:45:27 -0500 (EST)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02962-04; Fri, 24 Mar 2006 09:45:27 -0500 (EST)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id 76BE1987B8; Fri, 24 Mar 2006 09:45:27 -0500 (EST)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 30B4A98304; Fri, 24 Mar 2006 09:45:27 -0500 (EST)
User-Agent: Thunderbird 1.5 (X11/20060313)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17921>

Linus Torvalds wrote:
> Some branches don't get any ancestors at all, because their ancestor gets 
> a "dotcount" value of 0, and are thus not considered any better than not 
> having any ancestor. That's obviously wrong. Even a zero-dot-count 
> ancestor is better than having none at all.
> 
> This fixes the issue by making not having an ancestor branch have a 
> goodness value of -1, avoiding the problem (because even a zero dot-count 
> will be considered better).
> 
> Alternatively, the special-case for the "1.1.1.1" revision should be 
> removed (or made to imply a dot-count of 1).
> 


Thanks for this.  I'll look at bundling this and some miscellaneous 
other stuff this weekend (pray to gods for rain so I can stay in all 
weekend ;-).

Anyway, I'd like to nail down some of the other nagging ancestry/branch 
point problems if possible.

David
