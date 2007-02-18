From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-name-rev: accept list of refs from user
Date: Sun, 18 Feb 2007 01:02:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180101030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vmz3ctzer.fsf@assigned-by-dhcp.cox.net>
 <20070217231327.GA5382@coredump.intra.peff.net> <20070217231943.GA30839@coredump.intra.peff.net>
 <7vr6soqs5h.fsf@assigned-by-dhcp.cox.net> <20070217234046.GB6014@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZVh-0003ZL-Ox
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965414AbXBRACa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965415AbXBRACa
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:02:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:58061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965414AbXBRAC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:02:29 -0500
Received: (qmail invoked by alias); 18 Feb 2007 00:02:28 -0000
X-Provags-ID: V01U2FsdGVkX18HgyhXgwMHX5hjw3+TTWeRYYUNHBSRliBv3QRNTv
	LMKw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070217234046.GB6014@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40032>

Hi,

On Sat, 17 Feb 2007, Jeff King wrote:

> On Sat, Feb 17, 2007 at 03:30:02PM -0800, Junio C Hamano wrote:
> 
> > I was hoping that everybody would be happy once Johannes's patch
> > is extended to grok more than one --refs=<pattern> options.
> 
> I don't think just having text filters easily allows something like:
> 
>   git show-ref |
>     perl -ne 'print if m#tags/v1\.(\d+)# && $1 > 3' |
>     git name-rev --refs-from=- $commit

Does

	git name-rev --refs='*v1.[4-]*' $commit

what you are trying to achieve?

However, another use case could be where you do not want to tag a certain 
commit, but want to label it with a certin name just for this call to 
name-rev. But I don't know how useful that is.

Ciao,
Dscho
