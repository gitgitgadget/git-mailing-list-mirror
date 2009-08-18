From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save'
 is omitted
Date: Wed, 19 Aug 2009 00:37:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908190035140.8306@pacific.mpi-cbg.de>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr> <vpqws51l1hb.fsf@bauges.imag.fr> <20090818174509.GA27518@coredump.intra.peff.net> <alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de> <vpqtz0423jk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 00:36:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdXIF-0005Nc-ID
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 00:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZHRWgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 18:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZHRWga
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 18:36:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:39740 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751318AbZHRWga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 18:36:30 -0400
Received: (qmail invoked by alias); 18 Aug 2009 22:36:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 19 Aug 2009 00:36:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fUGowJbSfgHUZCdbT62EuSVMta6LiCIZsRk1oq9
	zHarWf89o3zC64
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <vpqtz0423jk.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126475>

Hi,

On Tue, 18 Aug 2009, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > But it is sloppy, in that it blindly accepts options that might be 
> > valid for several subcommands, not just "save".
> 
> I wouldn't call that sloppy. 'save' is the default command, if you don't 
> provide any command, then 'save' will be used.

'save' might be the default command, but we don't trigger it with _any_ 
crap, for a very good reason.  Read the commit log for git-stash.sh to 
know why.

> > So please register my objection.
> 
> I will if you register my objection to yours ;-).
> 
> Jokes aside,

If you think that's funny, I don't.  I actually put a lot of thought into 
the issue whether to allow _any_ parameter with looks like an option to 
trigger "save".  And I very much had to come to the decision that no, that 
is too dangerous.

So I cannot take your objection seriously.

Ciao,
Dscho
