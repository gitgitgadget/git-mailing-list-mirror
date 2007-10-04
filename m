From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9400: Add some tests for checkout
Date: Thu, 4 Oct 2007 20:17:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710042015580.4174@racer.site>
References: <1191521625-2597-1-git-send-email-frank@lichtenheld.de>
 <Pine.LNX.4.64.0710041921490.4174@racer.site> <20071004191217.GC31659@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 21:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdWCN-0005no-Oc
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 21:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438AbXJDTRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 15:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757364AbXJDTRL
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 15:17:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:47375 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756307AbXJDTRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 15:17:09 -0400
Received: (qmail invoked by alias); 04 Oct 2007 19:17:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 04 Oct 2007 21:17:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Rh6Aco+hRG6q6b0dnJdoMrayKEKOLht105M5bL8
	7hlLeLHxH62+60
X-X-Sender: gene099@racer.site
In-Reply-To: <20071004191217.GC31659@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 4 Oct 2007, Frank Lichtenheld wrote:

> On Thu, Oct 04, 2007 at 07:24:05PM +0100, Johannes Schindelin wrote:
> > On Thu, 4 Oct 2007, Frank Lichtenheld wrote:
> > 
> > > +# clean up
> > > +rm -fr cvswork2
> > > +rm -fr "$SERVERDIR"
> > > +cd "$WORKDIR" &&
> > > +git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
> > > +GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
> > > +GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
> > > +exit 1
> > 
> > Should this not be in a test_expect_success, too?
> 
> Since I do this several times and since it is easier to see what tests
> it belongs to if it isn't buried in one of them, I would say "no".

Just to clarify: I meant making an own "test_expect_success", a la "setup" 
in many other test scripts.

But I'm not the maintainer, so I'll just shut up.

Ciao,
Dscho
