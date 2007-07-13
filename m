From: Paul Mackerras <paulus@samba.org>
Subject: Re: Better handling of local changes in 'gitk'?
Date: Fri, 13 Jul 2007 20:09:05 +1000
Message-ID: <18071.20289.270560.640460@cargo.ozlabs.ibm.com>
References: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
	<18071.19489.6733.665052@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 12:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9I5P-0007iN-0o
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 12:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbXGMKJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 06:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbXGMKJN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 06:09:13 -0400
Received: from ozlabs.org ([203.10.76.45]:38100 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbXGMKJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 06:09:12 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 87DB4DDE26; Fri, 13 Jul 2007 20:09:11 +1000 (EST)
In-Reply-To: <18071.19489.6733.665052@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52380>

I wrote:

> Try this, let me know what you think.  I called the changes in the
> working directory "Local uncommitted changes, not checked in to index"
> and the changes in the index "Local changes checked in to index but
> not committed".  If you prefer some other wording, let me know.  I
> made the working directory commit red (as before) and the index commit
> magenta, as being between red and blue.  The index commit gets a fake
> SHA1 id of 00..001.

I should add that I'm sure that gitk won't yet do the right thing if
there are files in the index at other than stage 0, or if the local
changes are the result of an incomplete merge.  (In the latter case I
suppose one or other of the fake commits should have multiple parents,
but I don't have the infrastructure to add fake commits with multiple
parents yet.)

Paul.
