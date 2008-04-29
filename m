From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 23:26:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804292324040.13650@eeepc-johanness>
References: <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org>
 <20080429204417.GC6301@steel.home> <48178FD6.90104@gnu.org> <20080429213323.GA2413@steel.home> <48179625.3050704@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:27:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqyID-0000X8-N8
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 00:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbYD2W0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 18:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbYD2W0e
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 18:26:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:34170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbYD2W0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 18:26:33 -0400
Received: (qmail invoked by alias); 29 Apr 2008 22:26:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp057) with SMTP; 30 Apr 2008 00:26:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19i13YMopZi43p3hMF9yJe47MM01FNmQPTCN50R0J
	4G+Gm7QYgBwiee
X-X-Sender: user@eeepc-johanness
In-Reply-To: <48179625.3050704@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80759>

Hi,

On Tue, 29 Apr 2008, Paolo Bonzini wrote:

> I mean, I just wonder why as long as I had one remote only, I could 
> write "git push", while now I have to write "git push origin && git push 
> mirror".  The patch to "git fetch" comes from this observation too, and 
> I think it is a good idea, even though I'm less attached to it and it 
> would influence my workflow much less.

I wonder why you need to make such a big change, which _is_ incompatible, 
and not do the obvious thing, namely introduce a subcommand to "git 
remote" which does the "push" equivalent of "git remote update"...

Do you really think that it is a good idea to push down a huge change like 
this down everybody else's throat, just because you do not want to type 
"git remote ..." but "git fetch ..." in your workflow?

Ciao,
Dscho
