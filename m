From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on afs
Date: Fri, 19 Oct 2007 12:06:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710191204550.26902@woody.linux-foundation.org>
References: <20071018203106.GA13518@fries.net>
 <alpine.LFD.0.999.0710181543380.26902@woody.linux-foundation.org>
 <20071019060624.GK14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Todd T. Fries" <todd@fries.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:06:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IixBN-0003Nw-EK
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762470AbXJSTGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758913AbXJSTGl
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:06:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54174 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757239AbXJSTGk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 15:06:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JJ6Ycx024790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Oct 2007 12:06:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JJ6XcI015367;
	Fri, 19 Oct 2007 12:06:33 -0700
In-Reply-To: <20071019060624.GK14735@spearce.org>
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61742>



On Fri, 19 Oct 2007, Shawn O. Pearce wrote:
> 
> What about this instead?  It avoids the double lstat() of Todd's
> original patch but seems like it would fix the issue here.  Or did
> I misunderstand the problem?

No. As far as I can tell without testing it, this patch will make it show 
ignored regular files if they have DT_UNKNOWN in the directory entry (or 
the filesystem doesn't support it). Not good.

		Linus
