From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 15:57:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091513360.4167@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705061851411.4015@racer.site>
 <vpqk5vlamav.fsf@bauges.imag.fr> <7vvef5c0fw.fsf@assigned-by-dhcp.cox.net>
 <20070509125225.GP4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 09 15:57:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlmfb-00069F-Iu
	for gcvg-git@gmane.org; Wed, 09 May 2007 15:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbXEIN50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 09:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbXEIN50
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 09:57:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:52421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753106AbXEIN5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 09:57:25 -0400
Received: (qmail invoked by alias); 09 May 2007 13:57:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 09 May 2007 15:57:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qYnETPrpqUrykNeoDIm6rueRj1CoAn3LzmFi0O3
	bEw7n51F7VyBAb
X-X-Sender: gene099@racer.site
In-Reply-To: <20070509125225.GP4489@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46718>

Hi,

On Wed, 9 May 2007, Petr Baudis wrote:

> On Sun, May 06, 2007 at 07:43:31PM CEST, Junio C Hamano wrote:
> > A single liner "-m" is handy for "Oops, typofix in foo.c" kind
> > of commit, but in such a case you literally would be changing
> > only the typofix and won't have "edit foo.c; git add foo.c; edit
> > foo.c; git commit" sequence anyway.
> 
> I don't get this argument - I frequently write quite long descriptions
> inside the -m argument(s), since I just find it more convenient than
> having to edit it in an editor, for various reasons. So there is really
> no reason why the "-m is only for short single-liner commit messages"
> hypothesis could hold true.

:-) You yourself provided a reason in another reply: typos.

Another reason is that you can see how the end result will look like in an 
editor. For example, you'll have a hard time making sure in the 
command line that the lines are no longer than 76 characters.

Ciao,
Dscho
