From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 15:19:01 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231518340.4353@racer.site>
References: <47E65AF5.4060708@dirk.my1.cc> <76718490803230645k13471472sc99932563b0239da@mail.gmail.com> <47E66382.5030800@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-948370244-1206281944=:4353"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdR3H-00015X-PM
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575AbYCWOTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757604AbYCWOTF
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:19:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:41468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754776AbYCWOTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:19:03 -0400
Received: (qmail invoked by alias); 23 Mar 2008 14:19:01 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp053) with SMTP; 23 Mar 2008 15:19:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wCsBieEhwZvqpdsHZVJiCsRKjPTqSBJW8U2hMhS
	WCKbTfPIka3cHV
X-X-Sender: gene099@racer.site
In-Reply-To: <47E66382.5030800@dirk.my1.cc>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77905>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-948370244-1206281944=:4353
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 23 Mar 2008, Dirk Süsserott wrote:

> Jay Soffian schrieb:
> > On Sun, Mar 23, 2008 at 9:28 AM, Dirk Süsserott <newsletter@dirk.my1.cc>
> > wrote:
> >   
> > > Hi, I've a question concerning git config and the alias things.
> > >  I'd like to create an alias 'atag' that creates an annotated
> > >  tag with the message being the same as the tag. Usually I create
> > >  annotated tags like this:
> > >
> > >  $ git tag -a -m "mytag" mytag
> > >
> > >  (BTW: It's not documented, but I have the impression that
> > >  the '-a' switch is implicitely added when the '-m' switch
> > >  is present. Is that true?)
> > >
> > >  I'd like to have an alias like this:
> > >
> > >  [alias]
> > >     atag = tag -a -m "$1"
> > >
> > >  So that I can simply call
> > >
> > >  $ git atag mytag
> > >
> > >  Is it possible to pass parameters to the alias definition?
> > >  With the definition above I got a tag with message "$1".
> > >     
> >
> > atag = !git tag -a -m "$1"

Why so complicated?

	atag = tag -a -m

should work already.

Hth,
Dscho
--8323584-948370244-1206281944=:4353--
