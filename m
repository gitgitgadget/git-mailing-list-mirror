From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Better handling of local changes in 'gitk'?
Date: Fri, 13 Jul 2007 10:36:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707131033040.20061@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
 <18071.19489.6733.665052@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 19:37:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9P4w-0000Xz-Ps
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 19:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143AbXGMRhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757316AbXGMRhQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 13:37:16 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41365 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757143AbXGMRhO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2007 13:37:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6DHaVXK012075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2007 10:36:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6DHaQ7O007944;
	Fri, 13 Jul 2007 10:36:26 -0700
In-Reply-To: <18071.19489.6733.665052@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-2.611 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52403>



On Fri, 13 Jul 2007, Paul Mackerras wrote:
> 
> Try this, let me know what you think.  I called the changes in the
> working directory "Local uncommitted changes, not checked in to index"
> and the changes in the index "Local changes checked in to index but
> not committed".

ACK.

This matches exactly what I was thinking of.

The red vs magenta looks a bit too close in color for me (red, green and 
blue?), but quite frankly, it's not like I really care.

Those author/date fields look really empty, but that's probably a good way 
to emphasize that they aren't real commits, so while it's visually a bit 
strange, it probably is the right thing to do.

		Linus
