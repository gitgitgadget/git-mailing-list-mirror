From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk-1.1 out
Date: Thu, 9 Jun 2005 14:46:19 +1000
Message-ID: <17063.51611.467615.685723@cargo.ozlabs.ibm.com>
References: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506080743040.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 07:28:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgFZZ-0002mf-Lm
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 07:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVFIFbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 01:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVFIFbX
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 01:31:23 -0400
Received: from ozlabs.org ([203.10.76.45]:37533 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262273AbVFIFbW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 01:31:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E63C967B1D; Thu,  9 Jun 2005 15:31:20 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506080743040.2286@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> Can you do the same for things in .git/refs/heads? Possibly using another 
> color?

Sure - the hardest part is going to be deciding on the shape and color
to use. :)  Perhaps I'll try just using a green rectangle with black
on white text inside and see if that stands out enough.

> I realize that that may sound silly, but a tree that has many branches can 
> validly be used with gitk with something like this:
> 
> 	gitk $(ls .git/refs/heads)

Um, did I break that when I changed to using git-rev-list instead of
git-rev-tree?

Paul.
