From: Eric Wong <eric@petta-tech.com>
Subject: Re: git svn dcommit seg fault
Date: Wed, 18 Jul 2007 00:34:50 -0700
Message-ID: <20070718073450.GA30559@muzzle>
References: <951126.88373.qm@web52807.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Perrin Meyer <perrinmeyer@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB44B-0002Zj-MZ
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 09:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761458AbXGRHey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 03:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760570AbXGRHex
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 03:34:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44279 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755926AbXGRHev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 03:34:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 77A582DC08D;
	Wed, 18 Jul 2007 00:34:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <951126.88373.qm@web52807.mail.re2.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52839>

Perrin Meyer <perrinmeyer@yahoo.com> wrote:
> 
> I'm able to clone svn repo's fine with
> 
> $ git svn clone https://svn.eng.msli.com/perrin/trunk/TESTGIT/ .
> 
> and I'm then able to use git commit to commit local changes, but 
> when I try 
> 
> $ git svn dcommit
> 
> I get
> 
> [perrin@whisper TESTGIT]$ git svn dcommit
>         M       test.c
> Committed r717
> Segmentation fault


> As far as I can tell, the commit worked fine (verified by trying 'svn
> update' on another box).
> 
> I've tried git version 1.5.2.3, 1.5.3-rc2, and the latest build, and
> all give the seg fault.
> 
> I'm guessing it has something to do with using the https connection to
> svn?

I primarily work with https repositories using git-svn and I haven't
seen any segfaults in a while.  Which version of the SVN libraries do
you have?  (git-svn --version will tell you).

-- 
Eric Wong
