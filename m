From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 17:13:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804291711450.27457@eeepc-johanness>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org>
 <20080429053814.GA3332@steel.home> <4816BAB1.7080601@op5.se> <4816C67E.8010600@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:14:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqsTQ-0007pM-Oh
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbYD2QNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbYD2QNo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:13:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:49879 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754458AbYD2QNn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:13:43 -0400
Received: (qmail invoked by alias); 29 Apr 2008 16:13:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp021) with SMTP; 29 Apr 2008 18:13:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e8GNjWNYe+D7wXP8acMBi9CHtOhcd4j6CpIByU8
	U7jb9XFeQ6X/vf
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4816C67E.8010600@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80699>

Hi,

On Tue, 29 Apr 2008, Paolo Bonzini wrote:

> > Some of them point to my colleagues laptops, where temporary
> > git-daemons sometimes serve content, and sometimes it doesn't.
> 
> Again, you should probably have skipDefaultUpdate set on those remotes even
> now!

Umm, why?

>  A patch that makes a "wrong" (or incomplete) configuration more
> apparent, is not necessarily wrong in itself.

Your suggested changes are actively _making_ them wrong.  They are not 
wrong now.

Happily, I am quite certain that Junio will not allow such dramatic 
changes into Git, at least not without a long, long time of warning, 
during which I can safely undo the changes in my personal branch.

Because I do like to call "git remote update" from time to time, and I 
absolutely hate the idea of "origin" _not_ being special.

Ciao,
Dscho
