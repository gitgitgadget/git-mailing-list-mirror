From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 11:05:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181103580.27353@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707180925030.27353@woody.linux-foundation.org>
 <85r6n5y5m3.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 20:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBDv4-0001si-EO
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 20:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933903AbXGRSGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 14:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933805AbXGRSGe
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 14:06:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58231 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932270AbXGRSGe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 14:06:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6II603Q029987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 11:06:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6II5tpA021916;
	Wed, 18 Jul 2007 11:05:55 -0700
In-Reply-To: <85r6n5y5m3.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.672 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52886>



On Wed, 18 Jul 2007, David Kastrup wrote:
> 
> Since I did not try to argue this, could you beat another strawman?

How about a bit of honesty?

Here's the quote:

 "The FAQ answer is weazeling on several accounts:

  a) No, git only cares about files, or rather git tracks content and
     empty directories have no content.

  In the same manner as empty regular files have no contents, and git
  tracks those.  Existence and permissions are important."

You called it "weaselly" to say that git tracks only content, and then 
very much tried to equate "existence and permissions" with content.

That's the part I answered.

So it wasn't a strawman, it was a direct answer to your assertion. Now go 
away and either come back with the patch to implement it (that I have 
encouraged you to do), or add a ".gitignore" file to the directory (that 
others have told you will solve your problems).

Don't bother talking crap.

			Linus
