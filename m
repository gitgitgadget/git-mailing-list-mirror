From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 01:51:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705070146140.4167@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon May 07 01:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkqVh-0005mr-U2
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbXEFXvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbXEFXvT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:51:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:43920 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752367AbXEFXvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:51:18 -0400
Received: (qmail invoked by alias); 06 May 2007 23:51:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 07 May 2007 01:51:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Yaz45Y0EY42EPx0BOnTLLzJYHdnSFEaycrj4rlz
	RskdnHXP+Q86K7
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqbqgxak1i.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46399>

Hi,

On Sun, 6 May 2007, Matthieu Moy wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> >  - You fundamentally cannot do it any other way.
> >
> >    Not doing it the way git does it (point to the content) means that the 
> >    index-replacement has to point to something else, namely a "file ID". 
> 
> Well, git's index still tells more than "the content FOOBAR exists,
> somewhere". It also "contains", if not "points to", the file name.

As you pointed out yourself, the index _has_ an idea of the content of 
that file. So, arguably, it does not point to _that_ file, but rather to 
that file _with a certain content_.

> > What's so hard with adding that "-a" to "git commit"? You don't even need 
> > it on the status line, the status is relevant and understandable (and 
> > actually tells you more) even without it.
> 
> Off course, I don't have strong argument against it. The biggest
> annoyance is that my fingers are used to "commit -m message", and now
> type "commit -a message", but ...

Just another reason to hate CVS. Because it trained people to do that. If 
it was not for the training by CVS, I would have strongly opposed to the 
introduction of the "-m" switch to commit. It _encourages_ bad commit 
messages.

Now, with Git I usually let git-commit start up the editor. Because then I 
am actually encouraged to make up my mind, and put down a meaningful 
message, which might not only help _others_ to understand why I did it, 
and how, but also _myself_ (after a few months).

> The reason why I'm posting this is that I was wondering whether "commit 
> -a" not being the default was supposed to be a message like "you 
> shouln't use it too often".

IMHO yes, that is the message.

In addition to being nice to people used to the behaviour of "git commit" 
_without_ other arguments.

Ciao,
Dscho
