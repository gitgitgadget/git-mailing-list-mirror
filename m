From: Jeff King <peff@peff.net>
Subject: Re: why no "ignore" command on git
Date: Thu, 15 Oct 2009 11:52:20 -0400
Message-ID: <20091015155220.GA12169@coredump.intra.peff.net>
References: <42efdea40910141535g23a50b87p9b6c4a0fde7e842e@mail.gmail.com>
 <200910142220.51725.wjl@icecavern.net>
 <vpqaazsrj0q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Wesley J. Landaker" <wjl@icecavern.net>,
	Ralf Thielow <ralf.thielow@googlemail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 15 17:58:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MySiK-0000VE-7z
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 17:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbZJOPw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 11:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbZJOPw6
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 11:52:58 -0400
Received: from peff.net ([208.65.91.99]:54433 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932095AbZJOPw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 11:52:57 -0400
Received: (qmail 8053 invoked by uid 107); 15 Oct 2009 15:55:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Oct 2009 11:55:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Oct 2009 11:52:20 -0400
Content-Disposition: inline
In-Reply-To: <vpqaazsrj0q.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130397>

On Thu, Oct 15, 2009 at 01:31:01PM +0200, Matthieu Moy wrote:

> >> why there is no "ignore" command on git?
> >
> > You could always make your own git-ignore script, e.g.:
> >
> > #!/bin/sh
> > echo "$@" >> .gitignore
> 
> Sure. OTOH, there are other interesting things a "ignore" command can
> do. bzr, for example, has a "bzr ignore" command that can either add
> stuff to your .bzrignore, or tell you which pattern cause which file
> to be ignored. That's handy sometimes.

I wrote a toy patch that did something like that a while ago:

  http://thread.gmane.org/gmane.comp.version-control.git/108671/focus=108842

I don't think there is any reason such a thing could not be included
with git (if it did something more interesting than just echoing its
arguments to .gitignore), but nobody has felt strongly enough about it
yet to actually write something polished.

-Peff
