From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn fetch spewing warnings
Date: Tue, 27 Mar 2007 12:00:04 -0700
Message-ID: <20070327190004.GD16591@localdomain>
References: <m28xdkvsxx.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:00:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWGty-0008CQ-BO
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 21:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934185AbXC0TAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 15:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934187AbXC0TAJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 15:00:09 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45428 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934185AbXC0TAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 15:00:08 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 70AAF2DC01A;
	Tue, 27 Mar 2007 12:00:05 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 12:00:04 -0700
Content-Disposition: inline
In-Reply-To: <m28xdkvsxx.fsf@ziti.fhcrc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43296>

Seth Falcon <sethfalcon@gmail.com> wrote:
> Hi,
> 
> I'm using git 1.5.1.rc1.13.g0872 and I just tried the following to
> create a new git-svn tracked repository.
> 
> I did:
> 
> 
>     git svn init $URL
>     git svn fetch 
>     # I also tried git svn fetch --no-follow-parent
> 
> The command eventually completed and left me with a working
> repository, but in the process I had screenfuls of warning messages
> like this:

We now try harder to find previous versions of the path we're tracking.
I've also changed the window from 1000 to 100 revisions, so the
warning message spewing is 10 times more frequent.  Don't worry, though
it's harmless :)

-- 
Eric Wong
