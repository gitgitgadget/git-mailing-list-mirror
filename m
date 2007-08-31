From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] filter-branch: introduce convenience function
 "skip_commit"
Date: Fri, 31 Aug 2007 22:05:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312204490.28586@racer.site>
References: <Pine.LNX.4.64.0708312005420.28586@racer.site>
 <20070831191921.GB2151@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDge-0006Wi-Kk
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761204AbXHaVFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761185AbXHaVFs
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:05:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:33620 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761029AbXHaVFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:05:47 -0400
Received: (qmail invoked by alias); 31 Aug 2007 21:05:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 31 Aug 2007 23:05:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+R1lgbXKWRCtwGPv1lfn0zdVXCvr1YGt/gwN8CWR
	abWWrVK8YhlsV9
X-X-Sender: gene099@racer.site
In-Reply-To: <20070831191921.GB2151@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57209>

Hi,

On Fri, 31 Aug 2007, Karl Hasselstr?m wrote:

> On 2007-08-31 20:06:27 +0100, Johannes Schindelin wrote:
> 
> > It does _not_ undo the changeset corresponding to that commit, but
> > it _skips_ the revision. IOW its ancestors' tree objects remain the
> > same.
> 
> While this is true too, I'm guessing you intended to say that its
> _descendants'_ tree objects remain the same. Right?

Right.  So how about:

IOW no tree objects are changed by this.

Hmm?

Ciao,
Dscho
