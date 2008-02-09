From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fetch workflow improvements
Date: Sat, 9 Feb 2008 13:22:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091321110.11591@racer.site>
References: <3f4fd2640802090257m9ab8e24l2a836abfd2ef6bf@mail.gmail.com> <alpine.LSU.1.00.0802091318080.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpfd-0004zk-1d
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbYBINWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbYBINWa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:22:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:52131 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754670AbYBINW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:22:29 -0500
Received: (qmail invoked by alias); 09 Feb 2008 13:22:27 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp003) with SMTP; 09 Feb 2008 14:22:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189R2diTqY965yXMTaa2Uy56tR3tXwdHxqb3OH2Ot
	zSuLxbGsbikLv7
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802091318080.11591@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73224>

Hi,

On Sat, 9 Feb 2008, Johannes Schindelin wrote:

> On Sat, 9 Feb 2008, Reece Dunn wrote:
> 
> >     1.  When running `git fetch` on a bare repository that does not 
> > have a remote called 'origin', fetch fails. I would like this to pick 
> > up the first remote entry in the config file.
> 
> I am opposed to that.  If you want a default remote, then set the remote 
> "origin".  That is well established semantics, and you would only 
> confuse yourself if all of a sudden you fetched from a remote that you 
> erroneously added at some stage.

Oh and I completely forgot: if you have a bare repository, chances are 
that it should fetch in mirror mode.  You'd probably DWIM that, too, which 
would make semantics even worse.

Ciao,
Dscho
