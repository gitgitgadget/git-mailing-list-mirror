From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: cvsimport bug on branches [was: conversion to git]
Date: Sat, 22 Sep 2007 01:16:24 +0200
Message-ID: <200709220116.26369.robin.rosenberg.lists@dewire.com>
References: <loom.20070920T010842-272@post.gmane.org>
	<200709212242.53131.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.64.0709212212020.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <ebb9@byu.net>, Steffen Prohaska <prohaska@zib.de>,
	Jim Meyering <jim@meyering.net>, m4-patches@gnu.org,
	Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: m4-patches-bounces+gnu-m4-patches=m.gmane.org@gnu.org Sat Sep 22 01:14:36 2007
Return-path: <m4-patches-bounces+gnu-m4-patches=m.gmane.org@gnu.org>
Envelope-to: gnu-m4-patches@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYrhj-0007Pb-3v
	for gnu-m4-patches@m.gmane.org; Sat, 22 Sep 2007 01:14:35 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IYrhg-0003VP-To
	for gnu-m4-patches@m.gmane.org; Fri, 21 Sep 2007 19:14:32 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IYrhf-0003UM-Tv
	for m4-patches@gnu.org; Fri, 21 Sep 2007 19:14:31 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IYrhf-0003Tc-5U
	for m4-patches@gnu.org; Fri, 21 Sep 2007 19:14:31 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IYrhe-0003TV-Vs
	for m4-patches@gnu.org; Fri, 21 Sep 2007 19:14:31 -0400
Received: from [83.140.172.130] (helo=dewire.com)
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <robin.rosenberg.lists@dewire.com>)
	id 1IYrhe-0003G6-M7
	for m4-patches@gnu.org; Fri, 21 Sep 2007 19:14:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 017CA80288E;
	Sat, 22 Sep 2007 01:06:13 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
	by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 31828-09; Sat, 22 Sep 2007 01:06:13 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 9126D802868;
	Sat, 22 Sep 2007 01:06:13 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0709212212020.28395@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
X-Detected-Kernel: Linux 2.4-2.6
X-BeenThere: m4-patches@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Patch submission list for GNU M4 <m4-patches.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/m4-patches>,
	<mailto:m4-patches-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/m4-patches>
List-Post: <mailto:m4-patches@gnu.org>
List-Help: <mailto:m4-patches-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/m4-patches>,
	<mailto:m4-patches-request@gnu.org?subject=subscribe>
Sender: m4-patches-bounces+gnu-m4-patches=m.gmane.org@gnu.org
Errors-To: m4-patches-bounces+gnu-m4-patches=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58890>

fredag 21 september 2007 skrev Johannes Schindelin:
> No, it's yet another dependency.  And the quality of the code still 
> depends on the programmer, not the language.

I think I can agree there, on both counts. But, if you want a good incremental 
CVS importer and have access to the rcs files, that's the one there is.

git-cvsimport has a dependency on cvsps, which isn't included. You have to
to look it up yourself chooing among a dozen unequally bad versions. 
Installing ruby isn't any harder.

The dependency excludes it from being included with Git, but it does not 
disqualify it as a tool on it's own.

-- robin
