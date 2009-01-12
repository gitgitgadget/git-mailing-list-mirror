From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 2/3] Add specification of git-vcs helpers
Date: Mon, 12 Jan 2009 12:46:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901121228331.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110334350.19665@iabervon.org> <496AFB8D.4000803@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQtD-00013o-89
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbZALRqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbZALRqY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:46:24 -0500
Received: from iabervon.org ([66.92.72.58]:52547 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbZALRqX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:46:23 -0500
Received: (qmail 4520 invoked by uid 1000); 12 Jan 2009 17:46:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 17:46:21 -0000
In-Reply-To: <496AFB8D.4000803@viscovery.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105364>

On Mon, 12 Jan 2009, Johannes Sixt wrote:

> Daniel Barkalow schrieb:
> > +NAME
> > +----
> > +git-vcs-* - Helper programs for interoperation with foreign systems
> > +
> > +SYNOPSIS
> > +--------
> > +'git vcs-<system>' <command> [options] [arguments]
> 
> The current rule is that helper programs have double-dash in the name:
> git-rebase--interactive, git-web--browse, etc.

I'm not entirely sure if these are helper programs in that sense, or 
really what the distinction is between these and regular plumbing. 
Multiple programs will be calling them, and they'll have a specified API, 
in any case. (I think the double-dash programs are ones where all of the 
call sites are internal, so both the API and all the users can be changed 
together.)

	-Daniel
*This .sig left intentionally blank*
