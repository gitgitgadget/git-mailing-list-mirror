From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Thu, 25 Oct 2007 16:36:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251634200.30120@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710260007450.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 01:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlCHY-0005Xi-H4
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 01:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762723AbXJYXhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 19:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759951AbXJYXhx
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 19:37:53 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46188 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762466AbXJYXhw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 19:37:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PNaPfp026308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 16:36:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PNaOdH029782;
	Thu, 25 Oct 2007 16:36:25 -0700
In-Reply-To: <Pine.LNX.4.64.0710260007450.4362@racer.site>
X-Spam-Status: No, hits=-4.721 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62385>



On Fri, 26 Oct 2007, Johannes Schindelin wrote:
> 
> \--rebase::
> 	Instead of a merge, perform a rebase after fetching.
> 	*NOTE:* Never do this on branches you plan to publish!  This
> 	command will _destroy_ history, and is thus only suitable for
> 	topic branches to be submitted to another committer.

Well, it really needs explanation of what "destroy" means. 

Also, it's not strictly even necessary to publish things for this to cause 
problems. It's perfectly sufficient to just do development on two private 
developer machines, and do things like keeping the two machines in sync by 
pulling things between them manually...

So even "normal" developers who never publish a git tree to others may 
actually hit this issue.

			Linus
