From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule - register module url if adding in place
Date: Wed, 9 Jul 2008 02:11:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807090210080.5277@eeepc-johanness>
References: <1215484630-3784-1-git-send-email-mlevedahl@gmail.com> <alpine.DEB.1.00.0807081332580.4319@eeepc-johanness> <4873FF6E.2020602@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:12:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGNHy-0003tE-Qd
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbYGIALI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 20:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbYGIALH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 20:11:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:50468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751224AbYGIALG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 20:11:06 -0400
Received: (qmail invoked by alias); 09 Jul 2008 00:11:03 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp056) with SMTP; 09 Jul 2008 02:11:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NAyVtIobNl4u623JbkgQaaQXaHCjO5qXhBSLj0N
	2EkH5KcizYdr6t
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4873FF6E.2020602@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87816>

Hi,

On Tue, 8 Jul 2008, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > I agree with Sylvain here, namely that this is too dangerous.  
> > Imagine this very valid scenario:
> >
> >  $ git clone <somewhere> abc
> >  $ git submodule add abc
> >
> > Bummer.
> >
> > Yes, happened to me.
> >
> > So I'd like this to be an error, not something that tries to be 
> > helpful, when it clearly cannot be.
>
> I think the real issue here is that submodule-add is too flexible and 
> poorly documented, see my response to Junio in the other thread.

In contrast, I think that we should either disallow the form without URL, 
or get the URL automatically from the submodule's current branch's default 
remote.

Ciao,
Dscho
