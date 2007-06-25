From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 14:53:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706251450240.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <87bqf3u324.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2wV8-00026k-E8
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbXFYVxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbXFYVxV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:53:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43588 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269AbXFYVxU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 17:53:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PLrHZf015245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2007 14:53:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PLrBA7011732;
	Mon, 25 Jun 2007 14:53:12 -0700
In-Reply-To: <87bqf3u324.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.569 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50930>



On Mon, 25 Jun 2007, Jim Meyering wrote:
>
> Here's a version of that patch that retains the fflush call
> and adds a comment explaining why it's needed.

Ok. I will hereby just suggest to Junio that he just not take patches from 
you.

You seem to be totally unable to ever really think or worry about your own 
little uninteresting test-case, and have shown yourself totally 
uninterested in anything anybody ever tells you.

In other words, you now screwed up EPIPE.

AGAIN.

And why? All apparently because you want "disk full" rather than just 
"write error".

Jim, you really need to see past your small test, and think about the 
bigger picture.

		Linus
