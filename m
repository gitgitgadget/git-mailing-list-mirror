From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Problem merging
Date: Wed, 23 Nov 2005 09:59:53 +0100
Message-ID: <20051123085953.GA4933@c165.ib.student.liu.se>
References: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 10:01:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeqU7-0004OF-Up
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 10:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbVKWJAD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 04:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVKWJAC
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 04:00:02 -0500
Received: from [85.8.31.11] ([85.8.31.11]:26023 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030378AbVKWJAB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 04:00:01 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 8DF124100; Wed, 23 Nov 2005 10:09:08 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EeqTp-0001ji-00; Wed, 23 Nov 2005 09:59:53 +0100
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12614>

On Tue, Nov 22, 2005 at 06:50:01PM -0800, Luben Tuikov wrote:
> Ok, background:
> 
> I've two branches of the same .git, _but_ they live in
> different directories (bearing the branches' names)
> with different index caches, but with the same identical
> objects directory (different HEADs of course).
> (in effect, I have both branches "checked out")
> 
> Branch A is the "trunk", branch B is trunk+my changes.
> I do:
> 
> branchA: git pull <remote>
> branchA: cd ../branchB/
> branchB: git resolve HEAD branchA "merge trunk"
> 
> And I get:
> 
> Trying to merge 4b4a27dff4e2d4cc2eac1cde31aede834a966a48 into
> e1ef47b54d7e7e477f7f1eb3251a9d37f38e0469 using 989e4d6cbc69191c41ddf4b1c492457410376b43.
> Simple merge failed, trying Automatic merge
> Removing include/asm-um/ldt.h
> fatal: merge program failed
> Automatic merge failed, fix up by hand
> 
> This is with git HEAD: 
> 2392ee98eb76aa821de53c93c9e36acb18d27fc0 -- latest as
> of now.
> 
> Is this a bug in git?  Since this process has always worked
> before.

Have you tried this merge with the recursive merge strategy?

Btw is there a reason why 'recursive' isn't the default merge strategy
for git-merge? It might be a bit confusing that git-pull and git-merge
have different default strategies...

- Fredrik
