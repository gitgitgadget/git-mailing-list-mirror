From: Andreas Ericsson <ae@op5.se>
Subject: Re: re-licensing pkt-line.c code
Date: Thu, 25 Sep 2008 19:57:40 +0200
Message-ID: <48DBD114.80805@op5.se>
References: <d411cc4a0809251017h5509bbdmaef935c61cc0929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 19:58:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiv77-0007ZE-1c
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 19:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYIYR5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 13:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbYIYR5o
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 13:57:44 -0400
Received: from mail.op5.se ([193.201.96.20]:45591 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbYIYR5n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 13:57:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6743624B0051;
	Thu, 25 Sep 2008 19:48:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.074
X-Spam-Level: 
X-Spam-Status: No, score=-4.074 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.325, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BBvPvMv+qpsl; Thu, 25 Sep 2008 19:48:28 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E5D2124B0042;
	Thu, 25 Sep 2008 19:48:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <d411cc4a0809251017h5509bbdmaef935c61cc0929@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96787>

Scott Chacon wrote:
> Hey all,
> 
> I am writing a partial implementation of git in Objective-C so I can
> get a git server running on an iphone, and hopefully it could
> eventually be used in a mac desktop app that could be distributed
> without the git binary. If anyone is interested in the project, you
> can get it here:
> 
> http://github.com/schacon/objective-git
> 
> There are about 20-25 lines of code from pkt-line.c that I think were
> originally written back in 2005 that I would like to use so I don't
> have to re-implement them.  It is pretty generic - it is just the code
> that converts an int into a 4 char hex and back that is placed at the
> beginning of several of the network protocol lines.
> 
> http://github.com/schacon/objective-git/tree/master/ObjGitServerHandler.m#L554
> 
> I have to relicense this, since I can't legally distribute my source
> code for the iphone app due to Apples f**king NDA.  I would like to
> release my ObjectiveGit project under the MIT (or, alternately, LGPL).
>  Is Linus the right person to ask for this permission?  What is the
> best way to do so?


Linus wrote nearly all of pkt-line.c, so yes, he'd be the right person
to ask. If the lines you need were co-authored by someone else, you'll
need to ask that co-author too.

>  I could come up with an alternate way to
> accomplish the same thing, but it seems like a waste of time to do so,
> and helpful to nobody.
> 

Well, tracking down the original author(s) could turn out to be harder.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
