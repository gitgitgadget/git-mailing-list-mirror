From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 20:23:16 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812182022170.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>  <1229642734.5770.25.camel@rotwang.fnordora.org>  <20081219124452.6117@nanako3.lavabit.com>  <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
 <76718490812182018x37e3d6fob8d817c0e0b0e293@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@lavabit.com>, Alan <alan@clueserver.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 05:25:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDWvd-0007zO-Vy
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 05:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYLSEYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 23:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYLSEYP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 23:24:15 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40704 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752090AbYLSEYP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 23:24:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ4NHVO014709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 20:23:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ4NGdF023631;
	Thu, 18 Dec 2008 20:23:16 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <76718490812182018x37e3d6fob8d817c0e0b0e293@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.423 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103543>



On Thu, 18 Dec 2008, Jay Soffian wrote:
> 
> Instead of reverting the revert, why not rebase the branch which was
> merged to the point after the revert was done?

Sure, you can do that too. However, that has its own set of problems, ie 
all the "ok, who else was working based on this branch" thing.

But no, there are no single right answers. Rebasing may well be a 
reasonable approach.

		Linus
