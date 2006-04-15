From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 17:49:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604141748070.3701@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org> <7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 02:50:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUYzK-0001mH-Do
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 02:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWDOAuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 20:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWDOAuE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 20:50:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751457AbWDOAuB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 20:50:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3F0nvtH010164
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 17:49:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3F0nuS5018161;
	Fri, 14 Apr 2006 17:49:56 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18716>



On Fri, 14 Apr 2006, Junio C Hamano wrote:
> 
> I was thinking long because I had an impression that anything
> based on revision.c interface, if it wants to do a tree-diff on
> the commit stream, would need two different diff options.  One
> is used by revision.c internally so that it can use its own
> add_remove/change for parent pruning, and another to control the
> way diff is run by the user of revision.c.

I think you're right, and I've probably broken "--full-diff" (causing the 
revparse to also use the empty set of paths). Gaah.

		Linus
