From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 18:06:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181804410.5731@racer.site>
References: <4790BCED.4050207@gnu.org> <alpine.LSU.1.00.0801181545530.5731@racer.site> <4790CAF7.5010908@gnu.org> <alpine.LSU.1.00.0801181605020.5731@racer.site> <4790D5CF.8000602@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 19:06:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFvc5-0002fl-Kd
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 19:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759238AbYARSGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 13:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758119AbYARSGP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 13:06:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:41042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758780AbYARSGO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 13:06:14 -0500
Received: (qmail invoked by alias); 18 Jan 2008 18:06:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 18 Jan 2008 19:06:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CR1Qqg7ICNyVQCZu8ra7kQINREdHbyeQtJcR6Jd
	XC0e5ukSPaU9vk
X-X-Sender: gene099@racer.site
In-Reply-To: <4790D5CF.8000602@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71045>

Hi,

On Fri, 18 Jan 2008, Paolo Bonzini wrote:

> 
> > In the message hook, just grep if the template was already added.  If it
> > was, just return.  If it was not, add it.
> 
> Ah, so you want me to always type ":q!" to exit and unnecessarily 
> complicate the commit-msg hook.  Cunning, but no, thanks.

No, my intention was to avoid complications.  Like introducing yet another 
commit hook.  I like clean, elegant semantics.  I don't like overbloated 
semantics.  That's why I speak up whenever I fear it is entering git.

Hth,
Dscho
