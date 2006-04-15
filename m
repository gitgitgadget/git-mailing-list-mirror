From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Recent unresolved issues
Date: Sat, 15 Apr 2006 10:17:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604151016220.3701@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org> <7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141748070.3701@g5.osdl.org> <Pine.LNX.4.64.0604141751270.3701@g5.osdl.org>
 <7vu08vjra5.fsf@assigned-by-dhcp.cox.net> <7vk69ri5cp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604150958140.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 19:17:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUoOm-0006MG-7u
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 19:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWDORRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 13:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWDORRL
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 13:17:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56299 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030300AbWDORRK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 13:17:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3FHH6tH013303
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Apr 2006 10:17:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3FHH5mN009244;
	Sat, 15 Apr 2006 10:17:05 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604150958140.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18753>



On Sat, 15 Apr 2006, Linus Torvalds wrote:
> 
> So the calling sequence would be something like this:
> 
> 	init_revisions(&rev);
> 	.. any localized setup ..
> 	setup_revisions(&rev);

Btw, I can certainly understand if you don't want to do this before 1.3.x. 
Since there's no actual user-visible advantage to it, it's probably worth 
dropping for now.

		Linus
