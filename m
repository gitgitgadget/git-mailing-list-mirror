From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: symbolic link management in git-archive
Date: Thu, 27 Mar 2008 12:44:57 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803271244420.3802@racer.site>
References: <loom.20080327T112740-539@post.gmane.org> <20080327114024.GR14567@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergio Callegari <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 12:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeqY5-0003B6-9f
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 12:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801AbYC0Lo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 07:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbYC0Lo4
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 07:44:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:42011 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755370AbYC0Lo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 07:44:56 -0400
Received: (qmail invoked by alias); 27 Mar 2008 11:44:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 27 Mar 2008 12:44:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PgUtbjXjPOaD2kLxJNuamBp6aQ6fzFaEzBGVL/n
	ZTRdx+/nSMsVLQ
X-X-Sender: gene099@racer.site
In-Reply-To: <20080327114024.GR14567@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78346>

Hi,

On Thu, 27 Mar 2008, Miklos Vajna wrote:

> On Thu, Mar 27, 2008 at 11:29:28AM +0000, Sergio Callegari <sergio.callegari@gmail.com> wrote:
> > I guess the answer is "no" or "not yet", but is there a way to tell the zip
> > backend of git-archive to follow symbolic links rather than to store them?
> 
> how would that handle a '. -> foo' symlink? following such a recursion
> would lead to an infinite loop, i guess.

Don't forget '/ -> foo'.

Ciao,
Dscho
