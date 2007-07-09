From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Preferring shallower deltas on repack
Date: Sun, 8 Jul 2007 22:41:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707082238150.31544@woody.linux-foundation.org>
References: <20070709044326.GH4087@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7m0f-0001Dv-J6
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXGIFmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbXGIFmF
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:42:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55135 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbXGIFmE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 01:42:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l695g0Uv023901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 Jul 2007 22:42:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l695fsgE019651;
	Sun, 8 Jul 2007 22:41:55 -0700
In-Reply-To: <20070709044326.GH4087@lavos.net>
X-Spam-Status: No, hits=-2.641 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51957>



On Sun, 8 Jul 2007, Brian Downing wrote:
> 
> I modified this to prefer shallower deltas of the same size.  This made
> the deltas for this file a very wide tree with a maximum depth of about
> 65.  Other (much smaller) improvements were seen elsewhere in the pack.
> Runtime does not seem to have been affected, as most of the work had
> already been done when it was tossing deltas before.

This seems like a good thing to do, and on the face of it I think it's 
worth it. I can't see any real downsides, at least, and while the upside 
doesn't sound huge, it sounds real enough.

So here's at least an initial tentative "ack" from me.

		Linus
