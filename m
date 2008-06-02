From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 00/12] Extensions in core needed by PackWriter
Date: Tue, 3 Jun 2008 00:43:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806030040560.13507@racer.site.net>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com> <alpine.DEB.1.00.0806022313270.13507@racer.site.net> <48447B02.3040505@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: robin.rosenberg@dewire.com, spearce@spearce.org,
	git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 01:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3JiF-0004oE-5Z
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 01:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbYFBXoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 19:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbYFBXoX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 19:44:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:33140 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752596AbYFBXoW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 19:44:22 -0400
Received: (qmail invoked by alias); 02 Jun 2008 23:44:19 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 03 Jun 2008 01:44:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/E9VciDrrE6T9NIdYBw708HpJiIKvIp2dr6u3mEK
	Lh7ThusRr2Xryo
X-X-Sender: gene099@racer.site.net
In-Reply-To: <48447B02.3040505@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83597>

Hi,

On Tue, 3 Jun 2008, Marek Zawirski wrote:

> Johannes Schindelin wrote:
> (...)
> > You mean line-wrapping, right?  Is there a different recommended 
> > column/line ratio for JGit than for Git?  Because some of your later 
> > patches introduce lines longer than 80 columns/line.
> 
> Not only line-wrapping in fact. egit/jgit use it's own eclipse 
> formatting template that define more than line-wrapping, even some 
> spaces in javadocs as you may have seen.
>
> Actually I don't know is it 80 columns/line (but I suspect it may be), 
> as I just use this formatter associated with project by simply pressing 
> some keyboard shortcut. Maybe I simply missed some formatting, which 
> patch do you mean? Some things however look strange after 
> auto-formatting. While it may even look ugly for somebody I wouldn't try 
> to change that by hand, to make other commiters lifes easier allowing 
> them also just press "format" button ;)

Ah, thanks for the explanation!

> > >   Add getType() method to RevObject hierarchy
> > 
> > Was the idea not to use instanceof to be able to have multiple "types" 
> > per object?  I.e. a commit object is of type commit, but also of type 
> > object...
> 
> I'm not sure whether I understand you, but probably it was not what you 
> mean. The only idea behind that was to refactor instanceofs to 
> polymorphic getType() calls.

Actually, the result is no longer polymorphic, as every object can have 
only one type now.

> It allows us mapping, indexing by type, using switches... without tones 
> of code.

Hrm, I thought that you added more lines than you deleted.  But hey, I do 
not really know what you want to index, maybe you got a point there.  I 
guess I'll see ;-)

Ciao,
Dscho
