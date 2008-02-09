From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking
 pickier
Date: Sat, 9 Feb 2008 12:56:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802091251430.13593@iabervon.org>
References: <20080209162234.GA25533@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 18:56:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNtwa-0002fz-Oj
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 18:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbYBIR4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 12:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbYBIR4T
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 12:56:19 -0500
Received: from iabervon.org ([66.92.72.58]:49972 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbYBIR4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 12:56:18 -0500
Received: (qmail 7189 invoked by uid 1000); 9 Feb 2008 17:56:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Feb 2008 17:56:16 -0000
In-Reply-To: <20080209162234.GA25533@fieldses.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73250>

On Sat, 9 Feb 2008, J. Bruce Fields wrote:

> From: J. Bruce Fields <bfields@citi.umich.edu>
> 
> This will change the notion of "bad" whitespace for the git project to
> include initial whitespace that uses spaces where tabs could have been
> used.
> 
> This only changes which whitespace is considered "bad".  It doesn't
> change the behavior when bad whitespace is found.  By default, commands
> like git-apply, git-am, and git-rebase will print a warning but
> otherwise do nothing.

I think there are files under t/ with different whitespace rules. For 
example, expected format-patch output will have lines that are: "-- "
While you're putting in attributes in general, it'd be nice to take care 
of all of the cases already in the tree.

	-Daniel
*This .sig left intentionally blank*
