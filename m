From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add support for GIT_CEILING_DIRS
Date: Wed, 14 May 2008 18:02:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141759120.30431@racer>
References: <482A7CA0.9060908@facebook.com> <alpine.DEB.1.00.0805140903560.30431@racer> <D2EA6017-4607-4A55-8C72-CD2B772CAAE4@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed May 14 19:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKNn-0007Kq-Sq
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbYENRCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYENRCY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:02:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:41413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752544AbYENRCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:02:24 -0400
Received: (qmail invoked by alias); 14 May 2008 17:02:22 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp013) with SMTP; 14 May 2008 19:02:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OWxM9FVwOk285d+xxTQunMJ9JRUJwjCQ5mhT5Qj
	/DE40o01pmZEQ1
X-X-Sender: gene099@racer
In-Reply-To: <D2EA6017-4607-4A55-8C72-CD2B772CAAE4@sb.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82110>

Hi,

On Wed, 14 May 2008, Kevin Ballard wrote:

> On May 14, 2008, at 3:23 AM, Johannes Schindelin wrote:
> 
> > >@@ -414,6 +415,37 @@ const char *setup_git_directory_gently(int *nongit_ok)
> > > if (!getcwd(cwd, sizeof(cwd)-1))
> > >  die("Unable to read current working directory");
> > >
> > >+	// Compute min_offset based on GIT_CEILING_DIRS.
> >
> >We do not like C99 style comments.  Remember, there are people who compile
> >Git on something else than the super-latest Linux with cutting-edge GCC.
> 
> Out of curiosity, what environment these days doesn't allow C99 comments?

On an SGI/IRIX machine I was working some time ago, GCC was too big for my 
quota.  And the admin was not willing to install it.

But I have to wonder: why argue something as C99 comments, when it is _no 
problem_ whatsoever to replace them with C89-style comments, especially 
given the fact that this makes our source code more consistent and thus 
easier on the eye?

Ciao,
Dscho
