From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/7] Make unpack_trees_options bit flags actual
 bitfields
Date: Sat, 22 Mar 2008 10:47:59 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221045280.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LSU.1.00.0803221835240.4353@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:49:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7qQ-0001gv-2Y
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbYCVRso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbYCVRso
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:48:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38152 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754439AbYCVRso (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:48:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHm1xJ003584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:48:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHlxr2020189;
	Sat, 22 Mar 2008 10:48:00 -0700
In-Reply-To: <alpine.LSU.1.00.0803221835240.4353@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.755 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77836>



On Sat, 22 Mar 2008, Johannes Schindelin wrote:
> 
> Any point in doing the "From:" and "Date:" inside the mail body?

I encourage people to do that for the kernel ("From:" in particular), 
because while git-am will pick them up from the email headers, that is 
only true if the emails don't get passed around and commented upon by 
others.

Now, in git, the chain-of-command is very short (everybody -> Junio), so 
it really doesn't matter, but in the kernel, when people send out patches 
like this, the patches may be forwarded by others (who add their sign-off 
lines etc), and then it's really good to have that "From:" line in 
particular in the body of the email, because it's more likely that it will 
remain there (otherwise we depend on the person who signs off and forwards 
it to add it!)

			Linus
