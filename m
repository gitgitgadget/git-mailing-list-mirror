From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and
 --prune-empty.
Date: Fri, 31 Oct 2008 23:36:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810312334480.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pasky@suse.cz, srabbelier@gmail.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:31:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2W4-0000M4-Tl
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYJaW3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYJaW3k
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:29:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:56188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751096AbYJaW3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:29:39 -0400
Received: (qmail invoked by alias); 31 Oct 2008 22:29:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 31 Oct 2008 23:29:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184yys6pPU4F+e25B4iRHz2HxUYUS9jv8fA58mxc5
	5Ar6bd62rwlIT8
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1225445204-28000-1-git-send-email-madcoder@debian.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99662>

Hi,

On Fri, 31 Oct 2008, Pierre Habouzit wrote:

> git_commit_non_empty_tree is added to the functions that can be run from 
> commit filters. Its effect is to commit only commits actually touching 
> the tree and that are not merge points either.
> 
> The option --prune-empty is added. It defaults the commit-filter to
> 'git_commit_non_empty_tree "$@"', and can be used with any other
> combination of filters, except --commit-hook that must used
> 'git_commit_non_empty_tree "$@"' where one puts 'git commit-tree "$@"'
> usually to achieve the same result.

I think that the example Sverre posted is better.  It might be a bit more 
to write out, but at least people can adapt it to their needs (as opposed 
to only skip "empty" commits).

However, I would _love_ to see your tests being merged with Sverre's patch 
(of course, the tests should use the described procedure, then).

Ciao,
Dscho
