From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Diffs "from" working directory
Date: Sun, 20 Nov 2005 15:58:55 -0500
Message-ID: <20051120205855.GA30346@fieldses.org>
References: <200511201817.15780.blaisorblade@yahoo.it> <20051120174359.GA24177@fieldses.org> <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Blaisorblade <blaisorblade@yahoo.it>, Chuck Lever <cel@netapp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 22:00:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdwHn-00076c-SY
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 21:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKTU7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 15:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVKTU7E
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 15:59:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:54680 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750795AbVKTU7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 15:59:02 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.54)
	id 1EdwH1-0008Mk-DQ; Sun, 20 Nov 2005 15:58:55 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12402>

On Sun, Nov 20, 2005 at 10:13:32AM -0800, Linus Torvalds wrote:
> On Sun, 20 Nov 2005, J. Bruce Fields wrote:
> > 
> > That's a diff *to* the working directory.  My complaint was that there
> > wasn't a convenient way to get a diff *from* the working directory.
> 
> Something like
> 
> 	git diff -R -M -p
>
> should do it, no?

A "-R" option to "stg diff" would be convenient, sure.--b.
