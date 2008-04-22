From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote add: disallow --master and --mirror with non-bare
   repositories (review)
Date: Tue, 22 Apr 2008 23:04:35 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804222304100.22360@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local>
 <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <7vd4ohzvda.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221823010.4460@eeepc-johanness> <480E3294.4070807@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, Jeff King <peff@peff.net>,
	Mike Galbraith <efault@gmx.de>, git <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:06:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoQcH-0005tz-4M
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 00:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbYDVWEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 18:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757461AbYDVWEp
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 18:04:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:36999 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757460AbYDVWEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 18:04:44 -0400
Received: (qmail invoked by alias); 22 Apr 2008 22:04:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 23 Apr 2008 00:04:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194MnkwoVB4gszl9tCgsILLW0Y25vWUFmygGASG5R
	BrbRRaN/XHty3F
X-X-Sender: user@eeepc-johanness
In-Reply-To: <480E3294.4070807@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80169>

Hi,

On Tue, 22 Apr 2008, Paolo Bonzini wrote:

> > +	if (mirror && is_bare_repository())
> > +		die("--mirror with non-bare repository.");
> > +
> 
> Missing bang.  I think you need to adjust the testsuite, in fact.

Yep, I probably do.  If Junio nobody else beats me to it.

Ciao,
Dscho
