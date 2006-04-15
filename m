From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Support "git cmd --help" syntax
Date: Sat, 15 Apr 2006 14:07:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604151402470.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604151054380.3701@g5.osdl.org>
 <7vsloeef0k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 23:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUrzR-0008WH-2x
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 23:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWDOVH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 17:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWDOVH3
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 17:07:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751450AbWDOVH2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 17:07:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3FL7MtH019992
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Apr 2006 14:07:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3FL7MdC015020;
	Sat, 15 Apr 2006 14:07:22 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsloeef0k.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18765>



On Sat, 15 Apr 2006, Junio C Hamano wrote:
> 
> Tried "git commit --help" with and without the patch?

I get a usage message without the patch.

With the patch, I get the man-page.

IOW, I don't see your point.

I'd have expected that to be an improvement. You can always get the usage 
message with "git commit --huh?", so it's not like you've lost anything.

Now, if you have _not_ done

	make prefix=/usr/share install-doc

or similar, then yes, you get something less than helpful (along the lines 
of "No manual entry for git-commit"), and I agree that we could/should 
improve on that somehow. 

			Linus
