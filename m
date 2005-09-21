From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Wed, 21 Sep 2005 15:03:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509211501130.2553@g5.osdl.org>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org>
 <7vu0genlc1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 00:07:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EICgz-0004t9-NB
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 00:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVIUWDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 18:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbVIUWDq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 18:03:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965103AbVIUWDp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 18:03:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8LM3fBo022051
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 15:03:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8LM3d58032526;
	Wed, 21 Sep 2005 15:03:40 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0genlc1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9083>



On Wed, 21 Sep 2005, Junio C Hamano wrote:
> 
> * I thought you do not multitask and wonder why you are merging
>   while you still have local changes, but that does not justify
>   this regression.

I've always multi-tasked, but when I started git I was ready to drop it. 
Then I came up with that wonderful "merge in the index" approach, and I 
could do it again, and I was _soo_ happy.

I often have local changes in my tree that I don't want to commit but that 
I'm testing out. Havign them interfere with merging other peoples work 
would mean that I'd have to have a totally separate tree for that, which I 
could do, but I'm much much happier not having to.

		Linus
