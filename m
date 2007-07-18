From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
 possible to create hardlinks for directories as root under solaris)
Date: Wed, 18 Jul 2007 08:45:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707180844150.27353@woody.linux-foundation.org>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
 <20070716133602.GB26675@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707161004550.20061@woody.linux-foundation.org>
 <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
 <20070716133602.GB26675@cip.informatik.uni-erlangen.de>
 <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org>
 <20070716171732.GE6134@cip.informatik.uni-erlangen.de>
 <20070716180910.GB16878@cip.informatik.uni-erlangen.de>
 <20070718085055.GL25037@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 17:46:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBBjG-0006f4-Fz
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 17:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759837AbXGRPqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 11:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759741AbXGRPqO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 11:46:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34062 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758738AbXGRPqO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 11:46:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IFjZTU022129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 08:45:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6IFjTPl016404;
	Wed, 18 Jul 2007 08:45:29 -0700
In-Reply-To: <20070718085055.GL25037@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=-2.671 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52871>



On Wed, 18 Jul 2007, Thomas Glanzmann wrote:
>
> > the bug is filed.
> 
> http://bugs.opensolaris.org/view_bug.do?bug_id=6581318

I don't think the recipient "got it", since it already has a comment about 
"just use rmdir".

Can you please tell them that that isn't the point?

		Linus
