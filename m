From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Thu, 25 Oct 2007 16:49:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710251647420.30120@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710260007450.4362@racer.site>
 <alpine.LFD.0.999.0710251634200.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 01:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlCSe-0007an-TJ
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 01:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbXJYXtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 19:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbXJYXtr
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 19:49:47 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39003 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752536AbXJYXtq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 19:49:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PNnMsn026883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Oct 2007 16:49:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9PNnMKe030226;
	Thu, 25 Oct 2007 16:49:22 -0700
In-Reply-To: <alpine.LFD.0.999.0710251634200.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-4.722 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62386>



On Thu, 25 Oct 2007, Linus Torvalds wrote:

> Also, it's not strictly even necessary to publish things for this to cause 
> problems. It's perfectly sufficient to just do development on two private 
> developer machines, and do things like keeping the two machines in sync by 
> pulling things between them manually...

.. or any branch use, for that matter.

I do agree that "git merge --rebase" is potentially convenient, I'm just 
not sure it's a great idea to document as such. People shouldn't do it 
unless they really *really* understand the implications, and I think the 
implications are much easier to understand if you instead teach them 
"fetch+rebase", and perhaps even keep the "merge --rebase" option entirely 
undocumented.

				Linus
