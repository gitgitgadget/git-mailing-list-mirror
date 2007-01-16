From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail
 header
Date: Tue, 16 Jan 2007 12:41:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161239590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <871wm08kcu.fsf@morpheus.local> <7vd55jrj38.fsf@assigned-by-dhcp.cox.net>
 <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net> <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701131217410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <877ivo446n.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1219194599-1168947697=:22628"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 12:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6mhC-0005Oh-70
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 12:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbXAPLlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 06:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbXAPLlk
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 06:41:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:35323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751029AbXAPLlj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 06:41:39 -0500
Received: (qmail invoked by alias); 16 Jan 2007 11:41:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 16 Jan 2007 12:41:37 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <877ivo446n.fsf@morpheus.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36933>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1219194599-1168947697=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 15 Jan 2007, David Kågedal wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 12 Jan 2007, Junio C Hamano wrote:
> >
> >> Side note.  The previous patch does not help if your commit were
> >> made in non UTF-8 with not too recent git; the code assumes that
> >> commit messages without the new "encoding" headers are in UTF-8.
> >
> > Why not just use is_utf8() and warn, or error out, if the message is not 
> > UTF-8? (I tend towards the erroring out, since this _is_ a new feature, 
> > and gives undesired results with "old" commits.)
> 
> What do you mean? I have an old repository with latin1 commits without
> any encoding markers.  I want to be able to use format-patch from that
> and at least get a From: line with something readable.  You can't just
> barf and say "This isn't UTF-8, go away".

So what do you want to do instead? Just pretend that the unrecoded -- 
Latin-1 encoded -- text is UTF-8? That's plain wrong.

Ciao,
Dscho

---1148973799-1219194599-1168947697=:22628--
