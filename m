From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Finally implement "git log --follow"
Date: Thu, 21 Jun 2007 08:44:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706210842340.3593@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
  <e5bfff550706192327l187b30eblb5bd5e4e76b3eab6@mail.gmail.com> 
 <alpine.LFD.0.98.0706200940000.3593@woody.linux-foundation.org>
 <e5bfff550706202321t354ec0e3xb218f382f1c983ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 17:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Opq-0004KO-Si
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 17:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbXFUPoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 11:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbXFUPoh
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 11:44:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41784 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752336AbXFUPoh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 11:44:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LFiNF6011062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 08:44:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LFiHC8031468;
	Thu, 21 Jun 2007 08:44:18 -0700
In-Reply-To: <e5bfff550706202321t354ec0e3xb218f382f1c983ae@mail.gmail.com>
X-Spam-Status: No, hits=-2.519 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50635>



On Thu, 21 Jun 2007, Marco Costalba wrote:
> 
> Bad: Currently git-log does not support --stdin option, required IMHO
> when git-log is runned by a tool, not a user, due to the possibility
> of a very long command line.

I do think we should just fix this. The patch to do so can't be *that* 
bad.

I'll look at it.

> FWIK "git blame -M --incremental" does not support "code lines range
> filtering", when with the mouse you select some lines of code and
> after filtering you see the subset of file's history that modified
> that range of code. This feature is currently supported by qgit
> annotating code.

Yeah, that sounds like it would be a good thing to fix.

		Linus
