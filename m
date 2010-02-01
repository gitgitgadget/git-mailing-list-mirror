From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 1/6] revert: libify cherry-pick and revert
 functionnality
Date: Mon, 1 Feb 2010 11:26:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002011124440.4985@pacific.mpi-cbg.de>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org> <20100201075542.3929.38404.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 11:20:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbtO9-0002pb-Ss
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 11:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab0BAKUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 05:20:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:53407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751764Ab0BAKUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 05:20:05 -0500
Received: (qmail invoked by alias); 01 Feb 2010 10:20:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 01 Feb 2010 11:20:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UBV1PDuMURYBMnM9jq3VDFeoUzW/zG/Dh0a7GlA
	1qoNIq4dEJzRO4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100201075542.3929.38404.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138598>

Hi,

On Mon, 1 Feb 2010, Christian Couder wrote:

> From: Stephan Beyer <s-beyer@gmx.net>
> 
> The goal of this commit is to abstract out "git cherry-pick" and
> "git revert" functionnality into a new pick_commit() function made
> of code from "builtin-revert.c".
> 
> The new pick_commit() function is in a new "pick.c" file with an
> associated "pick.h".
> 
> This function starts from the current index (not HEAD), and allow
> the effect of one commit replayed (either forward or backward) to
> that state, leaving the result in the index. So it makes it
> possible to replay many commits to the index in sequence without
> commiting in between.
> 
> This commit is made of code from the sequencer GSoC project:
> 
> git://repo.or.cz/git/sbeyer.git
> 
> (at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)
> 
> And it contains some changes and comments suggested by Junio.
> 
> The original commit in the sequencer project that introduced
> this change is: 94a568a78d243d7a6c13778bc6b7ac1eb46e48cc
> 
> Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

I guess that this patch would look nicer using --patience. In its current 
form, it would put too big a dent in my Git time budget, sorry, I will not 
review it.

Ciao,
Dscho
