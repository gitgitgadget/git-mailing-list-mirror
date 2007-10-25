From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Thu, 25 Oct 2007 16:04:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 01:06:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlBmn-0007f5-1q
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 01:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbXJYXGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 19:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753694AbXJYXGa
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 19:06:30 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60799 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753521AbXJYXG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 19:06:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PN4TPn025024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 16:04:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PN4TXm028446;
	Thu, 25 Oct 2007 16:04:29 -0700
In-Reply-To: <Pine.LNX.4.64.0710252351130.4362@racer.site>
X-Spam-Status: No, hits=-4.721 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62383>



On Thu, 25 Oct 2007, Johannes Schindelin wrote:
> 
> This behavior is more desirable than fetch + pull when a topic branch
> is ready to be submitted.

I'd like there to be some *big*warning* about how this destroys history 
and how you must not do this if you expose your history anywhere else.

I think it's a perfectly fine history, but if you have already pushed out 
your history somewhere else, you're now really screwed. In ways that a 
*real* merge will never screw you.

So the "--rebase" option really is only good for the lowest-level 
developers. And that should be documented.

		Linus
