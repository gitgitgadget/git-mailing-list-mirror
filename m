From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 16:06:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181605020.5731@racer.site>
References: <4790BCED.4050207@gnu.org> <alpine.LSU.1.00.0801181545530.5731@racer.site> <4790CAF7.5010908@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 17:07:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFtkN-0003OC-Ku
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 17:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762147AbYARQGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 11:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762802AbYARQGI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 11:06:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:52880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762356AbYARQGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 11:06:07 -0500
Received: (qmail invoked by alias); 18 Jan 2008 16:06:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 18 Jan 2008 17:06:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183o7VN8CY34+MG/nWVlV4Xh5GVmkPYN13ZYJX/iR
	aw89gTjps12CcT
X-X-Sender: gene099@racer.site
In-Reply-To: <4790CAF7.5010908@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71033>

Hi,

On Fri, 18 Jan 2008, Paolo Bonzini wrote:

> 
> > > The prepare-commit-msg hook is run whenever a "fresh" commit message 
> > > (i.e. not one taken from another commit with -c) is shown in the 
> > > editor. It can modify the commit message in-place and/or abort the 
> > > commit.
> > > 
> > > While the default hook just adds a Signed-Off-By line at the bottom 
> > > of the commit messsage, the hook is more intended to build a 
> > > template for the commit message following project standards.
> > 
> > Would it not be much better for that hook to verify that the template 
> > has not been added?
> 
> I fail to parse this.

What I meant is this:

In the message hook, just grep if the template was already added.  If it 
was, just return.  If it was not, add it.

No need for yet another hook.

Ciao,
Dscho
