From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 20:09:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707292007440.4161@woody.linux-foundation.org>
References: <686661.84825.qm@web51011.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, david@lang.hm
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFLdG-0008PI-EV
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 05:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936710AbXG3DJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 23:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936602AbXG3DJP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 23:09:15 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53844 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936595AbXG3DJO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 23:09:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6U39793001169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jul 2007 20:09:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6U392Cq022679;
	Sun, 29 Jul 2007 20:09:02 -0700
In-Reply-To: <686661.84825.qm@web51011.mail.re2.yahoo.com>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54173>



On Sun, 29 Jul 2007, Matthew L Foster wrote:
> 
> > but if git did what you wanted it would show every commit with the time of 
> > the merge, and that wouldn't help you anyway.
>  
> Actually that is exactly what I want. I want to know what local time change X and Y (and all
> changes) were merged locally.

You misunderstand. It would do so both for the newly merged commits *and* 
for the old commits. Because _you_ think the "new" commits got merged, but 
it's logically exactly equivalent to saying that the *old* commits got 
merged.

So now *every* single commit would get the timestamp of the merge.

See? It would be pointless.

			Linus
