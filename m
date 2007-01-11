From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port (was: Re: [ANNOUNCE] qgit4 aka qgit ported to Windows)
Date: Thu, 11 Jan 2007 10:39:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701111037330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com>
 <46a038f90701101517s1d5e818eq2fba220d17a6aa03@mail.gmail.com>
 <45A604ED.5EF73A1E@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 10:39:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4wPB-0008BW-5N
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbXAKJj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965347AbXAKJj0
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:39:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:53369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965336AbXAKJjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:39:25 -0500
Received: (qmail invoked by alias); 11 Jan 2007 09:39:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 11 Jan 2007 10:39:23 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Johannes Sixt <J.Sixt@eudaptics.com>
In-Reply-To: <45A604ED.5EF73A1E@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36565>

Hi,

On Thu, 11 Jan 2007, Johannes Sixt wrote:

> This works: The tools that you commonly need to work on a local repo,
> except merges ([*]): commit, rebase, reset, log, diff and their
> plumbing.
> 
> [...]
> 
> [*] because shell scripts like merge-one-file can't be invoked from an 
> exe like merge-index, yet. Fortunately this looks like the easiest part 
> to solve.

Exactly. Just build-in merge-one-file. This has the further benefit that 
we (finally) can use the inbuilt xdl_merge() without a fork()!

And then, we'll get Alex' merge under 1 minute.

Ciao,
Dscho
