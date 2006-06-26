From: Jeff King <peff@peff.net>
Subject: perl profiling (was: PPC SHA-1 Updates in "pu")
Date: Sun, 25 Jun 2006 21:51:44 -0400
Message-ID: <20060626015144.GA6706@coredump.intra.peff.net>
References: <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <20060625012435.GZ21864@pasky.or.cz> <7vfyhtopjm.fsf@assigned-by-dhcp.cox.net> <20060625093444.GD21864@pasky.or.cz> <Pine.LNX.4.63.0606251202320.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060625102037.GI29364@pasky.or.cz> <7vzmg1v7ci.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0606251537450.29667@wbgn013.biozentrum.uni-wuerzburg.de> <86veqp8456.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0606260121040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 03:51:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FugGU-0004Nl-KX
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 03:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWFZBvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 21:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWFZBvr
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 21:51:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:14734 "HELO
	peff.net") by vger.kernel.org with SMTP id S965179AbWFZBvq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 21:51:46 -0400
Received: (qmail 30332 invoked from network); 25 Jun 2006 21:51:24 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 25 Jun 2006 21:51:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jun 2006 21:51:44 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606260121040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22653>

On Mon, Jun 26, 2006 at 01:23:21AM +0200, Johannes Schindelin wrote:

> one-liner, you probably want to say that profiling Perl is easy. Can you 
> enlighten me how to do memory _and_ timing profiling on, say, a per-line 
> basis?

For the timing, have you tried using Devel::SmallProf?
  perl -d:SmallProf foo.pl

-Peff
