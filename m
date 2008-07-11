From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: feature request: git-log should accept sth like
 v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 15:36:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111533310.8950@racer>
References: <200807102057.15063.toralf.foerster@gmx.de> <alpine.DEB.1.00.0807102028420.18205@racer> <200807111539.06606.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1771059144-1215786967=:8950"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHJkE-0006XU-1s
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 16:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbYGKOgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 10:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbYGKOgL
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 10:36:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:38189 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752106AbYGKOgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 10:36:10 -0400
Received: (qmail invoked by alias); 11 Jul 2008 14:36:08 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp052) with SMTP; 11 Jul 2008 16:36:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QQuN/l9sQNpl+VIzYd9kl1DvNB1GIrnC9F/SEuR
	To1y25rDAv8zOu
X-X-Sender: gene099@racer
In-Reply-To: <200807111539.06606.toralf.foerster@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88122>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1771059144-1215786967=:8950
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 11 Jul 2008, Toralf Förster wrote:

> At Thursday 10 July 2008 21:29:07 Johannes Schindelin wrote :
> 
> > On Thu, 10 Jul 2008, Toralf Förster wrote:
> > 
> > > I appended those strings to the names of my UML kernel executables. 
> > > Unfortunately I didn't used the commit id and now I'm wondering 
> > > whether git could accept v2.6.26-rc9-56 as well in future.
> > 
> > If that were unambiguous, yes.  But it is not.
> 
> Ok, following the thread I understand why this feature isn't wanted by 
> all. But for the given example (where I only pulled from another git 
> tree) this could work, isn't it : ?
> 
> tfoerste@n22 ~/devel/linux-2.6 $ git-log v2.6.26-rc9.. | perl -e '@c = grep { /^commit/ } <>; print map { $#c - $i++ . "\t" . $_ } @c'

The question is not so much if it would work, but what people would do 
with this.  They would probably include something in a mail to you like 
"v2.6.26-rc9-111 stopped working!", you would test "v2.6.26-rc9-111" and 
go back "but it still works!".

Because you are talking about two different things.

So, in what workflow would v2.6.26-rc9-111 actually be helpful?  For 
yourself working in your own lil' branch?  I do not think so.  HEAD~23 is 
much more helpful in that case, since locally, you do not work so much 
relative to a given tag, but relative to your current HEAD.

Hth,
Dscho

--8323329-1771059144-1215786967=:8950--
