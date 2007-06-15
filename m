From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-send-pack SIGSEGV..
Date: Thu, 14 Jun 2007 21:31:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706142130190.14121@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org
 >
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 06:32:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz3TZ-0004iF-8c
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 06:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbXFOEb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 00:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbXFOEb4
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 00:31:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43503 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779AbXFOEbz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2007 00:31:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5F4VCjg030491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2007 21:31:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5F4V6G5011139;
	Thu, 14 Jun 2007 21:31:07 -0700
In-Reply-To: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.559 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50241>


On Thu, 14 Jun 2007, Linus Torvalds wrote:

> 
> I haevn't had time to debug this at all, but
> 
> 	git push --tags all
> 
> actually SIGSEGV's for me on the git repository.

Oh, and this is with current 'master', of course. Commit 38570a47fc to be 
exact.

		Linus
