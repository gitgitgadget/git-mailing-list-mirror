From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 19:25:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111924180.8950@racer>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com> <alpine.DEB.1.00.0807111649290.8950@racer> <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com> <20080711161158.GD10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:26:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNJz-0005BW-Vw
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbYGKSZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbYGKSZV
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:25:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:45076 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752315AbYGKSZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:25:21 -0400
Received: (qmail invoked by alias); 11 Jul 2008 18:25:18 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp002) with SMTP; 11 Jul 2008 20:25:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Gi2kTRX2Gl43hwpywfIjB+MR2guW5GWMUkL7HD4
	6bNF6RXUm+aBMz
X-X-Sender: gene099@racer
In-Reply-To: <20080711161158.GD10347@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88149>

Hi,

On Fri, 11 Jul 2008, Miklos Vajna wrote:

> On Fri, Jul 11, 2008 at 12:09:02PM -0400, Denis Bueno <dbueno@gmail.com> wrote:
> > On Fri, Jul 11, 2008 at 11:51, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > $ git cherry-pick -n <bla>
> > > $ git archive --format=tar --prefix=pfx/ $(git write-tree) | gzip > prj.tgz
> > > $ git reset
> 
> I guess he wanted to write 'git reset --hard' here ;-)

He did not ;-)  "git reset" resets only the index, which is what I wanted.

Anyway, back to Denis' question: I could imagine (haven't tested, 
thought), that "git revert -n <the-same-commit>" would undo the "git 
cherry-pick -n".

Please test and report back,
Dscho
