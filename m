From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Thu, 26 Nov 2009 00:34:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911260032410.4985@pacific.mpi-cbg.de>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:30:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRK1-0008U7-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935123AbZKYXam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934909AbZKYXam
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:30:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:54111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934886AbZKYXal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:30:41 -0500
Received: (qmail invoked by alias); 25 Nov 2009 23:30:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 26 Nov 2009 00:30:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tt9NCvYDtp3FGngGNjCcMNV43oyJucL5GaSIhMU
	rZ76RJaIAaE1/A
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vmy2as319.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133703>

Hi,

On Wed, 25 Nov 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Nov 25, 2009 at 12:52:11PM -0800, Junio C Hamano wrote:
> >
> >> So I think the posted patch alone without changing anything else would be
> >> the approach to give the most benefit with the least impact to existing
> >> users, at least for now.
> >
> > Yes, I meant to say in my original message but forgot to: I think
> > --full-tree is an important first step, no matter what happens next. It
> > gives people a way to do what they want without typing the right number
> > of ".."s, and it opens up --no-full-tree if the default changes later.
> >
> > But I do worry about it being a command-line option. You are asking the
> > user to remember to type --full-tree every time.
> 
> We could redefine get_pathspec() to treat a pathspec that begins with a
> slash to be anchored at the top,

This would break spectacularly in MSys.  And this is just one reason not 
to do this "magic".

Clearly, a command line option is the only unambiguous way to do what you 
want to do (and not changing the default all of a sudden).

Ciao,
Dscho
