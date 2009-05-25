From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: can anybody explain the following to a git noob?
Date: Mon, 25 May 2009 13:10:59 +0200
Message-ID: <20090525111059.GE1070@macbook.lan>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com> <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com> <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com> <4A1671E5.4030400@op5.se> <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com> <4A16822A.2060404@viscovery.net> <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com> <alpine.LNX.2.00.0905221244370.2147@iabervon.org> <855e4dcf0905230121h28ef22f8n4758953e612325cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andreas Ericsson <ae@op5.se>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Tim Uckun <timuckun@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 13:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Y5N-0008If-GS
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 13:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbZEYLLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 07:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbZEYLLA
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 07:11:00 -0400
Received: from darksea.de ([83.133.111.250]:60365 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751044AbZEYLK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 07:10:59 -0400
Received: (qmail 13428 invoked from network); 25 May 2009 13:10:52 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 25 May 2009 13:10:52 +0200
Content-Disposition: inline
In-Reply-To: <855e4dcf0905230121h28ef22f8n4758953e612325cf@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119922>

On Sat, May 23, 2009 at 08:21:09PM +1200, Tim Uckun wrote:
> > I don't think any
> > version control system I know of likes having your initial import be of a
> > directory with other working directories for the same system as
> > subdirectories. (That is, Mercurial will be fine having git working
> > directories in the import, but git won't, and Mercurial wouldn't be happy
> > about having Mercurial working directories as subdirectories).
> >
> 
> I now realize that.  I did however did the same thing again but first
> deleted all the .git directories before doing a git init.  The end
> result didn't change.

Note that a second git init does not delete the previous database. So if
you want to start from scratch you need to delete the main .git folder.

As already mentioned a script recreating your setup from public sources
would really be a big help to find out were git does not do what you are
expecting.

cheers Heiko
