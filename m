From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 12:37:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151225130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr>
 <Pine.LNX.4.63.0702151152320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <vpqabzfsn1b.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 15 12:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHevW-00046u-Cj
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965904AbXBOLhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965905AbXBOLhX
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:37:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:51303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965904AbXBOLhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:37:22 -0500
Received: (qmail invoked by alias); 15 Feb 2007 11:37:20 -0000
X-Provags-ID: V01U2FsdGVkX1+lfx8Fj9qlDw9ha6D8dFGDbUujtQ6/4nJTYdf12o
	jVkw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <vpqabzfsn1b.fsf@olympe.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39821>

Hi,

[Cc'ed Duy, as he raised the same concerns.]

On Thu, 15 Feb 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 15 Feb 2007, Matthieu Moy wrote:
> >
> >> Is there a way to have a per-user ignore list in git?
> >
> > It's not really per user, but how about doing it with templates?
> 
> Correct me if I'm wrong (I didn't really find a documentation for 
> templates), but I believe this would only apply to newly created 
> project.

Yes. However, you can safely call "git init" in an _existing_ repo. It 
does not overwrite existing files.
 
> Then, it doesn't apply if I clone the project of someone using another 
> editor for example, nor to my old projects if I add something to the 
> list of things I want to ignore.

"git clone" implicitly calls "git init"; Therefore you get the templates, 
too. But you're right, if you already edited .git/info/exclude, this will 
not overwrite it.

Of course, you could fiddle with ~/.gitconfig, or even ~/.gitignore, but I 
suggest that you first think about a sane syntax.

Also note that this opens the door for shooting-in-the-foot; files you are 
certain you want ignored can show up in a cloned repo all to easy.

Ciao,
Dscho
