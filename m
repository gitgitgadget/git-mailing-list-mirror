From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist: Please add --author to git-tag
Date: Thu, 31 Jan 2008 23:48:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801312345520.23907@racer.site>
References: <47A20503.2000603@debian.org>  <20080131193550.GB10905@artemis.madism.org> <1b46aba20801311449l774a6213kc33c49c0682c0228@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 00:49:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKj9f-0000SS-HF
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 00:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759219AbYAaXsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 18:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274AbYAaXsn
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 18:48:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:54081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756246AbYAaXsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 18:48:42 -0500
Received: (qmail invoked by alias); 31 Jan 2008 23:48:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 01 Feb 2008 00:48:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RlxcPF3wRmxWph0+91aVj7HZljGF8H7PLFGRauH
	04bAo9zQW42a1I
X-X-Sender: gene099@racer.site
In-Reply-To: <1b46aba20801311449l774a6213kc33c49c0682c0228@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72142>

Hi,

On Thu, 31 Jan 2008, Carlos Rica wrote:

> On Jan 31, 2008 8:35 PM, Pierre Habouzit <madcoder@debian.org> wrote:
> > On Thu, Jan 31, 2008 at 05:27:31PM +0000, Daniel Baumann wrote:
> >
> > > git commit supports --author to overwrite the author information on 
> > > a particular commit; it would be nice if git tag would offer the 
> > > same.
> >
> >   Meanwhile,
> >
> >   GIT_AUTHOR_NAME="John Doe" GIT_AUTHOR_EMAIL=luser@example.com git tag
> 
> That didn't work for me,

Hey jasam, good to see you again.

I think that you have to use "-s" or "-a" for the author information to 
take effect (IOW a lightweight tag will not pick it up, since it is only a 
41-byte file, and does not change the object database).

Ciao,
Dscho
