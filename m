From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge strategy request
Date: Sun, 25 Mar 2007 03:20:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 03:21:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVHPu-0001iP-8x
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 03:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbXCYBUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 21:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbXCYBUz
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 21:20:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:36327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753293AbXCYBUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 21:20:54 -0400
Received: (qmail invoked by alias); 25 Mar 2007 01:20:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 25 Mar 2007 03:20:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gX49x409gOwGfKfPR5Qn8qWBzWZtSixON8K8B6Q
	7X1CSe+U4Qzvcw
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43028>

Hi,

On Sat, 24 Mar 2007, David Lang wrote:

> there's been talk about custom merge strategies for different types of 
> files (uncompressing office documents to merge them for example), so I 
> think this is along the same lines and wanted to let other people start 
> thinking about the problem and possible solutions.

There is a nice example script, named git-merge-stupid, which you can 
use as template.

Basically, just write a program named "git-merge-david-lang", which takes 
arguments of the form

	merge-base [merge-base2...] -- head remote [remote...]

IOW, all arguments up to "--" are merge bases, and after the "--" comes 
the HEAD and all branches to be merged. All of these argument (except 
"--") are given as commit hashes.

IIRC, if no merge bases are passed, the program is expected to find out 
(basically, take the output of "git-merge-base --all <head> <remote>...").

And I really prefer _you_ working on it.

Ciao,
Dscho
