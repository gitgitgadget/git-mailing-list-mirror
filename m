From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 21:39:48 -0600
Message-ID: <20060928033948.GC3650@socrates.priv>
References: <20060928001241.62887.qmail@web51013.mail.yahoo.com>
 <7vzmck7pis.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609272252041.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 28 05:36:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSmhV-0004GC-KO
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 05:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWI1Dgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 23:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWI1Dgh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 23:36:37 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5448 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750755AbWI1Dgh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 23:36:37 -0400
Received: from pd4mr1so.prod.shaw.ca
 (pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J6A007MTA103X90@l-daemon> for git@vger.kernel.org; Wed,
 27 Sep 2006 21:36:36 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd4mr1so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0J6A001VPA10JT30@pd4mr1so.prod.shaw.ca> for
 git@vger.kernel.org; Wed, 27 Sep 2006 21:36:36 -0600 (MDT)
Received: from socrates.priv ([68.148.44.50])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J6A009VXA0ZF3W0@l-daemon> for git@vger.kernel.org; Wed,
 27 Sep 2006 21:36:36 -0600 (MDT)
Received: from socrates.priv (localhost [127.0.0.1])
	by socrates.priv (8.13.4/8.13.4) with ESMTP id k8S3dm2C009589	for
 <git@vger.kernel.org>; Wed, 27 Sep 2006 21:39:48 -0600
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit)
 id k8S3dmU0009588	for git@vger.kernel.org; Wed, 27 Sep 2006 21:39:48 -0600
In-reply-to: <Pine.LNX.4.64.0609272252041.9349@xanadu.home>
To: git@vger.kernel.org
Mail-followup-to: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.11-2006-05-17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27975>

On Wed, Sep 27, 2006 at 11:07:35PM -0400, Nicolas Pitre wrote:
> I beg to differ.  Such information might be really useful.  I agree 
> though that this is an expensive operation and gitweb might not be the 
> best place for it at all.
> 
> For example... some times I look at git-log output and finds about a 
> certain bug fix that was apparently committed a month ago.  And 
> incidentally I recall having been bitten by that bug not really long 
> ago, say last week.  Although the bug fix was committed _somewhere_ last 
> month, what I would really want to know is just when _i_ received that 
> bug fix in my own repository to determine if it was before or after last 
> week.  So if it was before last week then I could conclude that the bug 
> fix didn't actually fix my bug.  Knowing that it has been committed last 
> month is absolutely useless to me in this case.
> 

But even knowing when the commit arrived in your local repository does
you no good unless you are compiling every time you pull, in which case,
the reflog support on you local machine will give you the information
you need. Otherwise, you need to know the name of the commit you were
running when you got bitten by the bug which is a separate issue.

> Nicolas

  Tom
