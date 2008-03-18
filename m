From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: auto gc again
Date: Tue, 18 Mar 2008 11:14:14 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org>
References: <20080318180118.GC17940@kernel.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc413-0006jn-Gv
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbYCST0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbYCST0x
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:26:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44594 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753929AbYCST0v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2008 15:26:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2IIFSc9004220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Mar 2008 11:15:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2IIEEca010101;
	Tue, 18 Mar 2008 11:14:15 -0700
In-Reply-To: <20080318180118.GC17940@kernel.dk>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-103.329 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77508>



On Tue, 18 Mar 2008, Jens Axboe wrote:
> 
> Could we please PLEASE kill this auto gc thing? I've complained about
> this in the past and disabled it through the gc.auto config entry,
> however now git seems to be happily auto running gc even with gc.auto=0.
> So there's probably some new magic I need to know.

Do you do something odd with your repositories? I don't even touch autogc 
on my systems, but I have never had that thing trigger, even when I apply 
series of patches from Andrew with hundreds of messages.

So what is it that you do to even get this behaviour in the first place?

			Linus
