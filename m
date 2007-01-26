From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Fri, 26 Jan 2007 22:09:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701262200131.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
 <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45B78836.5080508@zytor.com> <Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45B78C55.2030204@zytor.com> <ep83m2$mts$1@sea.gmane.org> <45B8E551.9020808@zytor.com>
 <7vireuxbel.fsf@assigned-by-dhcp.cox.net> <45BA2ED2.7080807@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 22:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAYK3-0001S6-2N
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 22:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbXAZVJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 16:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbXAZVJU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 16:09:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:38061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752149AbXAZVJT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 16:09:19 -0500
Received: (qmail invoked by alias); 26 Jan 2007 21:09:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 26 Jan 2007 22:09:17 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45BA2ED2.7080807@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37882>

Hi,

On Fri, 26 Jan 2007, H. Peter Anvin wrote:

> Junio C Hamano wrote:
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > 
> > > For heaven's sake, in computer science we can *NEVER* use the same
> > > feature for *MORE THAN ONE THING*.  If it doesn't work format-wise
> > > that's fine, but "it's only supposed to be used by dumb transports" is
> > > ridiculous.
> > 
> > Hmmmm... I am lost here....
> > 
> 
> Jakub and Johannes seems to have been arguing that "info/refs is for dumb
> transports, therefore it cannot be used for any other purpose."  I find this
> argument utterly bizarre, since in general, in computer science, you try to be
> multipurpose whenever practical.

You keep on harping on that issue. I really get tired of it.

You seem to propose that we should stuff things into .git/info/refs, just 
because it is already there.

You seem to suggest that computer science is all about breaking things, to 
muddle waters by mixing things which are clearly different kinds of 
kettle, to "just" add a small thing here and there, all under the guise of 
multi-purposity or whatever.

You seem to reason that practicality is more important than good style.

You know, this reasoning brought to us that big crap sh*tpile called 
Windows. They also thought: it's not a big deal, let's introduce just a 
little thing here and there, and a direct call from this component to that 
component cannot hurt, cannit?

I am really, really getting tired of that kind of reasoning.

If you don't see how UNELEGANT it is to force dumb transports to download 
things MEANT FOR GITWEB, and how much NICER it would be to have a file 
WHICH IS ONLY MEANT FOR GITWEB TO BEGIN WITH, and which is easily 
EXTENSIBLE, since we don't have to CARE about DUMB TRANSPORTS, because 
gitweb data is a PURELY LOCAL thing, while dumb transports are NOT, I will 
just start to ignore you.

Ciao,
Dscho
