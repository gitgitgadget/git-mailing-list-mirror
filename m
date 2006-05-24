From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Clean up sha1 file writing
Date: Wed, 24 May 2006 16:35:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605241631340.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605240820560.5623@g5.osdl.org>
 <7vslmz5ewt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 01:35:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj2tH-0005Fd-4t
	for gcvg-git@gmane.org; Thu, 25 May 2006 01:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWEXXfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 19:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWEXXff
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 19:35:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932313AbWEXXfe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 19:35:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4ONZNtH013859
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 May 2006 16:35:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4ONZJHl004129;
	Wed, 24 May 2006 16:35:22 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslmz5ewt.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20710>



On Wed, 24 May 2006, Junio C Hamano wrote:
>
> It was very pleasant to read the changes that way, especially around 
> write_sha1_to_fd() vs repack_object().  xxdiff is my new friend.

I think "kompare" (the KDE diff tool) is nicer.

I'm tolf xxdiff integrates with some of the other SCM tools well (svn and 
tla), so it people use xxdiff, maybe it could support the git way of doing 
things too..

		Linus
