From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: get rid of "set -e"
Date: Wed, 18 Jul 2007 15:05:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181503500.14781@racer.site>
References: <20070710205202.GA3212@steel.home> <Pine.LNX.4.64.0707181416050.14781@racer.site>
 <86vechj0zz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 16:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBA9u-0000mr-QC
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 16:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbXGROFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 10:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbXGROFk
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 10:05:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:55792 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752479AbXGROFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 10:05:39 -0400
Received: (qmail invoked by alias); 18 Jul 2007 14:05:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 18 Jul 2007 16:05:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19q/Fx6z79qcHyaVG4hT6huFe0gwYynHG1x7VujiU
	CdAUM613gBXzQG
X-X-Sender: gene099@racer.site
In-Reply-To: <86vechj0zz.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52863>

Hi,

[please Cc me]

On Wed, 18 Jul 2007, David Kastrup wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It was reported by Alex Riesen that "set -e" can break something as 
> > trivial as "unset CDPATH" in bash.
> 
> Not in bash.  Just tried it.  But there are Bourne shells that do get
> annoyed.

The mail I was replying to _explicitely_ stated that it _was_ with bash.  
Not your version of it, but some version.

> > So get rid of "set -e".
> 
> I'd rather write
> 
> [ "X$CDPATH" = "X" ] || unset CDPATH

We would write that as "test", not "[".

But it is much cleaner to get rid of "set -e" anyway.

Ciao,
Dscho
