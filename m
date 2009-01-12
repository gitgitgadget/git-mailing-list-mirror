From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 4/3] Add example git-vcs-p4
Date: Mon, 12 Jan 2009 13:36:03 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901121325080.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110336380.19665@iabervon.org> <81b0412b0901120346x79772846p6e5097028fc9720c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 19:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMRfW-0002Av-Ef
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 19:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbZALSgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZALSgL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 13:36:11 -0500
Received: from iabervon.org ([66.92.72.58]:56674 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbZALSgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 13:36:10 -0500
Received: (qmail 6273 invoked by uid 1000); 12 Jan 2009 18:36:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 18:36:03 -0000
In-Reply-To: <81b0412b0901120346x79772846p6e5097028fc9720c@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105372>

On Mon, 12 Jan 2009, Alex Riesen wrote:

> 2009/1/11 Daniel Barkalow <barkalow@iabervon.org>:
> > diff --git a/Makefile b/Makefile
> >
> > +LIB_OBJS += p4client.o
> > +LIB_OBJS += vcs-p4.o
> > +
> >
> > +extern int cmd_p4(int argc, const char **argv, const char *prefix);
> > +
> 
> Why is your foreign VCS importer built-in? The majority wont ever need it,
> yet they have to pay the price for its text being in git executable.

Purely for convenience in the RFC version. The real one will probably need 
to be linked separately, since it will want to have the option of using 
the terrible C++ API to the 
closed-source-but-you-can-download-it-from-them library.

	-Daniel
*This .sig left intentionally blank*
