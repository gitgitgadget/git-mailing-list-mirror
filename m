From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: List of files aded/removed/modified by "git-checkout"
Date: Thu, 7 Feb 2008 16:11:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802071610370.8543@racer.site>
References: <jwvodatkbdm.fsf-monnier+gmane.comp.version-control.git@gnu.org> <7vve51qva3.fsf@gitster.siamese.dyndns.org> <jwvfxw4ga0s.fsf-monnier+inbox@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Thu Feb 07 17:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9N8-00045R-3R
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 17:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbYBGQMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 11:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755570AbYBGQMW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 11:12:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:37977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755644AbYBGQMV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 11:12:21 -0500
Received: (qmail invoked by alias); 07 Feb 2008 16:12:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 07 Feb 2008 17:12:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18T1WNjEwoTcTPNh8moaGZ8qu3nAPBVa+eCSm8jEd
	uHbqQx+r6M9BCN
X-X-Sender: gene099@racer.site
In-Reply-To: <jwvfxw4ga0s.fsf-monnier+inbox@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72960>

Hi,

On Thu, 7 Feb 2008, Stefan Monnier wrote:

> >> Whenever I do a git-checkout to switch between branches, I'm 
> >> disappointed by the absence of a "-v" option which would list the 
> >> operations performed.
> >> 
> >> How can I get this information?
> 
> > I'd be mightily annoyed with it myself, though, as I switch between 
> > 'master', 'next', 'pu' and 'maint' pretty often.
> 
> Why would such a "-v" option bother you?  Nobody forces you to use it.

I agree.

> > Have something like this in .git/hooks/post-checkout and make it 
> > executable, perhaps?  Modify the options to suit your taste.
> 
> That doesn't really cut it: I'd like to use it in a git frontend.

Well, this request does not really cut it: it lacks a patch.  And yes, you 
have been given enough information to hack it yourself.  No, I will not do 
something about it; this is not my itch.

Hth,
Dscho
