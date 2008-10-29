From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: jgit as a jira plugin
Date: Wed, 29 Oct 2008 16:53:17 -0700
Message-ID: <20081029235317.GC31926@spearce.org>
References: <5915DAE3-7BDF-4296-9DB3-6FBEE504A317@xiplink.com> <20081029230816.GA31926@spearce.org> <D7D18CE8-BDBD-430A-BCB6-D1BEFD21C949@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Longman" <longman@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:54:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvKrv-000215-QT
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbYJ2XxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbYJ2XxS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:53:18 -0400
Received: from george.spearce.org ([209.20.77.23]:35081 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbYJ2XxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:53:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C9AA738360; Wed, 29 Oct 2008 23:53:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <D7D18CE8-BDBD-430A-BCB6-D1BEFD21C949@xiplink.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99439>

"J. Longman" <longman@xiplink.com> wrote:
> Basically I stole the pgm.Fetch code:
>
> Transport tn = Transport.open(repository, "origin");
> final FetchResult r;
> List<RefSpec> toget = new ArrayList<RefSpec>();
> try {
> 	r = tn.fetch(new TextProgressMonitor(), toget);
> } finally {
> 	tn.close();
> }
>
> Can I assume that this enough to update the database?

Yes

> After this (and not shown) is some  
> logging code taken from Fetch, which results in the following:
>
> From /Users/longman/workspace2/work/../masterRepo/
>     131dcf5..078d43f  master     -> origin/master
>
> but there doesn't appear to be any specific mention of the incoming  
> changes.

Well, the new changes are what "git log 131dcf5..078d43f" outputs.

-- 
Shawn.
