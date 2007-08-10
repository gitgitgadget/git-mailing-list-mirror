From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout-index needs a working tree
Date: Fri, 10 Aug 2007 02:11:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708100210280.21857@racer.site>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
 <20070809223530.GA29680@cassiopeia> <Pine.LNX.4.64.0708100129200.21857@racer.site>
 <7vd4xww6mr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 03:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJJ2r-0001tT-FE
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 03:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbXHJBL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 21:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755570AbXHJBL6
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 21:11:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:59219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753639AbXHJBL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 21:11:57 -0400
Received: (qmail invoked by alias); 10 Aug 2007 01:11:56 -0000
Received: from ppp-82-135-7-57.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.7.57]
  by mail.gmx.net (mp040) with SMTP; 10 Aug 2007 03:11:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DJ8di6y9DA48wvA+V1y6Uw7OXueDx8uzZXgZY0V
	Khsy6zDpd1lvHf
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4xww6mr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55496>

Hi,

On Thu, 9 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > That is _completely_ expected.  If it is a bare repository, you can _only_ 
> > override that check by GIT_WORK_TREE or --work-tree.
> >
> > But I have to wonder: if you want to use git checkout-index, which is a 
> > work-tree operation, why did you mark it as bare to begin with?
> 
> I do not necessarily think --prefix=untar/it/here/ is a work
> tree operation.
> 
> Perhaps we probably are better off if we add something that says
> specifying GIT_DIR alone means you are at the top of work tree
> (to resurrect the traditional behaviour), to alleviate fallouts
> like this and the other cvsserver one?  If one does not like
> that traditional behaviour, the new GIT_WORK_TREE support can
> be used override it.

I think I sent a patch for that, but was negative about it, even if I 
promised not to question your decision.

Ciao,
Dscho
