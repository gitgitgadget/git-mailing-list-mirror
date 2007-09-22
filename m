From: Steffen Prohaska <prohaska@zib.de>
Subject: fromcvs installation [was: cvsimport bug on branches [was: conversion to git]]
Date: Sat, 22 Sep 2007 10:07:22 +0200
Message-ID: <86B33DFE-65E6-4F8D-8483-509ACA4FA2F8@zib.de>
References: <loom.20070920T010842-272@post.gmane.org> <200709212242.53131.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709212212020.28395@racer.site> <200709220116.26369.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 10:27:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0Kl-0001V6-FG
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbXIVI1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 04:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbXIVI1V
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:27:21 -0400
Received: from mailer.zib.de ([130.73.108.11]:54499 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbXIVI1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:27:19 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8M8IgwI029824;
	Sat, 22 Sep 2007 10:19:41 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db11cec.pool.einsundeins.de [77.177.28.236])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8M8IfHt023320
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 22 Sep 2007 10:18:41 +0200 (MEST)
In-Reply-To: <200709220116.26369.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58919>


On Sep 22, 2007, at 1:16 AM, Robin Rosenberg wrote:

> fredag 21 september 2007 skrev Johannes Schindelin:
>> No, it's yet another dependency.  And the quality of the code still
>> depends on the programmer, not the language.
>
> I think I can agree there, on both counts. But, if you want a good  
> incremental
> CVS importer and have access to the rcs files, that's the one there  
> is.
>
> git-cvsimport has a dependency on cvsps, which isn't included. You  
> have to
> to look it up yourself chooing among a dozen unequally bad versions.
> Installing ruby isn't any harder.
>
> The dependency excludes it from being included with Git, but it  
> does not
> disqualify it as a tool on it's own.

Nonetheless a more detailed description how to install fromcvs
would be helpful. I remember it was not obvious to me.

The README of fromcvs only says
'''
Prerequisites:
- ruby (1.8.5 known working)
- fromcvs, <http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs>
- rcsparse, <http://ww2.fs.ei.tum.de/~corecode/hg/rcsparse> (ruby  
module)
- Ruby/RBTree, <http://raa.ruby-lang.org/project/ruby-rbtree/>
- for git: git-fast-import, part of git 1.5
- for db/commitset: sqlite3 + sqlite3-ruby (available as gem)
'''

I didn't use ruby before and had no idea how to install a ruby module
or what 'available as gem' means. And by the way, it was not obvious
for me that I can download the tip of the mercurial branch by clicking
on the 'gz' link at the top of the page.

I think a step by step explanation how to proceed would have helped me.

	Steffen
