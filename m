From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 16:31:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504261607310.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504261256150.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bram Cohen <bram@bitconjurer.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:28:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWet-0001tm-G2
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVDZUcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVDZUce
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:32:34 -0400
Received: from iabervon.org ([66.92.72.58]:50949 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261678AbVDZUcE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:32:04 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQWij-0005li-00; Tue, 26 Apr 2005 16:31:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261256150.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Apr 2005, Linus Torvalds wrote:

> 
> 
> On Tue, 26 Apr 2005, Bram Cohen wrote:
> > 
> > If one person renames a file and another person modifies it then the
> > changes should be applied to the moved file.
> 
> Bzzt. Wrong answer.
> 
> The _right_ answer is "if one person moves a function, and another person 
> modifies the function, the changes should be applied to the moved 
> function".

I'd even go so far as to say that we need to have the user sign off on
this. The modification is reasonably likely to not work in the new
location, due to use of statics that aren't available or something of the
sort.

I suspect that we want to report a conflict in the new location between
the old version and the new version, and let the person merging check
whether the change is okay. That is, both sides modified the same section
at the same time: one side modified its content, while the other modified
its location. We can give a good suggestion, but we need a final ruling.

	-Daniel
*This .sig left intentionally blank*

