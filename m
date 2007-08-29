From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: repo.or.cz wishes?
Date: Wed, 29 Aug 2007 10:11:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708291009570.25853@woody.linux-foundation.org>
References: <20070826235944.GM1219@pasky.or.cz> <Pine.LNX.4.64.0708270933450.28586@racer.site>
 <20070828041059.GK18160@spearce.org> <20070828111913.GA31120@thunk.org>
 <20070829041523.GS18160@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 19:12:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQR5Z-0007gH-P9
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 19:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533AbXH2RMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 13:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756515AbXH2RMR
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 13:12:17 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58454 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756195AbXH2RMQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2007 13:12:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7THBYnH011436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Aug 2007 10:11:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7THBXpP001887;
	Wed, 29 Aug 2007 10:11:33 -0700
In-Reply-To: <20070829041523.GS18160@spearce.org>
X-Spam-Status: No, hits=-2.747 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.30__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56968>



On Wed, 29 Aug 2007, Shawn O. Pearce wrote:
> 
> Not if I already have a pointer from B to A's refs.  repo.or.cz
> also has this same pointer:
> 
> 	git clone --shared A B
> 	ln -s A/refs B/refs/forkee

Now, this doesn't work well with packed refs, I'm afraid.

So I suspect that if we really want to support something like this, we'd 
need to do more than just avoid the recursion when you cross-link.

		Linus
