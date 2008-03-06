From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/5] Split-up "unpack_trees()" cleanup series
Date: Wed, 5 Mar 2008 20:51:02 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803052046540.12253@woody.linux-foundation.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 05:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX859-0006nH-JA
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491AbYCFEvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757309AbYCFEvM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:51:12 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42158 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757212AbYCFEvL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 23:51:11 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264pMLU007157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 20:51:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264p2wA009397;
	Wed, 5 Mar 2008 20:51:03 -0800
In-Reply-To: <cover.1204777699.git.torvalds@linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.921 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76327>



On Wed, 5 Mar 2008, Linus Torvalds wrote:
>
> Ok, here's the patch I sent out earlier, except now it's been split up
> into a series fo five patches (and has some trivial one-liner cleanups
> here and there, mainly to shrink the patches a bit)

Oh, and sorry about the 

	To: undisclosed-recipients:  ;

thing - I thought I'd just bounce the messages from the mbox I did with 
git-format-patch, but since those things didn't have any "To:" fields, 
that resulted in some rather ugly email headers.

My bad.

		Linus
