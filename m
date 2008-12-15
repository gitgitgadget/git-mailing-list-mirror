From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Interactive rebase encoding
Date: Mon, 15 Dec 2008 17:56:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812151755040.30769@pacific.mpi-cbg.de>
References: <85647ef50812150442n48609eadl4f3e47fcc715e643@mail.gmail.com>  <alpine.DEB.1.00.0812151652400.30769@pacific.mpi-cbg.de> <85647ef50812150821g4a032af0u31425fd7f4c0fd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 17:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGcm-0006pC-SW
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 17:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbYLOQrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 11:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYLOQrd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 11:47:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:59319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752621AbYLOQrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 11:47:32 -0500
Received: (qmail invoked by alias); 15 Dec 2008 16:47:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 15 Dec 2008 17:47:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/unbkW6cnutfKpXSL9HpO9XtJ4mO4phP3WeB6zSu
	rB9Gf+UrpNkESd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85647ef50812150821g4a032af0u31425fd7f4c0fd9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103180>

Hi,

On Mon, 15 Dec 2008, Constantine Plotnikov wrote:

> On Mon, Dec 15, 2008 at 6:54 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Indeed, I cannot think of any scenario where it might make sense to 
> > have a different encoding in git rebase -i than in git log.
> 
> For IDE, it might make sense to force UTF-8 encoding instead of using 
> currently configured logoutputencoding.

I consider rebase -i to be porcelain, and as such not suitable to be used 
as a backend for an IDE.  Help the git-sequencer effort if you want a 
plumbing.

Ciao,
Dscho
