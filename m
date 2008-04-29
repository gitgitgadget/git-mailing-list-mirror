From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 22:39:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804292236380.13650@eeepc-johanness>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org>
 <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <20080429204417.GC6301@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, srb@cuci.nl
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:40:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxYX-0002wh-Su
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbYD2VjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbYD2VjW
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:39:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:44440 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753242AbYD2VjT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:39:19 -0400
Received: (qmail invoked by alias); 29 Apr 2008 21:39:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp020) with SMTP; 29 Apr 2008 23:39:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tH9FTnUft88wDB/5NYIy6Nu4JvQMQxQJMvmIKh6
	AUUe+QIf15e6fo
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080429204417.GC6301@steel.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80743>

Hi,

On Tue, 29 Apr 2008, Alex Riesen wrote:

> Paolo Bonzini, Tue, Apr 29, 2008 09:57:57 +0200:
>
> > 3) your complaint was that it gave errors.  Alex did talk about losing 
> >    his work, but questions 1 and 2 would apply to him too.
> 
> Yes. And I can loose my work if "git fetch" (which I type without 
> thinking) will now update some remote I didn't mean it to. Remote 
> references can be shared - updated from different sites (think mirros 
> like kernel.org and repo.or.cz). Setups like this are used elsewhere too 
> (I use them).

Like I said, I think this change affects too many existing users in a very 
negative way.

But then, I respect Junio's very careful way of dealing with such issues, 
and am not really doubting that it will take a long, long time to change 
the default behaviour of Git, if at all.  Which is a good thing.

And I am certain that Paolo does not believe his release notes argument 
either.  Not seriously, anyway.

Ciao,
Dscho
