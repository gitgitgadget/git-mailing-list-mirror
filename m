From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk patch collection pull request
Date: Sat, 20 Oct 2007 14:45:15 +1000
Message-ID: <18201.34779.27836.531742@cargo.ozlabs.ibm.com>
References: <20071019052823.GI14735@spearce.org>
	<alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 06:45:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij6Dd-0004PP-Vi
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 06:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbXJTEpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 00:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbXJTEpi
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 00:45:38 -0400
Received: from ozlabs.org ([203.10.76.45]:56486 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbXJTEph (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 00:45:37 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 88695DDE46; Sat, 20 Oct 2007 14:45:36 +1000 (EST)
In-Reply-To: <alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61781>

Linus Torvalds writes:

> The biggest problem I have with gitk is that it is almost totally useless 
> for when you have a file limit.
> 
> I do "gitk --merge" (which has an implicit file limit of the list 
> of unmerged files) or just "gitk ORIG_HEAD.. Makefile" and the *history* 
> of gitk looks fine.
> 
> But the diffs are crap and useless, because they contain all the stuff I 
> did *not* want, and hides all the relevant information.

Do you mean that when you have a file limit, the diff window should
just show the diffs for those files, not any other files the commit
might have modified?  That would be easy enough to implement in gitk.

Paul.
