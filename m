From: Jeff King <peff@peff.net>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 16:16:36 -0400
Message-ID: <20060928201636.GA4386@coredump.intra.peff.net>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20060927113813.GC8056@admingilde.org> <Pine.LNX.4.63.0609271358100.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20060927124413.GN1221MdfPADPa@greensroom.kotnet.org> <7vhcyt81gn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Martin Waitz <tali@admingilde.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Thu Sep 28 22:17:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT2JH-0007bS-Tb
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 22:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWI1UQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 16:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbWI1UQk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 16:16:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:33722 "HELO
	peff.net") by vger.kernel.org with SMTP id S1161175AbWI1UQj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 16:16:39 -0400
Received: (qmail 32626 invoked from network); 28 Sep 2006 16:16:36 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Sep 2006 16:16:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2006 16:16:36 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhcyt81gn.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28045>

On Wed, Sep 27, 2006 at 02:05:28PM -0700, Junio C Hamano wrote:

> Avoiding checking out parts of the project tree that you do not
> care about while you work on such a single large project is
> another interesting and useful area to think about, but I would
> say at that point it is not about subproject at all -- it is
> about working in a sparsely populated working tree of a single
> project.

Keep in mind that it might not be an attempt to avoid checking out part
of the tree, but rather importing part of the tree (the subproject) into
your repository at all (to save space, download time, etc). So unless
you're also proposing sparse repos, I think this still might be a
subproject issue.

-Peff
