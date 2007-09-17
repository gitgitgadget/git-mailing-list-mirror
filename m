From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] apply: get rid of --index-info in favor of --build-fake-ancestor
Date: Tue, 18 Sep 2007 00:04:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709172355020.28586@racer.site>
References: <Pine.LNX.4.64.0709172330400.28586@racer.site>
 <7v7imozzgm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPen-0003oV-6q
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbXIQXF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 19:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901AbXIQXF2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:05:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:47184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753767AbXIQXF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:05:27 -0400
Received: (qmail invoked by alias); 17 Sep 2007 23:05:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 18 Sep 2007 01:05:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qCrQADZ5qWrYh1feOi5EUd6vEQwNg/s+Zb6tR2t
	csDTL6nTo1Pi7m
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7imozzgm.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58494>

Hi,

On Mon, 17 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Suggested by Junio, but the errors are all mine.
> >
> > 	I am not quite certain, though, if there is really no porcelain 
> > 	using that option.  It has been around since Oct 7 2005 (!), so 
> > 	there is a real chance that StGit, guilt or QGit use it.  In that 
> > 	case, this patch is obviously wrong.
> 
> You do not have to do the deprecating/removing part if that is
> the issue.

I'd rather avoid keeping this code, if nobody uses it anyway...

So I cloned StGit and guilt (the two porcelains that I feel are most used, 
apart from what is in git.git, and I'm too lazy to find that mail 
analysing the recent Git survey).  Neither of them has any --index-info in 
their complete history.

So I'm more confident now that there is no need to keep --index-info.

Ciao,
Dscho
