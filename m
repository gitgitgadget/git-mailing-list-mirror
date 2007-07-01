From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] cvstrack: work on imported cvs and other git branches
Date: Sun, 1 Jul 2007 17:03:53 +0200
Message-ID: <4880FDC4-BAD5-49B4-871B-98259D691449@zib.de>
References: <11832957963860-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0707011533370.4438@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 17:04:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I50yi-0000K4-3S
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 17:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbXGAPEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 11:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbXGAPEm
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 11:04:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:52319 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104AbXGAPEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 11:04:41 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l61F2m8L017925;
	Sun, 1 Jul 2007 17:04:39 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1bbde.pool.einsundeins.de [77.177.187.222])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l61F2lPW003622
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 1 Jul 2007 17:02:48 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0707011533370.4438@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51301>


On Jul 1, 2007, at 4:35 PM, Johannes Schindelin wrote:

> On Sun, 1 Jul 2007, Steffen Prohaska wrote:
>
>> The idea is to import a cvs repository using git cvsimport; build a
>> perfect history in git by cherry picking commits that are only in cvs
>> but not in git; and export only summaries back to cvs. Cvs imports  
>> are
>> organized on a separate git branch. git is used for merging. The
>> differences can be sent back to cvs as a squashed commit together  
>> with a
>> shortlog. Sent git commits are noted in the cvs commit message and  
>> will
>> be ignored in subsequent cvs imports.
>
> Wouldn't it be more intuitive to add a --squash option to
> git-cvsexportcommit?

Maybe.

But how to handle commits that are sent to cvs and come back
through git-cvsimport?

How can they be handled with git-cvsexportcommit/git-cvsimport?


>> To get the idea you can run t/t9250-git-cvstrack.sh and explore
>> the git repository created in t/trash/gitwork.
>
> Hmm. I would have expected such a non-descriptive description  
> _after_ the
> commit message, not _in_ it.

thanks, I'll remember this for future patches.

	Steffen
