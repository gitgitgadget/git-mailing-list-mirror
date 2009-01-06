From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: BUG?? INSTALL MAKEFILE
Date: Tue, 6 Jan 2009 12:24:25 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901061210250.19665@iabervon.org>
References: <49635BF8.1010700@sadau-online.de> <vpqiqosa3fc.fsf@bauges.imag.fr> <49638625.3090109@tedpavlic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Lars Sadau <lars@sadau-online.de>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 18:25:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKFgc-0003nJ-8y
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 18:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbZAFRY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 12:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbZAFRY1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 12:24:27 -0500
Received: from iabervon.org ([66.92.72.58]:41867 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbZAFRY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 12:24:26 -0500
Received: (qmail 6295 invoked by uid 1000); 6 Jan 2009 17:24:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jan 2009 17:24:25 -0000
In-Reply-To: <49638625.3090109@tedpavlic.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104702>

On Tue, 6 Jan 2009, Ted Pavlic wrote:

> > but then realized that prefix is set to $(HOME) by default. Are you
> > sure you didn't edit the Makefile or run any sort of ./configure
> > before "make install" ?
> 
> After doing a
> 
> 	git clean -f

You need a "git clean -fx"

> According to the INSTALL doc, the default prefix should be ~. However, this is
> certainly not the case. Either the INSTALL doc needs to be updated or a new
> default config.mak.autogen needs to be checked in (or perhaps
> config.mak.autogen needs to be omitted from the repo?).

It's omitted from the repo, but it's in .gitignore so "git clean" doesn't 
remove it unless you tell it to remove ignored files.

	-Daniel
*This .sig left intentionally blank*
