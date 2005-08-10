From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Cannot install git RPM
Date: Wed, 10 Aug 2005 18:32:02 +0200
Message-ID: <20050810163202.GA11131@mars.ravnborg.org>
References: <20050810003012.GB22778@mythryan2.michonline.com> <20050810074607.30803353C46@atlas.denx.de> <20050810162307.GE8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wolfgang Denk <wd@denx.de>, Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 18:31:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2tSP-0000Vm-GP
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 18:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVHJQ3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 12:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbVHJQ3J
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 12:29:09 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:59775 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S965192AbVHJQ3I
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 12:29:08 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 07F6047FE8B;
	Wed, 10 Aug 2005 18:29:01 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 0B8506AC01D; Wed, 10 Aug 2005 18:32:03 +0200 (CEST)
To: Chris Wright <chrisw@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050810162307.GE8041@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2005 at 09:23:07AM -0700, Chris Wright wrote:
> * Wolfgang Denk (wd@denx.de) wrote:
> > It's then the "perl(Email::Valid)" and "perl(Mail::Sendmail)"  depen-
> > dencies  which  cause  problems.  I  installed  all perl packages and
> > modules I was able to find in the standard FC places,  but  this  did
> > not solve the problem. Maybe this is actually a bug in Fedora Core ?
> 
> No, you probably missed the earlier thread on this.  It's not a bug,
> those are real dependencies which rpm automagically discovers (along
> with things like shared library dependencies).  The issue is the
> git-send-email-script uses Mail/Sendmail.pm and Email/Valid.pm which
> aren't part of standard install.

Not knowing perl at all I wonder if some more widespread used packages
can replace the above two?
I recall having trouble locating them myself when I first tried Greg's
send-a-lot-of-mails script.

	Sam
