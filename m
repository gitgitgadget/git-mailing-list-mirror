From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] Case-insensitive filesystem support, take 1
Date: Tue, 25 Mar 2008 20:37:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803252035430.2775@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <20080325081409.GI25381@dpotapov.dyndns.org> <alpine.LFD.1.00.0803251347400.2775@woody.linux-foundation.org> <20080326024609.GL25381@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 04:40:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeMUd-0002Ix-BN
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 04:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbYCZDjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 23:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYCZDjP
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 23:39:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50207 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821AbYCZDjO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 23:39:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2Q3cXbO026829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2008 20:38:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2Q3bIU4027991;
	Tue, 25 Mar 2008 20:38:23 -0700
In-Reply-To: <20080326024609.GL25381@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.755 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78249>



On Wed, 26 Mar 2008, Dmitry Potapov wrote:
> 
> Of course, case-insensitivity is about the working tree only. But when
> I merge another branch to the current one, git normally checks that it
> is not going to overwrite existing files in the *work tree* and refuses
> to do the merge if some files may be overwritten.

I do agree - but this is not really about the *merge*. It is about the 
checkout.

Imagine that the merge had been done on a sane filesystem, and you're just 
pulling it or cloning it. No merge on your machine, but the problem is the 
same.

		Linus
